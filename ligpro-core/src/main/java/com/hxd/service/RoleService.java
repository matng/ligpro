package com.hxd.service;

import java.util.List;

import com.hxd.bean.Role;
import com.hxd.vo.BaseVo;

public interface RoleService {
	
	String SERVICE_NAME = "RoleService";
	
    int deleteRoleByPrimaryKey(Integer id);

    int insertRole(Role record);

    int insertRoleSelective(Role record);

    Role selectRoleByPrimaryKey(Integer id);

    int updateRoleByPrimaryKeySelective(Role record);

    int updateRoleByPrimaryKey(Role record);
    
    List<Role> queryRoleByPage(BaseVo page);
    
    int queryRoleCount(BaseVo page);
    
    int deleteRoleByBatch(List<String> ids);
    
    List<Role> queryAllRole();
}
