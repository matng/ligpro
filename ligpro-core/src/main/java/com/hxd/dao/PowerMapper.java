package com.hxd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.Menu;
import com.hxd.bean.Power;
import com.hxd.vo.BaseVo;

public interface PowerMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Power record);
    
    int batchInsert(List<Power> record);

    int insertSelective(Power record);

    Power selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Power record);

    int updateByPrimaryKey(Power record);
    
    List<Power> queryPowerListByPage(BaseVo page,RowBounds rb);
    
    int queryPowerListCount(BaseVo page);
    
    List<Menu> queryPowerListByParentId(Map<String,Integer> map);
    
    int deleteByOwerId(Integer owerId);
    
    int saveOrUpdatePower(Power record);
    
    Power findPowerIsHave(Power record);
    
    int updatePowerStatus(Power record);
    
    List<Power> queryUserPower(Integer id);
}