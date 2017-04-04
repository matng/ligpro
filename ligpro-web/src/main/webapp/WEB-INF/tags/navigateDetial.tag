<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<style>
<!--
.navigateColor a{
	color: #858585;
	text-decoration: none
}
.navigateColor a:hover{
	color: blue;
	text-decoration: none;
}
.navigateColor b{
	color: #858585;
}
-->
</style>

<div class="brandNav navigateColor" >
	<a href="<c:url value='/home' />" target="_self" >首	页</a>
	<b>>></b>
	<a href="<c:url value='/${parentMenu.menuurl}'/>">${parentMenu.menuname}</a>
	<c:choose >
		 <c:when test="${contentParentMenuId=='0'}">
		 	<c:if test="${fn:length(cms.title)!='0'}">
	  				<b>>></b> 				
				<a target="_self">${cms.title}</a> 
			</c:if>
		 </c:when>
		 <c:otherwise>
 	<c:if test="${fn:length(contentParentMenuTitle)!='0'}">
  	<b>>></b>    
	 	 			<a href="<c:url value='/${contentParentMenuUrl}'/>" target="_self">${contentParentMenuTitle}</a>
	  				<c:if test="${fn:length(cms.title)!='0'}">
	  					<b>>></b> 				
					<a target="_self">${cms.title}</a> 
				</c:if>
			</c:if>
		</c:otherwise>
	</c:choose>	
 </div>