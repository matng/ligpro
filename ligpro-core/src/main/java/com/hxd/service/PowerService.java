package com.hxd.service;

import java.util.List;
import java.util.Map;

import com.hxd.bean.Menu;
import com.hxd.bean.Power;
import com.hxd.vo.BaseVo;

public interface PowerService {
	String SERVICE_NAME = "PowerService";
    int deletePowerByPrimaryKey(Integer id);

    int insertPower(Power record);
    
    int batchInsert(List<Power> record);

    int insertPowerSelective(Power record);

    Power selectPowerByPrimaryKey(Integer id);

    int updatePowerByPrimaryKeySelective(Power record);

    int updatePowerByPrimaryKey(Power record);
    
    List<Power> queryPowerByPage(BaseVo page);
    
    int queryPowerCount(BaseVo page);
    
    List<Menu> queryPowerListByParentId(Map<String,Integer> map);
    
    int deleteByOwerId(Integer owerId);
    
    int saveOrUpdatePower(Power record);
    
    Power findPowerIsHave(Power record);
    
    int updatePowerStatus(Power record);
    
    List<Power> queryUserPower(Integer id);
}
