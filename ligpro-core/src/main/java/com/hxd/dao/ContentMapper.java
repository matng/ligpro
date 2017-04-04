package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.Content;
import com.hxd.vo.BaseVo;
import com.hxd.vo.ContentVo;

public interface ContentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Content record);

    int insertSelective(Content record);

    Content selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Content record);

    int updateByPrimaryKeyWithBLOBs(Content record);

    int updateByPrimaryKey(Content record);
    
    List<Content> queryContentListByPage(BaseVo page,RowBounds rb);
    
    int queryContentListCount(BaseVo page);
    
    int deleteContentByBatch(List<Integer> ids);
    
    List<Content> findLimitContentByTypeUnion(int limit);
    
    List<Content> findLimitContentByMenuId(ContentVo vo);
    
    Content selectContentByMenuId(int menuid);
    
    int queryUseCountByResource(String rsName);
    
}