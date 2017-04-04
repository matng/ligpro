package com.hxd.site.filter;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.subject.Subject;

import com.hxd.bean.User;
import com.hxd.security.SpringContextHolder;
import com.hxd.service.UserService;
import com.hxd.site.filter.AuthRealm.Principal;

public class ShiroCache {
	
	private static UserService userService = SpringContextHolder.getBean(UserService.SERVICE_NAME);
	
	public static Map<String,User> onlineUserMap = new HashMap<String,User>();
	
	public static final String CACHE_USER = "UserCacheKey";
	public static final String CACHE_ROLE_LIST = "UserRoleList";
	public static final String CACHE_MENU_LIST = "UserMenuList";
	
	
	public static Object getCache(String key) {
		return getCache(key, null);
	}
	
	public static Object getCache(String key, Object defaultValue) {
		Object obj = getCacheMap().get(key);
		return obj==null?defaultValue:obj;
	}

	public static void putCache(String key, Object value) {
		getCacheMap().put(key, value);
	}

	public static void removeCache(String key) {
		getCacheMap().remove(key);
	}
	
	public static Map<String, Object> getCacheMap(){
		Map<String, Object> map = new HashMap<String ,Object>();
		try{
			Subject subject = SecurityUtils.getSubject();
			Principal principal = (Principal)subject.getPrincipal();
			return principal!=null ? principal.getCacheMap():map;
		}catch (UnavailableSecurityManagerException e) {
			e.printStackTrace();
		}catch (InvalidSessionException e){
			e.printStackTrace();
		}
		return map;
	}
	
	
	public static User getUser() {
		User user = (User) ShiroCache.getCache(ShiroCache.CACHE_USER);
		if (user == null) {
			try {
				Subject subject = SecurityUtils.getSubject();
				Principal principal = (Principal) subject.getPrincipal();

				if (principal != null) {
					user = userService.selectByPrimaryKey(Integer.parseInt(principal.getId()));
					ShiroCache.putCache(ShiroCache.CACHE_USER, user);
				}
			} catch (UnavailableSecurityManagerException e) {
				e.printStackTrace();
			} catch (InvalidSessionException e) {
				e.printStackTrace();
			}
		}
		return user;
	}

	public static User getUser(boolean isRefresh) {
		if (isRefresh) {
			ShiroCache.removeCache(ShiroCache.CACHE_USER);
		}
		return getUser();
	}
}
