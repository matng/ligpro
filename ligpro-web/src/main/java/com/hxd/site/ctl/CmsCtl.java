package com.hxd.site.ctl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hxd.util.ConfigUtil;
import com.hxd.util.DateUtil;
import org.apache.commons.io.FileUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.Content;
import com.hxd.bean.Menu;
import com.hxd.bean.Template;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.ContentService;
import com.hxd.service.MenuService;
import com.hxd.service.TemplateService;
import com.hxd.util.StrUtil;
import com.hxd.vo.ContentVo;
import com.hxd.vo.PageData;
import com.hxd.vo.StatusVo;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/cms")
public class CmsCtl extends BaseCtl {

	@Autowired
	private ContentService service;
	
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private TemplateService tService;

	private static String baseFileUploadDir = ConfigUtil.get("baseFileUploadDir");
	private static String separator = ConfigUtil.get("sysSeparator");
	
	@ControllerLog(cleanData="false",desc="log.cms.company.read")
	@RequiresPermissions("cms:company:r")
	@RequestMapping("/company")
	public String home(Model model,HttpServletRequest req) {
		model.addAttribute("type", "1");
		return "/view/cms/noticeList";
	}
	
	@ControllerLog(cleanData="false",desc="log.cms.news.read")
	@RequiresPermissions("cms:news:r")
	@RequestMapping("/news")
	public String notice(Model model,HttpServletRequest req) {
		model.addAttribute("type", "2");
		return "/view/cms/noticeList";
	}
	
	@ControllerLog(cleanData="false",desc="log.cms.service.read")
	@RequiresPermissions("cms:service:r")
	@RequestMapping("/service")
	public String news(Model model,HttpServletRequest req) {
		model.addAttribute("type", "3");
		return "/view/cms/noticeList";
	}
	
	@ControllerLog(cleanData="false",desc="log.cms.product.read")
	@RequiresPermissions("cms:product:r")
	@RequestMapping("/product")
	public String article(Model model,HttpServletRequest req) {
		model.addAttribute("type", "4");
		return "/view/cms/noticeList";
	}
	
	
	/**
	 * 通过MenuId查看数据信息
	 * @param menuId
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/listByMenu/{id}")
	public String getListByMenuId(@PathVariable("id") Integer menuId, Model model, HttpServletRequest req) {
		Menu menu = menuService.selectMenuByPrimaryKey(menuId);
		if (menu!=null) {
			String menuCode = menu.getMenucode();
			Subject p = SecurityUtils.getSubject();
			
			//首页屏蔽新增功能
			Template template = tService.selectTemplateByPrimaryKey(menu.getTemplateid());
			if (template.getType() == 0)
			{
				model.addAttribute("create", false);
				model.addAttribute("update", false);
				model.addAttribute("delete", false);
			}
			else {
				model.addAttribute("create", p.isPermitted(menuCode+":c")? true:false);
				model.addAttribute("update", p.isPermitted(menuCode+":u")? true:false);
				model.addAttribute("delete", p.isPermitted(menuCode+":d")? true:false);
				model.addAttribute("audit", p.isPermitted(menuCode+":a")? true:false);
				model.addAttribute("menuName",menu.getMenuname());
			}

		}
		
		model.addAttribute("menuid", menuId);
		return "/view/cms/display";
	}
	
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getListJson(HttpServletRequest req,ContentVo vo) {
		String json = null;
		try {
			
//			System.out.println("###@@@ aoData:"+vo.getAoData());
//			System.out.println("###@@@ echo:"+vo.getsEcho());
//			System.out.println("###@@@ iDisplayStart:"+vo.getiDisplayStart());
//			System.out.println("###@@@ iDisplayLength:"+vo.getiDisplayLength());
//			System.out.println("###@@@ sSearch:"+vo.getsSearch());
			
			System.out.println("###@@@ aoData:"+vo.getAoData());
			List<Content> list = service.queryContentByPage(vo);
			int totalCount = service.queryContentCount(vo);
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
	@ControllerLog(cleanData="true",desc="log.cmc.save")
	//@RequiresPermissions("cms:c")
	@RequestMapping(value = "/save", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String save(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			Content content = JSON.parseObject(json,Content.class);
			content.setAddtime(new Date());
			int i = 0;
			//content.setContent(StrUtil.str2html(content.getContent()));
			//id为空说明是增加一条新数据 否则为编辑数据
			if (content.getId() == null)
			{
				i = service.insertContent(content);
			}
			else {
				i = service.updateContentByPrimaryKeySelective(content);
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
	
	
	//查询某一条数据
	@RequestMapping(value = "/queryById", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String queryById(@RequestBody String json) {
		String jsonRet = null;
		try {
			Content ct = JSON.parseObject(json,Content.class);
//			System.out.println("###@@@ aoData:"+vo.getAoData());
//			System.out.println("###@@@ echo:"+vo.getsEcho());
//			System.out.println("###@@@ iDisplayStart:"+vo.getiDisplayStart());
//			System.out.println("###@@@ iDisplayLength:"+vo.getiDisplayLength());
//			System.out.println("###@@@ sSearch:"+vo.getsSearch());
			
			System.out.println("###@@@ aoData:"+ct.getId());
			Content content = service.selectContentByPrimaryKey(ct.getId());
			//返回json数据给界面
			jsonRet = StrUtil.toJsonStrWithFixed(content);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return jsonRet;
	}
	
	
	//通过内容ID获取所述菜单的url
	@RequestMapping(value = "/queryMenuUrlById", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String queryMenuUrlById(@RequestBody String json) {
		String jsonRet = null;
		try {
			Content ct = JSON.parseObject(json,Content.class);
//			System.out.println("###@@@ aoData:"+vo.getAoData());
//			System.out.println("###@@@ echo:"+vo.getsEcho());
//			System.out.println("###@@@ iDisplayStart:"+vo.getiDisplayStart());
//			System.out.println("###@@@ iDisplayLength:"+vo.getiDisplayLength());
//			System.out.println("###@@@ sSearch:"+vo.getsSearch());
			
			Content content = service.selectContentByPrimaryKey(ct.getId());
			
			Menu menu = menuService.selectMenuByPrimaryKey(content.getMenuid());
			//返回json数据给界面
			jsonRet = StrUtil.toJsonStrWithFixed(menu);
		} catch (Exception e) {
			log.error(e);
		}
		return jsonRet;
	}
	
	
	@ControllerLog(cleanData="true",desc="log.cms.del")
	//@RequiresPermissions("cms:d")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);


			ContentVo contentVo = JSON.parseObject(json,ContentVo.class);
			log.debug("####: json="+contentVo.getIdList());
			int i = 0;
			
			//批量删除，单个删除特例
			if (contentVo.getIdList().size() > 0)
			{
				i = service.deleteContentByBatch(contentVo.getIdList());
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

	@RequestMapping(value="/upload")
	@ResponseBody
	public String upload(@RequestParam("file") MultipartFile myfile){

		String cYear = DateUtil.getCurYear();
		String cMonth = DateUtil.getCurMM();
		String cDay = DateUtil.getCurDD();
		String cTime = DateUtil.getCurHHmmssSSS();
		String dbPath = cYear + separator + cMonth + separator + cDay + separator + cTime;
		String path =  baseFileUploadDir + separator + dbPath;
		String dbUrl = dbPath + separator + myfile.getOriginalFilename();

		try {
			FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(path, myfile.getOriginalFilename()));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.error(e);
			e.printStackTrace();
		}
		return dbUrl;
	}
}
