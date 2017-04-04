package com.hxd.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.OperatingSystem;
import eu.bitwalker.useragentutils.UserAgent;

/**
 * IP工具类
 * 
 * @author sy
 * 
 */
public class IpUtil {

	/**
	 * 获取登录用户的IP地址
	 * 
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if (ip.equals("0:0:0:0:0:0:0:1")) {
			ip = "本地";
		}
		if (ip.split(",").length > 1) {
			ip = ip.split(",")[0];
		}
		//return getIpInfo(ip);
		return ip;
	}

	/**
	 * 通过IP获取地址信息
	 * 
	 * @param ip
	 * @return
	 */
	public static Map<String,String> getIpInfo(String ip) {
		Map<String,String> map = new HashMap<String,String>();
		try {
			URL url = new URL("http://ip.taobao.com/service/getIpInfo.php?ip=" + ip);
			HttpURLConnection htpcon = (HttpURLConnection) url.openConnection();
			htpcon.setRequestMethod("GET");
			htpcon.setDoOutput(true);
			htpcon.setDoInput(true);
			htpcon.setUseCaches(false);

			InputStream in = htpcon.getInputStream();
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(in));
			StringBuffer temp = new StringBuffer();
			String line = bufferedReader.readLine();
			while (line != null) {
				temp.append(line).append("\r\n");
				line = bufferedReader.readLine();
			}
			bufferedReader.close();
			JSONObject obj = (JSONObject) JSON.parse(temp.toString());
			if (obj.getIntValue("code") == 0) {
				JSONObject data = obj.getJSONObject("data");
				map.put("country", data.getString("country"));
				map.put("region", data.getString("region"));
				map.put("city", data.getString("city"));
				map.put("isp", data.getString("isp"));
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 取得当前用户IP(如果服务器用了反向代理，必须用这个方法才能获取用户登录的真实IP)
	 */
	public static String getCurrentUserIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("x-client-ip");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		
		// 多级反向代理
		if (null != ip && !"".equals(ip.trim())) {
			StringTokenizer st = new StringTokenizer(ip, ",");
			if (st.countTokens() > 1) {
				return st.nextToken();
			}
		}
		return ip;
	}
	
	public static Map<String,String> getClicentInfo(HttpServletRequest request){
		Map<String,String> map = new HashMap<String,String>();
		UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));  
	       Browser browser = userAgent.getBrowser();  
	       OperatingSystem os = userAgent.getOperatingSystem();
	       map.put("browser", browser.toString());
	       map.put("os", os.toString());
		return map;
		
	}
	
	public static void main(String[] args) {
		System.out.println(getIpInfo("117.135.231.12"));
	}

}
