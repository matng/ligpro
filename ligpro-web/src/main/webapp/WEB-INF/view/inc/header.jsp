<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="<c:url value='/bootstrap/css/bootstrap.min.css'/>" />
		<link rel="stylesheet" href="<c:url value='/bootstrap/css/font-awesome.min.css'/>" />


		<!-- page specific plugin styles -->
		<!-- text fonts -->
		<link rel="stylesheet" href="<c:url value='/bootstrap/css/ace-fonts.min.css'/>" />

		<!-- ace styles -->
		<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/ace.css'/>" class="ace-main-stylesheet" id="main-ace-style" />
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="<c:url value='/bootstrap/css/ace-part2.min.css'/>" class="ace-main-stylesheet" />
		<![endif]-->

		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="<c:url value='/bootstrap/css/ace-ie.min.css'/>" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->
		<script src="<c:url value='/bootstrap/js/ace-extra.min.js'/>"></script>

		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		<!--[if lte IE 8]>
		<script src="<c:url value='/bootstrap/js/html5shiv.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/respond.min.js'/>"></script>
		<![endif]-->
		
		
<!-- vedio-js lib -->
  <link href="<c:url value='/html/vedio-js/video-js.min.css'/>" rel="stylesheet" type="text/css">
  <script src="<c:url value='/html/vedio-js/video.js'/>"></script>

  <script>
    videojs.options.flash.swf = "<c:url value='/html/vedio-js/video-js.swf'/>";
  </script>