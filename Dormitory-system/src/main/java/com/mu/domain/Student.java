package com.mu.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * 
 * @TableName student
 */
@Data
public class Student implements Serializable {
    /**
     * 学号
     */
    private String sno;

    /**
     * 名字
     */
    private String sname;

    /**
     * 年龄
     */
    private Integer age;

    /**
     * 性别0女1男
     */
    private Boolean sex;

    /**
     * 学院id
     */
    private String academy;

    /**
     * 班级
     */
    private String classname;

    /**
     * 寝室住址
     */
    private String address;

    /**
     * 手机号
     */
    private String phone;

    private static final long serialVersionUID = 1L;

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", sno=").append(sno);
        sb.append(", sname=").append(sname);
        sb.append(", age=").append(age);
        sb.append(", sex=").append(sex);
        sb.append(", academy=").append(academy);
        sb.append(", class=").append(classname);
        sb.append(", address=").append(address);
        sb.append(", phone=").append(phone);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}