package com.hxd.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.ResourceGroup;
import com.hxd.dao.ResourceGroupMapper;
import com.hxd.service.ResourceGroupService;
import com.hxd.vo.BaseVo;

@Transactional(rollbackFor = Exception.class)
@Service(ResourceGroupService.SERVICE_NAME)
public class ResourceGroupServiceImpl implements ResourceGroupService {

	@Autowired
	ResourceGroupMapper resourceGroupDao;
	
	private Log log = LogFactory.getLog(ResourceGroupServiceImpl.class);
	
	public int deleteResourceGroupByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return resourceGroupDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceGroupServiceImpl deleteResourceGroupByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertResourceGroup(ResourceGroup record) {
		// TODO Auto-generated method stub
		try {
			return resourceGroupDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceGroupServiceImpl insertResourceGroup failed!");
		}
		return -1;
	}

	public int insertResourceGroupSelective(ResourceGroup record) {
		try {
			return resourceGroupDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceGroupServiceImpl insertResourceGroupSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public ResourceGroup selectResourceGroupByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return resourceGroupDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceGroupServiceImpl selectResourceGroupByPrimaryKey failed!");
		}
		return null;
	}

	public int updateResourceGroupByPrimaryKeySelective(ResourceGroup record) {
		// TODO Auto-generated method stub
		try {
			return resourceGroupDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceGroupServiceImpl updateResourceGroupByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateResourceGroupByPrimaryKey(ResourceGroup record) {
		// TODO Auto-generated method stub
		try {
			return resourceGroupDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceGroupServiceImpl updateResourceGroupByPrimaryKey failed!");
		}
		return -1;
	}

	public List<ResourceGroup> queryResourceGroupByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return resourceGroupDao.queryResourceGroupListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ResourceGroupServiceImpl queryResourceGroupByPage failed!");
		}
		return null;
	}

	public int queryResourceGroupCount(BaseVo page) {
		  try {
				return resourceGroupDao.queryResourceGroupListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("ResourceGroupServiceImpl queryResourceGroupCount failed!");
			}
			  
			  return -1;
	}

	public List<ResourceGroup> queryListByParentId(ResourceGroup record) {
		try {
			
			return resourceGroupDao.queryListByParentId(record);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("ResourceGroupServiceImpl queryListByParentId failed!");
		}
		return null;
	}

	public int deleteResourceGroupByNodeId(Integer id) {
		try {
			return resourceGroupDao.deleteResourceGroupByNodeId(id);
		} catch (Exception e) {
			log.error(e);
			log.info("ResourceGroupServiceImpl deleteResourceGroupByNodeId failed!");
		}
		return -1;
	}

	public int queryChildCountByParentId(Integer id) {
		try {
			return resourceGroupDao.queryChildCountByParentId(id);
		} catch (Exception e) {
			log.error(e);
			log.info("ResourceGroupServiceImpl queryChildCountByParentId failed!");
		}
		return -1;
	}
}
