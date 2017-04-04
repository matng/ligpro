package com.hxd.site.ctl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.Menu;
import com.hxd.bean.ResourceGroup;
import com.hxd.bean.Template;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.MenuService;
import com.hxd.service.ResourceGroupService;
import com.hxd.service.TemplateService;
import com.hxd.util.StrUtil;
import com.hxd.vo.AdditionalParameters;
import com.hxd.vo.IdVo;
import com.hxd.vo.MenuItem;
import com.hxd.vo.MenuVo;
import com.hxd.vo.StatusVo;

@Controller
@RequestMapping("/menu")
public class MenuCtl extends BaseCtl {

	@Autowired
	private MenuService service;
	
	@Autowired
	private TemplateService tmpService;
	
	@Autowired
	private ResourceGroupService rsService;

	@ControllerLog(cleanData="false",desc="log.menu.read")
	@RequiresPermissions("menu:r")
	@RequestMapping("/list")
	public String home(Model model,HttpServletRequest req) {
		return "/view/menu/menuList";
	}
	
	@ControllerLog(cleanData="true",desc="log.menu.save")
	@RequiresPermissions("menu:c")
	@RequestMapping(value = "/save", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String save(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			Menu menu = JSON.parseObject(json,Menu.class);

			if(menu.getParentmenuid()==null) {
				menu.setParentmenuid(0);
			}
			
			
			int i = 0;
			if (menu.getId() != null)
			{
				//更新数据是当menuurl改变时校验menuurl是否唯一，否则不校验了
				Menu oldMenu = service.selectMenuByPrimaryKey(menu.getId());
				
				if (!oldMenu.getMenucode().equals(menu.getMenucode()))
				{
					int menuCount = service.queryMenuCountByMenuUrl(menu.getMenucode());
					
					if (menuCount > 0)
					{
						sta.setError(this.getMessage("menu_url_exsits"));
						return StrUtil.toJsonStrWithFixed(sta);
					}
				}
				
				i = service.updateMenuByPrimaryKey(menu);
			}
			else {
				//新增一条数据时校验menuurl是否唯一
				int menuCount = service.queryMenuCountByMenuUrl(menu.getMenucode());
				
				if (menuCount > 0)
				{
					sta.setError(this.getMessage("menu_url_exsits"));
					return StrUtil.toJsonStrWithFixed(sta);
				}
				i = service.insertMenu(menu);
			}

			

			if (i> 0) {
				//操作成功就更新资源分组表的menuUrl 只有非子结点才更新
				if (menu.getParentmenuid() == 0)
				{
					Template template = tmpService.selectTemplateByPrimaryKey(menu.getTemplateid());
					ResourceGroup rg = rsService.selectResourceGroupByPrimaryKey(template.getGroupid());
					rg.setMenuUrl(menu.getMenuurl());
					rsService.updateResourceGroupByPrimaryKey(rg);
				}
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
	
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getMenuListJson(@RequestBody String json) {
		
		List<MenuItem> listItem = new ArrayList<MenuItem>();
		try {
			log.debug("###@@@ getMenuListJson() ="+json);
			
			Menu menu = JSON.parseObject(json,Menu.class);
			List<Menu> listMenu = service.queryListByParentId(menu.getId());			
			MenuItem menuItem = null;
			for (Menu m : listMenu) {
				menuItem = new MenuItem();
				BeanUtils.copyProperties(m,menuItem);
				//对于已禁用的结点给予文字提示
				if(m.getIsenable() == 0)
				{
					menuItem.setText(m.getMenuname()+"--"+this.getMessage("forbidden"));
				}
				else {
					menuItem.setText(m.getMenuname());
				}
				//menuItem.setText(m.getMenuname());
				AdditionalParameters p = new AdditionalParameters();
				p.setId(String.valueOf(m.getId()));
				menuItem.setAdditionalParameters(p);	
				if (m.getCount()>0) {
					menuItem.setType("folder");						
				} else {
					menuItem.setType("item");
				}
				
				listItem.add(menuItem);
			}
			log.debug(StrUtil.toJsonStrWithFixed(listItem));

		} catch (Exception e) {
			log.error(e);
		}
		return StrUtil.toJsonStrWithFixed(listItem);
	}
	
	
	@RequestMapping(value = "/listJsonWithoutFirst", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getMenuListJsonWithoutFirst(@RequestBody String json) {
		
		List<MenuItem> listItem = new ArrayList<MenuItem>();
		try {
			log.debug("###@@@ getMenuListJson() ="+json);
			
			Menu menu = JSON.parseObject(json,Menu.class);
			List<Menu> listMenu = service.queryListByParentIdWithoutFirst(menu.getId());			
			MenuItem menuItem = null;
			for (Menu m : listMenu) {
				menuItem = new MenuItem();
				BeanUtils.copyProperties(m,menuItem);
				menuItem.setText(m.getMenuname());
				AdditionalParameters p = new AdditionalParameters();
				p.setId(String.valueOf(m.getId()));
				menuItem.setAdditionalParameters(p);	
				if (m.getCount()>0) {
					menuItem.setType("folder");						
				} else {
					menuItem.setType("item");
				}
				
				listItem.add(menuItem);
			}
			log.debug(StrUtil.toJsonStrWithFixed(listItem));

		} catch (Exception e) {
			log.error(e);
		}
		return StrUtil.toJsonStrWithFixed(listItem);
	}
	
	
	@ControllerLog(cleanData="true",desc="log.menu.del")
	@RequiresPermissions("menu:d")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);


			MenuVo menuVo = JSON.parseObject(json,MenuVo.class);
			int i = 0;
			
			//批量删除，单个删除特例
			if (menuVo.getId() != null)
			{
				i = service.deleteMenuByNodeId(menuVo.getId());
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
	
	
	@RequestMapping(value = "/queryMenuById", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String queryMenuById(@RequestBody String menuId) {
		String jsonRet = null;
		try {
			IdVo idVo = JSON.parseObject(menuId,IdVo.class);
 
			Menu menu = service.selectMenuByPrimaryKey(idVo.getId());
			
			//返回json数据给界面
			jsonRet = StrUtil.toJsonStrWithFixed(menu);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return jsonRet;
	}
	
	@RequestMapping(value = "/queryAllMenu", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String queryAllMenu() {
		String jsonRet = null;
		try {
			List<Menu> menu = service.findAllMenu();
			//返回json数据给界面
			jsonRet = StrUtil.toJsonStrWithFixed(menu);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return jsonRet;
	}
	
	@RequestMapping(value = "/queryMenuByModuleId", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String queryMenuByModuleId(int moduleId,int roleId) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("moduleId", moduleId);
		map.put("roleId", roleId);
		String jsonRet = null;
		try {
			List<Menu> menu = service.findMenuByModuleId(map);
			jsonRet = StrUtil.toJsonStrWithFixed(menu);
		} catch (Exception e) {
			log.error(e);
		}
		return jsonRet;
	}
	
}
