package com.hxd.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxd.bean.Visit;
import com.hxd.dao.VisitMapper;
import com.hxd.service.VisitService;
import com.hxd.vo.VisitVo;

@Transactional(rollbackFor = Exception.class)
@Service(VisitService.SERVICE_NAME)
public class VisitServiceImpl implements VisitService {

	private Log log = LogFactory.getLog(VisitServiceImpl.class);
	@Autowired
	private VisitMapper dao;
	
	@Override
	public int deleteByPrimaryKey(Long id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(Visit record) {
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

	@Override
	public int insertSelective(Visit record) {
		try {
			int i = dao.insertSelective(record);
			if (i > 0) {
				return i;
			}
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
			e.printStackTrace();
		}
		return -1;
	}

	@Override
	public Visit selectByPrimaryKey(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateByPrimaryKeySelective(Visit record) {
		// TODO Auto-generated method stub  
		return 0;
	}

	@Override
	public int updateByPrimaryKey(Visit record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Integer> queryEchartByDay() {
		return dao.queryEchartByDay();
	}
	
	@Override
	public List<Integer> queryEchartByWeek() {
		return dao.queryEchartByWeek();
	}

	@Override
	public List<Integer> queryEchartByYear() {
		return dao.queryEchartByYear();
	}

	@Override
	public List<VisitVo> queryEchartByMonth() {
		return dao.queryEchartByMonth();
	}

	@Override
	public List<VisitVo> queryEchartByArea() {
		// TODO Auto-generated method stub
		return dao.queryEchartByArea();
	}

	@Override
	public List<VisitVo> queryEchartByBrowser() {
		// TODO Auto-generated method stub
		return dao.queryEchartByBrowser();
	}

	@Override
	public List<VisitVo> queryEchartByOs() {
		// TODO Auto-generated method stub
		return dao.queryEchartByOs();
	}

	
}
