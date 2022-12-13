package com.mu.domain;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 
 * @TableName visiter
 */
@Data
public class Visiter implements Serializable {
    /**
     * id
     */
    private Integer id;

    /**
     * 来访名字
     */
    private String name;

    /**
     * 来访手机号
     */
    private String phone;

    /**
     * 来访目的
     */
    private String purpose;

    /**
     * 来访时间
     */
    private String createTime;

    /**
     * 管理执行人id
     */
    private String managername;

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
        sb.append(", purpose=").append(purpose);
        sb.append(", createtime=").append(createTime);
        sb.append(", managerid=").append(managername);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}