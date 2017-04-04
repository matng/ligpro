<%@page import="java.io.Console"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

var browserEchart;

//右侧柱形图
function DrawBrowserEchart(ec) {
	browserEchart = ec.init(document.getElementById('browserEchart'),e_macarons);
	browserEchart.showLoading({  
    	text : "图表数据正在加载..."  
	});  
	browserOption = {
		    title : {
		        text: '浏览器类型统计',
		        //subtext: '纯属虚构',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient : 'vertical',
		        x : 'left',
		        data:['']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {
		                show: true, 
		                type: ['pie', 'funnel'],
		                option: {
		                    funnel: {
		                        x: '25%',
		                        width: '50%',
		                        funnelAlign: 'left',
		                        max: 1548
		                    }
		                }
		            },
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    series : [
		        {
		            name:'访问来源',
		            type:'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:0, name:''}
		            ]
		        }
		    ]
		};
	browserEchart.setOption(browserOption,true);
	browserEchart.hideLoading();  
	getBrowserChartData();//aja后台交互    
	
}

function getBrowserChartData() {  
    //获得图表的options对象  
    var options = browserEchart.getOption();  
    var url = "<c:url value='/visit/getBrowserChartData'/>";
    var label=[];
    var value=[];
    //通过Ajax获取数据  
    $.ajax({  
        type : "post",  
        async : false, //同步执行  
        url : url,  
        data : {},  
        dataType : "json", //返回数据形式为json  
        success : function(result) {
          	$.each(result,function(i,p){
            	label[i]=p['name'];
            	value[i]={'name':p['name'],'value':p['value']};
            	});
          			browserEchart.hideLoading();
                	options.legend.data=label;
            		options.series[0]['data']=value;
                	options.series[0]['radius']=[0,100];
                	browserEchart.setOption(options);  
        },  
        error : function(errorMsg) {  
            alert("不好意思，大爷，图表请求数据失败啦!");  
            browserEchart.hideLoading();  
        }  
    });  
}  
</script>