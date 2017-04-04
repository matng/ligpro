package com.hxd.site.ctl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.Resource;
import com.hxd.bean.ResourceGroup;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.ContentService;
import com.hxd.service.ResourceGroupService;
import com.hxd.service.ResourceService;
import com.hxd.util.ImgUtil;
import com.hxd.util.SpellUtil;
import com.hxd.util.StrUtil;
import com.hxd.vo.AdditionalParameters;
import com.hxd.vo.PageData;
import com.hxd.vo.ResourceGroupItem;
import com.hxd.vo.ResourceGroupVo;
import com.hxd.vo.ResourceVo;
import com.hxd.vo.StatusVo;

@Controller
@RequestMapping("/res")
public class ResCtl extends BaseCtl {

	@Autowired
	private ResourceService service;
	
	@Autowired
	private ResourceGroupService rgService;
	
	@Autowired
	private ContentService ctService;
	
	 //上传目录
    private @Value("upload/")
    String uploadPath;
	
    @ControllerLog(cleanData="false",desc="log.res.gallery.read")
	@RequiresPermissions("gallery:r")
	@RequestMapping("/gallery")
	public String gallery(HttpServletRequest req) {
		return "/view/res/gallery";
	}
	
	
    @ControllerLog(cleanData="false",desc="log.res.flash.read")
	@RequiresPermissions("flash:r")
	@RequestMapping("/flash")
	public String flash(Model model,HttpServletRequest req) {
		model.addAttribute("type", "2");
		return "/view/res/resourceList";
	}
	
    @ControllerLog(cleanData="false",desc="log.res.video.read")
	@RequiresPermissions("video:r")
	@RequestMapping("/video")
	public String video(Model model,HttpServletRequest req) {
		model.addAttribute("type", "3");
		return "/view/res/resourceList";
	}
	
