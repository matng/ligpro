<%@page import="java.io.Console"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

var areaEchart;

//右侧柱形图
function DrawAreaEchart(ec) {
	areaEchart = ec.init(document.getElementById('areaEchart'),e_macarons);
	areaEchart.showLoading({  
    	text : "图表数据正在加载..."  
	});  
	areaOption = {
		    title : {
		        text: '区域访问量',
		        subtext: '总访问量',
		        x:'left'
		    },
		    tooltip : {
		        trigger: 'item'
		    },
		    /* legend: {
		        orient: 'vertical',
		        x:'left',
		        data:['iphone3']
		    }, */
		    dataRange: {
		        min: 0,
		        max: 10,
		        x: 'left',
		        y: 'bottom',
		        text:['高','低'],           // 文本，默认为数值文本
		        calculable : true
		    },
		    toolbox: {
		        show: true,
		        orient : 'vertical',
		        x: 'right',
		        y: 'center',
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    /* roamController: {
		        show: false,
		        x: 'right',
		        mapTypeControl: {
		            'china': true
		        }
		    }, */
		    series : [
		        {
		            name: '访问人数',
		            type: 'map',
		            mapType: 'china',
		            roam: false,
		            itemStyle:{
		                normal:{label:{show:true}},
		                emphasis:{label:{show:true}}
		            },
		            data:[
		                {name: '北京',value: Math.round(Math.random()*1000)},
		                {name: '天津',value: Math.round(Math.random()*1000)},
		                {name: '上海',value: Math.round(Math.random()*1000)},
		                {name: '重庆',value: Math.round(Math.random()*1000)},
		                {name: '河北',value: Math.round(Math.random()*1000)},
		                {name: '河南',value: Math.round(Math.random()*1000)},
		                {name: '云南',value: Math.round(Math.random()*1000)},
		                {name: '辽宁',value: Math.round(Math.random()*1000)},
		                {name: '黑龙江',value: Math.round(Math.random()*1000)},
		                {name: '湖南',value: Math.round(Math.random()*1000)},
		                {name: '安徽',value: Math.round(Math.random()*1000)},
		                {name: '山东',value: Math.round(Math.random()*1000)},
		                {name: '新疆',value: Math.round(Math.random()*1000)},
		                {name: '江苏',value: Math.round(Math.random()*1000)},
		                {name: '浙江',value: Math.round(Math.random()*1000)},
		                {name: '江西',value: Math.round(Math.random()*1000)},
		                {name: '湖北',value: Math.round(Math.random()*1000)},
		                {name: '广西',value: Math.round(Math.random()*1000)},
		                {name: '甘肃',value: Math.round(Math.random()*1000)},
		                {name: '山西',value: Math.round(Math.random()*1000)},
		                {name: '内蒙古',value: Math.round(Math.random()*1000)},
		                {name: '陕西',value: Math.round(Math.random()*1000)},
		                {name: '吉林',value: Math.round(Math.random()*1000)},
		                {name: '福建',value: Math.round(Math.random()*1000)},
		                {name: '贵州',value: Math.round(Math.random()*1000)},
		                {name: '广东',value: Math.round(Math.random()*1000)},
		                {name: '青海',value: Math.round(Math.random()*1000)},
		                {name: '西藏',value: Math.round(Math.random()*1000)},
		                {name: '四川',value: Math.round(Math.random()*1000)},
		                {name: '宁夏',value: Math.round(Math.random()*1000)},
		                {name: '海南',value: Math.round(Math.random()*1000)},
		                {name: '台湾',value: Math.round(Math.random()*1000)},
		                {name: '香港',value: Math.round(Math.random()*1000)},
		                {name: '澳门',value: Math.round(Math.random()*1000)}
		            ]
		        }
	    ]
	};
	areaEchart.setOption(areaOption,true);
	areaEchart.hideLoading();  
	getAreaChartData();//aja后台交互    
	
}

function getAreaChartData() {  
    //获得图表的options对象  
    var options = areaEchart.getOption();  
    var url = "<c:url value='/visit/getAreaChartData'/>";
    //通过Ajax获取数据  
    $.ajax({  
        type : "post",  
        async : false, //同步执行  
        url : url,  
        data : {},  
        dataType : "json", //返回数据形式为json  
        success : function(result) {
            if (result) {  
            	options.series[0].data = result;//赋值
            	options.dataRange.min=0;
            	options.dataRange.max=result[34].value;
                areaEchart.hideLoading();  
                areaEchart.setOption(options);  
            }  
        },  
        error : function(errorMsg) {  
            alert("不好意思，大爷，图表请求数据失败啦!");  
            areaEchart.hideLoading();  
        }  
    });  
}  
</script>