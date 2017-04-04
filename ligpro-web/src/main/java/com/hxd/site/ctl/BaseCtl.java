package com.hxd.site.ctl;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

public abstract class BaseCtl {

	protected final transient Log log = LogFactory.getLog(getClass());
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private ResourceBundleMessageSource res;
	
	@ExceptionHandler
    public String handleException(HttpServletRequest request, Exception ex) {
        String errorViewPage = "error";

        // 记录异常日志
        log.error(ex.getMessage(), ex);

        
        /**
         * // 异常处理
        if (ex instanceof BusinessException) {
        	errorViewPage = "errors/other-error";
        } else {
            // 异常转换
            ex = new Exception("系统太累了，需要休息!");
        }
        **/
        
        request.setAttribute("ex", ex);
        return errorViewPage;
    }
	
	
	protected String getMessage(String code) {
		return getMessage(code, new Object[] {});
	}

	protected String getMessage(String code, Object arg0) {
		return getMessage(code, new Object[] { arg0 });
	}

	protected String getMessage(String code, Object arg0, Object arg1) {
		return getMessage(code, new Object[] { arg0, arg1 });
	}

	protected String getMessage(String code, Object arg0, Object arg1,
			Object arg2) {
		return getMessage(code, new Object[] { arg0, arg1, arg2 });
	}

	protected String getMessage(String code, Object arg0, Object arg1,
			Object arg2, Object arg3) {
		return getMessage(code, new Object[] { arg0, arg1, arg2, arg3 });
	}
	
	protected String getMessage(String code, Object[] args) {
		//HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		Locale locale = localeResolver.resolveLocale(request);

		return res.getMessage(code, args, locale);
	}
	
	
	
	
	
	
}
