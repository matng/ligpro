package com.hxd.bean;

public class ResourceGroup {
    private Integer id;

    private Byte grouptype;

    private String groupname;

    private String groupdesc;
    
    private String menuUrl;

    private Integer parentgroupid;
    
    private Integer count;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Byte getGrouptype() {
        return grouptype;
    }

    public void setGrouptype(Byte grouptype) {
        this.grouptype = grouptype;
    }

    public String getGroupname() {
        return groupname;
    }

    public void setGroupname(String groupname) {
        this.groupname = groupname == null ? null : groupname.trim();
    }

    public String getGroupdesc() {
        return groupdesc;
    }

    public void setGroupdesc(String groupdesc) {
        this.groupdesc = groupdesc == null ? null : groupdesc.trim();
    }

    public Integer getParentgroupid() {
        return parentgroupid;
    }

    public void setParentgroupid(Integer parentgroupid) {
        this.parentgroupid = parentgroupid;
    }

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
    
    
}