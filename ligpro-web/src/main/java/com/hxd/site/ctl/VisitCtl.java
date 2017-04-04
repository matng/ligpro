package com.hxd.site.ctl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hxd.service.VisitService;
import com.hxd.vo.EchartData;
import com.hxd.vo.RoleVo;
import com.hxd.vo.Series;
import com.hxd.vo.VisitVo;

@Controller
@RequestMapping("/visit")
public class VisitCtl extends BaseCtl {
	
	@Autowired
	private VisitService vistiService;

	//@ControllerLog(cleanData="false",desc="log.role.read")
	@RequestMapping("/list")
	public String home(Model model,HttpServletRequest req) {
		return "/view/visit/visitList";
	}
	
	
	@RequestMapping(value = "/getWeekChartData", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public EchartData getWeekChartData(HttpServletRequest req,RoleVo vo) {
		
        List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"访问人数"}));//数据分组  
        
        List<String> category = new ArrayList<String>(Arrays.asList(new String []{"周一","周二","周三","周四","周五","周六","周日"}));//横坐标  
        
        List<Series> series = new ArrayList<Series>();//纵坐标  
          
        List<Integer> list = vistiService.queryEchartByWeek();
        
        series.add(new Series("访问人数", "line", list));    
          
        EchartData data = new EchartData(legend, category, series);  
        
		return data;
	}
	
	@RequestMapping(value = "/getDayChartData", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public EchartData getDayChartData(HttpServletRequest req,RoleVo vo) {
		
        List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"访问人数"}));//数据分组  
        
        List<String> category = new ArrayList<String>(Arrays.asList(new String []{"0点","1点","2点","3点","4点","5点","6点","7点","8点","9点","10点","11点","12点","13点","14点","15点","16点","17点","18点","19点","20点","21点","22点","23点"}));//横坐标
        
        List<Series> series = new ArrayList<Series>();//纵坐标  
        
        List<Integer> list = vistiService.queryEchartByDay();
        
        series.add(new Series("访问人数", "line", list));  
          
        EchartData data = new EchartData(legend, category, series);  
        
		return data;
	}
	
	@RequestMapping(value = "/getYearChartData", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public EchartData getYearChartData(HttpServletRequest req,RoleVo vo) {
		
        List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"访问人数"}));//数据分组  
        
        List<String> category = new ArrayList<String>(Arrays.asList(new String []{"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"}));//横坐标
        
        List<Series> series = new ArrayList<Series>();//纵坐标  
        
        List<Integer> list = vistiService.queryEchartByYear();
        
        series.add(new Series("访问人数", "line", list));  
          
        EchartData data = new EchartData(legend, category, series);  
        
		return data;
	}
	
	@RequestMapping(value = "/getMonthChartData", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public EchartData getMonthChartData(HttpServletRequest req,RoleVo vo) {
		
		/**获取数据**/
		List<VisitVo> list = vistiService.queryEchartByMonth();
		List<Integer> dataList = new ArrayList<Integer>();
		List<String> xAxis = new ArrayList<String>();
		for(VisitVo v : list){
			dataList.add(v.getData());
			xAxis.add(v.getMonth().toString());
		}
		
        List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"访问人数"}));//数据分组  
        
        //List<String> category = new ArrayList<String>(Arrays.asList(new String []{"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"}));//横坐标
        List<String> category = new ArrayList<String>(xAxis);//横坐标
        List<Series> series = new ArrayList<Series>();//纵坐标  
        
        
        series.add(new Series("访问人数", "line", dataList));  
          
        EchartData data = new EchartData(legend, category, series);  
        
		return data;
	}
	
	@RequestMapping(value = "/getAreaChartData", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public List<VisitVo> getAreaChartData(HttpServletRequest req,RoleVo vo) {
		
		VisitVo vv = new VisitVo();
		List<VisitVo> list = vistiService.queryEchartByArea();
		Map<String,Integer> map = new HashMap<String,Integer>();
		
		map.put("findBigest",list.get(0).getValue());
		for(VisitVo v : list){
			if(v.getValue() > map.get("findBigest")){
				map.put("findBigest", v.getValue());
			}
		}
		
		vv.setName("Bigest");
		vv.setValue(map.get("findBigest"));
		list.add(vv);
		
		return list;
	}
	
	@RequestMapping(value = "/getBrowserChartData", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public List<VisitVo> getBrowserChartData(HttpServletRequest req,RoleVo vo) {
		
		
		List<VisitVo> dataList = vistiService.queryEchartByBrowser();
		return dataList;
	}
	
	@RequestMapping(value = "/getOsChartData", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public List<VisitVo> getOsChartData(HttpServletRequest req,RoleVo vo) {
		
		List<VisitVo> dataList = vistiService.queryEchartByOs();
		return dataList;
	}
}
