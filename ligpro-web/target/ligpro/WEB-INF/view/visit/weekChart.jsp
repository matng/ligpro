<%@page import="java.io.Console"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

var weekEchart;

//右侧柱形图
function DrawWeekEChart(ec) {
weekEchart = ec.init(document.getElementById('weekEchart'),e_macarons);
weekEchart.showLoading({  
    text : "图表数据正在加载..."  
});  
right_option = {
	    title : {
	        text: '周访问量',
	        subtext: '本周数据'
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
	            data : ['1','2','3','4','5','6','7']
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
	            type:'bar',
	            data:[1, 2, 3, 4, 5, 6, 7],
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
weekEchart.setOption(right_option,true);
weekEchart.hideLoading();  
getWeekChartData();//aja后台交互    
}

function getWeekChartData() {  
    //获得图表的options对象  
    var options = weekEchart.getOption();  
    var url = "<c:url value='/visit/getWeekChartData'/>";
    //通过Ajax获取数据  
    $.ajax({  
        type : "post",  
        async : false, //同步执行  
        url : url,  
        data : {},  
        dataType : "json", //返回数据形式为json  
        success : function(result) {  
            if (result) {  
                options.legend.data = result.legend;  
                options.xAxis[0].data = result.category;  
                options.series[0].data = result.series[0].data;  
                weekEchart.hideLoading();  
                weekEchart.setOption(options);  
            }  
        },  
        error : function(errorMsg) {  
            alert("不好意思，大爷，图表请求数据失败啦!");  
            weekEchart.hideLoading();  
        }  
    });  
}  
</script>