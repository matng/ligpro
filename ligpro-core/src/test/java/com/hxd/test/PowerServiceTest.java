package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.Power;
import com.hxd.service.PowerService;

public class PowerServiceTest extends BaseJunitTest {
	private static Log log = LogFactory.getLog(PowerServiceTest.class);
	
	@Autowired
	PowerService powerService;
	
	@Override
	public void testInsert() {
		try {
			Power power = new Power();
			power.setIsenable((byte) 1);
			power.setOwner("Admin");
			power.setOwnerid(1);
			power.setResource("testImage");
			power.setResourceid(1);
			
			int i = powerService.insertPower(power);
			
			System.out.println(powerService.selectPowerByPrimaryKey(i).getOwner());
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("PowerService insert failed!");
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
