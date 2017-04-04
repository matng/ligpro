package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.Role;
import com.hxd.service.RoleService;

public class RoleServiceTest extends BaseJunitTest {

	private static Log log = LogFactory.getLog(RoleServiceTest.class);
	
	@Autowired
	RoleService roleService;
	
	@Override
	public void testInsert() {
		try {
			Role role = new Role();
			role.setIsenable((byte) 1);
			role.setRoledesc("角色描述！");
			role.setRolename("will");
			
			int i = roleService.insertRole(role);
			
			System.out.println(roleService.selectRoleByPrimaryKey(i).getRolename());
			roleService.deleteRoleByPrimaryKey(1);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("RoleServiceImpl insert failed!");
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
