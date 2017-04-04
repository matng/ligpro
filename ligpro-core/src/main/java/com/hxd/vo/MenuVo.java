package com.hxd.vo;

import java.util.List;


public class MenuVo extends BaseVo {

    private Integer id;

    private String modulecode;

    private String modulename;

    private String moduledesc;

    private Integer seqno;

    private Byte isenable;
    
    private List<String> idList;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getModulecode() {
		return modulecode;
	}

	public void setModulecode(String modulecode) {
		this.modulecode = modulecode;
	}

	public String getModulename() {
		return modulename;
	}

	public void setModulename(String modulename) {
		this.modulename = modulename;
	}

	public String getModuledesc() {
		return moduledesc;
	}

	public void setModuledesc(String moduledesc) {
		this.moduledesc = moduledesc;
	}

	public Integer getSeqno() {
		return seqno;
	}

	public void setSeqno(Integer seqno) {
		this.seqno = seqno;
	}

	public Byte getIsenable() {
		return isenable;
	}

	public void setIsenable(Byte isenable) {
		this.isenable = isenable;
	}

	public List<String> getIdList() {
		return idList;
	}

	public void setIdList(List<String> idList) {
		this.idList = idList;
	}
	
	
}
