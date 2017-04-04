package com.hxd.vo;

public class ResourceGroupItem extends Item{

    private Integer id;

    private Byte grouptype;

    private String groupname;

    private String groupdesc;
    
    private String menuUrl;

    private Integer parentgroupid;

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
		this.groupname = groupname;
	}

	public String getGroupdesc() {
		return groupdesc;
	}

	public void setGroupdesc(String groupdesc) {
		this.groupdesc = groupdesc;
	}

	public Integer getParentgroupid() {
		return parentgroupid;
	}

	public void setParentgroupid(Integer parentgroupid) {
		this.parentgroupid = parentgroupid;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	
	
    
}
