package com.hxd.vo;

import java.util.List;


public class ResourceGroupVo extends BaseVo {

    private Integer id;

    private Byte grouptype;

    private String groupname;

    private String groupdesc;

    private Integer parentgroupid;
    
    private List<String> idList;

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

	public List<String> getIdList() {
		return idList;
	}

	public void setIdList(List<String> idList) {
		this.idList = idList;
	}
	
	
}
