package com.hxd.interceptor;

import java.lang.reflect.Method;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.hxd.bean.OpLog;
import com.hxd.bean.User;
import com.hxd.service.OpLogService;
import com.hxd.site.ctl.ParseCtl;
import com.hxd.site.filter.ShiroCache;
import com.hxd.util.StrUtil;

/**
 * 日志记录AOP
 */
@Aspect
@Component
public class LogAspect {

	@Autowired
	private OpLogService LogService;// 日志记录Service
	
	@Autowired
	private ResourceBundleMessageSource messageSource;

	
	@Pointcut("@annotation(com.hxd.interceptor.ControllerLog)")
	public  void controllerLogAspect() {
		
	}
	
	
	@Around(value = "controllerLogAspect()")
	public Object doControllerAround(JoinPoint joinPoint) throws Throwable {
		long start = System.currentTimeMillis();
		Object result = null;
		try {
			result = ((ProceedingJoinPoint) joinPoint).proceed();
			long end = System.currentTimeMillis();
			long times = end - start;

			HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder
					.getRequestAttributes()).getRequest();

			// 获取登录信息
			User user = ShiroCache.getUser();

			if (user == null || StrUtil.isNull(user.getLoginname())) {
				return null;
			}
			
			String methodName = joinPoint.getSignature().getName();
			String targetName = joinPoint.getTarget().getClass().getName();
			Object[] arguments = joinPoint.getArgs();
					
			String[] arr = getControllerLogInfo(targetName,methodName,arguments);
//			System.out.println("######@@@@@@ 进入  doDataCacheClearAround()...arr[0]="+arr[0]);	
//			System.out.println("######@@@@@@ 进入  doDataCacheClearAround()...arr[1]="+arr[1]);	
//			System.out.println("######@@@@@@ 进入  doDataCacheClearAround()...arr[2]="+arr[2]);	
			if ("true".equals(arr[1])) {
				ParseCtl.cleanCacheMap();
			}
			
//			System.out.println("###@@@ methodName="+methodName);
//			System.out.println("###@@@ targetName="+targetName);
//			System.out.println("###@@@ desc="+desc);
			StringBuffer argSb = new StringBuffer();
			for (Object obj : arguments) {
				argSb.append(obj.toString()).append(" ");
				//System.out.println("###@@@ arguments="+obj);
			}
			
			StringBuffer sb = new StringBuffer();
			sb.append("执行方法:").append(methodName);
			sb.append(" 耗时:").append(times).append("ms;");
			sb.append(" 参数:").append(StrUtil.fixJsonForLogStr(argSb.toString()));			
			String titlemsg = "用户{0}"+getMessage(arr[0]);

			// add log to database
			OpLog log = new OpLog();
			log.setLoginip(req.getRemoteAddr());
			log.setLoginname(user.getLoginname());
			log.setUserid(user.getId());
			log.setTitle(StrUtil.fillMsg(titlemsg,new String[] { user.getLoginname() }));
			log.setContent(sb.toString());
			log.setOptime(new Date());
			LogService.insertOpLog(log);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static String[] getControllerLogInfo(String targetName, String methodName,Object[] arguments) 
			throws Exception {

		Class targetClass = Class.forName(targetName);
		Method[] method = targetClass.getMethods();
		String[] arr = new String[3];
		for (Method m : method) {
			if (m.getName().equals(methodName)) {
				Class[] tmpCs = m.getParameterTypes();
				if (tmpCs.length == arguments.length) {
					ControllerLog methodCache = m.getAnnotation(ControllerLog.class);
					if (methodCache != null) {
						arr[0] = methodCache.desc();
						arr[1] = methodCache.cleanData();
						arr[2] = methodCache.logType();
					}
					break;
				}
			}
		}
		return arr;
	}
	
	
	/**
	 * 获取i18n消息
	 * 
	 * @return String
	 */
	public String getMessage(String code, Object[] args) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		Locale locale = localeResolver.resolveLocale(request);

		return messageSource.getMessage(code, args, locale);
	}
	
	public String getMessage(String code) {
		return getMessage(code, new Object[] {});
	}

	public String getMessage(String code, Object arg0) {
		return getMessage(code, new Object[] { arg0 });
	}

	public String getMessage(String code, Object arg0, Object arg1) {
		return getMessage(code, new Object[] { arg0, arg1 });
	}

	public String getMessage(String code, Object arg0, Object arg1,
			Object arg2) {
		return getMessage(code, new Object[] { arg0, arg1, arg2 });
	}

	public String getMessage(String code, Object arg0, Object arg1,
			Object arg2, Object arg3) {
		return getMessage(code, new Object[] { arg0, arg1, arg2, arg3 });
	}

}
