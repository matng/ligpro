package com.hxd.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.User;
import com.hxd.dao.UserMapper;
import com.hxd.service.UserService;
import com.hxd.vo.BaseVo;

@Transactional(rollbackFor = Exception.class)
@Service(UserService.SERVICE_NAME)
public class UserServiceImpl implements UserService {

	private Log log = LogFactory.getLog(UserServiceImpl.class);
	@Autowired
	private UserMapper dao;

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return dao.deleteByPrimaryKey(id);

		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
		}
		return -1;
	}

	public int insert(User record) {
		try {
			int i = dao.insert(record);
			if (i > 0) {
				return record.getId();
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.info("UserServiceImpl insert failed!");
		}

		return -1;
	}

	public int insertSelective(User record) {
		// TODO Auto-generated method stub
		try {
			int i = dao.insert(record);
			if (i > 0) {
				return record.getId();
			}
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
		}
		return -1;
	}

	public User selectByPrimaryKey(Integer id) {
		try {
			return dao.selectByPrimaryKey(id);

		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
		}
		return null;
	}

	public int updateByPrimaryKeySelective(User record) {
		// TODO Auto-generated method stub
		try {
			return dao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
		}
		return -1;
	}

	public int updateByPrimaryKey(User record) {
		// TODO Auto-generated method stub
		try {
			return dao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
		}
		return -1;
	}

	public List<User> queryByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(),
					page.getiDisplayLength());
			return dao.queryUserListByPage(page, rb);
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
		}
		return null;
	}

	public int queryCount(BaseVo page) {
		try {
			return dao.queryUserListCount(page);
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
		}

		return -1;
	}

	public int deleteUserByBatch(List<String> ids) {
		try {
			List<Integer> idList = new ArrayList<Integer>();

			for (String idString : ids) {
				idList.add(Integer.parseInt(idString));
			}
			return dao.deleteUserByBatch(idList);
		} catch (Exception e) {
			log.error(e);
			log.info("UserService deleteUserByBatch failed!");
		}
		return -1;
	}

	public User findBySelective(User u) {
		try {
			return dao.findBySelective(u);
		} catch (Exception e) {
			log.error(e);
			log.info("UserService findBySelective failed!");
		}
		return null;
	}

	/**
	 * 判断loginname是否唯一
	 *  return true 是唯一， false 已有值存在
	 */
	public boolean checkUniqueLoginname(User u) {
		try {
			User user = dao.findBySelective(u);
			if(user!=null && user.getId()>0) {
				return false;
			}
		} catch (Exception e) {
			log.error(e);
			log.info("UserService checkUniqueLoginname failed!");
		}
		return true;
	}
	

	/**
	 * 判断email 唯一
	 * return true 唯一， false 已有值存在
	 */
	
	public boolean checkUniqueEmail(User u) {
		try {
			User user = dao.findBySelective(u);
			if(user!=null && user.getId()>0) {
				return false;
			}
		} catch (Exception e) {
			log.error(e);
			log.info("UserService checkUniqueEmail failed!");
		}
		return true;
	}
	
	/**
	 * 
	 */
	public List<User> selectByLoginNameOrEmail(User u) {
		try {
			return dao.selectByLoginNameOrEmail(u);
		} catch (Exception e) {
			log.error(e);
			log.info("UserService selectByLoginNameOrEmail failed!");
		}
		return null;
	}
	
	
}
