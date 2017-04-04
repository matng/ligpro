<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
		<title>网站管理</title>
		<meta name="description" content="overview &amp; stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
        
        <c:import url="view/inc/header.jsp"></c:import>
        		
	</head>

	<body class="no-skin">
		<!-- #section:basics/navbar.layout -->
		
		<div id="navbar" class="navbar navbar-default">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<!-- #section:basics/navbar.layout.brand -->
					<a href="javascript:void(0);" class="navbar-brand">
						<small>
							<i class="fa fa-leaf"></i>
							网站后台管理
							
						</small>
					</a>

				</div>

				<!-- #section:basics/navbar.dropdown -->
				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">

						<li class="purple">
							<a id="viewOnlineUser" data-toggle="dropdown" class="dropdown-toggle" href="javascript:void(0)" onclick="viewOnlineUser()">
								<i class="ace-icon fa fa-bell icon-animated-bell"></i>
							</a>

							<ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-exclamation-triangle"></i>
									信息提示
								</li>

								<li class="dropdown-content">
									<ul  id="onlineUserLook" class="dropdown-menu dropdown-navbar navbar-pink">
										
									</ul>
								</li>

							</ul>
						</li>

						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="<c:url value='/bootstrap//avatars/avatar2.png'/>" alt="Jason's Photo" />
								<span class="user-info">
									<small>欢迎您！</small>${loginname}
								</span>
								<i class="ace-icon fa fa-caret-down"></i>
							</a>

							<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="javascript:void(0)" id="modPsw">
										<i class="ace-icon fa fa-cog"></i>
										修改密码
									</a>
								</li>
								<li class="divider"></li>
								<li>
									<a href="logout">
										<i class="ace-icon fa fa-power-off"></i>
										退出系统
									</a>
								</li>
							</ul>
						</li>

					</ul>
				</div>


			</div><!-- /.navbar-container -->
		</div>



		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<!-- #sidebar -->
			<div id="sidebar" class="sidebar responsive">
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
				</script>

				<ul class="nav nav-list">
					<shiro:hasPermission name="menu">
						<li class="">
							<a href="#" class="dropdown-toggle">
								<i class="menu-icon fa fa-desktop"></i>
								<span class="menu-text">
									内容管理
								</span>
								<b class="arrow fa fa-angle-down"></b>
							</a>
							<b class="arrow"></b>
							<ul class="submenu">
								<li></li>	
								<tags:navMenuForMain />										
							</ul>
						</li>
					</shiro:hasPermission>
					
					<!-- 注释掉内容管理  add by chxy at 2016-1-14
					<li class="">
						<shiro:hasPermission name="cms">
							<a href="#" class="dropdown-toggle">
								<i class="menu-icon fa fa-pencil-square-o"></i>
								<span class="menu-text"> 内容管理 </span>
								<b class="arrow fa fa-angle-down"></b>
							</a>
						</shiro:hasPermission>
						<b class="arrow"></b>
						<ul class="submenu">
							<li></li>
							<shiro:hasPermission name="company:r">
								<li class="">
									<a href="#cms/company">
										<i class="menu-icon fa fa-caret-right"></i>
										公司动态
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="news:r">
	                            <li class="">
									<a href="#cms/news">
										<i class="menu-icon fa fa-caret-right"></i>
										行业新闻
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="ser:r">
	                            <li class="">
									<a href="#cms/service">
										<i class="menu-icon fa fa-caret-right"></i>
										服务
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>

							<shiro:hasPermission name="pro:r">
								<li class="">
									<a href="#cms/product">
										<i class="menu-icon fa fa-caret-right"></i>
										产品
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
						</ul>
					</li>
                    -->
                    <li class="">
                    	<shiro:hasPermission name="res">
							<a href="#" class="dropdown-toggle">
								<i class="menu-icon fa fa-picture-o"></i>
								<span class="menu-text"> 资源管理 </span>
								<b class="arrow fa fa-angle-down"></b>
							</a>
						</shiro:hasPermission>
						<b class="arrow"></b>
						<ul class="submenu">
							<li></li>
							<shiro:hasPermission name="gallery:r">
								<li class="">
									<a href="#res/gallery">
										<i class="menu-icon fa fa-caret-right"></i>
										图片
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="flash:r">
								<li class="">
									<a href="#res/flash">
										<i class="menu-icon fa fa-caret-right"></i>
										FLASH
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="video:r">
	                            <li class="">
									<a href="#res/video">
										<i class="menu-icon fa fa-caret-right"></i>
										视频
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							
							<shiro:hasPermission name="file:r">
	                            <li class="">
									<a href="#res/file">
										<i class="menu-icon fa fa-caret-right"></i>
										文件
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
						</ul>
					</li>

					<li class="">
						<shiro:hasPermission name="power">
							<a href="#" class="dropdown-toggle">
								<i class="menu-icon fa fa-tag"></i>
								<span class="menu-text"> 权限管理 </span>
	
								<b class="arrow fa fa-angle-down"></b>
							</a>
						</shiro:hasPermission>
						<b class="arrow"></b>

						<ul class="submenu">
							<shiro:hasPermission name="role:r">
								<li class="">
									<a href="#role/list">
										<i class="menu-icon fa fa-caret-right"></i>
										角色管理
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
						</ul>
					</li>
					
					<li class="">
						<shiro:hasPermission name="visit">
							<a href="#" class="dropdown-toggle">
								<i class="menu-icon fa fa-bar-chart-o"></i>
								<span class="menu-text"> 访问管理</span>
	
								<b class="arrow fa fa-angle-down"></b>
							</a>
						</shiro:hasPermission>
						<b class="arrow"></b>

						<ul class="submenu">
							<li class="">
								<a href="#visit/list">
									<i class="menu-icon fa fa-caret-right"></i>
									访问统计
								</a>

								<b class="arrow"></b>
							</li>
						</ul>
					</li>

                    
                    <li class="">
                    	<shiro:hasPermission name="sys">
							<a href="#" class="dropdown-toggle">
								<i class="menu-icon fa fa-cog"></i>
								<span class="menu-text"> 系统管理 </span>
	
								<b class="arrow fa fa-angle-down"></b>
							</a>
						</shiro:hasPermission>
						<b class="arrow"></b>

						<ul class="submenu">
							<shiro:hasPermission name="module:r">
								<li class="">
									<a href="#module/list">
										<i class="menu-icon fa fa-caret-right"></i>
										模块管理
									</a>
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="tmp:r">
								<li class="">
									<a href="#tmp/list">
										<i class="menu-icon fa fa-caret-right"></i>
										模板管理
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="submenu:r">
								<li class="">
									<a href="#menu/list">
										<i class="menu-icon fa fa-caret-right"></i>
										菜单管理
									</a>
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="user:r">
								<li class="">
									<a  href="#user/list">
										<i class="menu-icon fa fa-caret-right"></i>
										用户管理
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="link:r">
								<li class="">
									<a href="#link/list">
										<i class="menu-icon fa fa-caret-right"></i>
										友情链接
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
							<shiro:hasPermission name="log:r">
								<li class="">
									<a href="#oplog/list">
										<i class="menu-icon fa fa-caret-right"></i>
										日志管理
									</a>
	
									<b class="arrow"></b>
								</li>
							</shiro:hasPermission>
						</ul>
					</li>
				</ul><!-- /.nav-list -->

				<!-- #section:basics/sidebar.layout.minimize -->
				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>

			</div>
			
			<div class="main-content">
			    
				<div class="page-content">
					<div class="page-content-area" data-ajax-content="true">
							<!-- ajax content goes here -->
					</div>
				</div>
			</div>		
						
		</div>				
		
		
		<!-- 个性密码 -->
		<div id="modifyPsw" class="modal fade" tabindex="-1">		
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title">修改密码</span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
					<form id="ModifyPswForm" method="post" class="form-horizontal" role="form">											
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="psw">原密码</label>
							
							<div class="col-sm-9">
							<div class="clearfix">
								<input type="password" id="psw" name="psw" class="col-xs-10 col-sm-5" />
							</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="newpsw">新密码
							</label>
							<div class="col-sm-9">
							<div class="clearfix">
								<input id="newpsw" name="newpsw" type="password" id="form-field-2" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="newpsw2">重输新密码</label>
							<div class="col-sm-9">
							<div class="clearfix">
								<input type="password" id="newpsw2" name="newpsw2" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						</form>
					</div>

					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> 取消
						</button>

						<button id="saveBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i> 确定
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			
			</div>
			
	<c:import url="view/inc/footer.jsp"></c:import>

	<!-- /section:basics/sidebar.layout.minimize -->
		<script type="text/javascript">
			try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
			
			
			//保存
			$("#saveBtn").click(saveData);  //点击元素时会发生click事件，响应saveData函数
			function saveData() {
				if(!$('#ModifyPswForm').valid()) {
					return;
				}
				
				var json = {"psw":$('#psw').val(), "newpsw":$('#newpsw').val()};
				var url = "<c:url value='/user/savepsw'/>";
				
				fnAjaxPost(url,JSON.stringify(json),function(res){
					var obj = JSON.parse(JSON.stringify(res));		
					if (obj.success) {
						alert(obj.success);
						$("#modifyPsw").modal('hide');  //bootstrap手动隐藏一个模态框
						resetFrom();				
					} else {
						alert(obj.error);
					}
				});
				
			}
						
			//弹出窗口
			$("#modPsw").click(openModifyPswForm);
			function openModifyPswForm() {
				$("#modifyPsw").modal('show');
			}
			
			
			//验证
			var validForm = $("#ModifyPswForm").validate({
				errorElement: 'div',
				errorClass: 'help-block',
				focusInvalid: false,
				ignore: "",
				rules: {						
							psw: {required: true},
							newpsw: {required:true, minlength:6},
							newpsw2: {required:true, minlength:6, equalTo: "#newpsw"}
						},
				messages: {
					psw: {required: "请填写原密码! "},
					newpsw: {required: "请填写新密码! ", minlength:"密码长度需要六位以上!"},
					newpsw2: {required: " 请重输新密码!", minlength:"密码长度需要六位以上!", equalTo:"两次输入的新密码不一致!"}
				},
				highlight: function (e) {
					$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
				},

				success: function (e) {
					$(e).closest('.form-group').removeClass('has-error');
					$(e).remove();
				},
				errorPlacement: function (error, element) {
					error.insertAfter(element.parent());
				}
			});
			
			function viewOnlineUser() {
				
				var url = "<c:url value='/onlineUser'/>?t="+new Date();
				var json = {};
				fnAjaxGet(url,json,function(res){
					var obj = JSON.parse(JSON.stringify(res));		
					//alert(JSON.stringify(res));
					if(obj) {
						var count = obj.count;
						var list = obj.userList;
						var html = '';
							html += '<li><a href="javascript:void(0)">';
						    html += '<div class="clearfix"><span class="pull-left">';
						    html += '<i class="btn btn-xs no-hover btn-pink fa fa-comment"></i>当前登录用户数</span>';
						    html += '<span class="pull-right badge badge-info">';
						    html += count;
						    html += '</span></div></a></li>';
						    		
						$('#onlineUserLook').html(html);
						for (var i in list) {
							var item = list[i];
							var html2 = '<li><a href="javascript:void(0)"><div class="clearfix">';
						    html2 += '<span class="pull-left"><i class="btn btn-xs no-hover btn-pink fa fa-comment"></i>';
						    html2 += item.loginname;
						    html2 += '</span><span class="pull-right ">';
						    html2 += item.gender;
						    html2 += '</span></div></li>';
						    $('#onlineUserLook').append(html2);
						}																					
					}
				});								
			}
		</script>
	</body>
</html>
