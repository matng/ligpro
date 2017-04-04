package com.hxd.test;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.Module;
import com.hxd.service.ModuleService;
import com.hxd.vo.BaseVo;

public class ModuleServiceTest extends BaseJunitTest {
	private static Log log = LogFactory.getLog(ModuleServiceTest.class);
	
	@Autowired
	ModuleService moduleService;
	
	@Override
	public void testInsert() {
		try {
//			Module module = new Module();
//			module.setIsenable((byte) 1);
//			module.setModulecode("test");
//			module.setModuledesc("test@@@");
//			module.setModulename("联系我们");
//			module.setSeqno(1);
//			
//			int i = moduleService.insertModule(module);
//			
//			System.out.println(moduleService.selectModuleByPrimaryKey(i).getModulename());
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("ModuleService insert failed!");
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
		try {
			BaseVo p = new BaseVo();
			p.setsSearch("我");
			p.setiDisplayStart(0);
			p.setiDisplayLength(2);		
			List<Module> moduleList = moduleService.queryModuleByPage(p);
			for (Module m : moduleList)
			{
				System.out.println("###MyModule###"+m);
			}
		} catch (Exception e) {
			log.error(e);
		}

	}
	
	@Test
	public void testDeleteBatch()
	{
//		try {
//			List<Integer> idList = new ArrayList<Integer>();
//			idList.add(2);
//			idList.add(3);
//			
//			int i = moduleService.deleteModuleByBatch(idList);
//			
//			System.out.println(i);
//			
//		} catch (Exception e) {
//			log.error(e);
//		}
	}
	
	@Test
	public void testQueryAll()
	{
		List<Module> moduleList =  moduleService.queryAll();
		System.out.println(moduleList.get(0).getModulename());
	}

}
