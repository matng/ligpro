package com.hxd.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.Content;
import com.hxd.dao.ContentMapper;
import com.hxd.service.ContentService;
import com.hxd.vo.BaseVo;
import com.hxd.vo.ContentVo;

@Transactional(rollbackFor = Exception.class)
@Service(ContentService.SERVICE_NAME)
public class ContentServiceImpl implements ContentService {

	@Autowired
	ContentMapper contentDao;
	
	private Log log = LogFactory.getLog(ContentServiceImpl.class);
	
	public int deleteContentByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return contentDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ContentServiceImpl deleteContentByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertContent(Content record) {
		// TODO Auto-generated method stub
		try {
			return contentDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ContentServiceImpl insertContent failed!");
		}
		return -1;
	}

	public int insertContentSelective(Content record) {
		try {
			return contentDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ContentServiceImpl insertContentSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public Content selectContentByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return contentDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ContentServiceImpl selectContentByPrimaryKey failed!");
		}
		return null;
	}

	public int updateContentByPrimaryKeySelective(Content record) {
		// TODO Auto-generated method stub
		try {
			return contentDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ContentServiceImpl updateContentByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateContentByPrimaryKey(Content record) {
		// TODO Auto-generated method stub
		try {
			return contentDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ContentServiceImpl updateContentByPrimaryKey failed!");
		}
		return -1;
	}

	public List<Content> queryContentByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return contentDao.queryContentListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ContentServiceImpl queryContentByPage failed!");
		}
		return null;
	}

	public int queryContentCount(BaseVo page) {
		  try {
				return contentDao.queryContentListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("ContentServiceImpl queryContentCount failed!");
			}
			  
			  return -1;
	}

	public int deleteContentByBatch(List<String> ids) {
		try {
			List<Integer> idList = new ArrayList<Integer>();
			
			for (String idString : ids)
			{
				idList.add(Integer.parseInt(idString));
			}
			return contentDao.deleteContentByBatch(idList);
		} catch (Exception e) {
			log.error(e);
			log.info("ModuleServiceImpl deleteModuleByBatch failed!");
		}
		return -1;
	}
	
	public List<Content> findLimitContentByTypeUnion(int limit){
		try {
			return contentDao.findLimitContentByTypeUnion(limit);
		} catch (Exception e) {
			log.error(e);
			return null;
		}	
	}
	
	public List<Content> findLimitContentByMenuId(ContentVo vo){
		try {
			List<Content> list = contentDao.findLimitContentByMenuId(vo);
			return list;
		} catch (Exception e) {
			log.error(e);
			return null;
		}
	}
	
	public Content selectContentByMenuId(int menuid) {
		try {
			return contentDao.selectContentByMenuId(menuid);
		} catch (Exception e) {
			log.error(e);
			return null;
		}	
	}

	public int queryUseCountByResource(String rs) {
	  try {
			return contentDao.queryUseCountByResource(rs);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("ContentServiceImpl queryUseCountByResource failed!");
		}
			  
	  return -1;
	}
}
