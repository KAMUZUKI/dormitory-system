package com.mu;

import com.mu.utils.Md5;
import org.junit.jupiter.api.Test;

/**
 * @author : MUZUKI
 * @date : 2022-12-08 21:01
 **/

public class servlet {
    @Test
    public void test() {
        System.out.println(Md5.getInstance().getMD5("a"));
    }
}
