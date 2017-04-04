package com.hxd.vo;

import java.util.List;

import com.hxd.bean.Content;
import com.hxd.bean.Menu;

public class TPLVo {

	//for menu
	private Menu menu;
	private List<Menu> subMenu;
	private int subMenuLength;
	
	
	//for contents
	private String moreUrl;
	private List<Content> contentList;
	
	
	
	
	public String getMoreUrl() {
		return moreUrl;
	}
	public void setMoreUrl(String moreUrl) {
		this.moreUrl = moreUrl;
	}
	public List<Content> getContentList() {
		return contentList;
	}
	public void setContentList(List<Content> contentList) {
		this.contentList = contentList;
	}
	public Menu getMenu() {
		return menu;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	public List<Menu> getSubMenu() {
		return subMenu;
	}
	public void setSubMenu(List<Menu> subMenu) {
		this.subMenu = subMenu;
	}
	public int getSubMenuLength() {
		return subMenuLength;
	}
	public void setSubMenuLength(int subMenuLength) {
		this.subMenuLength = subMenuLength;
	}
	
	
}
