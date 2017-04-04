package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.Role;
import com.hxd.vo.BaseVo;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    
    List<Role> queryRoleListByPage(BaseVo page,RowBounds rb);
    
    int queryRoleListCount(BaseVo page);
    
    int deleteRoleByBatch(List<Integer> ids);
    
    List<Role> queryAllRole();
}