package com.hxd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.Menu;
import com.hxd.vo.BaseVo;

public interface MenuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
    
    List<Menu> queryMenuListByPage(BaseVo page,RowBounds rb);
    
    int queryMenuListCount(BaseVo page);
    
    List<Menu> queryListByParentId(Integer id);
    
    List<Menu> queryListByParentIdWithoutFirst(Integer id);
    
    int deleteMenuByNodeId(Integer id);
    
    Menu findMenuByMenuUrl(String menuUrl);
    
    List<Menu> findAllMenu();
    
    List<Menu> findMenuByModuleId(Map<String,Integer> map);
    
    int queryMenuCountByMenuUrl(String url);
}