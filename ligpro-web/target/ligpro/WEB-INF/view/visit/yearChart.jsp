<%@page import="java.io.Console"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

var yearEchart;

//右侧柱形图
function DrawYearEchart(ec) {
	yearEchart = ec.init(document.getElementById('yearEchart'),e_macarons);
	yearEchart.showLoading({  
    	text : "图表数据正在加载..."  
	});  
	year_option = {
	    title : {
	        text: '年访问量',
	        subtext: '当年数据'
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
	            data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
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
	            data:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
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
	yearEchart.setOption(year_option,true);
	yearEchart.hideLoading();  
	getYearChartData();//aja后台交互    
	
}

function getYearChartData() {  
    //获得图表的options对象  
    var options = yearEchart.getOption();  
    var url = "<c:url value='/visit/getYearChartData'/>";
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
                yearEchart.hideLoading();  
                yearEchart.setOption(options);  
            }  
        },  
        error : function(errorMsg) {  
            alert("不好意思，大爷，图表请求数据失败啦!");  
            yearEchart.hideLoading();  
        }  
    });  
}  
</script>