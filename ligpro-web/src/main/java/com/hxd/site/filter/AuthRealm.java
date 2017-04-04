package com.hxd.site.filter;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hxd.bean.OpLog;
import com.hxd.bean.Power;
import com.hxd.bean.User;
import com.hxd.exception.CaptchaException;
import com.hxd.exception.UserLockException;
import com.hxd.interceptor.ControllerLog;
import com.hxd.security.Encodes;
import com.hxd.security.LoginToken;
import com.hxd.service.OpLogService;
import com.hxd.service.PowerService;
import com.hxd.service.UserService;
import com.hxd.site.ctl.LoginCtl;
import com.hxd.site.servlet.ValidateCodeServlet;
import com.hxd.util.StrUtil;

@Service("authRealm")
public class AuthRealm extends AuthorizingRealm  {
	
	protected final transient Log log = LogFactory.getLog(getClass());
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OpLogService LogService;
	
	@Autowired
	private PowerService powerService;
	
	/**
	 * 登录验证
	 */
	@ControllerLog(desc = "登录系统")
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken loginToken) throws AuthenticationException {
		log.debug("###@@@ 58 goto doGetAuthenticationInfo()....");
		long start = System.currentTimeMillis();
		LoginToken token = (LoginToken)loginToken;
		
		if (LoginCtl.isValidateCodeLogin(token.getUsername(), false, false)){
			// 判断验证码
			Session session = SecurityUtils.getSubject().getSession();
			String code = (String)session.getAttribute(ValidateCodeServlet.VALIDATE_CODE);
			if (token.getCaptcha() == null || !token.getCaptcha().toUpperCase().equals(code)){
				throw new CaptchaException("验证码错误.");
			}
		}

		User findUser = new User();
		findUser.setLoginname(token.getUsername());
		User user = userService.findBySelective(findUser);
		if (user != null ) {		
			
			if(user.getStatus()!=1) {
				throw new UserLockException(" ");
			}
			
			if(Encodes.validatePsw(String.valueOf(token.getPassword()), user.getPsw())) {
				//成功登录，记录日志
				long end = System.currentTimeMillis();
				long times = end - start;
				StringBuffer sb = new StringBuffer();
				sb.append("执行方法:login");
				sb.append(" 耗时:").append(times).append("ms;");
				sb.append(" 参数:").append(user.getLoginname());			
				String titlemsg = "用户{0}成功登录系统";
				try {
					HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest(); 
					// add log to database
					OpLog log = new OpLog();
					log.setLoginip(request.getRemoteAddr());
					log.setLoginname(user.getLoginname());
					log.setUserid(user.getId());
					log.setTitle(StrUtil.fillMsg(titlemsg,new String[] { user.getLoginname() }));
					log.setContent(sb.toString());
					log.setOptime(new Date());
					LogService.insertOpLog(log);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			
			
			return new SimpleAuthenticationInfo(new Principal(user),user.getPsw(),user.getRealname());
		} else {
			return null;
		}
		
	}

	

	/**
	 * 权限控制
	 */
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		log.debug("###@@@ 96 goto doGetAuthorizationInfo()....");
		Principal principal = (Principal) getAvailablePrincipal(principals);
		User findUser = new User();
		findUser.setLoginname(principal.getLoginName());
		User user = userService.findBySelective(findUser);
		
		if (user != null) {
			
			ShiroCache.putCache("user", user);
			List<Power> power = powerService.queryUserPower(user.getId());
			
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();		
			for(Power p : power){
				info.addStringPermission(p.getResource());
			}
			
			return info;
						
		}
			
		return null;
	}
	
	/**
	 * 设定检验
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
//		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher();
//		matcher.setHashIterations(Encodes.HASH_INTERATIONS);
//		matcher.setHashAlgorithmName(Encodes.HASH_ALGORITHM);
//		matcher.setHashSalted(true);
//		setCredentialsMatcher(matcher);
		
		setCredentialsMatcher(new AuthCM());
		
	}
	
	/**
	 * 清空用户关联权限认证，待下次使用时重新加载
	 */
	public void clearCachedAuthorizationInfo(String principal) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(principal, getName());
		clearCachedAuthorizationInfo(principals);
	}

	/**
	 * 清空所有关联认证
	 */
	public void clearAllCachedAuthorizationInfo() {
		Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
		if (cache != null) {
			for (Object key : cache.keys()) {
				cache.remove(key);
			}
		}
	}
	
	public static class Principal implements Serializable {

		private static final long serialVersionUID = 1L;
		
		private String id;
		private String loginName;
		private String name;
		private String psw;
		private Map<String, Object> cacheMap;

		public Principal(User user) {
			this.id = String.valueOf(user.getId());
			this.loginName = user.getLoginname();
			this.name = user.getRealname();
			this.psw = user.getPsw();
		}

		public String getId() {
			return id;
		}

		public String getLoginName() {
			return loginName;
		}

		public String getName() {
			return name;
		}

		public Map<String, Object> getCacheMap() {
			if (cacheMap==null){
				cacheMap = new HashMap<String, Object>();
			}
			return cacheMap;
		}

		public String getPsw() {
			return psw;
		}

	}
	
}
