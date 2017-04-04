package com.hxd.service;

import java.util.List;

import com.hxd.bean.UserRole;
import com.hxd.vo.BaseVo;

public interface UserRoleService {
	
	String SERVICE_NAME = "UserRoleService";
	
    int deleteUserRoleByPrimaryKey(Integer id);
    
    int deleteByUserId(List<String> ids);

    int insertUserRole(UserRole record);

    int insertUserRoleSelective(UserRole record);

    UserRole selectUserRoleByPrimaryKey(Integer id);

    int updateByUserId(UserRole record);

    int updateUserRoleByPrimaryKey(UserRole record);
    
    List<UserRole> queryUserRoleByPage(BaseVo page);
    
    int queryUserRoleCount(BaseVo page);
}
