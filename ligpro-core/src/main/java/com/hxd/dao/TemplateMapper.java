package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.Template;
import com.hxd.vo.BaseVo;

public interface TemplateMapper {
    int deleteByPrimaryKey(Integer id);
    
    int deleteTemplateByBatch(List<Integer> ids);

    int insert(Template record);

    int insertSelective(Template record);

    Template selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Template record);

    int updateByPrimaryKey(Template record);
    
    List<Template> queryAll();
    
    List<Template> queryTemplateListByPage(BaseVo page,RowBounds rb);
    
    int queryTemplateListCount(BaseVo page);
}