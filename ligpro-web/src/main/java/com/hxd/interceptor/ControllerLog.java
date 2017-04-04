package com.hxd.interceptor;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * 控制层的Log注解
 * 
 */
@Documented
@Target({ElementType.PARAMETER,ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface ControllerLog {

	String desc() default "";
	
	String logType() default "0";
	
	String cleanData() default "";
}
