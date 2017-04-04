package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.Module;
import com.hxd.vo.BaseVo;

public interface ModuleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Module record);

    int insertSelective(Module record);

    Module selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Module record);

    int updateByPrimaryKey(Module record);
    
    List<Module> queryModuleListByPage(BaseVo page,RowBounds rb);
    
    List<Module> queryAll();
    
    int queryModuleListCount(BaseVo page);
    
    int deleteModuleByBatch(List<Integer> ids);
    
    List<Module> queryForPower(Integer ownerId);
}