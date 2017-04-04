package com.hxd.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.UserRole;
import com.hxd.dao.UserRoleMapper;
import com.hxd.service.UserRoleService;
import com.hxd.vo.BaseVo;

@Transactional(rollbackFor = Exception.class)
@Service(UserRoleService.SERVICE_NAME)
public class UserRoleServiceImpl implements UserRoleService {

	@Autowired
	UserRoleMapper userRoleDao;
	
	private Log log = LogFactory.getLog(UserRoleServiceImpl.class);
	
	public int deleteUserRoleByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return userRoleDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("UserRoleServiceImpl deleteUserRoleByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertUserRole(UserRole record) {
		// TODO Auto-generated method stub
		try {
			return userRoleDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("UserRoleServiceImpl insertUserRole failed!");
		}
		
		return -1;
	}

	public int insertUserRoleSelective(UserRole record) {
		try {
			return userRoleDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("UserRoleServiceImpl insertUserRoleSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public UserRole selectUserRoleByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return userRoleDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("UserRoleServiceImpl selectUserRoleByPrimaryKey failed!");
		}
		return null;
	}

	public int updateByUserId(UserRole record) {
		// TODO Auto-generated method stub
		try {
			return userRoleDao.updateByUserId(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("UserRoleServiceImpl updateUserRoleByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateUserRoleByPrimaryKey(UserRole record) {
		// TODO Auto-generated method stub
		try {
			return userRoleDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("UserRoleServiceImpl updateUserRoleByPrimaryKey failed!");
		}
		return -1;
	}

	public List<UserRole> queryUserRoleByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return userRoleDao.queryUserRoleListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("UserRoleServiceImpl queryUserRoleByPage failed!");
		}
		return null;
	}

	public int queryUserRoleCount(BaseVo page) {
		  try {
				return userRoleDao.queryUserRoleListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("UserRoleServiceImpl queryUserRoleCount failed!");
			}
			  
			  return -1;
	}

	public int deleteByUserId(List<String> ids) {
		try {
			List<Integer> idList = new ArrayList<Integer>();

			for (String idString : ids) {
				idList.add(Integer.parseInt(idString));
			}
			return userRoleDao.deleteByUserId(idList);
		} catch (Exception e) {
			log.error(e);
			log.info("UserRoleServiceImpl deleteByUserId failed!");
		}
		return -1;
	}

}
