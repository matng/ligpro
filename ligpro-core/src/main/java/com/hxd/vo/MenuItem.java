package com.hxd.vo;

public class MenuItem extends Item{

	private Integer id;

    private Integer moduleid;

    private String menucode;

    private String menuname;

    private Integer parentmenuid;

    private String menuurl;

    private Integer templateid;

    private String templateurl;

    private Integer seqno;

    private Integer isenable;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getModuleid() {
		return moduleid;
	}

	public void setModuleid(Integer moduleid) {
		this.moduleid = moduleid;
	}

	public String getMenucode() {
		return menucode;
	}

	public void setMenucode(String menucode) {
		this.menucode = menucode;
	}

	public String getMenuname() {
		return menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	public Integer getParentmenuid() {
		return parentmenuid;
	}

	public void setParentmenuid(Integer parentmenuid) {
		this.parentmenuid = parentmenuid;
	}

	public String getMenuurl() {
		return menuurl;
	}

	public void setMenuurl(String menuurl) {
		this.menuurl = menuurl;
	}

	public Integer getTemplateid() {
		return templateid;
	}

	public void setTemplateid(Integer templateid) {
		this.templateid = templateid;
	}

	public String getTemplateurl() {
		return templateurl;
	}

	public void setTemplateurl(String templateurl) {
		this.templateurl = templateurl;
	}

	public Integer getSeqno() {
		return seqno;
	}

	public void setSeqno(Integer seqno) {
		this.seqno = seqno;
	}

	public Integer getIsenable() {
		return isenable;
	}

	public void setIsenable(Integer isenable) {
		this.isenable = isenable;
	}
    
    
    
    
}
