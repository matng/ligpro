<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>

<style>
<!--
.navbar-inverse {
	background-color: #b9090b;
	/* background color will be black for all browsers */
	background-image: none;
	background-repeat: no-repeat;
	padding-top: 0px;
	padding-bottom: 0px;
	filter: none;
}

.navbar-inverse .navbar-nav>li {
	font-size: 18px;
}
.navbar-inverse .navbar-nav>.active>a, .navbar-inverse .navbar-nav>.open>a,
	.navbar-inverse .navbar-nav>.open>a:focus, .navbar-inverse .navbar-nav>li>a:hover
	{
	background-color: #E40B0E;
	color: #fff;
	height: 60px;
	padding-top: 17px;
}

.navbar-inverse .navbar-nav>li>a {
	color: #fff;
	height: 60px;
	padding-top: 17px;
}
/* 下拉菜单背景颜色 */
.navbar-inverse .navbar-nav>.dropdown>.dropdown-menu>li>a:hover {
	background-color: #E40B0E;
	color: #fff;
}
-->
</style>
<header id="header">
	<nav class="navbar navbar-inverse" role="banner">
		<!--/#main-slider-->
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="#"><img width="192px" height="55"
						src="<c:url value='/html/images/logo/ligpro-logo.png'/>" alt="logo"></a>
			</div>

			<div class="collapse navbar-collapse navbar-left">
				<ul class="nav navbar-nav">
					<c:forEach var="m" items="${menuList}" varStatus="s">
						<c:choose>
							<c:when test="${m.subMenuLength == 0}">
								<li class="${m.menu.menuurl eq activeMenu ? 'active' : ''}"><a
									href="<c:url value='/${m.menu.menuurl}'/>">${m.menu.menuname}</a></li>
							</c:when>
							<c:otherwise>
								<li class="dropdown "><a
									href="<c:url value='/${m.menu.menuurl}'/>"
									class="dropdown-toggle" data-toggle="dropdown">${m.menu.menuname}</a>
									<ul class="dropdown-menu">
										<c:forEach var="sMenu" items="${m.subMenu}" varStatus="s">
											<c:choose>
												<c:when test="${sMenu.count > 1}">
													<li><a href="<c:url value='/${sMenu.menuurl}'/>">${sMenu.menuname}</a></li>
												</c:when>
												<c:otherwise>
													<li><a
														href="<c:url value='/${sMenu.menuurl}/${sMenu.id}/1'/>">${sMenu.menuname}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</ul></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
			</div>
		</div>
		<!--/.container-->
	</nav>
	<!--/nav-->
</header>
<!--/header-->
