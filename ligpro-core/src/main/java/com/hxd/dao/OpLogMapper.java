package com.hxd.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.hxd.bean.OpLog;
import com.hxd.vo.BaseVo;

public interface OpLogMapper {
    int deleteByPrimaryKey(Long id);

    int insert(OpLog record);

    int insertSelective(OpLog record);

    OpLog selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(OpLog record);

    int updateByPrimaryKeyWithBLOBs(OpLog record);

    int updateByPrimaryKey(OpLog record);
    
    List<OpLog> queryOpLogListByPage(BaseVo page,RowBounds rb);
    
    int queryOpLogListCount(BaseVo page);
    
    int deleteOpLogByBatch(List<Integer> ids);
}