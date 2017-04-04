package com.hxd.service;

import java.util.List;

import com.hxd.bean.User;
import com.hxd.vo.BaseVo;

public interface UserService {

	String SERVICE_NAME = "UserService";
	
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    List<User> queryByPage(BaseVo page);

    int queryCount(BaseVo page);
    
    int deleteUserByBatch(List<String> ids);
    
    User findBySelective(User u);
    
    boolean checkUniqueLoginname(User u);
    
    boolean checkUniqueEmail(User u);
    
    List<User> selectByLoginNameOrEmail(User u);  //查询登录名或者Email相同的数据项
    
}
