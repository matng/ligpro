package com.hxd.service;

import java.util.List;

import com.hxd.bean.OpLog;
import com.hxd.vo.BaseVo;

public interface OpLogService {
	String SERVICE_NAME = "OpLogService";
    int deleteOpLogByPrimaryKey(Long id);

    int insertOpLog(OpLog record);

    int insertOpLogSelective(OpLog record);

    OpLog selectOpLogByPrimaryKey(Long id);

    int updateOpLogByPrimaryKeySelective(OpLog record);

    int updateOpLogByPrimaryKey(OpLog record);
    
    List<OpLog> queryOpLogByPage(BaseVo page);
    
    int queryOpLogCount(BaseVo page);
    
    int deleteOpLogByBatch(List<String> ids);
}
