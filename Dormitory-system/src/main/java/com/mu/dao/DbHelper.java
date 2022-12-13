package com.mu.dao;


import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author MUZUKI
 */
public class DbHelper {
    static {
        try {
            System.out.println("加载驱动");
            Class.forName(DbProperties.getInstance().getProperty("driverClassName"));
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    public Connection getConnection() {//将数据库的获取封装成一个方法
        DbProperties d = DbProperties.getInstance();
        Connection con = null;
        try {
            con = DriverManager.getConnection(d.getProperty("url"), d.getProperty("username"), d.getProperty("password"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    /**
     * 设置参数
     *
     * @param pstmt
     * @param value
     * @throws SQLException
     */
    public void setParams(PreparedStatement pstmt, Object... value) throws SQLException {
        if (value != null && value.length > 0) {
            for (int i = 0; i < value.length; i++) {
                pstmt.setObject(i + 1, value[i]);
            }
        }
    }

    /**
     * 更新操作,增删改统称更新操作
     *
     * @param sql
     * @param value
     * @return
     */
    public int doUpdata(String sql, Object... value) {
        int result = 0;
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            setParams(pstmt, value);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 聚合查询函数
     *
     * @param sql
     * @param value
     * @return double
     */
    public double selectAggreation(String sql, Object... value) throws Exception {
        double result = 0;
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            setParams(pstmt, value);
            ResultSet r = pstmt.executeQuery();
            if (r.next()) {
                result = r.getDouble(1);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            throw e;
        }
        return result;
    }

    /**
     * @return List<T>
     */
    public <T> List<T> select(String sql, Class<T> cls, Object... value) throws SQLException {
        List<T> list = new ArrayList<T>();
        //1.调用下面的select(), 返回List<Map<String, Object>>
        List<Map<String, Object>> listMap = select(sql, value);
        //2.循环这个List<Map>,取出每个map
        if (listMap != null && listMap.size() > 0) {
            for (Map<String, Object> map : listMap) {
                T t = null;
                try {
                    t = getT(map, cls);
                    list.add(t);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //3.参照CommonServlet中的parseRequestToT，将map转为T
        return list;
    }

    /**
     * @return Object
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     */
    private <T> T getT(Map<String, Object> map, Class<T> cls) throws InstantiationException, IllegalAccessException, InvocationTargetException {
        //1.通过class字节码创建一个对象
        T obj = cls.newInstance();
        //3.取出cls中所有的属性，看有几个和map中的键相同，相同则调用cls中的set方法，注入值
        Method[] ms = cls.getMethods();
        for (Method m : ms) {
            if (m.getName().startsWith("set")) {
                //这个m是一个setXxx（），取出Xxx是什么，根据Xxx，在 map.get（Xxx）取出这个值
                String fieldName = getFieldName(m);
                Object value = map.get(fieldName);
                if (value == null) {
                    continue;
                }
                //判断这个m方法的参数类型，然后将v进行类型转换
                String methodParameterTypeName = m.getParameterTypes()[0].getTypeName();
                if ("java.lang.Integer".equals(methodParameterTypeName) || "int".equals(methodParameterTypeName)) {
                    Integer va = Integer.parseInt(value.toString());
                    //然后在调用setXxx（），将值注入
                    m.invoke(obj, va);
                } else if ("java.lang.Double".equals(methodParameterTypeName) || "double".equals(methodParameterTypeName)) {
                    Double va = Double.parseDouble(value.toString());
                    m.invoke(obj, va);
                } else if ("java.lang.float".equals(methodParameterTypeName) || "float".equals(methodParameterTypeName)) {
                    Float va = Float.parseFloat(value.toString());
                    m.invoke(obj, va);
                } else if ("java.lang.Long".equals(methodParameterTypeName) || "long".equals(methodParameterTypeName)) {
                    Long va = Long.parseLong(value.toString());
                    m.invoke(obj, va);
                } else if("java.lang.Boolean".equals(methodParameterTypeName) || "boolean".equals(methodParameterTypeName)){
                    Boolean va = Boolean.parseBoolean(value.toString());
                    m.invoke(obj, va);
                } else if ("java.lang.Byte".equals(methodParameterTypeName) || "byte".equals(methodParameterTypeName)) {
                    Byte va = Byte.parseByte(value.toString());
                    m.invoke(obj, va);
                } else {
                    m.invoke(obj, value.toString());
                }
            }
        }
        return obj;
    }

    /**
     * @param setMethod
     * @return
     */
    private String getFieldName(Method setMethod) {
        String fieldName = setMethod.getName().substring("set".length());
        //将fieldName的首字母改小写
        fieldName = fieldName.substring(0, 1).toLowerCase() + fieldName.substring(1);
        return fieldName;
    }

    /**
     * 查询：返回值为list<map<String,Object>>
     */
    public List<Map<String, Object>> select(String sql, Object... value) throws SQLException {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Connection con = getConnection();
        PreparedStatement pstmt = con.prepareStatement(sql);
        setParams(pstmt, value);
        ResultSet rs = pstmt.executeQuery();
        ResultSetMetaData rsmd = rs.getMetaData();
        int cc = rsmd.getColumnCount();
        List<String> columnName = new ArrayList<String>();
        for (int i = 0; i < cc; i++) {
            columnName.add(rsmd.getColumnName(i + 1));
        }
        while (rs.next()) {
            Map<String, Object> map = new HashMap<String, Object>();
            for (int i = 0; i < columnName.size(); i++) {
				//取列名
                String cn = columnName.get(i);
                Object value1 = rs.getObject(cn);
				//存到map中
                map.put(cn, value1);
            }
            list.add(map);
        }
        return list;
    }

	/**
	 * @return List<T>
     * 存储过程
	 */
	public <T> List<T> selectProc(String sql, Class<T> cls, Object... value) throws SQLException {
		List<T> list = new ArrayList<T>();
		//1.调用下面的select(), 返回List<Map<String, Object>>
		List<Map<String, Object>> listMap = selectProc(sql, value);
		//2.循环这个List<Map>,取出每个map
		if (listMap != null && listMap.size() > 0) {
			for (Map<String, Object> map : listMap) {
				T t = null;
				try {
					t = getT(map, cls);
					list.add(t);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		//3.参照CommonServlet中的parseRequestToT，将map转为T
		return list;
	}

	/**
	 * 执行存储过程：返回值为list<map<String,Object>>
	 * 存储过程
	 */
	public List<Map<String, Object>> selectProc(String sql, Object... value) throws SQLException {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection con = getConnection();
		//PreparedStatement pstmt = con.prepareStatement(sql);
		CallableStatement cs = con.prepareCall(sql);
		//setParams(pstmt, value);
		setParams(cs, value);
		//ResultSet rs = pstmt.executeQuery();
		ResultSet rs = cs.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();
		int cc = rsmd.getColumnCount();
		List<String> columnName = new ArrayList<String>();
		for (int i = 0; i < cc; i++) {
			columnName.add(rsmd.getColumnName(i + 1));
		}
		while (rs.next()) {
			Map<String, Object> map = new HashMap<String, Object>();
			for (int i = 0; i < columnName.size(); i++) {
				//取列名
				String cn = columnName.get(i);
				Object value1 = rs.getObject(cn);
				//存到map中
				map.put(cn, value1);
			}
			list.add(map);
		}
		return list;
	}

    /**
     * 更新操作,增删改统称更新操作
     * 使用存储过程
     * @param sql
     * @param value
     * @return
     */
    public int doUpdataProc(String sql, Object... value) {
        int result = 0;
        try (Connection con = getConnection();
             CallableStatement cs = con.prepareCall(sql);) {
            setParams(cs, value);
            result = cs.executeUpdate();
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return result;
    }

}
