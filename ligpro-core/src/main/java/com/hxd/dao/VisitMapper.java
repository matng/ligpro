package com.hxd.dao;

import java.util.List;

import com.hxd.bean.Visit;
import com.hxd.vo.VisitVo;

public interface VisitMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Visit record);

    int insertSelective(Visit record);

    Visit selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Visit record);

    int updateByPrimaryKey(Visit record);
    
    List<Integer> queryEchartByDay();
    
    List<Integer> queryEchartByWeek();
    
    List<VisitVo> queryEchartByMonth();
    
    List<Integer> queryEchartByYear();
    
    List<VisitVo> queryEchartByArea();
    
    List<VisitVo> queryEchartByBrowser();
    
    List<VisitVo> queryEchartByOs();
}