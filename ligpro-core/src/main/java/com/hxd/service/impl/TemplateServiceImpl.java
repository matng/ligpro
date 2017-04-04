package com.hxd.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.Template;
import com.hxd.dao.TemplateMapper;
import com.hxd.service.TemplateService;
import com.hxd.vo.BaseVo;


@Transactional(rollbackFor = Exception.class)
@Service(TemplateService.SERVICE_NAME)
public class TemplateServiceImpl implements TemplateService{

	@Autowired
	TemplateMapper templateDao;
	
	private Log log = LogFactory.getLog(TemplateServiceImpl.class);
	
	public int deleteTemplateByPrimaryKey(Integer id) {
		try {
			return templateDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("TemplateServiceImpl deleteTemplateByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertTemplate(Template record) {
		try {
			return templateDao.insert(record);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("TemplateServiceImpl insertTemplate failed!");
		}
		return -1;
	}

	public int insertTemplateSelective(Template record) {
		try {
			return templateDao.insertSelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("TemplateServiceImpl insertTemplateSelective failed!");
		}
		return -1;
	}

	public Template selectTemplateByPrimaryKey(Integer id) {
		try {
			return templateDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("TemplateServiceImpl selectTemplateByPrimaryKey failed!");
		}
		return null;
	}

	public int updateTemplateByPrimaryKeySelective(Template record) {
		try {
			return templateDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("TemplateServiceImpl updateTemplateByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateTemplateByPrimaryKey(Template record) {
		try {
			return templateDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("TemplateServiceImpl updateTemplateByPrimaryKey failed!");
		}
		return -1;
	}

	public List<Template> queryTemplateByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return templateDao.queryTemplateListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("TemplateServiceImpl queryTemplateByPage failed!");
		}
		return null;
	}

	public int queryTemplateCount(BaseVo page) {
		  try {
				return templateDao.queryTemplateListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("TemplateServiceImpl queryTemplateCount failed!");
			}
			  
			  return -1;
	}

	public int deleteTemplateByBatch(List<String> ids) {
		try {
			List<Integer> idList = new ArrayList<Integer>();

			for (String idString : ids) {
				idList.add(Integer.parseInt(idString));
			}
			return templateDao.deleteTemplateByBatch(idList);
		} catch (Exception e) {
			log.error(e);
			log.info("TemplateServiceImpl deleteTemplateByBatch failed!");
		}
		return -1;
	}


	public List<Template> queryAll() {
		try {
			return templateDao.queryAll();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("TemplateServiceImpl queryAll failed!");
		}
		
		return null;
	}

}
