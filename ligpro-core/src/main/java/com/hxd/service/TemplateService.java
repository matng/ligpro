package com.hxd.service;

import java.util.List;

import com.hxd.bean.Template;
import com.hxd.vo.BaseVo;

public interface TemplateService {
	String SERVICE_NAME = "TemplateService";
	
    int deleteTemplateByPrimaryKey(Integer id);
    
    int deleteTemplateByBatch(List<String> ids);

    int insertTemplate(Template record);

    int insertTemplateSelective(Template record);

    Template selectTemplateByPrimaryKey(Integer id);

    int updateTemplateByPrimaryKeySelective(Template record);

    int updateTemplateByPrimaryKey(Template record);
    
    List<Template> queryTemplateByPage(BaseVo page);
    
    int queryTemplateCount(BaseVo page);
    
    List<Template> queryAll();
}
