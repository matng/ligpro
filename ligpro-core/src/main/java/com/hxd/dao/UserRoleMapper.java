package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.UserRole;
import com.hxd.vo.BaseVo;

public interface UserRoleMapper {
    int deleteByPrimaryKey(Integer id);
    
    int deleteByUserId(List<Integer> ids);

    int insert(UserRole record);

    int insertSelective(UserRole record);

    UserRole selectByPrimaryKey(Integer id);

    int updateByUserId(UserRole record);

    int updateByPrimaryKey(UserRole record);
    
    List<UserRole> queryUserRoleListByPage(BaseVo page,RowBounds rb);
    
    int queryUserRoleListCount(BaseVo page);
}