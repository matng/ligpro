package com.hxd.bean;

public class Button {
    private Integer id;

    private String menucode;

    private String btnname;

    private String btncode;

    private Byte isenable;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMenucode() {
        return menucode;
    }

    public void setMenucode(String menucode) {
        this.menucode = menucode == null ? null : menucode.trim();
    }

    public String getBtnname() {
        return btnname;
    }

    public void setBtnname(String btnname) {
        this.btnname = btnname == null ? null : btnname.trim();
    }

    public String getBtncode() {
        return btncode;
    }

    public void setBtncode(String btncode) {
        this.btncode = btncode == null ? null : btncode.trim();
    }

    public Byte getIsenable() {
        return isenable;
    }

    public void setIsenable(Byte isenable) {
        this.isenable = isenable;
    }
}