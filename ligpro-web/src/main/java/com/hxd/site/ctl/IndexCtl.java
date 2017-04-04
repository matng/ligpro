package com.hxd.site.ctl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hxd.bean.Menu;
import com.hxd.bean.User;
import com.hxd.service.MenuService;
import com.hxd.site.filter.ShiroCache;
import com.hxd.util.MapUtil;
import com.hxd.util.StrUtil;
import com.hxd.vo.OnlineUserVo;
import com.hxd.vo.TPLVo;

@Controller
public class IndexCtl extends BaseCtl {

	@Autowired
	private MenuService menuService;
	
	@RequestMapping("/main")
	public String home(Model model,HttpServletRequest req) {
		try {
			User u = ShiroCache.getUser();
			if (u!=null) {
				ShiroCache.onlineUserMap.put(u.getLoginname(), u);
			}
			model.addAttribute("loginname", u.getLoginname());
			
			//init the Nav menu
		
			List<Menu> allMenu = (List<Menu> )ParseCtl.cacheMap.get(ParseCtl.MENU);
			if (allMenu==null) {
				allMenu = menuService.findAllMenu();
				ParseCtl.cacheMap.put(ParseCtl.MENU, allMenu);
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
			model.addAttribute("navMenuList", tplMenuList);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		
		

		return "/main";
	}
	
	@RequestMapping(value = "/onlineUser", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getOnlineUser() {
		try {
			List<User> list = new ArrayList<User>();
			list.addAll(ShiroCache.onlineUserMap.values());
			OnlineUserVo vo = new OnlineUserVo();
			vo.setCount(String.valueOf(list.size()));
			vo.setUserList(list);
			return StrUtil.toJsonStrWithFixed(vo);
		} catch (Exception e) {
			log.error(e);
		}
		return "";
	}
	
	@RequestMapping("/center")
	public String test(Model model,HttpServletRequest req) {
		return "center";
	}
}
