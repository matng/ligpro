package com.hxd.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.FriendLink;
import com.hxd.dao.FriendLinkMapper;
import com.hxd.service.FriendLinkService;
import com.hxd.vo.BaseVo;

@Transactional(rollbackFor = Exception.class)
@Service(FriendLinkService.SERVICE_NAME)
public class FriendLinkServiceImpl implements FriendLinkService {

	@Autowired
	FriendLinkMapper FriendLinkDao;
	
	private Log log = LogFactory.getLog(FriendLinkServiceImpl.class);
	
	public int deleteFriendLinkByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return FriendLinkDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("FriendLinkServiceImpl deleteFriendLinkByPrimaryKey failed!");
		}
		return -1;
	}

	public int insertFriendLink(FriendLink record) {
		// TODO Auto-generated method stub
		try {
			return FriendLinkDao.insert(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("FriendLinkServiceImpl insertFriendLink failed!");
		}
		return -1;
	}

	public int insertFriendLinkSelective(FriendLink record) {
		try {
			return FriendLinkDao.insertSelective(record);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("FriendLinkServiceImpl insertFriendLinkSelective failed!");
		}
		// TODO Auto-generated method stub
		return -1;
	}

	public FriendLink selectFriendLinkByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		try {
			return FriendLinkDao.selectByPrimaryKey(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("FriendLinkServiceImpl selectFriendLinkByPrimaryKey failed!");
		}
		return null;
	}

	public int updateFriendLinkByPrimaryKeySelective(FriendLink record) {
		// TODO Auto-generated method stub
		try {
			return FriendLinkDao.updateByPrimaryKeySelective(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("FriendLinkServiceImpl updateFriendLinkByPrimaryKeySelective failed!");
		}
		return -1;
	}

	public int updateFriendLinkByPrimaryKey(FriendLink record) {
		// TODO Auto-generated method stub
		try {
			return FriendLinkDao.updateByPrimaryKey(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("FriendLinkServiceImpl updateFriendLinkByPrimaryKey failed!");
		}
		return -1;
	}

	public List<FriendLink> queryFriendLinkByPage(BaseVo page) {
		try {
			RowBounds rb = new RowBounds(page.getiDisplayStart(), page.getiDisplayLength());
			return FriendLinkDao.queryFriendLinkListByPage(page,rb);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("FriendLinkServiceImpl queryFriendLinkByPage failed!");
		}
		return null;
	}

	public int queryFriendLinkCount(BaseVo page) {
		  try {
				return FriendLinkDao.queryFriendLinkListCount(page);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				log.info("FriendLinkServiceImpl queryFriendLinkCount failed!");
			}
			  
			  return -1;
	}
	
	
	public int deleteFriendLinkByBatch(List<String> ids) {
		try {
			List<Integer> idList = new ArrayList<Integer>();
			
			for (String idString : ids)
			{
				idList.add(Integer.parseInt(idString));
			}
			return FriendLinkDao.deleteFriendLinkByBatch(idList);
		} catch (Exception e) {
			log.error(e);
			log.info("FriendLinkServiceImpl deleteFriendLinkByBatch failed!");
		}
		return -1;
	}

	public List<FriendLink> selectBySiteName(FriendLink record) {
		// TODO Auto-generated method stub
		try {
			return FriendLinkDao.selectBySiteName(record);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.info("FriendLinkServiceImpl selectBySiteName failed!");
		}
		return null;
	}
	
	public List<FriendLink> findAllFriendLink() {
		try {
			return FriendLinkDao.findAllFriendLink();
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
}
