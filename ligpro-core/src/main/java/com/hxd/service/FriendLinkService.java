package com.hxd.service;

import java.util.List;

import com.hxd.bean.FriendLink;
import com.hxd.vo.BaseVo;

public interface FriendLinkService {
	String SERVICE_NAME = "FriendLinkService";
    int deleteFriendLinkByPrimaryKey(Integer id);

    int insertFriendLink(FriendLink record);

    int insertFriendLinkSelective(FriendLink record);

    FriendLink selectFriendLinkByPrimaryKey(Integer id);

    int updateFriendLinkByPrimaryKeySelective(FriendLink record);

    int updateFriendLinkByPrimaryKey(FriendLink record);
    
    List<FriendLink> queryFriendLinkByPage(BaseVo page);
    
    int queryFriendLinkCount(BaseVo page);
    
    int deleteFriendLinkByBatch(List<String> ids);
    
    List<FriendLink> selectBySiteName(FriendLink record);
    
    List<FriendLink> findAllFriendLink();
}
