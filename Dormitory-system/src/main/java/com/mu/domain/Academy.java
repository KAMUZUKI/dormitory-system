package com.mu.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * 
 * @TableName academy
 */
@Data
public class Academy implements Serializable {
    /**
     *  学院id
     */
    private Integer id;

    /**
     * 学院名称
     */
    private String aname;

    private static final long serialVersionUID = 1L;

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", aname=").append(aname);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}