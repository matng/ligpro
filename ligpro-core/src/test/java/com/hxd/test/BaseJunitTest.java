package com.hxd.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/application-context.xml" })
public abstract class BaseJunitTest {

	@Test
	public abstract void testInsert();
	
	@Test
	public abstract void testInsertSelective();
	
	@Test
	public abstract void testUpdate();
	
	@Test
	public abstract void testSelect();
	
	@Test
	public abstract void testDelete();
	
	@Test
	public abstract void testQueryCount();
	
	@Test
	public abstract void testQueryPage();
}
