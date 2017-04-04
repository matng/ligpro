package com.hxd.service;

import java.util.List;

import com.hxd.bean.Resource;
import com.hxd.vo.BaseVo;
import com.hxd.vo.ResourceVo;

public interface ResourceService {
	String SERVICE_NAME = "ResourceService";
    int deleteResourceByPrimaryKey(Integer id);

    int insertResource(Resource record);

    int insertResourceSelective(Resource record);

    Resource selectResourceByPrimaryKey(Integer id);

    int updateResourceByPrimaryKeySelective(Resource record);

    int updateResourceByPrimaryKey(Resource record);
    
    List<Resource> queryResourceByPage(BaseVo page);
    
    int queryResourceCount(BaseVo page);
    
    int deleteResourceByBatch(List<String> ids);
    
    int queryResourceCountByGroupID(Resource record);
    
    List<ResourceVo> findResourceByUserTypeWithLimit(ResourceVo vo);
    
}
