package com.hxd.vo;

public class PowerVo {
	private Integer id;

    private String owner;

    private Integer ownerid;

    private String resource;

    private Integer resourceid;

    private Byte isenable;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public Integer getOwnerid() {
		return ownerid;
	}

	public void setOwnerid(Integer ownerid) {
		this.ownerid = ownerid;
	}

	public String getResource() {
		return resource;
	}

	public void setResource(String resource) {
		this.resource = resource;
	}

	public Integer getResourceid() {
		return resourceid;
	}

	public void setResourceid(Integer resourceid) {
		this.resourceid = resourceid;
	}

	public Byte getIsenable() {
		return isenable;
	}

	public void setIsenable(Byte isenable) {
		this.isenable = isenable;
	}
}
