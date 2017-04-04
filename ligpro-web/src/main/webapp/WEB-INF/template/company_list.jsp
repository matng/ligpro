<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="keywords" content=""/>
    <meta name="description" content="">
    <title><fmt:message key="site_name" /></title>
	<tags:header />
   
</head><!--/head-->

<body class="homepage">
	<!-- 导航菜单 -->    
	<tags:menu />
    

    <section id="mainBanner" class="no-margin">
		<div class="imgItem" style="background-image: url(<c:url value='/html/images/logo/JK_Company_Banner.png'/>)">     
		</div><!--/.item-->
    </section><!--/#main-slider-->
		
	<section id="hxd" >
        <div class="container">
        
            <!-- add by tl in 151224 -->
            <div class="row">
    			<tags:navigateList />
   		    </div><!--/.row-->
    		<!------------------------->
    		
    		
            <div class="row">
                <div class="box">
                     <div class="col-sm-2 col-md-2">
						<!-- left menu -->
						<tags:leftMenu />
					</div>

					
					<div class="col-sm-10 col-md-10">
						<div class="cms">
							<h2>${menuTitle}</h2>
							<hr>

							<ul id="newsList" class="newsBox">
								<c:forEach var="clist" items="${contentList}" varStatus="s">  															
								<li><a href="${clist.htmlurl}/${clist.id}"><i class="fa fa-angle-double-right"></i> ${clist.title} <span class="pull-right"><fmt:formatDate value="${clist.addtime}" pattern="yyyy-MM-dd"/></span></a></li>
								</c:forEach>
							</ul>

							<a id="moreBtn" class="btn btn-default" href="#" >加载更多...</a>
							<input type="text" id="menuid" value="${vo.menuid}" class="hidden" />
							<input type="text" id="start" value="${vo.start}" class="hidden" />
							<input type="text" id="limit" value="${vo.limit}" class="hidden" />
							<input type="text" id="cParentMenuId" value="${contentParentMenuId}" class="hidden" />
						</div>
					</div>
                        
                </div><!--/.services-->
            </div><!--/.row-->    
        </div><!--/.container-->
    </section><!--/#feature-->
    
    <tags:footer />
        
	

</body>
</html>