package com.mu.web.servlet;

import com.mu.domain.*;
import com.mu.dao.DbHelper;
import com.mu.web.model.JsonModel;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


/**
 * @date : 2022-11-06 19:32
 * @description : 信息获取
 * @author MUZUKI
 **/
@WebServlet(name = "InfoServlet", value = "/info.action")
public class InfoServlet extends CommonServlet {
    /**
     * info.action?op=getAllStudent
     * 获取所有学生信息
     */
    protected void getAllStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        JsonModel jm = new JsonModel();
        Student student = new Student();
        List<Student> list = null;
        String sql = "{call select_s()}";
        try {
            list = db.selectProc(sql, Student.class);
            if (list == null && list.size() <= 0) {
                jm.setCode(0);
                jm.setMsg("无数据...");
                super.writeJson(jm, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setData(list);
        super.writeJson(jm, response);
    }

    /**
     * info.action?op=deleteStudentById
     * 通过学生id删除学生信息
     */
    protected void deleteStudentBySno(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        JsonModel jm = new JsonModel();
        String sno = request.getParameter("sno");
        String sql = "{call delete_s(?)}";
        int result = 0;
        try {
            result = db.doUpdataProc(sql,sno);
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        if(result == 0){
            jm.setCode(0);
            jm.setMsg("删除学号为" + sno + "的学生失败");
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setMsg("删除学号为" + sno + "的学生成功");
        super.writeJson(jm, response);
    }

    /**
     * info.action?op=getAllAcademy
     * 获取所有学院信息
     */
    protected void getAllAcademy(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        JsonModel jm = new JsonModel();
        Academy academy = new Academy();
        List<Academy> list = null;
        String sql = "{call select_a()}";
        try {
            list = db.selectProc(sql, Academy.class);
            if (list == null && list.size() <= 0) {
                jm.setCode(0);
                jm.setMsg("无数据...");
                super.writeJson(jm, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setData(list);
        super.writeJson(jm, response);
    }

    /**
     * info.action?op=getAllAcademy
     * 获取所有学院信息
     */
    protected void getAllManager(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        JsonModel jm = new JsonModel();
        Manager manager = new Manager();
        List<Manager> list = null;
        String sql = "{call select_m()}";
        try {
            list = db.selectProc(sql, Manager.class);
            if (list == null && list.size() <= 0) {
                jm.setCode(0);
                jm.setMsg("无数据...");
                super.writeJson(jm, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setData(list);
        super.writeJson(jm, response);
    }

    /**
     * info.action?op=getAllVisiter
     * 获取所有来访者信息
     */
    protected void getAllVisiter(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        JsonModel jm = new JsonModel();
        Visiter visiter = new Visiter();
        List<Visiter> list = null;
        String sql = "{call select_v()}";
        try {
            list = db.selectProc(sql, Visiter.class);
            if (list == null && list.size() <= 0) {
                jm.setCode(0);
                jm.setMsg("无数据...");
                super.writeJson(jm, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setData(list);
        super.writeJson(jm, response);
    }

    /**
     * info.action?op=getAllLeaveschool
     * 获取所有离校学生信息
     */
    protected void getAllLeaveschool(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        JsonModel jm = new JsonModel();
        Leaveschool leaveschool = new Leaveschool();
        List<Leaveschool> list = null;
        String sql = "{call select_ls()}";
        try {
            list = db.selectProc(sql, Leaveschool.class);
            if (list == null && list.size() <= 0) {
                jm.setCode(0);
                jm.setMsg("无数据...");
                super.writeJson(jm, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setData(list);
        super.writeJson(jm, response);
    }

    /**
     * info.action?op=addStudent
     * 添加学生信息
     */
    protected void addStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        Student student = null;
        JsonModel jm = new JsonModel();
        int result = 0;
        String sql = "{call add_s(?,?,?,?,?,?,?)}";
        try {
            student = super.parseRequestToT(request, Student.class);
            result = db.doUpdataProc(sql,student.getSname(),student.getAge(),student.getSex(),student.getAcademy(),student.getClassname(),student.getAddress(),student.getPhone());
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        if(result == 0){
            jm.setCode(0);
            jm.setMsg("添加学生"+ student.getSname() + "信息失败");
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setMsg("添加学生"+ student.getSname() + "信息成功");
        super.writeJson(jm, response);
    }

    /**
     * info.action?op=addLeaveStudent
     * 添加离校学生信息
     */
    protected void addLeaveStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        JsonModel jm = new JsonModel();
        Leaveschool leaveschool = null;
        int result = 0;
        String sql = "{call add_ls(?,?,?,?,?)}";
        try {
            leaveschool = super.parseRequestToT(request, Leaveschool.class);
            result = db.doUpdataProc(sql,leaveschool.getSno(),leaveschool.getPurpose(),leaveschool.getLeaveTime(),leaveschool.getBackTime(),leaveschool.getManagername());
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        if(result == 0){
            jm.setCode(0);
            jm.setMsg("添加离校学生" + leaveschool.getSno() + "信息失败");
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setMsg("添加离校学生" + leaveschool.getSno() + "信息成功");
        super.writeJson(jm, response);
    }

    /**
     * info.action?op=addVisiter
     * 添加来访者信息
     */
    protected void addVisiter(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DbHelper db = new DbHelper();
        JsonModel jm = new JsonModel();
        Visiter visiter = null;
        int result = 0;
        String sql = "{call add_v(?,?,?,?)}";
        try {
            visiter = super.parseRequestToT(request, Visiter.class);
            result = db.doUpdataProc(sql,visiter.getName(),visiter.getPhone(),visiter.getPurpose(),visiter.getManagername());
        } catch (Exception e) {
            e.printStackTrace();
            jm.setCode(0);
            jm.setMsg(e.getMessage());
            super.writeJson(jm, response);
            return;
        }
        if(result == 0){
            jm.setCode(0);
            jm.setMsg("添加来访者" + visiter.getName() + "信息失败");
            super.writeJson(jm, response);
            return;
        }
        jm.setCode(1);
        jm.setMsg("添加来访者" + visiter.getName() + "信息成功");
        super.writeJson(jm, response);
    }
}
