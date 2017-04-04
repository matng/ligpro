package com.hxd.service;

import java.util.List;

import com.hxd.bean.Module;
import com.hxd.vo.BaseVo;

public interface ModuleService {
	String SERVICE_NAME = "ModuleService";
    int deleteModuleByPrimaryKey(Integer id);

    int insertModule(Module record);

    int insertModuleSelective(Module record);

    Module selectModuleByPrimaryKey(Integer id);

    int updateModuleByPrimaryKeySelective(Module record);

    int updateModuleByPrimaryKey(Module record);
    
    List<Module> queryModuleByPage(BaseVo page);
    
    List<Module> queryAll();
    
    int queryModuleCount(BaseVo page);
    
    int deleteModuleByBatch(List<String> ids);
    
    List<Module> queryForPower(Integer ownerId);
}
