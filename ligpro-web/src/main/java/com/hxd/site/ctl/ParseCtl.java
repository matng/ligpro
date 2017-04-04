package com.hxd.site.ctl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.Content;
import com.hxd.bean.FriendLink;
import com.hxd.bean.Menu;
import com.hxd.service.ContentService;
import com.hxd.service.FriendLinkService;
import com.hxd.service.MenuService;
import com.hxd.service.ResourceGroupService;
import com.hxd.service.ResourceService;
import com.hxd.util.MapUtil;
import com.hxd.util.StrUtil;
import com.hxd.vo.ContentVo;
import com.hxd.vo.ResourceVo;
import com.hxd.vo.TPLVo;


/**
 * 基于restful 方式，数据与模板集成
 * 
 * @author mwd
 *
 */
@Controller
public class ParseCtl extends BaseCtl {

	@Autowired
	private ContentService contentService;	
	
	@Autowired
	private FriendLinkService friendService;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private ResourceService rsService;
	
	@Autowired
	private ResourceGroupService rgService;
	
	public static final String HTML = "html";
	public static final String MENU = "menu";
	public static final String FRIEND_LINK= "friendLink";
	public static final String CONTENT = "CONTENT";
	
	public static Map<String,Object> cacheMap = new HashMap<String,Object>();
	

	
	/**
	 * 数据集成
	 * @param menuUrl
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/{menuUrl}")
	public String menuPage(@PathVariable("menuUrl") String menuUrl,Model model,HttpServletRequest req) {
		StringBuffer template = new StringBuffer("/template/");
		try {
			if (StrUtil.isNull(menuUrl)) {
				return "error/error";
			}
			System.out.println("####@@@ menuUrl="+menuUrl);
			Menu menu = menuService.findMenuByMenuUrl(menuUrl);
			
			if (menu!=null) {						
				List<TPLVo> tplMenuList = getTopMenu();
				model.addAttribute("menuList", tplMenuList);
							
				if (menuUrl.indexOf("home")>=0) {
					template.append(StrUtil.getTemplateForList(menu.getTemplateurl()));
					
					//首页解析				
					//slider轮播数据 
					ResourceVo vo = new ResourceVo();
					vo.setUseType(2);
					vo.setLimit(4);
					List<ResourceVo> sliderPicList = rsService.findResourceByUserTypeWithLimit(vo);
					model.addAttribute("sliderPicList", sliderPicList);
					
					//热点图数据
					ResourceVo voHot = new ResourceVo();
					voHot.setUseType(3);
					voHot.setLimit(8);
					List<ResourceVo> hotPicList = rsService.findResourceByUserTypeWithLimit(voHot);
					model.addAttribute("hotPicList", hotPicList);		
					model.addAttribute("groupNameList", filterGroupName(hotPicList));
					
					//通知公告数据
					List<Content> contentList = (List<Content>)cacheMap.get(CONTENT);
					if (contentList==null) {
						contentList = contentService.findLimitContentByTypeUnion(4);
						cacheMap.put(CONTENT, contentList);
					}
					//公司动态
					model.addAttribute("type1", MapUtil.getSubListContent(contentList, "company"));
					//行业新闻
					model.addAttribute("type2", MapUtil.getSubListContent(contentList, "latest"));
					//产品
					model.addAttribute("type3", MapUtil.getSubListContent(contentList, "business"));
					//服务
					model.addAttribute("type4", MapUtil.getSubListContent(contentList, "institute"));
					
					
					//友情连接数据
					List<FriendLink> linkList = (List<FriendLink>)cacheMap.get(FRIEND_LINK);
					if (linkList==null) {
						linkList = friendService.findAllFriendLink();
						cacheMap.put(FRIEND_LINK, linkList);
					}
					model.addAttribute("linkList", linkList);
					
					model.addAttribute("activeMenu", menu.getMenuurl());
					
				} else {
					if (menu.getParentmenuid()==0) {
						
						//有下列菜单的项数据
						//取栏目模板
						//Menu parentmenu = menu.getParentmenuid()==0? menu : menuService.selectMenuByPrimaryKey(menu.getParentmenuid());
						template.append(StrUtil.getTemplateForList(menu.getTemplateurl()));
						
						ContentVo cv = new ContentVo();
						cv.setMenuid(menu.getId());
						cv.setId(0);
						cv.setStart(0);
						cv.setLimit(Integer.parseInt(getMessage("list.limit")));
						cv.setHtmlurl(menu.getMenuurl());
						//获取内容列表
						List<Content> contentList = contentService.findLimitContentByMenuId(cv);
						//获取左边导航菜单
						List<Menu> leftMenuList = getLeftMenu(menu.getId());
						//model.addAttribute("menuUrl", menu.getMenuurl());
						model.addAttribute("vo", cv);
						model.addAttribute("menuTitle", menu.getMenuname());
						model.addAttribute("parentMenu", menu);
						
						
						//获取内容的直接父级菜单id
						model.addAttribute("contentParentMenuId", menu.getParentmenuid());
		
						model.addAttribute("contentList", contentList);
						model.addAttribute("leftMenuList", leftMenuList);
						model.addAttribute("activeMenu", menu.getMenuurl());  //等效于contentParentMenuUrl
					

					} else {
						//有下列菜单的项数据
						//取栏目模板
						Menu parentmenu = menuService.selectMenuByPrimaryKey(menu.getParentmenuid());
						template.append(StrUtil.getTemplateForList(parentmenu.getTemplateurl()));
						
						ContentVo cv = new ContentVo();
						cv.setMenuid(menu.getId());
						cv.setId(1);
						cv.setStart(0);
						cv.setLimit(Integer.parseInt(getMessage("list.limit")));
						cv.setHtmlurl(menu.getMenuurl());  //add by tl in 151224
						//获取内容列表
						List<Content> contentList = contentService.findLimitContentByMenuId(cv);
						//获取左边导航菜单
						List<Menu> leftMenuList = getLeftMenu(parentmenu.getId());
						//model.addAttribute("menuUrl", menu.getMenuurl());
						model.addAttribute("vo", cv);
						model.addAttribute("menuTitle", menu.getMenuname());
						model.addAttribute("parentMenu", parentmenu);
		
						model.addAttribute("contentList", contentList);
						model.addAttribute("leftMenuList", leftMenuList);
						model.addAttribute("activeMenu", parentmenu.getMenuurl());  //等效于contentParentMenuUrl
						
						if(menu.getCount()<=1){
							model.addAttribute("contentParentMenuId", 0);
						}else{
							//获取内容的直接父级菜单id
							model.addAttribute("contentParentMenuId", menu.getParentmenuid());
						}
					}
				}
								
			}		
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		//System.out.println("####@@@ template_url="+template.toString());
		return template.toString();
	}
	
	
	
	
	/**
	 * 详细页数据集成
	 * @param menuUrl
	 * @param id
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/{menuUrl}/{contentId}")
	public String makeDetailPage(@PathVariable("menuUrl") String menuUrl,@PathVariable("contentId") Integer contentId,
			Model model,HttpServletRequest req) {
		StringBuffer template = new StringBuffer("/template/");
		try {
			if (StrUtil.isNull(menuUrl)) {
				return "error/error";
			}
			System.out.println("####@@@ menuUrl="+menuUrl);
			Menu menu = menuService.findMenuByMenuUrl(menuUrl);
			if (menu!=null) {
				//top menu数据									
				List<TPLVo> tplMenuList = getTopMenu();
				model.addAttribute("menuList", tplMenuList);
				
				//取栏目模板
				Menu parentmenu = menuService.selectMenuByPrimaryKey(menu.getParentmenuid());
				template.append(StrUtil.getTemplateForDetail(parentmenu.getTemplateurl()));
				
				//left menu
				List<Menu> leftMenuList = getLeftMenu(parentmenu.getId());
				model.addAttribute("leftMenuList", leftMenuList);
				model.addAttribute("parentMenu", parentmenu);
				
				//详细页面数据
				//selectByPrimaryKey
				Content content = contentService.selectContentByPrimaryKey(contentId);
				
				if (content!=null) {
					content.setContent(StrUtil.decodeHtml(content.getContent()));
				}
				model.addAttribute("cms", content);
				
				model.addAttribute("activeMenu", parentmenu.getMenuurl());	
				
				if(menu.getParentmenuid()!=0)  //parentmenu为一级菜单  content的父级菜单为二级菜单  
				{
					model.addAttribute("contentParentMenuId", menu.getId());  
					model.addAttribute("contentParentMenuTitle", menu.getMenuname());
					model.addAttribute("contentParentMenuUrl", menu.getMenuurl());
				}
				else //parentmenu为一级菜单  content的父级菜单也为一级菜单时  
				{
					model.addAttribute("contentParentMenuId", 0);  
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}

		return template.toString();
	}
	
	
	/**
	 * 详细页数据集成(参数menuId)
	 * @param menuUrl
	 * @param id
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/{menuUrl}/{menuId}/{flag}")
	public String makeDetailPageByMenuId(@PathVariable("menuUrl") String menuUrl,@PathVariable("menuId") Integer menuId,
			@PathVariable("flag") Integer flag,Model model,HttpServletRequest req) {
		StringBuffer template = new StringBuffer("/template/");
		try {
			if (StrUtil.isNull(menuUrl)) {
				return "error/error";
			}
			System.out.println("####@@@ menuUrl="+menuUrl);
			Menu menu = menuService.findMenuByMenuUrl(menuUrl);
			if (menu!=null) {
				//top menu数据									
				List<TPLVo> tplMenuList = getTopMenu();
				model.addAttribute("menuList", tplMenuList);
				
				//取栏目模板
				Menu parentmenu = menuService.selectMenuByPrimaryKey(menu.getParentmenuid());
				//left menu
				List<Menu> leftMenuList = getLeftMenu(parentmenu.getId());
				model.addAttribute("leftMenuList", leftMenuList);
				model.addAttribute("parentMenu", parentmenu);
				
				//详细页面数据
				//selectByPrimaryKey
				Content content;
				if(menu.getCount() <= 1){
					template.append(StrUtil.getTemplateForDetail(parentmenu.getTemplateurl()));
					content = contentService.selectContentByMenuId(menuId);
					
					if (content!=null) {
						content.setContent(StrUtil.decodeHtml(content.getContent()));
					}
					model.addAttribute("cms", content);
					
					model.addAttribute("activeMenu", parentmenu.getMenuurl());	
					
					if(menu.getParentmenuid()!=0)  //parentmenu为一级菜单  content的父级菜单为二级菜单  
					{
						model.addAttribute("contentParentMenuId", menu.getId());  
						model.addAttribute("contentParentMenuTitle", menu.getMenuname());
						model.addAttribute("contentParentMenuUrl", menu.getMenuurl());
					}
					else //parentmenu为一级菜单  content的父级菜单也为一级菜单时  
					{
						model.addAttribute("contentParentMenuId", 0);  
					}
					
					
				}else{
					
					template.append(StrUtil.getTemplateForList(parentmenu.getTemplateurl()));
					ContentVo cv = new ContentVo();
					cv.setMenuid(menu.getId());
					cv.setId(1);
					cv.setStart(0);
					cv.setLimit(Integer.parseInt(getMessage("list.limit")));
					cv.setHtmlurl(menu.getMenuurl());  //add by tl in 151224
					//获取内容列表
					List<Content> contentList = contentService.findLimitContentByMenuId(cv);
					model.addAttribute("vo", cv);
					model.addAttribute("menuTitle", menu.getMenuname());
					model.addAttribute("parentMenu", parentmenu);
	
					model.addAttribute("contentList", contentList);
					model.addAttribute("leftMenuList", leftMenuList);
					model.addAttribute("activeMenu", parentmenu.getMenuurl());  //等效于contentParentMenuUrl
					
					if(menu.getParentmenuid()!=0)  //parentmenu为一级菜单  content的父级菜单为二级菜单  
					{
						model.addAttribute("contentParentMenuId", menu.getId());  
						model.addAttribute("contentParentMenuTitle", menu.getMenuname());
						model.addAttribute("contentParentMenuUrl", menu.getMenuurl());
					}
					else //parentmenu为一级菜单  content的父级菜单也为一级菜单时  
					{
						model.addAttribute("contentParentMenuId", 0);  
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}

		return template.toString();
	}
	
	
	
	
	@RequestMapping(value = "/getMoreData", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getMoreData(@RequestBody String json) {
		try {
			
			ContentVo cv = JSON.parseObject(json,ContentVo.class);

			//获取内容列表
			List<Content> contentList = contentService.findLimitContentByMenuId(cv);


			String jsonData = StrUtil.toJsonStrWithFixed(contentList);
			//log.debug("###@@@ getMoreData(): jsonData="+jsonData);
			
			return jsonData;
		} catch (Exception e) {
			log.error(e);
			return "";
		}
	}
	
	
	
	/**
	 * 获取顶部导航菜单数据
	 * @return
	 */
	private List<TPLVo> getTopMenu() {
		try {
			//top menu数据									
			List<Menu> allMenu = (List<Menu> )cacheMap.get(MENU);
			if (allMenu==null) {
				allMenu = menuService.findAllMenu();
				cacheMap.put(MENU, allMenu);
			}
			List<TPLVo> tplMenuList = new ArrayList<TPLVo>();
			TPLVo tplMenu = null;
			if (allMenu!=null && allMenu.size()>0) {
				for (Menu topMenu : MapUtil.getTopMenuList(allMenu)) {
					tplMenu = new TPLVo();
					tplMenu.setMenu(topMenu);
					List<Menu> subMList = MapUtil.getSubMenuList(allMenu, topMenu.getId());
					if (subMList!=null && subMList.size()>0) {
						tplMenu.setSubMenu(subMList);
						tplMenu.setSubMenuLength(subMList.size());
					} else {
						tplMenu.setSubMenuLength(0);
					}
					tplMenuList.add(tplMenu);
				}
			}
			return tplMenuList;			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			return null;
		}
	}
	
