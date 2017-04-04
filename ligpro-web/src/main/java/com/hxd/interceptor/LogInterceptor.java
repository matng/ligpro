
package com.hxd.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.NamedThreadLocal;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.hxd.bean.User;
import com.hxd.site.filter.ShiroCache;
import com.hxd.util.StrUtil;

import eu.bitwalker.useragentutils.DeviceType;
import eu.bitwalker.useragentutils.UserAgent;

/**
 * 日志记录拦截器
 */
public class LogInterceptor  implements HandlerInterceptor {

	private NamedThreadLocal<Long>  startTimeThreadLocal = new NamedThreadLocal<Long>("startTimeThreadLocal");
	private NamedThreadLocal<String>  paramThreadLocal = new NamedThreadLocal<String>("paramThreadLocal");
	
	protected final transient Log log = LogFactory.getLog(getClass());
	

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		long beginTime = System.currentTimeMillis();
        startTimeThreadLocal.set(beginTime);


        User user = ShiroCache.getUser();
		if (user!=null && user.getId()!=null) {			
			//paramThreadLocal.set(StrUtil.getStrFromStream(request.getInputStream()));
			//log.debug("### inputStream1="+paramThreadLocal.get());
			
		}
		return true;
	}


	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, 
			ModelAndView modelAndView) throws Exception {
		if(modelAndView!=null) {
			String viewName = modelAndView.getViewName();
			UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent")); 
			if(viewName.startsWith("modules/") && DeviceType.MOBILE.equals(userAgent.getOperatingSystem().getDeviceType())){
				modelAndView.setViewName(viewName.replaceFirst("modules", "mobile"));
			}
			
//			log.debug("### LogInterceptor ### viewName="+viewName);
//			log.debug("### LogInterceptor ### os.getDeviceType="+userAgent.getOperatingSystem().getDeviceType());
		}
		
	}


	@Transactional(readOnly = false)
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object handler, Exception ex) throws Exception {
		long endTime = System.currentTimeMillis();
        long beginTime = startTimeThreadLocal.get();
        long consumeTime = endTime - beginTime;
        
		String requestRri = request.getRequestURI();
		String uriPrefix = request.getContextPath();
		log.debug("### LogInterceptor ### requestRri"+requestRri);
		log.debug("### LogInterceptor ### uriPrefix"+uriPrefix);
		User user = ShiroCache.getUser();
		if (user!=null && user.getId()!=null) {
			StringBuilder params = new StringBuilder();
			int index = 0;
	
			for (Object param : request.getParameterMap().keySet()){ 
				params.append((index++ == 0 ? "" : "&") + param + "=");
				params.append(StrUtil.abbr(StringUtils.endsWithIgnoreCase((String)param, "password")
						? "" : request.getParameter((String)param), 100));
			}
			

			//log.debug("### inputStream2="+paramThreadLocal.get());
			log.debug("### LogInterceptor ### afterCompletion 运行时间: "+consumeTime);
			log.debug("### LogInterceptor ###  params="+params.toString());
			log.debug("### LogInterceptor ### 最大内存:"+Runtime.getRuntime().maxMemory());
			log.debug("### LogInterceptor ### 已分配内存:"+Runtime.getRuntime().totalMemory());
			log.debug("### LogInterceptor ###  已分配内存中的剩余空间:"+Runtime.getRuntime().freeMemory());
			log.debug("### LogInterceptor ###  最大可用内存:"+(Runtime.getRuntime().maxMemory()-Runtime.getRuntime().totalMemory()+Runtime.getRuntime().freeMemory()));
			
		}
		

		
	}

}
