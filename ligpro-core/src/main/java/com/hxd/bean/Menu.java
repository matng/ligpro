package com.hxd.bean;

public class Menu {
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
    
    private Integer count;
    
    private Integer statusC;
    
    private Integer statusR;
    
    private Integer statusU;
    
    private Integer statusD;
    
    private Integer statusA;
    
    private Integer statusK;
    
    private Byte type;

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
        this.menucode = menucode == null ? null : menucode.trim();
    }

    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname == null ? null : menuname.trim();
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
        this.menuurl = menuurl == null ? null : menuurl.trim();
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
        this.templateurl = templateurl == null ? null : templateurl.trim();
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

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getStatusC() {
		return statusC;
	}

	public void setStatusC(Integer statusC) {
		this.statusC = statusC;
	}

	public Integer getStatusR() {
		return statusR;
	}

	public void setStatusR(Integer statusR) {
		this.statusR = statusR;
	}

	public Integer getStatusU() {
		return statusU;
	}

	public void setStatusU(Integer statusU) {
		this.statusU = statusU;
	}

	public Integer getStatusD() {
		return statusD;
	}

	public void setStatusD(Integer statusD) {
		this.statusD = statusD;
	}

	public Integer getStatusA() {
		return statusA;
	}

	public void setStatusA(Integer statusA) {
		this.statusA = statusA;
	}
	
	public Integer getStatusK() {
		return statusK;
	}

	public void setStatusK(Integer statusK) {
		this.statusK = statusK;
	}

	public Byte getType() {
		return type;
	}

	public void setType(Byte type) {
		this.type = type;
	}
	
	

}