package com.hxd.site.ctl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.Template;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.TemplateService;
import com.hxd.util.SpellUtil;
import com.hxd.util.StrUtil;
import com.hxd.vo.PageData;
import com.hxd.vo.StatusVo;
import com.hxd.vo.TemplateVo;

@Controller
@RequestMapping("/tmp")
public class TmpCtl extends BaseCtl {
	
	@Autowired
	private TemplateService service;

	@ControllerLog(cleanData="false",desc="log.tmp.read")
	@RequiresPermissions("tmp:r")
	@RequestMapping("/list")
	public String home(Model model,HttpServletRequest req) {
		return "/view/tmp/tmpList";
	}
	
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String moduleListJson(HttpServletRequest req,TemplateVo vo) {
		String json = null;
		try {
			
			String sSearch = new String(vo.getsSearch().getBytes("ISO-8859-1"),"UTF-8");
			vo.setsSearch(sSearch);
			
			List<Template> list = service.queryTemplateByPage(vo);
			int totalCount = service.queryTemplateCount(vo);
			
			PageData data =new PageData();
			data.setsEcho(vo.getsEcho());
			data.setiTotalRecords(totalCount);
			data.setiTotalDisplayRecords(totalCount);
			data.setAaData(StrUtil.toJsonStrWithFixed(list));
			json = StrUtil.toJsonStrWithFixed(data);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}
	
	
	@ResponseBody
	@RequestMapping("/upload")
	public String upload(@RequestParam("file") CommonsMultipartFile file,HttpServletResponse response,HttpServletRequest request) {
		
		String path = request.getSession().getServletContext().getRealPath("/");
		String tmpPath = this.getMessage("tmp_file_path");
		String fileName = SpellUtil.getEname(file.getOriginalFilename());
		
        File uploadDir = new File(path+tmpPath);
        
		if (!uploadDir.exists()) {// 不存在则创建
			uploadDir.mkdirs();
		}
        String localPath = uploadDir+File.separator+fileName;
        
        try {
            file.transferTo(new File(localPath));
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
		return fileName;
	}
	
	
	
	//更新也走这里
	@ControllerLog(cleanData="true",desc="log.tmp.save")
	@RequiresPermissions("tmp:c")
	@RequestMapping(value = "/save", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	//public String save(@RequestBody String json,@RequestParam("file") CommonsMultipartFile file,HttpServletResponse response,HttpServletRequest request) {
	public String save(@RequestBody String json,HttpServletResponse response,HttpServletRequest request) {
		
		StatusVo sta = new StatusVo();
		
		try {
			Template tmp = JSON.parseObject(json,Template.class);
			int i = 0;
			//id为空说明是增加一条新数据 否则为编辑数据
			if (tmp.getId() == null)
			{
				i = service.insertTemplate(tmp);
			}
			else {
				i = service.updateTemplateByPrimaryKeySelective(tmp);
			}
			
			if (i > -1) {
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
	
	@ControllerLog(cleanData="true",desc="log.tmp.del")
	@RequiresPermissions("tmp:d")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);
			TemplateVo tmpVo = JSON.parseObject(json,TemplateVo.class);
			log.debug("####: json="+tmpVo.getIdList());
			int i = 0;
			
			//批量删除，单个删除特例
			if (tmpVo.getIdList().size() > 0)
			{
				i = service.deleteTemplateByBatch(tmpVo.getIdList());
			}
			if (i> 0) {
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

			
			List<Template> list = service.queryAll();
			
			//返回json数据给界面
			json = StrUtil.toJsonStrWithFixed(list);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}	
	
}
