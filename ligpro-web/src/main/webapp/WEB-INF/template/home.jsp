<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="keywords" content="天馈防雷" />
<meta name="description" content="天馈防雷">
<title><fmt:message key="site_name" /></title>
<tags:header />

</head>
<!--/head-->

<style>
<!--
.box {
	margin: 30px auto;
	padding: 0px 0px 0px 0px;
	float: none;
	width: 101%;
	height: auto;
	box-shadow: 0 0 3px 3px rgba(255, 255, 255, 0);
	border-radius: 15px;
	background: rgba(255, 255, 255, 0.7);
	background-image: linear-gradient(to bottom, rgba(255, 255, 255, 0.9) 0%,
		rgba(255, 255, 255, 0.1) 40%, rgba(255, 255, 255, 0.2) 98%, #FFFFFF
		100%);
}

.content-bg {
	background: url("<c:url value='/html/images/logo/bg.jpg'/>") no-repeat
		center center;
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<c:url value="/html/images/logo/bg-old.png"/>',
		sizingMethod='scale');
	-ms-filter:
		"progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<c:url value="/html/images/logo/bg-old.png
		"/>', sizingMethod='scale')";
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: 100% 100%;
}

.fea_transparent {
	background: rgba(255, 255, 255, 0) !important;
	filter: Alpha(opacity = 60);
	background: #fff;
}

.scroll_div {
	height: 49px;
	margin: 0 auto;
	padding-top: 5px;
	overflow: hidden;
	white-space: nowrap;
	background: #ffffff;
}

.scroll_div img {
	height: 49px;
	border: 0;
	margin: auto 0px;
}

#scroll_begin, #scroll_end, #scroll_begin ul, #scroll_end ul,
	#scroll_begin ul li, #scroll_end ul li {
	display: inline;
} /* 设置ul和li横排 */
-->
</style>


