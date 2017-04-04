package com.hxd.site.ctl;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import com.hxd.bean.Role;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.PowerService;
import com.hxd.service.RoleService;
import com.hxd.util.StrUtil;
import com.hxd.vo.PageData;
import com.hxd.vo.RoleVo;
import com.hxd.vo.StatusVo;

@Controller
@RequestMapping("/role")
public class RoleCtl extends BaseCtl {
	
	@Autowired
	private RoleService service;
	
	@Autowired
	private PowerService powerService;

	@ControllerLog(cleanData="false",desc="log.role.read")
	@RequiresPermissions("role:r")
	@RequestMapping("/list")
	public String home(Model model,HttpServletRequest req) {
		return "/view/role/roleList";
	}
	
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String roleListJson(HttpServletRequest req,RoleVo vo) {
		String json = null;
	    
		try {
			String sSearch = new String(vo.getsSearch().getBytes("ISO-8859-1"),"UTF-8");
			vo.setsSearch(sSearch);
			
			List<Role> list = service.queryRoleByPage(vo);
			int totalCount = service.queryRoleCount(vo);
			
			//返回json数据给界面
			PageData data = new PageData();
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
	
	/**
	 * <查询所有权限>
	 * @param req
	 * @param vo
	 * @return
	 */
	@RequestMapping(value = "/queryAllRole")
	@ResponseBody
	public List<Role> queryAllRole(HttpServletRequest req,RoleVo vo) {
		try {
			return service.queryAllRole();
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	
	@ControllerLog(cleanData="true",desc="log.role.save")
	@RequiresPermissions("role:c")
	@RequestMapping(value = "/save", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String save(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			Role role = JSON.parseObject(json,Role.class);
			int i = service.insertRole(role);
			
			log.debug("####: loginname="+role.getRolename());
			log.debug("####: realname="+role.getRoledesc());
				
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
	

	//删除 add by tl
	@ControllerLog(cleanData="true",desc="log.role.del")
	@RequiresPermissions("role:d")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json) {  
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			RoleVo role = JSON.parseObject(json,RoleVo.class);
			log.debug("####: json="+role.getIdList());
			int i = 0;
			
			//批量删除，单个删除特例
			if (role.getIdList().size() > 0)
			{
				i = service.deleteRoleByBatch(role.getIdList());
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

	@ControllerLog(cleanData="true",desc="log.role.update")
	@RequiresPermissions("role:u")
	@RequestMapping(value = "/edit", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String edit(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			Role role = JSON.parseObject(json,Role.class);
			int i = service.updateRoleByPrimaryKeySelective(role);
			log.debug("###@@@ i="+i);
			
			log.debug("####: loginname="+role.getRolename());
			log.debug("####: realname="+role.getRoledesc());
				
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
}
