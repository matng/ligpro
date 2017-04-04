<%@page import="java.io.Console"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

var dayEchart;

//右侧柱形图
function DrawDayEChart(ec) {
	dayEchart = ec.init(document.getElementById('dayEchart'),e_macarons);
	dayEchart.showLoading({  
    	text : "图表数据正在加载..."  
	});  
	day_option = {
	    title : {
	        text: '日访问量',
	        subtext: '当日数据'
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	    	data:['访问人数']
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: true},
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            data : ['0点','1点','2点','3点','4点','5点','6点','7点','8点','9点','10点','11点','12点','13点','14点','15点','16点','17点','18点','19点','20点','21点','22点','23点']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'访问人数',
	            type:'line',
	            data:[1, 2, 3, 4, 5, 6, 7, 8,9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
	            markPoint : {
	                data : [
	                    {type : 'max', name: '最大值'},
	                    {type : 'min', name: '最小值'}
	                ]
	            },
	            markLine : {
	                data : [
	                    {type : 'average', name: '平均值'}
	                ]
	            }
	        }
	    ]
	};
	dayEchart.setOption(day_option,true);
	dayEchart.hideLoading();  
	getDayChartData();//aja后台交互    
	
}

function getDayChartData() {  
    //获得图表的options对象  
    var options = dayEchart.getOption();  
    var url = "<c:url value='/visit/getDayChartData'/>";
    //通过Ajax获取数据  
    $.ajax({  
        type : "post",  
        async : false, //同步执行  
        url : url,  
        //url : "/jkgarden-web/visit/weekChart",  
        data : {},  
        dataType : "json", //返回数据形式为json  
        success : function(result) {  
            if (result) {  
                options.legend.data = result.legend;  
                options.xAxis[0].data = result.category;  
                options.series[0].data = result.series[0].data;  
                dayEchart.hideLoading();  
                dayEchart.setOption(options);  
            }  
        },  
        error : function(errorMsg) {  
            alert("不好意思，大爷，图表请求数据失败啦!");  
            dayEchart.hideLoading();  
        }  
    });  
}  
</script>