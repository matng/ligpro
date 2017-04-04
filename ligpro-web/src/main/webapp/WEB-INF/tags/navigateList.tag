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
	text-decoration: none
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
  	<c:if test="${contentParentMenuId!='0'}">
  		<b>>></b>     				
	<a target="_self">${menuTitle}</a> 
	</c:if>
 </div>