	/**
	 * 获取左边菜单数据
	 * @param parentMenuId
	 * @return
	 */
	private List<Menu> getLeftMenu(int parentMenuId) {
		try {
			List<Menu> allMenu = (List<Menu> )cacheMap.get(MENU);
			if (allMenu==null) {
				allMenu = menuService.findAllMenu();
				cacheMap.put(MENU, allMenu);
			}
			List<Menu> leftMenuList = MapUtil.getSubMenuList(allMenu, parentMenuId);
			return leftMenuList;
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			return null;
		}
	}
	
	/**
	 * filter TheGroupname
	 * @param listRes
	 * @return
	 */
	private List<ResourceVo> filterGroupName(List<ResourceVo> listRes) {
		try {
			List<ResourceVo> list = new ArrayList<ResourceVo>();
			Map<String,ResourceVo> m = new HashMap<String,ResourceVo>();
			for (ResourceVo vo : listRes) {
				if(!m.containsKey(vo.getGroupName())) {
					m.put(vo.getGroupName(), vo);
				}
			}
			for (ResourceVo gn : m.values()) {
				list.add(gn);
				log.debug("###@@@ gn.groupName="+gn.getGroupName()+", menuUrl="+gn.getMenuUrl());
			}
			return list;		
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			return null;
		}
	}
	
	/**
	 * 清缓存数据
	 */
	public static void cleanCacheMap() {
		try {
			cacheMap = null;
			cacheMap = new HashMap<String,Object>();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
