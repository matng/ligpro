package com.hxd.service;

import java.util.List;

import com.hxd.bean.Content;
import com.hxd.vo.BaseVo;
import com.hxd.vo.ContentVo;

public interface ContentService {
	String SERVICE_NAME = "ContentService";
    int deleteContentByPrimaryKey(Integer id);

    int insertContent(Content record);

    int insertContentSelective(Content record);

    Content selectContentByPrimaryKey(Integer id);

    int updateContentByPrimaryKeySelective(Content record);

    int updateContentByPrimaryKey(Content record);
    
    List<Content> queryContentByPage(BaseVo page);
    
    int queryContentCount(BaseVo page);
    
    int deleteContentByBatch(List<String> ids);
    
    List<Content> findLimitContentByTypeUnion(int limit);
    
    List<Content> findLimitContentByMenuId(ContentVo vo);
    
    Content selectContentByMenuId(int menuid);
    
    int queryUseCountByResource(String rs);
    
}
