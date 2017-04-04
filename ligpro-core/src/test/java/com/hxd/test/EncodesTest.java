package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Test;

import com.hxd.security.Encodes;

/**
 * com.hxd.security.Encodes类的测试用例
 *
 */
public class EncodesTest {

	private static Log log = LogFactory.getLog(EncodesTest.class);
	
	/**
	 * 测试加密程序
	 */
	@Test
	public void testEncodePsw() {
		try {
			String psw = "123456";
			
			String encodePsw = Encodes.encodePsw(psw);
			
			boolean flag = Encodes.validatePsw(psw, encodePsw);
			
			log.debug("明文密码: psw="+psw);
			log.debug("加密后: Encodes.encodePsw(psw)="+encodePsw);
			log.debug("验证密码: Encodes.validatePsw(psw, encodePsw)="+flag);
			
			//断言结果
			Assert.assertTrue(flag);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
