package com.hxd.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.Role;
import com.hxd.dao.RoleMapper;
import com.hxd.service.RoleService;
import com.hxd.vo.BaseVo;

@Transactional(rollbackFor = Exception.class)
@Service(RoleService.SERVICE_NAME)
public class RoleServiceImpl implements RoleService {

	@Autowired
	RoleMapper roleDao;
	
	private Log log = LogFactory.getLog(RoleServiceImpl.class);
	
	public int deleteRoleByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return roleDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
			log.info("RoleServiceImpl deleteRoleByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertRole(Role record) {
		// TODO Auto-generated method stub
		try {
			return roleDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("RoleServiceImpl insertRole failed!");
		}
		return -1;
	}

	public int insertRoleSelective(Role record) {
		try {
			return roleDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("RoleServiceImpl insertRoleSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public Role selectRoleByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return roleDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("RoleServiceImpl selectRoleByPrimaryKey failed!");
		}
		return null;
	}

	public int updateRoleByPrimaryKeySelective(Role record) {
		// TODO Auto-generated method stub
		try {
			return roleDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("RoleServiceImpl updateRoleByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateRoleByPrimaryKey(Role record) {
		// TODO Auto-generated method stub
		try {
			return roleDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("RoleServiceImpl updateRoleByPrimaryKey failed!");
		}
		return -1;
	}

	public List<Role> queryRoleByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return roleDao.queryRoleListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("RoleServiceImpl queryRoleByPage failed!");
		}
		return null;
	}

	public int queryRoleCount(BaseVo page) {
		  try {
				return roleDao.queryRoleListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("RoleServiceImpl queryRoleCount failed!");
			}
			  
			  return -1;
	}

	public int deleteRoleByBatch(List<String> ids) {
		try {
			List<Integer> idList = new ArrayList<Integer>();
			
			for (String idString : ids)
			{
				idList.add(Integer.parseInt(idString));
			}
			return roleDao.deleteRoleByBatch(idList);
		} catch (Exception e) {
			log.error(e);
			log.info("RoleServiceImpl deleteRoleByBatch failed!");
		}
		return -1;
	}

	public List<Role> queryAllRole() {
		try {
			return roleDao.queryAllRole();
		} catch (Exception e) {
			e.printStackTrace();
			log.info("RoleServiceImpl queryAllRole failed!");
		}
		return null;
	}

}
