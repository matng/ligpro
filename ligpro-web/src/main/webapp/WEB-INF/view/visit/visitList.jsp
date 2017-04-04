<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<title><fmt:message key="backStage_name" /></title>
<style>
<!--
.echarts-width{
	height: 450px; 
	border: 1px dashed #48C0CD; 
	padding: 10px; 
	width: 95%; 
	float: none; 
	align: center
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
<c:import url="weekChart.jsp"></c:import>
<c:import url="dayChart.jsp"></c:import>
<c:import url="yearChart.jsp"></c:import>
<c:import url="monthChart.jsp"></c:import>
<c:import url="areaChart.jsp"></c:import>
<c:import url="browserChart.jsp"></c:import>
<c:import url="osChart.jsp"></c:import>

<script type="text/javascript">
	var scripts = [ "<c:url value='/echarts/esl.js'/>",
			"<c:url value='/echarts/macarons.js'/>" ]
	$('.page-content-area').ace_ajax(
			'loadScripts',
			scripts,
			function() {
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
