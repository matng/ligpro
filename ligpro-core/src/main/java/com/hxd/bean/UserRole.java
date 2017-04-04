package com.hxd.bean;

public class UserRole {
    private Integer id;

    private Integer userid;

    private Integer roleid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

	public Integer getUserid() {
		return userid;
	}

	public void setUserId(Integer userid) {
		this.userid = userid;
	}

	public Integer getRoleid() {
		return roleid;
	}

	public void setRoleId(Integer roleid) {
		this.roleid = roleid;
	}

	@Override
	public String toString() {
		return "UserRole [userId=" + userid + "]";
	}
	
	

}