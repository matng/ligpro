<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<div class="nav">
    <span id="title" style="background-image: url(<c:url value='/html/images/logo/JK_${parentMenu.menucode}_MenuTitle.png'/>)"></span>
	<c:forEach var="lmenu" items="${leftMenuList}" varStatus="s">  															
		<c:choose >
			<c:when test="${(lmenu.menuname eq menuTitle) or (lmenu.menuname eq contentParentMenuTitle)}"><!-- add by tl in 151225 -->
			 	<c:choose >
       				<c:when test="${lmenu.count > 1}">	
       					<span class='active'><a  href="<c:url value='/${lmenu.menuurl}'/>">${lmenu.menuname}</a></span>
       				</c:when>
       				<c:otherwise>
       					<span class='active'><a  href="<c:url value='/${lmenu.menuurl}/${lmenu.id}/1'/>">${lmenu.menuname}</a></span>
       				</c:otherwise> 
       			</c:choose>	      			
       		</c:when> 
       		<c:otherwise>
       			<c:choose >
       				<c:when test="${lmenu.count > 1}">	
       					<span ><a href="<c:url value='/${lmenu.menuurl}'/>">${lmenu.menuname}</a></span>
       				</c:when>
       				<c:otherwise>
       					<span ><a href="<c:url value='/${lmenu.menuurl}/${lmenu.id}/1'/>">${lmenu.menuname}</a></span>
       				</c:otherwise> 
       			</c:choose>
       		</c:otherwise> 			                            		
       	</c:choose>	   
	</c:forEach>
</div>