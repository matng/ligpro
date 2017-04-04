package com.hxd.vo;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;


public class ResourceVo extends BaseVo {

    private Integer id;

    private Integer groupid;

    private Byte restype;

    private String bigpicurl;

    private String smallpicurl;

    private String fileurl;
    
    private List<String> idList;
    
    private String resName;
    
    private String groupName;
    
    private String menuUrl;
    
    private int limit;
    
    private int useType;
    
    private String slidepicdetailsurl;  //151117 tl

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	

	public Integer getGroupid() {
		return groupid;
	}

	public void setGroupid(Integer groupid) {
		this.groupid = groupid;
	}

	public Byte getRestype() {
		return restype;
	}

	public void setRestype(Byte restype) {
		this.restype = restype;
	}

	public String getBigpicurl() {
		return bigpicurl;
	}

	public void setBigpicurl(String bigpicurl) {
		this.bigpicurl = bigpicurl;
	}

	public String getSmallpicurl() {
		return smallpicurl;
	}

	public void setSmallpicurl(String smallpicurl) {
		this.smallpicurl = smallpicurl;
	}

	public String getFileurl() {
		return fileurl;
	}

	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}

	public List<String> getIdList() {
		return idList;
	}

	public void setIdList(List<String> idList) {
		this.idList = idList;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getUseType() {
		return useType;
	}

	public void setUseType(int useType) {
		this.useType = useType;
	}

	public String getResName() {
		return resName;
	}

	public void setResName(String resName) {
		this.resName = resName;
	}

	//151117 tl
	public String getSlidePicDetailsUrl() {
		return slidepicdetailsurl;
	}

	public void setSlidePicDetailsUrl(String slidepicdetailsurl) {
		this.slidepicdetailsurl = slidepicdetailsurl;
	}
	
	
}
