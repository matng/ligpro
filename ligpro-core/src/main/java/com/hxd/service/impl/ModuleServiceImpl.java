package com.hxd.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.Module;
import com.hxd.dao.ModuleMapper;
import com.hxd.service.ModuleService;
import com.hxd.vo.BaseVo;

@Transactional(rollbackFor = Exception.class)
@Service(ModuleService.SERVICE_NAME)
public class ModuleServiceImpl implements ModuleService {

	@Autowired
	ModuleMapper ModuleDao;
	
	private Log log = LogFactory.getLog(ModuleServiceImpl.class);
	
	public int deleteModuleByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return ModuleDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ModuleServiceImpl deleteModuleByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertModule(Module record) {
		// TODO Auto-generated method stub
		try {
			return ModuleDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ModuleServiceImpl insertModule failed!");
		}
		return -1;
	}

	public int insertModuleSelective(Module record) {
		try {
			return ModuleDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ModuleServiceImpl insertModuleSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public Module selectModuleByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return ModuleDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ModuleServiceImpl selectModuleByPrimaryKey failed!");
		}
		return null;
	}

	public int updateModuleByPrimaryKeySelective(Module record) {
		// TODO Auto-generated method stub
		try {
			return ModuleDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ModuleServiceImpl updateModuleByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateModuleByPrimaryKey(Module record) {
		// TODO Auto-generated method stub
		try {
			return ModuleDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ModuleServiceImpl updateModuleByPrimaryKey failed!");
		}
		return -1;
	}

	public List<Module> queryModuleByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return ModuleDao.queryModuleListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("ModuleServiceImpl queryModuleByPage failed!");
		}
		return null;
	}

	public int queryModuleCount(BaseVo page) {
		  try {
				return ModuleDao.queryModuleListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("ModuleServiceImpl queryModuleCount failed!");
			}
			  
			  return -1;
	}

	public int deleteModuleByBatch(List<String> ids) {
		try {
			List<Integer> idList = new ArrayList<Integer>();
			
			for (String idString : ids)
			{
				idList.add(Integer.parseInt(idString));
			}
			return ModuleDao.deleteModuleByBatch(idList);
		} catch (Exception e) {
			log.error(e);
			log.info("ModuleServiceImpl deleteModuleByBatch failed!");
		}
		return -1;
	}

	public List<Module> queryAll() {
		try {
			return ModuleDao.queryAll();
		} catch (Exception e) {
			log.error(e);
			log.info("ModuleServiceImpl queryAll failed!");
		}
		return null;
	}

	public List<Module> queryForPower(Integer ownerId) {
		try {
			return ModuleDao.queryForPower(ownerId);
		} catch (Exception e) {
			log.error(e);
			log.info("ModuleServiceImpl queryForPower failed!");
		}
		return null;
	}

}
