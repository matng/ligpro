package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.ResourceGroup;
import com.hxd.vo.BaseVo;

public interface ResourceGroupMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ResourceGroup record);

    int insertSelective(ResourceGroup record);

    ResourceGroup selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ResourceGroup record);

    int updateByPrimaryKey(ResourceGroup record);
    
    List<ResourceGroup> queryResourceGroupListByPage(BaseVo page,RowBounds rb);
    
    int queryResourceGroupListCount(BaseVo page);
    
    List<ResourceGroup> queryListByParentId(ResourceGroup record);
    
    public int deleteResourceGroupByNodeId(Integer id);
    
    int queryChildCountByParentId(Integer id);
}