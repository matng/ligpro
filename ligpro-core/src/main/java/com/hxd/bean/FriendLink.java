package com.hxd.bean;

public class FriendLink {
    private Integer id;

    private String sitename;

    private String siteurl;

    private String logourl;

    private Byte linktype;

    private Integer seqno;

    private Byte isenable;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSitename() {
        return sitename;
    }

    public void setSitename(String sitename) {
        this.sitename = sitename == null ? null : sitename.trim();
    }

    public String getSiteurl() {
    	if (siteurl!=null && siteurl.indexOf("http://")<0) {
    		siteurl = "http://"+siteurl;
    	}
        return siteurl;
    }

    public void setSiteurl(String siteurl) {
        this.siteurl = siteurl == null ? null : siteurl.trim();
    }

    public String getLogourl() {
    	if (logourl!=null && logourl.indexOf("http://")<0) {
    		logourl = "http://"+logourl;
    	}
        return logourl;
    }

    public void setLogourl(String logourl) {
        this.logourl = logourl == null ? null : logourl.trim();
    }

    public Byte getLinktype() {
        return linktype;
    }

    public void setLinktype(Byte linktype) {
        this.linktype = linktype;
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
}