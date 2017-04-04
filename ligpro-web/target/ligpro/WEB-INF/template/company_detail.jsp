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
	<meta name="keywords" content="${cms.keyword}"/>
    <meta name="description" content="${cms.title}">
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
            <div class="row">
    			<tags:navigateDetial />
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
							<h1>${cms.title}</h1>	
							<hr>
							${cms.content}
						</div>
					</div>
                        
                </div><!--/.services-->
            </div><!--/.row-->    
        </div><!--/.container-->
    </section><!--/#feature-->
	

    <tags:footer />    

</body>
</html>