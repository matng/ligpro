package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.FriendLink;
import com.hxd.vo.BaseVo;

public interface FriendLinkMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(FriendLink record);

    int insertSelective(FriendLink record);

    FriendLink selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(FriendLink record);

    int updateByPrimaryKey(FriendLink record);
    
    List<FriendLink> queryFriendLinkListByPage(BaseVo page,RowBounds rb);
    
    int queryFriendLinkListCount(BaseVo page);
    
    int deleteFriendLinkByBatch(List<Integer> ids);
    
    List<FriendLink> selectBySiteName(FriendLink record);
    
    List<FriendLink> findAllFriendLink();
}