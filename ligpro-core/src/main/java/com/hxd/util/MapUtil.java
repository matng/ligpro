package com.hxd.util;

import java.util.ArrayList;
import java.util.List;

import com.hxd.bean.Content;
import com.hxd.bean.Menu;
import com.hxd.vo.TPLVo;

public class MapUtil {

	
	
	public static List<Menu> getSubMenuList(List<Menu> allMenu, int parentId) {
		try {
			if (allMenu==null || allMenu.size()==0) {
				return null;
			}
			
			List<Menu> list = new ArrayList<Menu>();
			for (Menu m : allMenu) {
				if (m.getParentmenuid().intValue()==parentId) {
					list.add(m);
				}
			}
			return list;
			
		} catch (Exception e) {		
			e.printStackTrace();
			return null;
		}
		
	}
	
	public static List<Menu> getTopMenuList(List<Menu> allMenu) {
		return getSubMenuList(allMenu,0);
	}
	
	
	public static TPLVo getSubListContent(List<Content> list, String templateUrl) {
		try {
			TPLVo vo = new TPLVo();
			if (list==null || list.size()==0) {
				return null;
			}
			List<Content> subList = new ArrayList<Content>();
			for (Content c : list) {
				if (c.getContent().indexOf(templateUrl)>=0) {
					vo.setMoreUrl(c.getHtmlurl());
					subList.add(c);
				}
			}
			vo.setContentList(subList);
			return vo;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
}
