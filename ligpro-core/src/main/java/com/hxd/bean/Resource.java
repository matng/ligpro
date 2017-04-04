package com.hxd.bean;

public class Resource {
    private Integer id;

    private Integer groupid;

    private Byte restype;

    private String bigpicurl;

    private String smallpicurl;

    private String fileurl;

    private String resname;
    
    private Byte usetype;
    
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
        this.bigpicurl = bigpicurl == null ? null : bigpicurl.trim();
    }

    public String getSmallpicurl() {
        return smallpicurl;
    }

    public void setSmallpicurl(String smallpicurl) {
        this.smallpicurl = smallpicurl == null ? null : smallpicurl.trim();
    }

    public String getFileurl() {
        return fileurl;
    }

    public void setFileurl(String fileurl) {
        this.fileurl = fileurl == null ? null : fileurl.trim();
    }

	public String getResname() {
		return resname;
	}

	public void setResname(String resname) {
		this.resname = resname;
	}

	public Byte getUsetype() {
		return usetype;
	}

	public void setUsetype(Byte usetype) {
		this.usetype = usetype;
	}
	
	//151117 tl
	public String getSlidePicDetailsUrl() {
		return slidepicdetailsurl;
	}

	public void setSlidePicDetailsUrl(String slidepicdetailsurl) {
		this.slidepicdetailsurl = slidepicdetailsurl;
	}
    
}