package com.hxd.bean;

public class Module {
    private Integer id;

    private String modulecode;

    private String modulename;

    private String moduledesc;

    private Integer seqno;

    private Byte isenable;
    
    private Integer count;

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
        this.modulecode = modulecode == null ? null : modulecode.trim();
    }

    public String getModulename() {
        return modulename;
    }

    public void setModulename(String modulename) {
        this.modulename = modulename == null ? null : modulename.trim();
    }

    public String getModuledesc() {
        return moduledesc;
    }

    public void setModuledesc(String moduledesc) {
        this.moduledesc = moduledesc == null ? null : moduledesc.trim();
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

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
    
}