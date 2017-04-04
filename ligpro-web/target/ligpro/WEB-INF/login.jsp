<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>Login Page</title>

		<meta name="description" content="User login page" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		
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


		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		<!--[if lte IE 8]>
		<script src="<c:url value='/bootstrap/js/html5shiv.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/respond.min.js'/>"></script>
		<![endif]-->
		
		
	</head>

	<body class="login-layout">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">
							<div class="center">
								<h1>
									<i class="ace-icon fa fa-leaf green"></i>
									<span class="red"></span>
									<span class="white" id="id-text2">网站管理登录</span>
								</h1>

							</div>

							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-coffee green"></i>
												请输入您的登录信息
											</h4>

											<div class="space-6"></div>
											
											
									<%String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
									  if (error==null) {
										  error = null;
									  } else if ("com.hxd.exception.CaptchaException".equals(error)) {
										  error = "验证码错误!";
									  } else if ("com.hxd.exception.UserLockException".equals(error)) {
										  error = "登录帐号被冻结！ ";
									  } else {
										  error = "用户或密码错误!";
									  }
									%>
									<div id="messageBox" class="alert alert-error <%=error==null?"hide":""%>"><button data-dismiss="alert" class="close">×</button>
										<span class="label label-warning" id="checkError">
											<label id="loginError" class="error"><%=error%></label>
										</span>
										
									</div>
											
											
											<form id="loginForm" action="<%=basePath%>/login" method="post">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" id="username" name="username" value="${username}" class="form-control" placeholder="帐号" />
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" id="password" name="password" class="form-control" placeholder="密码" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>
													
													<div class="space-4"></div>
													
													<c:if test="${isValidateCodeLogin}">
														<div class="validateCode">
															<label for="validateCode">验证码：</label>
															<tags:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
														</div>
													</c:if>
																		
													<div class="space"></div>

													<div class="clearfix">
														<button id="loginBtn" class="width-35 pull-right btn btn-sm btn-primary">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110">登 录</span>
														</button>
													</div>

													<div class="space-4"></div>
												</fieldset>
											</form>											

											<div class="space-6"></div>

											
										</div><!-- /.widget-main -->

										<div class="toolbar clearfix">
											<div class="right">
												<a href="#" data-target="#forgot-box" class="forgot-password-link">
													忘记密码
													<i class="ace-icon fa fa-arrow-right"></i>
												</a>
											</div>
										</div>
									</div><!-- /.widget-body -->
								</div><!-- /.login-box -->

								<div id="forgot-box" class="forgot-box widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header red lighter bigger">
												<i class="ace-icon fa fa-key"></i>
												找回密码
											</h4>

											<div class="space-6"></div>
											<p>请输入您的注册电子邮箱</p>

											<form id="sendEmailForm" action="<%=basePath%>/sendemail" method="post">
												<fieldset>
												<div class="form-group">
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">

															<input id="eamil" name="email" type="email" class="form-control" placeholder="Email" />
															<i class="ace-icon fa fa-envelope"></i>
														
														</span>
													</label>
												</div>
													<div class="clearfix">
														<button id="sendEmailBtn" type="button" class="width-35 pull-right btn btn-sm btn-danger">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110">发 送</span>
														</button>
													</div>
												</fieldset>
											</form>
											
										</div><!-- /.widget-main -->

										<div class="toolbar center">
											<a href="#" data-target="#login-box" class="back-to-login-link">
												返回登录
												<i class="ace-icon fa fa-arrow-right"></i>
											</a>
										</div>
									</div><!-- /.widget-body -->
								</div><!-- /.forgot-box -->
								
							</div><!-- /.position-relative -->
							
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->

		<!-- basic scripts -->


		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='<c:url value='/bootstrap/js/jquery.min.js'/>'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->
	
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='<c:url value='/bootstrap/js/jquery.mobile.custom.min.js'/>'>"+"<"+"/script>");
		</script>
		
		
		<script src="<c:url value='/bootstrap/js/bootstrap.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/jquery.validate.min.js'/>"></script>

		<!-- page specific plugin scripts -->



		<!-- inline scripts related to this page -->
		<script type="text/javascript">
		
		
		function init() {
			$('body').attr('class', 'login-layout blur-login');
			$('#id-text2').attr('class', 'white');
			$('#id-company-text').attr('class', 'light-blue');
		}
		
		
		
		jQuery(function($) {
		 $(document).on('click', '.toolbar a[data-target]', function(e) {
			e.preventDefault();
			var target = $(this).data('target');
			$('.widget-box.visible').removeClass('visible');//hide others
			$(target).addClass('visible');//show target
		 });
		 init();
		 
		});
			
		//提交form
		$("#loginBtn").click(loginSubmit);
		function loginSubmit() {
			if(!$("#loginForm").valid()) {
				return;
			}			
			 $("#loginForm").submit();
		}


			var validForm = $("#loginForm").validate({
				rules: {
							validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"},
							username: {required: true},
							password: {required:true}
						},
						messages: {
							username: {required: "请填写用户名! "},
							password: {required: "请填写密码! "},
							validateCode: {remote: "验证码不正确! ", required: " 请填写验证码!"}
						},
				errorLabelContainer: "#checkError",
				errorPlacement: function(error, element) {
					error.appendTo($("#checkError"));
					
				} 
			});

		
			//提交form
			$("#sendEmailBtn").click(sendEmailSubmit);
			function sendEmailSubmit() {
				
				if(!$("#sendEmailForm").valid()) {
					return;
				}			
				 $("#sendEmailForm").submit();
				 alert('找回密码邮件已发送！请注意查收！');
			}


			var validForm = $("#sendEmailForm").validate({
				rules: {
							email: {required:true,email:true}
						},
						messages: {
							email: {required: "<font color='red'>请填写Email! </font>", email: "<font color='red'>请输入合法的Email地址!</font>"}
						},
				errorPlacement: function (error, element) {
					error.insertAfter(element.parent());
				}
			});

		
			
		</script>
	</body>
</html>

