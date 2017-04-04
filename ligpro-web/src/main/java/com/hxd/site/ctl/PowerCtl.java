package com.hxd.site.ctl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.Menu;
import com.hxd.bean.Power;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.PowerService;
import com.hxd.util.StrUtil;
import com.hxd.vo.AdditionalParameters;
import com.hxd.vo.MenuItem;
import com.hxd.vo.StatusVo;

@Controller
@RequestMapping("/power")
public class PowerCtl extends BaseCtl{
	
	
	@Autowired
	private PowerService service;
	
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getMenuListJson(@RequestBody String json) throws JsonGenerationException, JsonMappingException, IOException {
		
		List<MenuItem> listItem = new ArrayList<MenuItem>();
		try {
			log.debug("###@@@ getMenuListJson() ="+json);
			
			Menu menu = JSON.parseObject(json,Menu.class);
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("id",menu.getId());
			map.put("ownerId",menu.getModuleid());
			List<Menu> listMenu = service.queryPowerListByParentId(map);
			MenuItem menuItem = null;
			for (Menu m : listMenu) {
				menuItem = new MenuItem();
				BeanUtils.copyProperties(m,menuItem);
				menuItem.setText(m.getMenuname());
				AdditionalParameters p = new AdditionalParameters();
				p.setId(String.valueOf(m.getId()));
				if(m.getIsenable() == 1){
					p.setItemSelected(true);
				}
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
		ObjectMapper mapper = new ObjectMapper();
		return StrUtil.toJsonStrWithFixed(mapper.writeValueAsString(listItem));
	}
	
	@ControllerLog(cleanData="true",desc="log.power.save")
	@RequestMapping(value = "/save", produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.POST })
	@ResponseBody
	public String savePower(@RequestBody Power[] arr) {
		StatusVo sta = new StatusVo();
		List<Power> powers = new ArrayList<Power>();
		for(Power obj : arr){
			Power p = new Power();
			p.setId(obj.getId());
			p.setOwner(obj.getOwner());
			p.setOwnerid(obj.getOwnerid());
			p.setResource(obj.getResource());
			p.setResourceid(obj.getResourceid());
			p.setIsenable(obj.getIsenable());
			powers.add(p);
		}
		
		int i = service.deleteByOwerId(arr[0].getOwnerid());
		if(i > -1){
			try {
				service.batchInsert(powers);
				sta.setSuccess(this.getMessage("op.success"));
			}catch (Exception e) {
				log.error(e);
				sta.setError(this.getMessage("op.fail"));
				return StrUtil.toJsonStrWithFixed(sta);
			}
		}else{
			sta.setError(this.getMessage("op.fail"));
			return StrUtil.toJsonStrWithFixed(sta);
		}
		return StrUtil.toJsonStrWithFixed(sta);
	}
	
	@ControllerLog(cleanData="true",desc="log.power.update")
	@RequestMapping(value = "/saveOrUpdatePower", produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.POST })
	@ResponseBody
	public String saveOrUpdatePower(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		Power power = JSON.parseObject(json,Power.class);
		
		Power po = service.findPowerIsHave(power);
		int i;
		byte a;
		if(po.getCount() > 0){
			if(po.getIsenable()==1){
				a = 0;
			}else{
				a=1;
			}
			power.setIsenable(a);
			i = service.updatePowerStatus(power);
		}else{
			power.setIsenable((byte) 1);
			i = service.insertPower(power) ;
		}
		
		if(i > -1){
			sta.setSuccess(this.getMessage("op.success"));
		}else{
			sta.setError(this.getMessage("op.fail"));
			return StrUtil.toJsonStrWithFixed(sta);
		}
		return StrUtil.toJsonStrWithFixed(sta);
	}
}
