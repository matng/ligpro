package com.hxd.test;

import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.Template;
import com.hxd.service.TemplateService;

public class TemplateServiceTest extends BaseJunitTest {

	@Autowired
	TemplateService tempService;
	
	@Override
	public void testInsert() {
		// TODO Auto-generated method stub
		Template template = new Template();
		template.setGroupid(1);
		template.setName("首页");
		template.setType((byte) 0);
		template.setUrl("www.baidu.com");
		
		int i = tempService.insertTemplate(template);
		
		System.out.println(tempService.selectTemplateByPrimaryKey(i));

	}

	@Override
	public void testInsertSelective() {
		// TODO Auto-generated method stub

	}

	@Override
	public void testUpdate() {
		// TODO Auto-generated method stub

	}

	@Override
	public void testSelect() {
		// TODO Auto-generated method stub

	}

	@Override
	public void testDelete() {
		// TODO Auto-generated method stub

	}

	@Override
	public void testQueryCount() {
		// TODO Auto-generated method stub

	}

	@Override
	public void testQueryPage() {
		// TODO Auto-generated method stub

	}

}
