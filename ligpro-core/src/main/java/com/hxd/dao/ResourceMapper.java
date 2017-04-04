package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.Resource;
import com.hxd.vo.BaseVo;
import com.hxd.vo.ResourceVo;

public interface ResourceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Resource record);

    int insertSelective(Resource record);

    Resource selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Resource record);

    int updateByPrimaryKey(Resource record);
    
    List<Resource> queryResourceListByPage(BaseVo page,RowBounds rb);
    
    int queryResourceListCount(BaseVo page);
    
    int deleteResourceByBatch(List<Integer> ids);
    
    int queryResourceCountByGroupID(Resource record);
    
    List<ResourceVo> findResourceByUserTypeWithLimit(ResourceVo vo);
    
}