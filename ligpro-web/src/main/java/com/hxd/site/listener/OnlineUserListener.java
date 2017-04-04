package com.hxd.site.listener;

import java.util.Date;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.hxd.bean.User;
import com.hxd.bean.Visit;
import com.hxd.service.VisitService;
import com.hxd.site.filter.ShiroCache;
import com.hxd.util.IpUtil;

public class OnlineUserListener  implements ServletContextListener,ServletContextAttributeListener,
									HttpSessionListener,HttpSessionAttributeListener,ServletRequestListener {
	
	public static final String APPLCATION_USER_KEY = "ApplcationUser";
	public static final String SESSION_USER_KEY = "SessionUser";
	public static final String SHIRO_KEY = "org.apache.shiro.subject.support.DefaultSubjectContext_PRINCIPALS_SESSION_KEY";
	
	private HttpServletRequest request = null;

	@Override
	public void attributeAdded(HttpSessionBindingEvent se) {	   
		 if (se.getName().equals(SHIRO_KEY)) {
			 System.out.println("@@@### attributeAdded obj=" + se.getValue());
			 
		 }
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent se) {
		if (se.getName().equals(SHIRO_KEY)) {
			User u = ShiroCache.getUser();
			if (u!=null) {
				ShiroCache.onlineUserMap.remove(u.getLoginname());
				System.out.println("###@@@ 当前在线数:"+ShiroCache.onlineUserMap.size());
				System.out.println("###@@@ session移除 loginname="+u.getLoginname());
			}
			
		}
		
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent se) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		
		String sUrl = request.getServletPath();
		String rUrl = sUrl.replace("/", "");
		if(sUrl != null && (rUrl.equals("home") || rUrl.equals("index.jsp"))){
			ServletContext sc = se.getSession().getServletContext();
			ApplicationContext beans = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
			VisitService visitService = (VisitService) beans.getBean("VisitService");
			Visit visit = new Visit();
			String ip = IpUtil.getCurrentUserIp(request);
			Map<String,String> ipAddr = IpUtil.getIpInfo(ip);
			Map<String,String> map = IpUtil.getClicentInfo(request);
			
			visit.setIp(ip);
			visit.setVdate(new Date());
			visit.setBrowser(map.get("browser"));
			visit.setOs(map.get("os"));
			visit.setCountry(ipAddr.get("country"));
			visit.setRegion(ipAddr.get("region"));
			visit.setCity(ipAddr.get("city"));
			visit.setIsp(ipAddr.get("isp"));
			visitService.insertSelective(visit);
		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attributeAdded(ServletContextAttributeEvent scab) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attributeRemoved(ServletContextAttributeEvent scab) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attributeReplaced(ServletContextAttributeEvent scab) {
		// TODO Auto-generated method stub
		
	}
	
	
	public void contextInitialized(ServletContextEvent sce) {
	
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		
	}  
	
	@Override
	public void requestInitialized(ServletRequestEvent event) {
		request = (HttpServletRequest)event.getServletRequest();
		  
	}

	@Override
	public void requestDestroyed(ServletRequestEvent sre) {
		// TODO Auto-generated method stub
		
	}
	
}  