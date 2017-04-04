package com.hxd.site.ctl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.FriendLink;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.FriendLinkService;
import com.hxd.util.StrUtil;
import com.hxd.vo.FriendLinkVo;
import com.hxd.vo.PageData;
import com.hxd.vo.StatusVo;




@Controller
@RequestMapping("/link")
public class FriendLinkCtl extends BaseCtl {

	//------added by tl in 150601
	@Autowired
	private FriendLinkService service;
	//--------------------------
	
	@RequestMapping("/list")
	public String home(Model model,HttpServletRequest req) {
		return "/view/sys/friendLinkList";
	}	
	
	//--------------added by tl in 150601
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String friendLinkListJson(HttpServletRequest req,FriendLinkVo vo) {
		String json = null;
		try {
			
//			System.out.println("###@@@ aoData:"+vo.getAoData());
//			System.out.println("###@@@ echo:"+vo.getsEcho());
//			System.out.println("###@@@ iDisplayStart:"+vo.getiDisplayStart());
//			System.out.println("###@@@ iDisplayLength:"+vo.getiDisplayLength());
//			System.out.println("###@@@ sSearch:"+vo.getsSearch());
			
			List<FriendLink> list = service.queryFriendLinkByPage(vo);
			int totalCount = service.queryFriendLinkCount(vo);
			//返回json数据给界面
			PageData data =new PageData();
			data.setsEcho(vo.getsEcho());
			data.setiTotalRecords(totalCount);
			data.setiTotalDisplayRecords(totalCount);
			//log.debug("###@@@ list.size:"+list.size());
			//log.debug("###@@@ StrUtil.toJsonStrWithFixed(list):"+StrUtil.toJsonStrWithFixed(list));
			data.setAaData(StrUtil.toJsonStrWithFixed(list));
			json = StrUtil.toJsonStrWithFixed(data);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}
	
	//----------------------------------------
	@RequiresPermissions("link:c")
	@ControllerLog(cleanData="true",desc="log.friendLink.save")
	@RequestMapping(value = "/save", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String save(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			
			//log.debug("####: json="+json);	
			FriendLink friendLink = JSON.parseObject(json,FriendLink.class);
			int i = service.insertFriendLink(friendLink);
			
			//log.debug("####: loginname="+friendLink.getSitename());
			//log.debug("####: realname="+friendLink.getSiteurl());
				
			if (i> 0) {
				//返回结果json数据给界面		
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		//log.debug("###@@@ status:"+StrUtil.toJsonStrWithFixed(sta));
		return StrUtil.toJsonStrWithFixed(sta);
	}
	

	//删除 add by tl
	@RequiresPermissions("link:d")
	@ControllerLog(desc = "log.friendLink.del",cleanData="true")
//	@RequiresPermissions("friendLink:del")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json) {  
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			FriendLinkVo friendLink = JSON.parseObject(json,FriendLinkVo.class);
			log.debug("####: json="+friendLink.getIdList());
			int i = 0;
			
			//批量删除，单个删除特例
			if (friendLink.getIdList().size() > 0)
			{
				i = service.deleteFriendLinkByBatch(friendLink.getIdList());
			}
				
			if (i> 0) {
				//返回结果json数据给界面		
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		log.debug("###@@@ status:"+StrUtil.toJsonStrWithFixed(sta));
		return StrUtil.toJsonStrWithFixed(sta);
	}
	
	//更新 add by tl
	@RequiresPermissions("link:u")
	@ControllerLog(desc = "log.friendLink.edit",cleanData="true")
	@RequestMapping(value = "/edit", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String edit(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			//log.debug("####: json="+json);	
			FriendLink friendLink = JSON.parseObject(json,FriendLink.class);
			int i = service.updateFriendLinkByPrimaryKeySelective(friendLink);
			//log.debug("###@@@ i="+i);
			
			//log.debug("####: loginname="+friendLink.getSitename());
			//log.debug("####: realname="+friendLink.getSiteurl());
				
			if (i> 0) {
				//返回结果json数据给界面		
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		//log.debug("###@@@ status:"+StrUtil.toJsonStrWithFixed(sta));
		return StrUtil.toJsonStrWithFixed(sta);
	}
	
	
	//查询新增或修改的网站名称是否与后台数据重复
	@RequestMapping(value = "/check", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String check(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			FriendLink friendLink = JSON.parseObject(json,FriendLink.class);
			List<FriendLink> list=service.selectBySiteName(friendLink);
			
			if(list.size()==0)
			{
				sta.setSuccess(this.getMessage("op.success"));
				log.debug("网站名称添加成功");
			}
			else
			{
				for (FriendLink fl : list) {
					if((fl.getId()!=friendLink.getId())&(fl.getSitename().equals(friendLink.getSitename())))
					{
						sta.setError(this.getMessage("op.fail"));
						log.debug("网站名称添加错误");
						break;
					}
					else
					{
						sta.setSuccess(this.getMessage("op.success"));
						log.debug("网站名称添加成功");
						break;
					}
				}	
			}			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		log.debug("###@@@ status:"+StrUtil.toJsonStrWithFixed(sta));
		String test=StrUtil.toJsonStrWithFixed(sta);
		return test;
	}	
}

