package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.Menu;
import com.hxd.service.MenuService;

public class MenuServiceTest extends BaseJunitTest {
	private static Log log = LogFactory.getLog(MenuServiceTest.class);
	
	@Autowired
	MenuService menuService;
	
	@Override
	public void testInsert() {
		try {
			Menu menu = new Menu();
			menu.setIsenable(0);
			menu.setMenucode("test");
			menu.setMenuname("菜单");
			menu.setMenuurl("http://www.baidu.com");
			menu.setModuleid(1);
			menu.setParentmenuid(2);
			menu.setSeqno(0);
			menu.setTemplateid(12);
			menu.setTemplateurl("D:\\tempUrl");
			
			int i = menuService.insertMenu(menu);
			
			System.out.println(menuService.selectMenuByPrimaryKey(i).getMenuurl());
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("MenuService insert failed!");
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
