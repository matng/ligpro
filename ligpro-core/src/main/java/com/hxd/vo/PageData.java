package com.hxd.vo;

public class PageData {

	public int iTotalRecords;
	public int iTotalDisplayRecords;
	public String sEcho;
	public String aaData;
	
	public int getiTotalRecords() {
		return iTotalRecords;
	}
	public void setiTotalRecords(int iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}
	public int getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}
	public void setiTotalDisplayRecords(int iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}
	public String getsEcho() {
		return sEcho;
	}
	public void setsEcho(String sEcho) {
		this.sEcho = sEcho;
	}
	public String getAaData() {
		return aaData;
	}
	public void setAaData(String aaData) {
		this.aaData = aaData;
	}
	
	
	
	
}
