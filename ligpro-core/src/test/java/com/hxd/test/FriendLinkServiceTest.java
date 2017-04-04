package com.hxd.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.FriendLink;
import com.hxd.service.FriendLinkService;

public class FriendLinkServiceTest extends BaseJunitTest {
	private static Log log = LogFactory.getLog(FriendLinkServiceTest.class);
	
	@Autowired
	FriendLinkService friendLinkService;
	
	@Override
	public void testInsert() {
		try {
			FriendLink friendLink = new FriendLink();
			
			friendLink.setIsenable((byte) 1);
			friendLink.setLinktype((byte) 1);
			friendLink.setLogourl("logourl/image");
			friendLink.setSeqno(1);
			friendLink.setSitename("网站名称");
			friendLink.setSiteurl("www.sitename.com");
			
			int i = friendLinkService.insertFriendLink(friendLink);
			
			System.out.println(friendLinkService.selectFriendLinkByPrimaryKey(i).getSiteurl());
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("FriendLinkService insert failed!");
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
