package com.hxd.test;

import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.OpLog;
import com.hxd.service.OpLogService;

public class OpLogServiceTest extends BaseJunitTest {
	private static Log log = LogFactory.getLog(OpLogServiceTest.class);
	
	@Autowired
	OpLogService opLogService;
	
	@Override
	public void testInsert() {
		try {
			OpLog opLog = new OpLog();
			opLog.setLoginip("192.168.1.2");
			opLog.setLoginname("will");
			opLog.setOptime(new Date());
			opLog.setTitle("sadjsaiof;jea;ifjesifaj164789156498456");
			opLog.setUserid(1);
			opLog.setContent("asadjsaiof;jea;ifjesifajelijfasljfdiewofjoiewfjiewjfiecdknvjdsa[jdipsfpoiewfjoiewjfcoeqjpieq[jfoireqjvire[jvqoieqj"
					+ "asadjsaiof;jea;ifjesifajelijfasljfdiewofjoiewfjiewjfiecdknvjdsa[jdipsfpoiewfjoiewjfcoeqjpieq[jfoireqjvire[jvqoieqj"
					+ "asadjsaiof;jea;ifjesifajelijfasljfdiewofjoiewfjiewjfiecdknvjdsa[jdipsfpoiewfjoiewjfcoeqjpieq[jfoireqjvire[jvqoieqj"
					+ "asadjsaiof;jea;ifjesifajelijfasljfdiewofjoiewfjiewjfiecdknvjdsa[jdipsfpoiewfjoiewjfcoeqjpieq[jfoireqjvire[jvqoieqj"
					+ "asadjsaiof;jea;ifjesifajelijfasljfdiewofjoiewfjiewjfiecdknvjdsa[jdipsfpoiewfjoiewjfcoeqjpieq[jfoireqjvire[jvqoieqj");
			
			long i = opLogService.insertOpLog(opLog);
			
			System.out.println(opLogService.selectOpLogByPrimaryKey(i).getContent());
		} catch (Exception e) {
			e.printStackTrace();
			log.info("OpLogService insert failed!");
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
