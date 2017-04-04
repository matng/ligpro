package com.hxd.test;

import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hxd.bean.Content;
import com.hxd.service.ContentService;
import com.hxd.vo.BaseVo;

public class ContentServiceTest extends BaseJunitTest {
	private static Log log = LogFactory.getLog(ContentServiceTest.class);
	
	@Autowired
	ContentService contentService;
	
	@Override
	public void testInsert() {
		try {
			Content content = new Content();
			content.setAddtime(new Date());
			content.setContent("发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容发布内容");
			content.setHtmlurl("www.baidu.com");
			content.setIscheck((byte) 0);
			content.setKeyword("关键字");
			content.setMenuid(1);
			content.setSeqno(2);
			content.setTitle("内容发布");
			content.setType((byte) 1);
			
			int i = contentService.insertContent(content);
			
			System.out.println(contentService.selectContentByPrimaryKey(i).getContent());
		} catch (Exception e) {
			e.printStackTrace();
			log.info("ContentService insert failed!");
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
			p.setsSearch("");
			p.setiDisplayStart(0);
			p.setiDisplayLength(2);		
			List<Content> contentList = contentService.queryContentByPage(p);
			for (Content c : contentList)
			{
				System.out.println("###MyContent###"+c);
			}
		} catch (Exception e) {
			log.error(e);
		}

	}

}