    @ControllerLog(cleanData="false",desc="log.res.file.read")
	@RequiresPermissions("file:r")
	@RequestMapping("/file")
	public String file(Model model,HttpServletRequest req) {
		model.addAttribute("type", "4");
		return "/view/res/resourceList";
	}
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getListJsonWithGroupID(HttpServletRequest req,ResourceVo vo) {
		String json = null;
		try {
			
			System.out.println("#####@@@@@"+vo.getGroupid());
			System.out.println("#####@@@@@"+vo.getRestype());
			
			List<Resource> list = null;
			int totalCount = 0;
			
			list = service.queryResourceByPage(vo);
			totalCount = service.queryResourceCount(vo);

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
	
	@RequestMapping(value = "/treeListJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getFlashGroupListJson(@RequestBody String json) {
		
		List<ResourceGroupItem> listItem = new ArrayList<ResourceGroupItem>();
		try {
			log.debug("###@@@ getFlashListJson() ="+json);
			
			ResourceGroup rGroup = JSON.parseObject(json,ResourceGroup.class);
			List<ResourceGroup> listReourceGroup = rgService.queryListByParentId(rGroup);			
			ResourceGroupItem resourceGroupItem = null;
			for (ResourceGroup rg : listReourceGroup) {
				resourceGroupItem = new ResourceGroupItem();
				BeanUtils.copyProperties(rg,resourceGroupItem);
				resourceGroupItem.setText(rg.getGroupname());
				AdditionalParameters p = new AdditionalParameters();
				p.setId(String.valueOf(rg.getId()));
				resourceGroupItem.setAdditionalParameters(p);	
				if (rg.getCount()>0) {
					resourceGroupItem.setType("folder");						
				} else {
					resourceGroupItem.setType("item");
				}
				
				listItem.add(resourceGroupItem);
			}
			log.debug(StrUtil.toJsonStrWithFixed(listItem));

		} catch (Exception e) {
			log.error(e);
		}
		return StrUtil.toJsonStrWithFixed(listItem);
	}
	
	@RequestMapping(value = "/listGallery", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getGalleryList(HttpServletRequest req,@RequestBody String json) {
		
		ResourceVo vo = JSON.parseObject(json,ResourceVo.class);
		
		try {
			
			System.out.println("#####@@@@@"+vo.getGroupid());
			System.out.println("#####@@@@@"+vo.getRestype());
			
			List<Resource> list = null;
			int totalCount = 0;
			
			list = service.queryResourceByPage(vo);
			totalCount = service.queryResourceCount(vo);

			//返回json数据给界面
			PageData data =new PageData();
			data.setsEcho(vo.getsEcho());
			data.setiTotalRecords(totalCount);
			data.setiTotalDisplayRecords(totalCount);
			log.debug("###@@@ list.size:"+list.size());
			//log.debug("###@@@ StrUtil.toJsonStrWithFixed(list):"+StrUtil.toJsonStrWithFixed(list));
			data.setAaData(StrUtil.toJsonStrWithFixed(list));
			json = StrUtil.toJsonStrWithFixed(list);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}
	
	
	//更新也走这里
	@RequestMapping(value = "/saveResourceGroup", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String saveResourceGroup(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			ResourceGroup rGroup = JSON.parseObject(json,ResourceGroup.class);
			int i = 0;
			//id为空说明是增加一条新数据 否则为编辑数据
			if (rGroup.getId() == null)
			{
				i = rgService.insertResourceGroup(rGroup);
			}
			else {
				i = rgService.updateResourceGroupByPrimaryKey(rGroup);
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
	
	
	@RequestMapping(value = "/deleteResourceGroup", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String deleteResourceGroup(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);


			ResourceGroupVo rgVo = JSON.parseObject(json,ResourceGroupVo.class);
			int i = 0;
			//批量删除，单个删除特例
			if (rgVo.getId() != null)
			{
				//只有没有数据的叶节点才可以删除
				int childCount = rgService.queryChildCountByParentId(rgVo.getId());
				if (childCount > 0)
				{
					sta.setError(this.getMessage("tree_delete_error_1"));
					return StrUtil.toJsonStrWithFixed(sta);
				}
				
				Resource rs = new Resource();
				rs.setGroupid(rgVo.getId());
				
				int resourceCount = service.queryResourceCountByGroupID(rs);
				
				if (resourceCount > 0)
				{
					sta.setError(this.getMessage("tree_delete_error_2"));
					return StrUtil.toJsonStrWithFixed(sta);
				}
				
				//
				i = rgService.deleteResourceGroupByNodeId(rgVo.getId());
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
	
	
	@ControllerLog(cleanData="true",desc="log.res.del")
	@RequiresPermissions("res:d")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json,HttpServletRequest request) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);

			String path = request.getSession().getServletContext().getRealPath("/");
			ResourceVo rsVo = JSON.parseObject(json,ResourceVo.class);
			//删除前先校验是否在使用中
			boolean bUsed = false;
			for (String idString : rsVo.getIdList())
			{
				Resource rs = service.selectResourceByPrimaryKey(Integer.parseInt(idString));
				String fileUrl = rs.getFileurl();
				String resourceFileName = fileUrl.substring(fileUrl.lastIndexOf("/"), fileUrl.length());
				int useCount = ctService.queryUseCountByResource(resourceFileName);
				if (useCount > 0)
				{
					bUsed = true;
					break;
				}

			}
			
			if (bUsed)
			{
				sta.setError(this.getMessage("delete_resource_error"));
				return StrUtil.toJsonStrWithFixed(sta);
			}
			
			//执行删除操作，本地文件一起删除
			int i = 0;
			
			//批量删除，单个删除特例
			if (rsVo.getIdList().size() > 0)
			{
				//删除本地文件
				for (String idString : rsVo.getIdList())
				{
					Resource rs = service.selectResourceByPrimaryKey(Integer.parseInt(idString));
					File file = new File(path+rs.getFileurl());
					file.delete();
					
					if (rs.getRestype() == 1)
					{
						File fileSmallPic = new File(path+rs.getSmallpicurl());
						fileSmallPic.delete();
						
						File fileBigPic	= new File(path+rs.getBigpicurl());
						fileBigPic.delete();
					}
				}
				i = service.deleteResourceByBatch(rsVo.getIdList());
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
	
	@RequestMapping(value = "/insert", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String insertResource(@RequestBody String json) {
		
		ResourceVo rsVo = JSON.parseObject(json,ResourceVo.class);
		String jsonRet = null;
		try {
			
			//System.out.println("#####@@@@@"+rsVo.getGroupid());
			//System.out.println("#####@@@@@"+rsVo.getRestype());
			
			List<Resource> rsList = new ArrayList<Resource>();
			//批量删除，单个删除特例
			if (rsVo.getIdList().size() > 0)
			{
				//删除本地文件
				for (String idString : rsVo.getIdList())
				{
					Resource rs = service.selectResourceByPrimaryKey(Integer.parseInt(idString));
					rsList.add(rs);
				}
			}
			
			//返回json数据给界面
			jsonRet = StrUtil.toJsonStrWithFixed(rsList);
		} catch (Exception e) {
			log.error(e);
		}
		
		return jsonRet;
	}
	
	
	/**
     * <上传附件>
     * 
     * @param file
     * @param response
     */
	@ControllerLog(cleanData="true",desc="log.res.save")
	@RequiresPermissions("res:c")
	@ResponseBody
    @RequestMapping("/upload")
    public void uploadAccessory(@RequestParam("extraData") String json, @RequestParam("file") CommonsMultipartFile file,HttpServletResponse response,HttpServletRequest request) {
        try {
            response.setContentType("textml;charset=UTF-8");
            Resource rs = JSON.parseObject(json,Resource.class);
            
            String path = request.getSession().getServletContext().getRealPath("/");
            System.out.println("@@@###@@@:"+path);
            String resourcePathString = "";
            switch (rs.getRestype()) {
    		case 1:
    			resourcePathString = this.getMessage("Image_Path");
    			break;
    		case 2:
    			resourcePathString = this.getMessage("Flash_Path");
    			break;
    		case 3:
    			resourcePathString = this.getMessage("Vedio_Path");
    			break;
    		case 4:
    			resourcePathString = this.getMessage("File_Path");
    			break;

    		default:
    			break;
    		}
            String originalName = file.getOriginalFilename();
            String fileName = SpellUtil.getEname(file.getOriginalFilename());
            File uploadDir = new File(path+resourcePathString+SpellUtil.getEname(rs.getBigpicurl()));
    		if (!uploadDir.exists()) {// 不存在则创建
    			uploadDir.mkdirs();
    		}
            String localPath = uploadDir+File.separator+fileName;
            String dbPath = resourcePathString+SpellUtil.getEname(rs.getBigpicurl())+"/"+fileName;
            file.transferTo(new File(localPath));
            rs.setFileurl(dbPath);
            rs.setResname(originalName);
            //只在类型为图片是进行压缩处理
            if (rs.getRestype() == 1)
            {
            	//获取不带拓展名的文件名称
            	String fileNameNew = fileName.substring(0, fileName.lastIndexOf("."));
            	String fileExtention = fileName.substring(fileName.lastIndexOf("."), fileName.length());            	
            	String smallPicPath = uploadDir+File.separator+fileNameNew+"_s"+fileExtention;
            	String bigPicPath = uploadDir+File.separator+fileNameNew+"_b"+fileExtention;
            	//生成缩略图
            	ImgUtil.ImgForSize(localPath, smallPicPath, Integer.parseInt(getMessage("Small_Pic_Width")), Integer.parseInt(getMessage("Small_Pic_Height")));
            	//压缩图片
            	ImgUtil.ImgScaleBySize(localPath, bigPicPath);
            	ImgUtil.imgScaleByEstimateSize(uploadDir+"",fileNameNew+"_b"+fileExtention);
            	String smallPicDbPath = resourcePathString+SpellUtil.getEname(rs.getBigpicurl())+"/"+fileNameNew+"_s"+fileExtention;
            	String bigPicDbPath	  = resourcePathString+SpellUtil.getEname(rs.getBigpicurl())+"/"+fileNameNew+"_b"+fileExtention;
            	System.out.println("@@@@filename$$$$:"+smallPicDbPath);
            	rs.setSmallpicurl(smallPicDbPath);
            	rs.setBigpicurl(bigPicDbPath);
            	//rs.setResname(originalName);
                rs.setUsetype((byte) 0);
            }
            else {
            	rs.setSmallpicurl("");
            	rs.setBigpicurl("");
			}
            
            
            service.insertResource(rs);
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	
	
	@RequestMapping("/download/{id}")
	public ModelAndView download(@PathVariable("id") String id,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
		Resource rs = service.selectResourceByPrimaryKey(Integer.parseInt(id));
		String filePath = rs.getFileurl();
		String path = request.getSession().getServletContext().getRealPath("/");
		String downLoadPath = path+filePath;
		String fileNameString = filePath.substring(filePath.lastIndexOf("/")+1);
		System.out.println("filename@@@+++:"+fileNameString);
		try {
			long fileLength = new File(downLoadPath).length();
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition", "attachment; filename="
					+ new String(fileNameString.getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length", String.valueOf(fileLength));
			bis = new BufferedInputStream(new FileInputStream(downLoadPath));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
		return null;
	}
	
	
	@RequestMapping(value = "/changePictureType", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String changePictureType(@RequestBody String json){
		StatusVo sta = new StatusVo();
		Resource rs = JSON.parseObject(json,Resource.class);
		try {
			int i = service.updateResourceByPrimaryKeySelective(rs);
			if (i >= 0) {
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		return StrUtil.toJsonStrWithFixed(sta);
	}
	
}
