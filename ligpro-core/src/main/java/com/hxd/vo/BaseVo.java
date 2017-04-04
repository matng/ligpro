package com.hxd.vo;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class BaseVo {

	public int iTotalRecords;
	public int iTotalDisplayRecords;
	public String sEcho;
	public String sColumns;
	public String aaData;
	public String sSearch;
	public int iDisplayLength;
	public int iDisplayStart;
	public String aoData;
	public String orderField;
	public String orderDirection;
	public String sortCol;
	
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
	public String getsColumns() {
		return sColumns;
	}
	public void setsColumns(String sColumns) {
		this.sColumns = sColumns;
	}
	public String getAaData() {
		return aaData;
	}
	public void setAaData(String aaData) {
		this.aaData = aaData;
	}
	public String getsSearch() {
		return sSearch;
	}
	public void setsSearch(String sSearch) {
		this.sSearch = sSearch;
	}
	public int getiDisplayLength() {
		return iDisplayLength;
	}
	public void setiDisplayLength(int iDisplayLength) {
		this.iDisplayLength = iDisplayLength;
	}
	public int getiDisplayStart() {
		return iDisplayStart;
	}
	public void setiDisplayStart(int iDisplayStart) {
		this.iDisplayStart = iDisplayStart;
	}
	
	
	
	public String getSortCol() {
		return sortCol;
	}
	public void setSortCol(String sortCol) {
		this.sortCol = sortCol;
	}
	public String getOrderField() {
		return orderField;
	}
	public void setOrderField(String orderField) {
		this.orderField = orderField;
	}
	public String getOrderDirection() {
		return orderDirection;
	}
	public void setOrderDirection(String orderDirection) {
		this.orderDirection = orderDirection;
	}
	public String getAoData() {
		return aoData;
	}
	public void setAoData(String aoData) {
		this.aoData = aoData;
		init();
		initOrderField();
	}
	
	private void init() {
		if (this.aoData!=null && this.aoData.length()>0) {
			JSONArray arr = JSON.parseArray(this.getAoData());
			JSONObject j = null;
			for (Object obj : arr) {
				j=(JSONObject)obj;			
				 if(j.get("name").equals("sEcho")) {
					 this.setsEcho(j.get("value").toString());
				 }

		         if(j.get("name").equals("iDisplayStart"))  {
		        	 this.setiDisplayStart(Integer.parseInt(j.get("value").toString()));
		         }
		               
	            if(j.get("name").equals("iDisplayLength")){
	            	this.setiDisplayLength(Integer.parseInt(j.get("value").toString()));
	            }
	            if(j.get("name").equals("sSearch")) {
					 this.setsSearch(j.get("value").toString());
				 }
	            if(j.get("name").equals("iSortCol_0")) {
					 this.setOrderField(String.valueOf(j.get("value").toString()));
				 }
	            if(j.get("name").equals("sSortDir_0")) {
					 this.setOrderDirection(j.get("value").toString());
				 }
	            if(j.get("name").equals("sortCol")) {
					 this.setSortCol(j.get("value").toString());
				 }
			}
		}		
	}
	
	private void initOrderField() {
		if (orderField!=null) {
			String[] cols = sortCol.split("[,]");
			if (cols  != null && cols.length>0) {
				orderField = cols[Integer.parseInt(orderField)];
				
			}
		}
		
	}
	
}
