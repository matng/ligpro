package com.hxd.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.Resource;
import com.hxd.dao.ResourceMapper;
import com.hxd.service.ResourceService;
import com.hxd.vo.BaseVo;
import com.hxd.vo.ResourceVo;

@Transactional(rollbackFor = Exception.class)
@Service(ResourceService.SERVICE_NAME)
public class ResourceServiceImpl implements ResourceService {

	@Autowired
	ResourceMapper resourceDao;
	
	private Log log = LogFactory.getLog(ResourceServiceImpl.class);
	
	public int deleteResourceByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return resourceDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceServiceImpl deleteResourceByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertResource(Resource record) {
		// TODO Auto-generated method stub
		try {
			return resourceDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceServiceImpl insertResource failed!");
		}
		return -1;
	}

	public int insertResourceSelective(Resource record) {
		try {
			return resourceDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceServiceImpl insertResourceSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public Resource selectResourceByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return resourceDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceServiceImpl selectResourceByPrimaryKey failed!");
		}
		return null;
	}

	public int updateResourceByPrimaryKeySelective(Resource record) {
		// TODO Auto-generated method stub
		try {
			return resourceDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceServiceImpl updateResourceByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateResourceByPrimaryKey(Resource record) {
		// TODO Auto-generated method stub
		try {
			return resourceDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceServiceImpl updateResourceByPrimaryKey failed!");
		}
		return -1;
	}

	public List<Resource> queryResourceByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return resourceDao.queryResourceListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceServiceImpl queryResourceByPage failed!");
		}
		return null;
	}

	public int queryResourceCount(BaseVo page) {
		  try {
				return resourceDao.queryResourceListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("ResourceServiceImpl queryResourceCount failed!");
			}
			  
			  return -1;
	}

	public int deleteResourceByBatch(List<String> ids) {
		try {
			List<Integer> idList = new ArrayList<Integer>();
			
			for (String idString : ids)
			{
				idList.add(Integer.parseInt(idString));
			}
			return resourceDao.deleteResourceByBatch(idList);
		} catch (Exception e) {
			log.error(e);
			log.info("ResourceServiceImpl deleteModuleByBatch failed!");
		}
		return -1;
	}

	public int queryResourceCountByGroupID(Resource record) {
		try {
			return resourceDao.queryResourceCountByGroupID(record);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("ResourceServiceImpl queryResourceCountByGroupID failed!");
		}
		return -1;
	}
	
	public  List<ResourceVo> findResourceByUserTypeWithLimit(ResourceVo vo) {
		try {
			return resourceDao.findResourceByUserTypeWithLimit(vo);
		} catch (Exception e) {
			e.printStackTrace();	
			log.error(e);
			return null;
		}
	}

}
