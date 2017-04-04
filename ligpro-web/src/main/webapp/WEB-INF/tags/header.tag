<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<!-- core CSS -->
    <link href="<c:url value='/html/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/html/css/font-awesome.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/html/css/animate.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/html/css/prettyPhoto.css'/>" rel="stylesheet">
    <link href="<c:url value='/html/css/main.css'/>" rel="stylesheet">
    <link href="<c:url value='/html/css/responsive.css'/>" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="<c:url value='/html/js/html5shiv.js'/>js/html5shiv.js"></script>
    <script src="<c:url value='/html/js/respond.min.js'/>"></script>
    <![endif]-->   
    

<!-- vedio-js lib -->
  <link href="<c:url value='/html/vedio-js/video-js.min.css'/>" rel="stylesheet" type="text/css">
  <script src="<c:url value='/html/vedio-js/video.js'/>"></script>

  <script>
    videojs.options.flash.swf = "<c:url value='/html/vedio-js/video-js.swf'/>";
  </script>