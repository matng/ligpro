package com.hxd.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.Menu;
import com.hxd.bean.Power;
import com.hxd.dao.PowerMapper;
import com.hxd.service.PowerService;
import com.hxd.vo.BaseVo;

@Transactional(rollbackFor = Exception.class)
@Service(PowerService.SERVICE_NAME)
public class PowerServiceImpl implements PowerService {

	@Autowired
	PowerMapper PowerDao;
	
	private Log log = LogFactory.getLog(PowerServiceImpl.class);
	
	public int deletePowerByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return PowerDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl deletePowerByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertPower(Power record) {
		// TODO Auto-generated method stub
		try {
			return PowerDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl insertPower failed!");
		}
		return -1;
	}

	public int insertPowerSelective(Power record) {
		try {
			return PowerDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl insertPowerSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public Power selectPowerByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return PowerDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl selectPowerByPrimaryKey failed!");
		}
		return null;
	}

	public int updatePowerByPrimaryKeySelective(Power record) {
		// TODO Auto-generated method stub
		try {
			return PowerDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl updatePowerByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updatePowerByPrimaryKey(Power record) {
		// TODO Auto-generated method stub
		try {
			return PowerDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl updatePowerByPrimaryKey failed!");
		}
		return -1;
	}

	public List<Power> queryPowerByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return PowerDao.queryPowerListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl queryPowerByPage failed!");
		}
		return null;
	}

	public int queryPowerCount(BaseVo page) {
		  try {
				return PowerDao.queryPowerListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("PowerServiceImpl queryPowerCount failed!");
			}
			  
			  return -1;
	}

	public List<Menu> queryPowerListByParentId(Map<String,Integer> map) {
		try {
			
			return PowerDao.queryPowerListByParentId(map);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("PowerServiceImpl queryPowerListByParentId failed!");
		}
		return null;
	}

	public int batchInsert(List<Power> record) {
		try {
			return PowerDao.batchInsert(record);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("PowerServiceImpl batchInsert failed!");
		}
		return -1;
	}

	public int deleteByOwerId(Integer owerId) {
		try {
			return PowerDao.deleteByOwerId(owerId);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("PowerServiceImpl deleteByOwerId failed!");
		}
		return -1;
	}

	@Override
	public int saveOrUpdatePower(Power record) {
		try {
			return PowerDao.saveOrUpdatePower(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl saveOrUpdatePower failed!");
		}
		return -1;
	}

	@Override
	public Power findPowerIsHave(Power record) {
		try {
			return PowerDao.findPowerIsHave(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl findPowerIsHave failed!");
		}
		return null;
	}

	@Override
	public int updatePowerStatus(Power record) {
		try {
			return PowerDao.updatePowerStatus(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl updatePowerStatus failed!");
		}
		return -1;
	}

	@Override
	public List<Power> queryUserPower(Integer id) {
		try {
			return PowerDao.queryUserPower(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("PowerServiceImpl queryUserPower failed!");
		}
		return null;
	}
}
