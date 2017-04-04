<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<!-- init the Nav Menu -->				
	<c:forEach var="m" items="${navMenuList}" varStatus="s">   
		<c:choose>
			<c:when test="${m.subMenuLength == 0}">
				<!-- 																							
				<li class="">
					<a href="#cms/listByMenu/${m.menu.id}">
						<i class="menu-icon fa fa-caret-right"></i>
						${m.menu.menuname}
					</a>
					<b class="arrow"></b>
				</li>
				 -->
				<c:if test="${m.menu.type == 0}">
					<li class="">
						<a href="${m.menu.menuurl}" target="_blank">
							<i class="menu-icon fa fa-pencil orange"></i>
							${m.menu.menuname}
						</a>
						<b class="arrow"></b>
					</li>
				</c:if>
				
				<c:if test="${m.menu.type != 0}">
					<li class="">
						<a href="#cms/listByMenu/${m.menu.id}">
							<i class="menu-icon fa fa-pencil orange"></i>
							${m.menu.menuname}
						</a>
						<b class="arrow"></b>
					</li>
				</c:if>
			</c:when>
			<c:otherwise>											
				<li class="">
					<a href="#" class="dropdown-toggle">
						<i class="menu-icon fa fa-caret-right"></i>
						${m.menu.menuname}
						<b class="arrow fa fa-angle-down"></b>
					</a>
					<b class="arrow"></b>
					<ul class="submenu">										
						<c:forEach var="sMenu" items="${m.subMenu}" varStatus="s"> 
							<li class="">
								<a href="#cms/listByMenu/${sMenu.id}">
									<i class="menu-icon fa fa-pencil orange"></i>
									${sMenu.menuname}
								</a>
								<b class="arrow"></b>
							</li>		      		
                        </c:forEach>												
					</ul>								
				</li>									
			</c:otherwise>
		</c:choose>
	</c:forEach>		