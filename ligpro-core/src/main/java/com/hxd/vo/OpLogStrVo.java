package com.hxd.vo;


//OpLogStrVo是optime为String格式的OpLogVo
public class OpLogStrVo  {
	
	private Long id;

    private String title;

    private String loginip;

    private Integer userid;

    private String loginname;

    private String optimeStr;

    private String content;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getLoginip() {
        return loginip;
    }

    public void setLoginip(String loginip) {
        this.loginip = loginip == null ? null : loginip.trim();
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname == null ? null : loginname.trim();
    }



    public String getOptimeStr() {
		return optimeStr;
	}

	public void setOptimeStr(String optimeStr) {
		this.optimeStr = optimeStr;
	}

	public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
       
}
