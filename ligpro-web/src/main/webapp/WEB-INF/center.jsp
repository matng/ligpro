<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<title></title>
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/jquery-ui.custom.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />
<style>
<!--
.echarts-width{
	height: 450px; 
	border: 1px dashed #48C0CD; 
	padding: 10px; 
	width: 95%; 
	float: none; 
	align: center;
}
-->
</style>
<div class="row">
	<div class="col-xs-6">
		<div id="areaEchart" class="echarts-width"></div>
		<div id="osEchart" class="echarts-width"></div>
		<div id="weekEchart" class="echarts-width"></div>
		<div id="yearEchart" class="echarts-width"></div>
	</div>
	<div class="col-xs-6">
		<div id="browserEchart" class="echarts-width"></div>
		<div id="dayEchart" class="echarts-width"></div>
		<div id="monthEchart" class="echarts-width"></div>
	</div>
</div>


<c:import url="view/visit/weekChart.jsp"></c:import>
<c:import url="view/visit/dayChart.jsp"></c:import>
<c:import url="view/visit/yearChart.jsp"></c:import>
<c:import url="view/visit/monthChart.jsp"></c:import>
<c:import url="view/visit/areaChart.jsp"></c:import>
<c:import url="view/visit/browserChart.jsp"></c:import>
<c:import url="view/visit/osChart.jsp"></c:import>

<!-- page specific plugin scripts -->
<script type="text/javascript">
	var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
	               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>",
	           	   "<c:url value='/echarts/esl.js'/>",
	               "<c:url value='/echarts/macarons.js'/>"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		jQuery(function($) {
			require.config({
				paths : {
					echarts : './echarts/echarts-map',
					'echarts/chart/bar' : './echarts/echarts-map',
					'echarts/chart/line' : './echarts/echarts-map',
					'echarts/chart/map' : './echarts/echarts-map',
					'echarts/chart/pie' : './echarts/echarts-map'
				}
			});
			require([ 'echarts', 'echarts/chart/bar',
					'echarts/chart/line', 'echarts/chart/map','echarts/chart/pie' ],
					DrawEChart);
			function DrawEChart(ec) {
				DrawDayEChart(ec);
				DrawWeekEChart(ec);
				DrawYearEchart(ec);
				DrawMonthEchart(ec);
				DrawAreaEchart(ec);
				DrawBrowserEchart(ec);
				DrawOsEchart(ec);
			}

		});
		
	});
</script>

