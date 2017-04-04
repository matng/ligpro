package com.hxd.site.ctl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hxd.bean.User;
import com.hxd.email.MailUtil;
import com.hxd.security.Encodes;
import com.hxd.service.OpLogService;
import com.hxd.service.UserService;
import com.hxd.site.filter.AuthRealm.Principal;
import com.hxd.site.filter.ShiroCache;
import com.hxd.util.CacheUtils;
import com.hxd.util.CookieUtils;
import com.hxd.util.StrUtil;

@Controller
public class LoginCtl extends BaseCtl {

	@Autowired
	private UserService userService;
	
	@Autowired
	private OpLogService LogService;

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(
			@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String username,
			HttpServletRequest req, HttpServletResponse resp, Model model) {
		log.debug("####@@@ goto 45 login() ");
		
		User user = ShiroCache.getUser();
		// 如果已经登录，则跳转到管理首页
		if (user != null && user.getId() != null) {
			// 登录成功后，验证码计算器清零
			isValidateCodeLogin(user.getLoginname(), false, true);		
			//set cookies
			ShiroCache.putCache("siteId", CookieUtils.getCookie(req, "siteId"));
			log.debug("####@@@ goto 54 login() ");
			return "redirect:/main";
		}
		model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM,
				username);
		model.addAttribute("isValidateCodeLogin",
				isValidateCodeLogin(username, true, false));

		return "login";
	}

	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpServletRequest req, HttpServletResponse resp,
			Model model) {
		log.debug("####@@@ goto 69 login() ");
		User user = ShiroCache.getUser();
		// 如果已经登录，则跳转到管理首页
		if (user!=null && user.getId() != null) {
			log.debug("####@@@ goto 73 login() ");
			return "redirect:/main";
		}
		return "login";
	}


	@RequestMapping("/logout")
	public String logout(Model model, HttpServletRequest req) {
		try {
			Subject subject = SecurityUtils.getSubject();
			Principal p = (Principal) subject.getPrincipal();
			if(p!=null){
				// 登录成功后，验证码计算器清零
				isValidateCodeLogin(p.getLoginName(),false,true);
			}
			

//			ShiroCache.onlineUserMap.remove(p.getLoginName());
//			System.out.println("###@@@ 当前在线数:"+ShiroCache.onlineUserMap.size());
//			System.out.println("###@@@ session创建 loginname="+p.getLoginName());
			
			
			SecurityUtils.getSubject().logout();			
		} catch (UnavailableSecurityManagerException e) {
			log.error(e);
		} catch (InvalidSessionException e) {
			log.error(e);
		}
		return "login";
	}

	@RequestMapping(value = "/sendemail", method = RequestMethod.POST)
	public String sendEmail(@RequestParam("email") String email) {
		try {
			User findUser = new User();
			findUser.setEmail(email);
			User user = userService.findBySelective(findUser);
			if (user!=null && user.getId()!=null  && user.getStatus() != 0) {
				String randomPsw = StrUtil.randomNum(6);
				user.setPsw(Encodes.encodePsw(randomPsw));
				int i = userService.updateByPrimaryKeySelective(user);
				if (i>0) {
					//send email
					String title = "密码找回邮件";
					String content = "您好,"+user.getRealname()+"!<br><br>你通过邮件找回密码成功，这是系统随机生成给您的初始密码：<font color='red'><b>"+randomPsw+"</b></font><br>请登录系统后，重新修改密码!";
					MailUtil.sendEmail(title, content, email);
				}				
			}
		} catch (Exception e) {
			log.error(e);
		}
		return "redirect:/login";
	}
	
	/**
	 * 是否是验证码登录
	 * 
	 * @param useruame
	 *            用户名
	 * @param isFail
	 *            计数加1
	 * @param clean
	 *            计数清零
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean isValidateCodeLogin(String loginname, boolean isFail,
			boolean clean) {
		Map<String, Integer> loginFailMap = (Map<String, Integer>) CacheUtils.get("loginFailMap");
		if (loginFailMap == null) {
			loginFailMap = new HashMap<String, Integer>();
			CacheUtils.put("loginFailMap", loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(loginname);
		if (loginFailNum == null) {
			loginFailNum = 0;
		}
		if (isFail) {
			loginFailNum++;
			loginFailMap.put(loginname, loginFailNum);
		}
		if (clean) {
			loginFailMap.remove(loginname);
		}
		return loginFailNum >= 3;
	}

	
	

}
