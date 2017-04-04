package com.hxd.service;

import java.util.List;

import com.hxd.bean.ResourceGroup;
import com.hxd.vo.BaseVo;

public interface ResourceGroupService {
	String SERVICE_NAME = "ResourceGroupService";
    int deleteResourceGroupByPrimaryKey(Integer id);

    int insertResourceGroup(ResourceGroup record);

    int insertResourceGroupSelective(ResourceGroup record);

    ResourceGroup selectResourceGroupByPrimaryKey(Integer id);

    int updateResourceGroupByPrimaryKeySelective(ResourceGroup record);

    int updateResourceGroupByPrimaryKey(ResourceGroup record);
    
    List<ResourceGroup> queryResourceGroupByPage(BaseVo page);
    
    int queryResourceGroupCount(BaseVo page);
    
    List<ResourceGroup> queryListByParentId(ResourceGroup record);
    
    int deleteResourceGroupByNodeId(Integer id);
    
    int queryChildCountByParentId(Integer id);
}
