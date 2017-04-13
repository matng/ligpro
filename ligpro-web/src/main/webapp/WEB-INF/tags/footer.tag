<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<style>
<!--
.footer1{ display:block; height:170px; border-right:1px solid #3F5B6F;overflow:hidden;}
.footer-nav li{
	padding-top: 25px;
	padding-left: 25px;
	color: #000;
}
.footer-nav li > a:hover{
	text-decoration: none;
	font-style: red;
}
.footer-title{
	padding-top:20px;
	padding-left:38px; 
	text-align: left;
	padding-bottom:15px;
	font-size: 16px;
	font-family: Microsoft YaHei, ΢���ź�, MicrosoftJhengHei, ����ϸ��, STHeiti, MingLiu; 
	font-weight: bold;
}
-->
</style>
<footer id="footer" class="midnight-blue"
	style="background-color: #2c3f50;height:230px">
	<div class="container">
		<div class="row">
			<div class="col-sm-4 footer1">
				<div style="text-align: left;">
					<div><img width="268px" src="<c:url value='/html/images/logo/ligpro-logo-footer.png'/>" alt="logo"></div>
				</div>
				<div style="text-align: left;padding-top:5px;">
					<div style="float: left;padding-top:5px;padding-right:16px">
						<img height="35px" src="<c:url value='/html/images/logo/csh.png'/>" alt="logo">
					</div>
					<div style="float: none;padding-top:5px;">
						<div style="padding-top:18px;font-size: 27px;"><font color="8acaed">0531-86576095</font></div>
					</div>
				</div>
				<div style="float: none;padding-top:35px;font-size: 22px;">
					<font color="8acaed">邮箱：abcdefg@sina.com</font>
				</div>
			</div>
			<div class="col-sm-4 footer1">
				<div>
					<div class="footer-title"><span>公司概况</span></div>
					<div>
						<ul class="footer-nav">
							<c:forEach var="m" items="${menuList}" varStatus="s">
								<c:choose>
									<c:when test="${m.menu.menuname == '公司概况'}">
										<c:forEach var="sMenu" items="${m.subMenu}" varStatus="s">
											<c:choose>
												<c:when test="${sMenu.count > 1}">
													<li><a href="<c:url value='/${sMenu.menuurl}'/>"><font color="8acaed">${sMenu.menuname}</font></a></li>
												</c:when>
												<c:otherwise>
													<li><a
														href="<c:url value='/${sMenu.menuurl}/${sMenu.id}/1'/>"><font color="8acaed">${sMenu.menuname}</font></a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
								</c:choose>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div>
					<div class="footer-title"><span>工程案例</span></div>
					<div>
						<ul class="footer-nav">
							<c:forEach var="m" items="${menuList}" varStatus="s">
								<c:choose>
									<c:when test="${m.menu.menuname == '工程案例'}">
										<c:forEach var="sMenu" items="${m.subMenu}" varStatus="s">
											<c:choose>
												<c:when test="${sMenu.count > 1}">
													<li><a href="<c:url value='/${sMenu.menuurl}'/>"><font color="8acaed">${sMenu.menuname}</font></a></li>
												</c:when>
												<c:otherwise>
													<li><a
														href="<c:url value='/${sMenu.menuurl}/${sMenu.id}/1'/>"><font color="8acaed">${sMenu.menuname}</font></a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
								</c:choose>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>

<footer id="footer" class="midnight-blue"
	style="background-color: #213241">
	<div class="container">
		<div class="row">
			<div style="text-align: center;">
				<font color=#8acaeb>Copyright © 2017 山东天馈防雷科技有限公司</font>
			</div>
		</div>
	</div>
</footer>
<!--/#footer-->

<script src="<c:url value='/html/js/jquery.js'/>"></script>
<script src="<c:url value='/html/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/html/js/jquery.prettyPhoto.js'/>"></script>
<script src="<c:url value='/html/js/jquery.isotope.min.js'/>"></script>
<script src="<c:url value='/html/js/main.js'/>"></script>
<script src="<c:url value='/html/js/wow.min.js'/>"></script>
<script src="<c:url value='/bootstrap/js/Jslib.js'/>"></script>

<script type="text/javascript">
	$("#moreBtn").click(getMoreData);
	function getMoreData() {
		var start = parseInt($('#start').val());
		var limit = parseInt($('#limit').val());
		start = start + limit;
		var flag = $('#cParentMenuId').val()==0?0:1;
		var json = {
			"id" : flag,
			"menuid" : $('#menuid').val(),
			"start" : start,
			"limit" : limit
		};
		var url = "<c:url value='/getMoreData'/>";

		fnAjaxPost(
				url,
				JSON.stringify(json),
				function(res) {
					//alert(JSON.stringify(res));
					var list = JSON.parse(JSON.stringify(res));
					for ( var i in list) {
						var d = list[i];
						var myDate = new Date(d.addtime);
						var dateStr = myDate.Format("yyyy-MM-dd");
						var html = '<li><a href="'+d.htmlurl+'/'+d.id+'"><i class="fa fa-angle-double-right"></i> ';
						html += d.title + '<span class="pull-right">' + dateStr
								+ '</span></a></li>';
						$('#newsList').append(html);
					}
					$('#start').val(start);

				});

	}
</script>