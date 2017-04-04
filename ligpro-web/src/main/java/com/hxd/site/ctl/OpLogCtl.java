package com.hxd.site.ctl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hxd.bean.OpLog;
import com.hxd.service.OpLogService;
import com.hxd.util.DateUtil;
import com.hxd.util.StrUtil;
import com.hxd.vo.OpLogStrVo;
import com.hxd.vo.OpLogVo;
import com.hxd.vo.PageData;

@Controller
@RequestMapping("/oplog")
public class OpLogCtl extends BaseCtl{

	//------added by tl in 150601
		@Autowired
		private OpLogService service;
		//--------------------------
		
		@RequestMapping("/list")
		public String home(Model model,HttpServletRequest req) {
			return "/view/sys/opLogList";
		}	
		
		//--------------added by tl in 150601
		@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
		@ResponseBody
		public String opLogListJson(HttpServletRequest req,OpLogVo vo) {
			String json = null;
			try {
				List<OpLog> list = service.queryOpLogByPage(vo);
				int totalCount = service.queryOpLogCount(vo);
								
				List<OpLogStrVo>  listVo = new ArrayList<OpLogStrVo>();
				OpLogStrVo opvo = null;
				for (OpLog op : list) {
					opvo = new OpLogStrVo();
					opvo.setId(op.getId());
					opvo.setTitle(op.getTitle());
					opvo.setLoginip(op.getLoginip());
					opvo.setUserid(op.getUserid());
					opvo.setLoginname(op.getLoginname());
					opvo.setContent(op.getContent());
					opvo.setOptimeStr(DateUtil.date2Str(op.getOptime(), DateUtil.YMD_HMS));
					listVo.add(opvo);
				}			
				
				//返回json数据给界面
				PageData data =new PageData();
				data.setsEcho(vo.getsEcho());
				data.setiTotalRecords(totalCount);
				data.setiTotalDisplayRecords(totalCount);
				log.debug("###@@@ listVo.size:"+listVo.size());
				//log.debug("###@@@ StrUtil.toJsonStrWithFixed(list):"+StrUtil.toJsonStrWithFixed(listVo));
				data.setAaData(StrUtil.toJsonStrWithFixed(listVo));
				json = StrUtil.toJsonStrWithFixed(data);
				//log.debug("###@@@ json:"+json);
			} catch (Exception e) {
				log.error(e);
			}
			return json;
		}
	
}
