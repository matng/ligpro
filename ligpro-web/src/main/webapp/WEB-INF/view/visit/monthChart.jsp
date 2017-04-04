<%@page import="java.io.Console"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

var monthEchart;

//右侧柱形图
function DrawMonthEchart(ec) {
	monthEchart = ec.init(document.getElementById('monthEchart'),e_macarons);
	monthEchart.showLoading({  
    	text : "图表数据正在加载..."  
	});  
	year_option = {
	    title : {
	        text: '月访问量',
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
	            data : ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30']
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
	            data:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
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
	monthEchart.setOption(year_option,true);
	monthEchart.hideLoading();  
	getMonthChartData();//aja后台交互    
	
}

function getMonthChartData() {  
    //获得图表的options对象  
    var options = monthEchart.getOption();  
    var url = "<c:url value='/visit/getMonthChartData'/>";
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
                monthEchart.hideLoading();  
                monthEchart.setOption(options);  
            }  
        },  
        error : function(errorMsg) {  
            alert("不好意思，大爷，图表请求数据失败啦!");  
            monthEchart.hideLoading();  
        }  
    });  
}  
</script>