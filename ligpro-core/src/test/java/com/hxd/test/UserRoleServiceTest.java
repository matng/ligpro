package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.UserRole;
import com.hxd.service.UserRoleService;

public class UserRoleServiceTest extends BaseJunitTest {

	private static Log log = LogFactory.getLog(UserRoleServiceTest.class);
	@Autowired
	UserRoleService userRoleService;

	@Override
	public void testInsert() {
		// TODO Auto-generated method stub
		try {
			UserRole userRole = new UserRole();
			userRole.setRoleId(1);
			userRole.setUserId(2);
			
			int id = userRoleService.insertUserRole(userRole);
			
			System.out.println(userRoleService.selectUserRoleByPrimaryKey(id));
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("UserRoleServiceImpl insert failed!");
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
