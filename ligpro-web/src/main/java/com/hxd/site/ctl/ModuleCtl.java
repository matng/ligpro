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
import com.hxd.bean.Module;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.ModuleService;
import com.hxd.util.StrUtil;
import com.hxd.vo.ModuleVo;
import com.hxd.vo.PageData;
import com.hxd.vo.StatusVo;

@Controller
@RequestMapping("/module")
public class ModuleCtl extends BaseCtl {
	
	@Autowired
	private ModuleService service;

	@ControllerLog(cleanData="false",desc="log.module.read")
	@RequiresPermissions("module:r")
	@RequestMapping("/list")
	public String home(Model model,HttpServletRequest req) {
		return "/view/sys/moduleList";
	}
	
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String moduleListJson(HttpServletRequest req,ModuleVo vo) {
		String json = null;
		try {
			
//			System.out.println("###@@@ aoData:"+vo.getAoData());
//			System.out.println("###@@@ echo:"+vo.getsEcho());
//			System.out.println("###@@@ iDisplayStart:"+vo.getiDisplayStart());
//			System.out.println("###@@@ iDisplayLength:"+vo.getiDisplayLength());
//			System.out.println("###@@@ sSearch:"+vo.getsSearch());
			
			List<Module> list = service.queryModuleByPage(vo);
			int totalCount = service.queryModuleCount(vo);
			
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
	
	
	//更新也走这里
	@ControllerLog(cleanData="true",desc="log.module.save")
	@RequiresPermissions("module:c")
	@RequestMapping(value = "/save", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String save(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			Module module = JSON.parseObject(json,Module.class);
			
			int i = 0;
			//id为空说明是增加一条新数据 否则为编辑数据
			if (module.getId() == null)
			{
				i = service.insertModule(module);
			}
			else {
				i = service.updateModuleByPrimaryKeySelective(module);
			}
			
			log.debug("####: modulename="+module.getModulename());
			log.debug("####: modulename="+module.getModuledesc());
				
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
	
	
	@ControllerLog(cleanData="true",desc="log.module.del")
	@RequiresPermissions("module:d")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);


			ModuleVo module = JSON.parseObject(json,ModuleVo.class);
			log.debug("####: json="+module.getIdList());
			int i = 0;
			
			//批量删除，单个删除特例
			if (module.getIdList().size() > 0)
			{
				i = service.deleteModuleByBatch(module.getIdList());
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
	
	
	@RequestMapping(value = "/queryAll", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String queryAll(HttpServletRequest req) {
		String json = null;
		try {

			List<Module> list = service.queryAll();
			
			//返回json数据给界面
			json = StrUtil.toJsonStrWithFixed(list);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}	
	
	@RequestMapping(value = "/queryForPower", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String queryForPower(int ownerId) {
		String json = null;
		try {
			List<Module> list = service.queryForPower(ownerId);
			//返回json数据给界面
			json = StrUtil.toJsonStrWithFixed(list);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}
}
