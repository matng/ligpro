package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.ResourceGroup;
import com.hxd.service.ResourceGroupService;

public class ResourceGroupServiceTest extends BaseJunitTest {

	private static Log log = LogFactory.getLog(ResourceGroupServiceTest.class);
	
	@Autowired
	ResourceGroupService resourceGroupService;
	
	@Override
	public void testInsert() {
		try {
			ResourceGroup rGroup = new ResourceGroup();
			rGroup.setGroupdesc("@Test@");
			rGroup.setGroupname("图片");
			rGroup.setGrouptype((byte) 0);
			rGroup.setParentgroupid(0);
			
			int i = resourceGroupService.insertResourceGroup(rGroup);
			System.out.println(resourceGroupService.selectResourceGroupByPrimaryKey(i).getGroupname());
		} catch (Exception e) {
			e.printStackTrace();
			log.info("ResourceGroupService insert failed!");
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
