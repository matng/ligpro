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
import com.hxd.dao.MenuMapper;
import com.hxd.service.MenuService;
import com.hxd.vo.BaseVo;

@Transactional(rollbackFor = Exception.class)
@Service(MenuService.SERVICE_NAME)
public class MenuServiceImpl implements MenuService {

	@Autowired
	MenuMapper MenuDao;
	
	private Log log = LogFactory.getLog(MenuServiceImpl.class);
	
	public int deleteMenuByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return MenuDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("MenuServiceImpl deleteMenuByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertMenu(Menu record) {
		// TODO Auto-generated method stub
		try {
			return MenuDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("MenuServiceImpl insertMenu failed!");
		}
		return -1;
	}

	public int insertMenuSelective(Menu record) {
		try {
			return MenuDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("MenuServiceImpl insertMenuSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public Menu selectMenuByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return MenuDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("MenuServiceImpl selectMenuByPrimaryKey failed!");
		}
		return null;
	}

	public int updateMenuByPrimaryKeySelective(Menu record) {
		// TODO Auto-generated method stub
		try {
			return MenuDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("MenuServiceImpl updateMenuByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateMenuByPrimaryKey(Menu record) {
		// TODO Auto-generated method stub
		try {
			return MenuDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("MenuServiceImpl updateMenuByPrimaryKey failed!");
		}
		return -1;
	}

	public List<Menu> queryMenuByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return MenuDao.queryMenuListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("MenuServiceImpl queryMenuByPage failed!");
		}
		return null;
	}

	public int queryMenuCount(BaseVo page) {
		  try {
				return MenuDao.queryMenuListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("MenuServiceImpl queryMenuCount failed!");
			}
			  
			  return -1;
	}
	
	public List<Menu> queryListByParentId(Integer id){
		try {
			
			return MenuDao.queryListByParentId(id);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("MenuServiceImpl queryListByParentId failed!");
		}
		return null;
	}

	public int deleteMenuByNodeId(Integer id) {
		try {
			return MenuDao.deleteMenuByNodeId(id);
		} catch (Exception e) {
			log.error(e);
			log.info("MenuServiceImpl deleteMenuByNodeId failed!");
		}
		return -1;
	}
	
	public Menu findMenuByMenuUrl(String menuUrl) {
		try {
			return MenuDao.findMenuByMenuUrl(menuUrl);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	public  List<Menu> findAllMenu() {
		try {
			return MenuDao.findAllMenu();
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	@Override
	public List<Menu> findMenuByModuleId(Map<String,Integer> map) {
		try {
			return MenuDao.findMenuByModuleId(map);
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	@Override
	public int queryMenuCountByMenuUrl(String url) {
		try {
			return MenuDao.queryMenuCountByMenuUrl(url);
		} catch (Exception e) {
			log.error(e);
			log.info("MenuServiceImpl queryMenuCountByMenuUrl failed!");
		}
		return -1;
	}

	public List<Menu> queryListByParentIdWithoutFirst(Integer id) {
		try {
			
			return MenuDao.queryListByParentIdWithoutFirst(id);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.info("MenuServiceImpl queryListByParentIdWithoutFirst failed!");
		}
		return null;
	}
}
