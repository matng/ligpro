package com.hxd.service;

import java.util.List;
import java.util.Map;

import com.hxd.bean.Menu;
import com.hxd.vo.BaseVo;

public interface MenuService {
	String SERVICE_NAME = "MenuService";
    int deleteMenuByPrimaryKey(Integer id);

    int insertMenu(Menu record);

    int insertMenuSelective(Menu record);

    Menu selectMenuByPrimaryKey(Integer id);

    int updateMenuByPrimaryKeySelective(Menu record);

    int updateMenuByPrimaryKey(Menu record);
    
    List<Menu> queryMenuByPage(BaseVo page);
    
    int queryMenuCount(BaseVo page);
    
    List<Menu> queryListByParentId(Integer id);
    
    List<Menu> queryListByParentIdWithoutFirst(Integer id);
    
    int deleteMenuByNodeId(Integer id);
    
    Menu findMenuByMenuUrl(String menuUrl);
    
    List<Menu> findAllMenu();
    
    List<Menu> findMenuByModuleId(Map<String,Integer> map);
    
    int queryMenuCountByMenuUrl(String url);
}
