package com.hxd.site.filter;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;

import com.hxd.security.Encodes;
import com.hxd.security.LoginToken;

public class AuthCM extends SimpleCredentialsMatcher {

	
	public boolean doCredentialsMatch(AuthenticationToken token,
			AuthenticationInfo info) {

		LoginToken loginToken = (LoginToken)token;	
		String psw = String.valueOf(loginToken.getPassword());
		Object userInfo = this.getCredentials(info);	
		boolean result = false;

		try {
			if (psw!=null) {
				result = Encodes.validatePsw(psw, userInfo.toString())? true : false;
			}		
			//System.out.println("###@@@ result="+result);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
