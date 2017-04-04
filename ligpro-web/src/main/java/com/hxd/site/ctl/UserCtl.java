package com.hxd.site.ctl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.User;
import com.hxd.bean.UserRole;
import com.hxd.interceptor.ControllerLog;
import com.hxd.security.Encodes;
import com.hxd.service.UserRoleService;
import com.hxd.service.UserService;
import com.hxd.site.filter.AuthRealm.Principal;
import com.hxd.util.StrUtil;
import com.hxd.vo.PageData;
import com.hxd.vo.StatusVo;
import com.hxd.vo.UserVo;

import org.apache.shiro.authz.annotation.RequiresPermissions;
//----------

@Controller
@RequestMapping("/user")
public class UserCtl extends BaseCtl {
	
	@Autowired
	private UserService service;
	
	@Autowired
	private UserRoleService userRoleService;

	@RequestMapping("/list")
	public String home(Model model,HttpServletRequest req) {
		return "/view/sys/userList";
	}
	
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String userListJson(HttpServletRequest req,UserVo vo) {
		String json = null;
		try {
			
//			System.out.println("###@@@ aoData:"+vo.getAoData());
//			System.out.println("###@@@ echo:"+vo.getsEcho());
//			System.out.println("###@@@ iDisplayStart:"+vo.getiDisplayStart());
//			System.out.println("###@@@ iDisplayLength:"+vo.getiDisplayLength());
//			System.out.println("###@@@ sSearch:"+vo.getsSearch());
			
			List<User> list = service.queryByPage(vo);
			int totalCount = service.queryCount(vo);
			
			//返回json数据给界面
			PageData data =new PageData();
			data.setsEcho(vo.getsEcho());
			data.setiTotalRecords(totalCount);
			data.setiTotalDisplayRecords(totalCount);
			log.debug("###@@@ list.size:"+list.size());
			//log.debug("###@@@ StrUtil.toJsonStrWithFixed(list):"+StrUtil.toJsonStrWithFixed(list));
			data.setAaData(StrUtil.toJsonStrWithFixed(list));
			json = StrUtil.toJsonStrWithFixed(data);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}
	
	@RequiresPermissions("user:c")
	@ControllerLog(desc = "log.user.save")
	@RequestMapping(value = "/save", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String save(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			User user = JSON.parseObject(json,User.class);
			
			//加密
			user.setPsw(Encodes.encodePsw(user.getPsw()));
			
			int i = service.insert(user);
			
			//插入角色表
			UserRole userRole = new UserRole();
			userRole.setRoleId(user.getRoleId());
			userRole.setUserId(i);
			int j = userRoleService.insertUserRole(userRole);
			
			log.debug("####: loginname="+user.getLoginname());
			log.debug("####: realname="+user.getRealname());
				
			if (i> 0 && j > 0) {
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
	
	@ControllerLog(desc = "log.user.savepsw")
	@RequestMapping(value = "/savepsw", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String savePsw(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			UserVo uv = JSON.parseObject(json,UserVo.class);
			Subject subject = SecurityUtils.getSubject();
			Principal p = (Principal) subject.getPrincipal();
			
			boolean valid = Encodes.validatePsw(uv.getPsw(), p.getPsw());
			if (valid) {
				uv.setId(Integer.parseInt(p.getId()));
				uv.setPsw(Encodes.encodePsw(uv.getNewPsw()));
				
				User user = new User();
				BeanUtils.copyProperties(uv,user);
				int i = service.updateByPrimaryKeySelective(user);
				if (i> 0) {		
					sta.setSuccess(this.getMessage("op.success"));	
				} else {
					sta.setError(this.getMessage("op.fail"));
				}		
				
			} else {
				sta.setError("输入的原密码错误!");
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		log.debug("###@@@ status:"+StrUtil.toJsonStrWithFixed(sta));
		return StrUtil.toJsonStrWithFixed(sta);
	}
	

	//删除 add by tl
	@RequiresPermissions("user:d")
	@ControllerLog(desc = "log.user.del")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json) {  
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			UserVo user = JSON.parseObject(json,UserVo.class);
			log.debug("####: json="+user.getIdList());
			int i = 0;
			int j = 0;
			//批量删除，单个删除特例
			if (user.getIdList().size() > 0)
			{
				i = service.deleteUserByBatch(user.getIdList());
				j = userRoleService.deleteByUserId(user.getIdList());
			}
				
			if (i> 0 && j > 0) {
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
	
	
	/*
			//-----------------
		//删除 add by tl
		@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
		@ResponseBody
		public String delete(@RequestBody String json) {  
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			User user = JSON.parseObject(json,User.class);
			int my_id=user.getId();
			int i = service.deleteByPrimaryKey(my_id);
			
			log.debug("####: id="+user.getId());
				
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
	 */

	//更新 add by tl
	@RequiresPermissions("user:u")
	@ControllerLog(desc = "log.user.edit")
	@RequestMapping(value = "/edit", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String edit(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			User user = JSON.parseObject(json,User.class);
			int i = service.updateByPrimaryKeySelective(user);
			log.debug("###@@@ i="+i);
			
			//更新角色关联表
			UserRole ur = new UserRole();
			ur.setUserId(user.getId());
			ur.setRoleId(user.getRoleId());
			int j = userRoleService.updateByUserId(ur);
			log.debug("####: loginname="+user.getLoginname());
			log.debug("####: realname="+user.getRealname());
				
			if (i > 0 && j > 0) {
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
	
	//查询新增或修改的网站名称是否与后台数据重复
	@RequestMapping(value = "/userNamecheck", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String userNamecheck(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			User user = JSON.parseObject(json,User.class);
			List<User> list=service.selectByLoginNameOrEmail(user);
			
			if(list.size()==0)
			{
				sta.setSuccess(this.getMessage("op.success"));
				log.debug("登陆账号添加成功");
			}
			else
			{
				for (User u : list) {
					if((u.getId()!=user.getId())&(u.getLoginname().equals(user.getLoginname())))
					{
						sta.setError(this.getMessage("op.fail"));
						log.debug("登陆账号重复");
						break;
					}
					else
					{
						sta.setSuccess(this.getMessage("op.success"));
						log.debug("登陆账号添加成功");
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
	
	//查询新增或修改的网站名称是否与后台数据重复
		@RequestMapping(value = "/emailcheck", produces = {"application/json;charset=UTF-8"})
		@ResponseBody
		public String emailcheck(@RequestBody String json) {
			StatusVo sta = new StatusVo();
			try {
				log.debug("####: json="+json);	
				User user = JSON.parseObject(json,User.class);
				List<User> list=service.selectByLoginNameOrEmail(user);
				
				if(list.size()==0)
				{
					sta.setSuccess(this.getMessage("op.success"));
					log.debug("电子邮箱添加成功");
				}
				else
				{
					for (User u : list) {
						if((u.getId()!=user.getId())&(u.getEmail().equals(user.getEmail())))
						{
							sta.setError(this.getMessage("op.fail"));
							log.debug("注册邮箱重复");
							break;
						}
						else
						{
							sta.setSuccess(this.getMessage("op.success"));
							log.debug("电子邮箱添加成功");
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
