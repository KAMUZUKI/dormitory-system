package com.mu.domain;

import java.io.Serializable;
import java.util.Arrays;
import lombok.Data;

/**
 * 
 * @TableName manager
 */
@Data
public class Manager implements Serializable {
    /**
     *  管理id
     */
    private Integer id;

    /**
     * 管理名字
     */
    private String name;

    /**
     * 管理手机号
     */
    private String phone;

    /**
     * 账号
     */
    private String account;

    /**
     * 密码
     */
    private String password;

    /**
     * 账号类型 0-全部权限  1-管理权限  2-查看权限
     */
    private Integer type;

    /**
     * 账号是否启用
     */
    private Boolean status;

    private static final long serialVersionUID = 1L;

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", name=").append(name);
        sb.append(", phone=").append(phone);
        sb.append(", account=").append(account);
        sb.append(", password=").append(password);
        sb.append(", type=").append(type);
        sb.append(", status=").append(status);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}