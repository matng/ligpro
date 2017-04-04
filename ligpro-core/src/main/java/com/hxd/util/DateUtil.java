package com.hxd.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	public static final String YMD_HMSS = "yyyy-MM-dd HH:mm:ss:SSS";
	
	public static final String YMD_HMS = "yyyy-MM-dd HH:mm:ss";

	public static final String YMD = "yyyy-MM-dd";
	
	public static final String Y = "yyyy";
	
	public static final String M = "M";

	public static final String YMDH = "yyyyMMddHH";
	
	public static String date2Str(Date date) {
		String dStr = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(YMD_HMS);
			dStr = sdf.format(date);
		} catch (Exception e) {
			SimpleDateFormat sdf = new SimpleDateFormat(YMD_HMSS);
			dStr = sdf.format(date);
			return dStr;
		}
		
		return dStr;
	}
	
	public static String date2Str(Date date,String dateFormat) {
		SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
		return sdf.format(date);
	}
	
	//字符串转为时间
	public static Date str2date(String dateStr,String dateFormat) {
		SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
		try {
			return sdf.parse(dateStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	//获取两个时间之间的毫秒数
	public static Long getTimeBetween(String dateBegin,String dateEnd) {
		Date startDate = DateUtil.str2date(dateBegin, YMD_HMSS);
		Date endDate = DateUtil.str2date(dateEnd, YMD_HMSS);
		return endDate.getTime() - startDate.getTime();
	}
	
	public static String getCurYear() {
		SimpleDateFormat sdf = new SimpleDateFormat(Y);
		return sdf.format(new Date());
	}
	
	public static String getCurMonth() {
		SimpleDateFormat sdf = new SimpleDateFormat(M);
		return sdf.format(new Date());
	}
	
	public static void main(String[] args) {
		System.out.println(getCurYear());
		System.out.println(getCurMonth());
		System.out.println(date2Str(new Date(),DateUtil.YMD_HMSS));
	}
	
}
