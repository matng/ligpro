package com.hxd.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringEscapeUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class StrUtil {
	public static final String TEMP_LIST_PAGE = "list";
	public static final String TEMP_DETAIL_PAGE = "detail";
	
	/**
	 * 修复json字串
	 * @param json
	 * @return
	 */
	public static String fixJsonStr(String json) {
		json=json.replaceAll("\\\\", "");
		json = json.replace(Matcher.quoteReplacement("]\""), "]");
		json = json.replace(Matcher.quoteReplacement("\"["), "[");
		return json;
	}
	
	
	public static String fixJsonForLogStr(String json) {
		json=json.replaceAll("\\\\", "");
		json = json.replace(Matcher.quoteReplacement("]\""), "");
		json = json.replace(Matcher.quoteReplacement("\"["), "");
		json = json.replace(Matcher.quoteReplacement("]"), "");
		json = json.replace(Matcher.quoteReplacement("["), "");
		json = json.replace(Matcher.quoteReplacement("\""), "");
		json = json.replace(Matcher.quoteReplacement("{"), "");
		json = json.replace(Matcher.quoteReplacement("}"), "");
		return json;
	}
	
	public static String encodeHtml(String html) {
		try {
			if (isNull(html)) {
				return "";
			}
			html = html.replaceAll("&", "&amp;");
			html = html.replaceAll("<", "&lt;");
			html = html.replaceAll(">", "&gt;");
			html = html.replaceAll(" ", "&nbsp;");
			html = html.replaceAll("'", "&#39;");
			html = html.replaceAll("\"", "&quot;");
			html = html.replaceAll("\n", "<br>");
		
			return html;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	
	public static String decodeHtml(String html) {
		try {
			if (isNull(html)) {
				return "";
			}
			html = html.replaceAll("&amp;", "&");
			html = html.replaceAll("&lt;", "<");
			html = html.replaceAll("&gt;", ">");
			html = html.replaceAll("&nbsp;", " ");
			html = html.replaceAll("&#39;", "'");
			html = html.replaceAll("&quot;", "\"");
			html = html.replaceAll("<br>", "\n");
		
			return html;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	public static String toJsonStr(Object obj) {
		if (obj==null) 
			return "";
		
		String json = JSON.toJSONString(obj);
		return json;
	}
	
	public static String toJsonStrWithFixed(Object obj) {
		if (obj==null) 
			return "";
		
		String json = JSON.toJSONString(obj);
		return fixJsonStr(json);
	}
	
	
	/**
	 * 通过 key取json值
	 * @param json
	 * @param key
	 * @return
	 */
	public static String getValueFromJson(String json,String key) {
		if (key==null || json==null) 
			return "";		
		String value = "";
		JSONArray arr = JSON.parseArray(json);
		JSONObject j = null;
		for (Object obj : arr) {
			j=(JSONObject)obj;			
			 if(j.get("name").equals(key)) {
				 value = j.get("value").toString();
				 break;
			 }     
		}
		return value;
	}
	
	public static String getStrFromStream(InputStream in) {
		StringBuffer sb = new StringBuffer();		
		try {
			InputStreamReader isr = new InputStreamReader(in);
			BufferedReader br = new BufferedReader(isr); 
			String s = "" ; 
			while((s=br.readLine())!=null){ 
				sb.append(s) ; 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	public static boolean isNotNull(String str) {
		return str!=null && str.trim().length()>0 ? true : false;
	}
	
	public static boolean isNull(String str) {
		return !isNotNull(str);
	}
	

	/**
	 * 替换消息
	 * @param str
	 * @param arr
	 * @return
	 */
	public static String fillMsg(String msg, String[] arr) {
		Matcher m = Pattern.compile("\\{(\\d)\\}").matcher(msg);
		while (m.find()) {
			msg = msg.replace(m.group(), arr[Integer.parseInt(m.group(1))]);
		}
		return msg;
	}
	
	/**
	 * 替换掉HTML标签方法
	 */
	public static String replaceHtml(String html) {
		if (!isNotNull(html)){
			return "";
		}
		String regEx = "<.+?>";
		Pattern p = Pattern.compile(regEx);
		Matcher m = p.matcher(html);
		String s = m.replaceAll("");
		return s;
	}

	
	/**
	 * 缩略字符串（不区分中英文字符）
	 * @param str 目标字符串
	 * @param length 截取长度
	 * @return
	 */
	public static String abbr(String str, int length) {
		if (str == null) {
			return "";
		}
		try {
			StringBuilder sb = new StringBuilder();
			int currentLength = 0;
			for (char c : replaceHtml(StringEscapeUtils.unescapeHtml4(str)).toCharArray()) {
				currentLength += String.valueOf(c).getBytes("GBK").length;
				if (currentLength <= length - 3) {
					sb.append(c);
				} else {
					sb.append("...");
					break;
				}
			}
			return sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	/**
	 * 随机数生成 
	 * @param length
	 * @return
	 */
	public static String randomNum(int length) {
		StringBuffer sb = new StringBuffer();
		try {
			Random r=new Random();
			for(int i=0; i<length; i++){
				sb.append(r.nextInt(10));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	
	public static String getTemplateForList(String tempUrl) {
		String temp_name = null;
		try {
			String[] tempList = tempUrl.split("[|]");
			if(tempList.length==1) {
				temp_name = tempList[0];
			} else {
				for (String temp : tempList) {
					if (temp.indexOf(TEMP_LIST_PAGE)>0) {
						temp_name = temp;
						break;
					}
				}
			}
			if (temp_name!=null) {
				temp_name = temp_name.substring(0, temp_name.length()-4);;
			}
		} catch (Exception e) {		
			e.printStackTrace();
			return null;
		}
		return temp_name;
	}
	
	public static String getTemplateForDetail(String tempUrl) {
		String temp_name = null;
		try {
			String[] tempList = tempUrl.split("[|]");
			if(tempList.length==1) {
				temp_name = tempList[0];
			} else {
				for (String temp : tempList) {
					if (temp.indexOf(TEMP_DETAIL_PAGE)>0) {
						temp_name = temp;
						break;
					}
				}
			}
			
			if (temp_name!=null) {
				temp_name = temp_name.substring(0, temp_name.length()-4);;
			}
		} catch (Exception e) {		
			e.printStackTrace();
			return null;
		}
		return temp_name;
	}
	
	public static String getStr(String str) {
		return str!=null && str.length()>0 ? str : "";
	}
	
	public static void main(String[] args) {
		try {
			String s = randomNum(8);
			System.out.println(s);
			
			String temp = "home.jsp";
			
			//System.out.println(getTemplateForList(temp));
			//System.out.println(getTemplateForDetail(temp));
			
			String html = "<img scr='abc.jsp' code=\"cccc\"/> \n";
			String encodeHtml = encodeHtml(html);
			System.out.println(encodeHtml);
			System.out.println(decodeHtml(encodeHtml));

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
}
