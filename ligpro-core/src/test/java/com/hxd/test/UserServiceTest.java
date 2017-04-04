package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.User;
import com.hxd.service.UserService;
import com.hxd.vo.BaseVo;
import java.util.List;

public class UserServiceTest extends BaseJunitTest {

	private static Log log = LogFactory.getLog(UserServiceTest.class);
	
	@Autowired
	UserService service;

	public void testInsert() {
		try {
			User user = new User();
			user.setEmail("test@test5555");
			user.setGender("test");
			user.setLoginname("william3333");
			user.setMobile("13900000000");
			user.setPsw("123456");
			user.setRealname("张三5555555555");
			user.setStatus(1);
			
			int i = service.insert(user);//插入操作  
			User u = service.selectByPrimaryKey(i);
			System.out.println(u);
			//测试完后删除脏数据
			//service.deleteByPrimaryKey(i);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("UserServiceImpl insert failed!");
		}

	}
	
	
	public void testDelete()
	{
		//int i = service.deleteByPrimaryKey(3);
		//System.out.println(i);
	}
	
	
	public void testQueryCount()
	{
		//all
//		PageVo p = new PageVo();
//		p.setsSearch("");
//		p.setiDisplayStart(0);
//		p.setiDisplayLength(10);		
//		int i = service.queryCount(p);
//		System.out.println(i);
		
		//some
		BaseVo p = new BaseVo();
		p.setsSearch("a");
		p.setiDisplayStart(0);
		p.setiDisplayLength(10);
		int i = service.queryCount(p);
		System.out.println("##MyDebug##： "+i);
		
	}
	
	public void testQueryPage()
	{
		//all
//		PageVo p = new PageVo();
//		p.setsSearch("");
//		p.setiDisplayStart(0);
//		p.setiDisplayLength(5);		
//		List<User> userList = service.queryByPage(p);
//		for (User u : userList)
//		{
//			System.out.println("###MyUser###"+u);
//		}
		
		//some
		
		BaseVo p = new BaseVo();
		p.setsSearch("a");
		p.setiDisplayStart(0);
		p.setiDisplayLength(2);		
		List<User> userList = service.queryByPage(p);
		for (User u : userList)
		{
			System.out.println("###MyUser###"+u);
		}
	}


	public void testUpdate() {
		// TODO Auto-generated method stub
		
	}


	public void testSelect() {
		// TODO Auto-generated method stub
		
	}


	public void testInsertSelective() {
		// TODO Auto-generated method stub
		
	}
}
