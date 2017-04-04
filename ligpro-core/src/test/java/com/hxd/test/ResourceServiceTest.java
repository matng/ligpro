package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.Resource;
import com.hxd.service.ResourceService;

public class ResourceServiceTest extends BaseJunitTest {

	private static Log log = LogFactory.getLog(ResourceServiceTest.class);
	
	@Autowired
	ResourceService resourceService;
	
	
	@Override
	public void testInsert() {
		try {
			Resource resource = new Resource();
			resource.setBigpicurl("D:\\bigimage");
			resource.setFileurl("@Test@");
			resource.setGroupid(1);
			resource.setRestype((byte) 0);
			resource.setSmallpicurl("D:\\smallimage");
			
			int i = resourceService.insertResource(resource);
			
			System.out.println(resourceService.selectResourceByPrimaryKey(i).getBigpicurl());
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("ResourceService insert failed!");
			
		}

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