<body class="homepage">
	<nav class="navbar navbar-inverse" role="banner">
		<section id="main-slider" class="no-margin">
			<div class="carousel slide">
				<!-- tl 151113 -->
				<ol class="carousel-indicators">
					<c:forEach var="slider" items="${sliderPicList}" varStatus="s">
						<c:if test="${s.index==0 }">
							<li data-target="#main-slider" data-slide-to="0" class="active"></li>
						</c:if>
						<c:if test="${s.index!=0 }">
							<li data-target="#main-slider" data-slide-to="${s.index}"></li>
						</c:if>
					</c:forEach>
				</ol>

				<div class="carousel-inner">
					<c:forEach var="slider" items="${sliderPicList}" varStatus="s">
						<c:if test="${s.index==0 }">
							<div class="item active"
								style="background-image:url(/ligproDir${slider.fileurl})">
								<div class="container">
									<div class="row slide-margin">
										<div class="col-sm-6">
											<div class="carousel-content">
												<a class="btn-slide animation animated-item-1"
													target="_blank" href="${slider.slidePicDetailsUrl}"><img
													src="html/images/logo/wBtn.png" alt="点击查看"></a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--/.item-->
						</c:if>
						<c:if test="${s.index!=0 }">
							<div class="item"
								style="background-image:url(/ligproDir${slider.fileurl}) ">
								<div class="container">
									<div class="row slide-margin">
										<div class="col-sm-6">
											<div class="carousel-content">
												<a class="btn-slide animation animated-item-1"
													target="_blank" href="${slider.slidePicDetailsUrl}"><img
													src="html/images/logo/wBtn.png" alt="点击查看"></a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--/.item-->
						</c:if>
					</c:forEach>
				</div>
				<!-- /tl 151113-->
			</div>
			<!--/.carousel-->
			<div style="display: none">
				<a id="prev" class="prev hidden-xs" href="#main-slider"
					data-slide="prev"> <i class="fa fa-chevron-left"></i>
				</a> <a id="sNext" class="next hidden-xs" href="#main-slider"
					data-slide="next"> <i class="fa fa-chevron-right"></i>
				</a>
			</div>
		</section>
	</nav>
	<!-- 首页菜单 -->
	<tags:menu />
	<!-- content -->
	<div class="content-bg">
		<div class="container">
			<div class="row">
				<div class="box" id="center_box">
					<!-- 热点图数据 -->
					<section id="feature" class="fea_transparent">
						<div class="container fea_transparent">
							<div class="row fea_transparent">
								<div class="imgbox fea_transparent">
									<ul class="portfolio-filter fea_transparent">
										<li><a class="active fea_transparent" href="#"
											data-filter="*">全部</a></li>
										<c:forEach var="gn" items="${groupNameList}" varStatus="s">
											<li><a href="#" class="fea_transparent"
												data-filter=".${gn.menuUrl}">${gn.groupName}</a></li>
										</c:forEach>
									</ul>
									<!--/#portfolio-filter-->

									<div class="row fea_transparent">
										<div class="portfolio-items fea_transparent">

											<c:forEach var="hot" items="${hotPicList}" varStatus="s">
												<div
													class="portfolio-item ${hot.menuUrl} col-xs-12 col-sm-4 col-md-3 fea_transparent">
													<div class="recent-work-wrap fea_transparent">
														<img class="img-responsive fea_transparent"
															src="<c:url value='../ligproDir${hot.fileurl}'/>" alt="">
														<div class="overlay">
															<div class="recent-work-inner">
																<h3>
																	<a href="#">${hot.resName}</a>
																</h3>
																<a class="preview"
																	href="<c:url value='../ligproDir/${hot.bigpicurl}'/>"
																	rel="prettyPhoto"><i class="fa fa-eye"></i> 看大图</a><br>
																<a class="preview"
																	href="<c:url value='${hot.menuUrl}'/>"><i
																	class="fa fa-eye"></i> 看内容</a>
															</div>
														</div>
													</div>
												</div>
												<!--/.portfolio-item-->
											</c:forEach>
										</div>
									</div>

								</div>
								<!--/.services-->
							</div>
							<!--/.row-->
						</div>
						<!--/.container-->
					</section>
					<!--/#feature-->


					<!-- 新闻数据 -->
					<section id="feature" class="fea_transparent">
						<div class="container fea_transparent">
							<div class="row">
								<div class="features fea_transparent">
									<div class="col-sm-6 col-md-6">
										<div class="widget">
											<h3>
												<span
													style="font-size: 20px; font-family: Microsoft YaHei, 微软雅黑, MicrosoftJhengHei, 华文细黑, STHeiti, MingLiu; font-weight: bold;"><i
													class="fa fa-minus fa-rotate-90"></i>&nbsp;&nbsp;公司概况</span> <span
													class="pull-right"><a href="<c:url value='/company'/>">更多
														<i class="fa fa-angle-double-right"></i>
												</a></span>
											</h3>
											<div class="row">
												<div class="col-sm-12">
													<ul class="newsBox">
														<c:forEach var="t1" items="${type1.contentList}"
															varStatus="s">
															<li>
																<a href="${t1.htmlurl}/${t1.id}">
																	<span style="font-size: 23px; vertical-align: bottom; padding-left: 4px">•</span>
																	<c:choose >
       																	<c:when test="${fn:length(t1.title) > '25'}">	
       																		${fn:substring(t1.title, 0,25)}... 
       																	</c:when>
	       																<c:otherwise>
													       					${t1.title}
													       				</c:otherwise> 
												       				</c:choose>
															<span class="pull-right"><fmt:formatDate value="${t1.addtime}" pattern="yyyy-MM-dd" /></span></a></li>
														</c:forEach>
													</ul>
												</div>
											</div>
										</div>
										<!--/.archieve-->
									</div>

									<div class="col-sm-6 col-md-6">
										<div class="widget">
											<h3>
												<span
													style="font-size: 20px; font-family: Microsoft YaHei, 微软雅黑, MicrosoftJhengHei, 华文细黑, STHeiti, MingLiu; font-weight: bold;"><i
													class="fa fa-minus fa-rotate-90"></i>&nbsp;&nbsp;最新动态</span> <span
													class="pull-right"><a href="<c:url value='/latest'/>">更多
														<i class="fa fa-angle-double-right"></i>
												</a></span>
											</h3>
											<div class="row">
												<div class="col-sm-12">
													<ul class="newsBox">
														<c:forEach var="t2" items="${type2.contentList}"
															varStatus="s">
															<li>
																<a href="${t2.htmlurl}/${t2.id}">
																	<span style="font-size: 23px; vertical-align: bottom; padding-left: 4px">•</span>
																	<c:choose >
       																	<c:when test="${fn:length(t2.title) > '25'}">	
       																		${fn:substring(t2.title, 0,25)}... 
       																	</c:when>
	       																<c:otherwise>
													       					${t2.title}
													       				</c:otherwise> 
												       				</c:choose>
															<span class="pull-right"><fmt:formatDate value="${t2.addtime}" pattern="yyyy-MM-dd" /></span></a></li>
														</c:forEach>
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--/.services-->
							</div>
							<!--/.row-->
						</div>
						<!--/.container-->
					</section>
					<!--/#feature-->

					<section id="feature" class="fea_transparent">
						<div class="container fea_transparent">
							<div class="row">
								<div class="features fea_transparent">
									<div class="col-sm-6 col-md-6">
										<div class="widget">
											<h3>
												<span
													style="font-size: 20px; font-family: Microsoft YaHei, 微软雅黑, MicrosoftJhengHei, 华文细黑, STHeiti, MingLiu; font-weight: bold;"><i
													class="fa fa-minus fa-rotate-90"></i>&nbsp;&nbsp;业务技术</span> <span
													class="pull-right"><a href="<c:url value='/business'/>">更多
														<i class="fa fa-angle-double-right"></i>
												</a></span>
											</h3>
											<div class="row">
												<div class="col-sm-12">
													<ul class="newsBox">
														<c:forEach var="t3" items="${type3.contentList}"
															varStatus="s">
															<li>
																<a href="${t3.htmlurl}/${t3.id}">
																	<span style="font-size: 23px; vertical-align: bottom; padding-left: 4px">•</span>
																	<c:choose >
       																	<c:when test="${fn:length(t3.title) > '25'}">	
       																		${fn:substring(t3.title, 0,25)}... 
       																	</c:when>
	       																<c:otherwise>
													       					${t3.title}
													       				</c:otherwise> 
												       				</c:choose>
															<span class="pull-right"><fmt:formatDate value="${t3.addtime}" pattern="yyyy-MM-dd" /></span></a></li>
														</c:forEach>
													</ul>
												</div>
											</div>
										</div>
										<!--/.archieve-->
									</div>

									<div class="col-sm-6 col-md-6">
										<div class="widget">
											<h3>
												<span
													style="font-size: 20px; font-family: Microsoft YaHei, 微软雅黑, MicrosoftJhengHei, 华文细黑, STHeiti, MingLiu; font-weight: bold;"><i
													class="fa fa-minus fa-rotate-90"></i>&nbsp;&nbsp;科技研发中心</span> <span
													class="pull-right"><a href="<c:url value='/institute'/>">更多
														<i class="fa fa-angle-double-right"></i>
												</a></span>
											</h3>
											<div class="row">
												<div class="col-sm-12">
													<ul class="newsBox">
														<c:forEach var="t4" items="${type4.contentList}"
															varStatus="s">
															<li>
																<a href="${t4.htmlurl}/${t4.id}">
																	<span style="font-size: 23px; vertical-align: bottom; padding-left: 4px">•</span>
																	<c:choose >
       																	<c:when test="${fn:length(t4.title) > '25'}">	
       																		${fn:substring(t4.title, 0,25)}... 
       																	</c:when>
	       																<c:otherwise>
													       					${t4.title}
													       				</c:otherwise> 
												       				</c:choose>
															<span class="pull-right"><fmt:formatDate value="${t4.addtime}" pattern="yyyy-MM-dd" /></span></a></li>
														</c:forEach>
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--/.services-->
							</div>
							<!--/.row-->
						</div>
						<!--/.container-->
					</section>
					<!--/#feature-->


					<!-- 友情连接 -->
					<section id="feature" class="fea_transparent">
						<div class="container fea_transparent">
							<div class="row">
								<div class="linkBox fea_transparent">
									<div class="col-sm-12 col-md-12">
										<div class="media linkBox-wrap fea_transparent">
											<!-- <div class="pull-left">
										<img class="img-responsive" src="html/images/logo/link.png">
									</div> -->
											<div class="media-body fea_transparent">
												<h3>合作伙伴</h3>
												<div id="scroll_div" class="scroll_div fea_transparent">
													<div id="scroll_begin" class="fea_transparent">
														<c:forEach var="i" begin="1" end="${10}">
															<ul>
																<c:forEach var="link" items="${linkList}" varStatus="s">
																	<c:choose>
																		<c:when test="${link.linktype == 1}">
																			<li><a href="${link.siteurl}" target="_blank">${link.sitename}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
																		</c:when>
																		<c:otherwise>
	
																			<li><a href="${link.siteurl}" target="_blank"><img
																					src="${link.logourl}" alt="${link.sitename}"
																					height="40px"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
	
																		</c:otherwise>
																	</c:choose>
	
																</c:forEach>
															</ul>
														</c:forEach>
													</div>
													<div id="scroll_end"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--/.services-->
							</div>
							<!--/.row-->
						</div>
						<!--/.container-->
					</section>
					<!--/#feature-->
				</div>
			</div>
		</div>
	</div>
	<!-- content end-->
	<tags:footer />

	<script type="text/javascript">
		setInterval(sNextFunc, 5000);
		function sNextFunc() {
			$('#sNext').click();
		}
	</script>
	
	<script type="text/javascript">
	
	function ScrollImgLeft() {
		var speed = 20;
		var scroll_begin = document.getElementById("scroll_begin");
		var scroll_end = document.getElementById("scroll_end");
		var scroll_div = document.getElementById("scroll_div");
		document.getElementById("scroll_div").style.width = $('#center_box').width() + "px";
		scroll_end.innerHTML = scroll_begin.innerHTML;
		
		function Marquee() {
			if(scroll_end.offsetWidth - scroll_div.scrollLeft <= 0) 
				scroll_div.scrollLeft -= scroll_begin.offsetWidth;
			else 
				scroll_div.scrollLeft++;
		}
		var MyMar = setInterval(Marquee, speed);
		scroll_div.onmouseover = function() {
			clearInterval(MyMar);
		}
		scroll_div.onmouseout = function() {
			MyMar = setInterval(Marquee, speed);
		}
	}
	</script>
	<script type="text/javascript">
		ScrollImgLeft();
	</script> 
</body>
</html>