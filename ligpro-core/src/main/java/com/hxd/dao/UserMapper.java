package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import com.hxd.bean.User;
import com.hxd.vo.BaseVo;

@Repository
public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    List<User> queryUserListByPage(BaseVo page,RowBounds rb);

    int queryUserListCount(BaseVo page);
    
    int deleteUserByBatch(List<Integer> ids);
    
    User findBySelective(User u);
    
    
    List<User> selectByLoginNameOrEmail(User u);  //查询登录名或者Email相同的数据项
}