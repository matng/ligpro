<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<title><fmt:message key="backStage_name" /></title>
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/jquery-ui.custom.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/bootstrap-select.min.css'/>" />

<div class="row">
	<div class="col-xs-12">
		<div class="table-header">
			<a href="#modal-table" role="button" class="green"
				data-toggle="modal">
				<shiro:hasPermission name="user:c">
				<button id="newBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 新增
				</button>
				</shiro:hasPermission>
			</a>
			<!-- modified by tl in 150526 
			<button id="editBtn" class="btn btn-white btn-default btn-round"> 
			 <i class="ace-icon fa fa-pencil-square-o red2"></i> 更新 	
			</button> 
			-->
			<shiro:hasPermission name="user:d">
			<button id="delBtn" class="btn btn-white btn-default btn-round">
				<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> 删除
			</button>
			</shiro:hasPermission>
		</div>

		<div>
			<table id="data-table"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center"><label class="position-relative">
								<input id="selectAllCB" type="checkbox" class="ace" /> <span class="lbl"></span>
						</label></th>
						<th>用户帐号</th>
						<th>性别</th>
						<th>电子邮件</th>
						<th>手机</th>
						<th>角色</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	</div>



	<div id="modal-table" class="modal fade" tabindex="-1">		
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title">新增</span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
					<form id="MyForm" method="post" class="form-horizontal" role="form">
						<div class="form-group">
							<div class="col-sm-9">
								<input type="text" id="id" name="id"
									class="hidden" />
							</div>
						</div>
												
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="loginname">登录帐号</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="loginname" name="loginname"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="psw">密码
							</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input id="psw" name="psw" type="password" id="form-field-2"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="loginname">姓名</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="realname" name="realname"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="loginname">性别</label>
							<div class="col-sm-9">
								<div class="radio inline">
									<div class="clearfix">
										<label>
											<input name="gender" type="radio" class="ace" value="男"/>
											<span class="lbl">男</span>
										</label>
									</div>
								</div>
		
								<div class="radio inline">
									<label>
										<input name="gender" type="radio" class="ace" value="女"/>
										<span class="lbl">女</span>
									</label>
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="loginname">手机号</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="mobile" name="mobile"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="loginname">电子邮件</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="email" name="email" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="menuname">角色</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<select id="roleSelect" name="roleSelect"   class="selectpicker show-tick" data-size="5" data-style="btn btn-primary">
									</select>
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="loginname">状态</label>
							<div class="col-sm-9">
								<div class="radio inline">
									<div class="clearfix">
										<label>
											<input name="status" type="radio" class="ace" value="1"/>	
											<span class="lbl">生效</span>								
										</label>
									</div>
								</div>
		
								<div class="radio inline">
									<label>
										<input name="status" type="radio" class="ace" value="0"/>
										<span class="lbl">禁用</span>
									</label>
								</div>
							</div>
						</div>
						</form>
					</div>

					<div class="modal-footer no-margin-top">

						<button id="cancelBtn" class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> 取消
						</button>

						<button id="saveBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i> 确定
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		
	</div>

</div>
<!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">

$(function(){
	$('.selectpicker').selectpicker();
	$.ajax({
		type:'POST',
		url: "<c:url value='/role/queryAllRole'/>",
		cache:false,
		dataType: 'json',
		success: function(data){
			var option = new Option("选择角色",-1);
			$('#roleSelect').append(option);
			for(var i = 0;i < data.length; i++) {
				var item = new Option(data[i].rolename,data[i].id);
				$('#roleSelect').append(item);
	        }
			$('#roleSelect').selectpicker('val', -1);
			$('#roleSelect').selectpicker('refresh');
		}
	});
});


	//删除方法
	function deleteObj(ids){	
		var url = "<c:url value='/user/delete'/>";
		var json = {"idList":ids};
		
		fnAjaxPost(url,JSON.stringify(json),function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
//				alert(obj.success);
				msgBox(obj.success);
				oTable.fnDraw();
//				$.gritter.add({
//					title: '测试!',
//					text: 'haha.',
//					class_name: 'gritter-success  gritter-light'
//				}); 
		
			} else {
//				alert(obj.error);
				msgBox(obj.error);
			}
		});	
	}
	
	/*
	//删除方法
	function deleteObj(ids){	
		var url = "<c:url value='/user/delete'/>";
		var json = '{\"id\":\"'+ids+'\"}';
		
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
				alert(obj.success);
				$("#modal-table").modal('hide');  //bootstrap手动隐藏一个模态框
				resetFrom();
				oTable.fnDraw();
//				$.gritter.add({
//					title: '测试!',
//					text: 'haha.',
//					class_name: 'gritter-success  gritter-light'
//				}); 
		
			} else {
				alert(obj.error);
			}
		});	
	}
	*/

	//批量删除
	$('#delBtn').click(batchDelete);
	function batchDelete() {
		var ids = fnGetIDs('#data-table');
		var json = {"idList":ids};
		alert('ids:'+ids);  //test 160126
		if (ids.length > 0) {
			bootbox.confirm("确定删除吗? ", function(result) {
				if(result) {
					deleteObj(ids);					
				}
			});
			 	
		} else {
//	        alert('请选择一条记录操作。');
			msgBox('请选择一条记录操作。');
	    }
	}
	
	/*
	//批量删除
	$('#delBtn').click(batchDelete);
	function batchDelete() {
		var ids = fnGetIDs('#data-table');
		if (ids.length > 0) {
			bootbox.confirm("确定删除吗? ", function(result) {
				if(result) {
					for(var i=0;i<ids.length;i++)
						{
							deleteObj(ids[i]);							
						}				
				}
			});
			 	
		} else {
	        alert('请选择一条记录操作。');
	    }
	}
	
	*/
	
	//删除一条
	function delOne(ids) {
		bootbox.confirm("确定删除吗? ", function(result) {
			if(result) {
				var idList = new Array();
				idList.push(ids);
//				alert(idList);
				deleteObj(idList);	
			}
		});
	}
	
	/*
	//删除一条
	function delOne(ids) {
		bootbox.confirm("确定删除吗? ", function(result) {
			if(result) {
				deleteObj(ids);	
			}
		});
	}
	*/
	
	//更新编辑
	function updateObj(json) {
		// init data
		$("#modal-title").html("编辑!");
		$("#modal-table").draggable({
		      handle: ".modal-header"
		  });
		document.getElementById('psw').disabled = true;
		
		var obj = JSON.parse(decodeJson(json));
		$("#loginname").val(obj.loginname);

		if((obj.loginname=="admin"))  //admin用户校验 add  by tl in 160126
		{
			document.getElementById('loginname').disabled = true;
		}
		else
		{
			document.getElementById('loginname').disabled = false;	
		}
		
//		$("#psw").val(obj.psw);		   //modified by tl in 150526 night
		$("#realname").val(obj.realname);  //姓名
		$('#roleSelect').selectpicker('val', obj.roleId);

		var gender=document.getElementsByName("gender");
		for(var i=0;i<gender.length;i++)
			{
				if(gender.item(i).value==obj.gender)
					{
					gender.item(i).checked=true;
					}
			}
		
		$("#mobile").val(obj.mobile);  //手机号
		$("#email").val(obj.email);  //电子邮件
		
		var status=document.getElementsByName("status");
		for(var i=0;i<status.length;i++)
			{
				if(status.item(i).value==obj.status)
					{
					status.item(i).checked=true;
					}
			}
		$("#id").val(obj.id);
	}

	var validator = $("#MyForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	
	focusInvalid: false,
	ignore: "",
	rules: {
		loginname: {
			stringCheck:true,
			required: true,
			maxlength:50,
			usernameCheck:true
		},
		psw: {
			required: true,
			maxlength:50,
			checkPassword:true
		},
		realname: {
			realNameCheck:true,
			required: true,
			maxlength:50
		},
		gender: {
			required: true,
		},
		mobile: {
			digits: true,
			required: true,
			maxlength:20
		},		
		email:{
			required:true,
			maxlength:100,
			EmailFormatCheck:true,
			EmailCheck:true,
		},
		roleSelect:{
			roleSelectChecked:true,
		},
		status:{
			required:true
		}
	},

	messages: {
		loginname: {
			required: "不能为空.",
			maxlength:"输入长度应小于50字符",
		},
		psw: {
			required: "不能为空.",
			maxlength:"输入长度应小于50字符"
		},
		realname: {
			required:"不能为空.",
			maxlength:"输入长度应小于50字符"
		},
		gender: {
			required: "请选择状态."
		},
		mobile: {
			required: "不能为空.",
			digits: "请输入整数",
			maxlength:"输入长度应小于20字符"
		},
		email: {
			required: "不能为空.",
			maxlength:"输入长度应小于100字符",
			
		},
		roleSelect: {
		},
		status: {
			required: "请选择状态."
		},
	},
	highlight: function (e) {
		$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
	},

	success: function (e) {
		$(e).closest('.form-group').removeClass('has-error');
		$(e).remove();
	},
	
	errorPlacement: function (error, element) {
		if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
			var controls = element.closest('div[class*="col-"]');
			if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
			else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
		}
		else error.insertAfter(element.parent());
	}

});	

	jQuery.validator.addMethod("usernameCheck", function(value, element) {    
		var res=true;
		//------查询用户名与邮箱是否与已有数据重复----------
		var formData;
		var json; 

		var title=$("#modal-title").text();
		var url;
		if(title=="编辑!")
		{
				var id = $('#id').val(); 
				formData = $("#MyForm").serializeJSON();   
				formData["id"]=id;
				json = JSON.stringify(formData);			
		}
		else{
				formData = $("#MyForm").serializeJSON();   //Jquery将表单转化为json对象
				json = JSON.stringify(formData);
			}	
		url = "<c:url value='/user/userNamecheck'/>";
		fnAjaxPostSync(url,json,function(data){
			var obj = JSON.parse(JSON.stringify(data));	
			if (!obj.success) {
				res=false;
			} 
		});
		
        return /*this.optional(element) || */res;       
   }, "登陆账号已存在 请重新输入");
	
	
	jQuery.validator.addMethod("EmailCheck", function(value, element) {    
		var res=true;
		//------查询用户名与邮箱是否与已有数据重复----------
		var formData;
		var json; 

		var title=$("#modal-title").text();
		var url;
		if(title=="编辑!")
		{
				var id = $('#id').val(); 
				formData = $("#MyForm").serializeJSON();   
				formData["id"]=id;
				json = JSON.stringify(formData);			
		}
		else{
				formData = $("#MyForm").serializeJSON();   //Jquery将表单转化为json对象
				json = JSON.stringify(formData);
			}	
		url = "<c:url value='/user/emailcheck'/>";
		fnAjaxPostSync(url,json,function(data){
			var obj = JSON.parse(JSON.stringify(data));	
			if (!obj.success) {
				res=false;
			} 
		});
		
        return /*this.optional(element) || */res;       
   }, "电子邮箱已存在 请重新输入");

	//登陆账号校验
	jQuery.validator.addMethod("stringCheck", function(value, element) {       
        return this.optional(element) || /^[a-zA-Z_0-9]+$/.test(value);       
   }, "只能包含英文、数字、下划线等字符");
	
	//姓名校验
	jQuery.validator.addMethod("realNameCheck", function(value, element) {       
    return this.optional(element) || /^[\u4e00-\u9fa5a-zA-Z0-9 ]+$/.test(value);  //中文英文数字和空格等字符       
 }, "只能包含中文英文数字和空格等字符");
	
	//验证密码 6-18位由字符数字和特殊符号组成 排除空格..
    jQuery.validator.addMethod("checkPassword",function(value, element) {  
        var myreg = /^[^\s]{6,18}$/;  
        if (value != '') {if (!myreg.test(value)) {return false;}};  
        return true;}, "请输入有效密码,由6-18位字符数字和特殊符号组成!"); 
    
    jQuery.validator.addMethod( "EmailFormatCheck",function(value,element){       
    	  
        var myreg = /^[_a-zA-Z0-9\-]+(\.[_a-zA-Z0-9\-]*)*@[a-zA-Z0-9\-]+([\.][a-zA-Z0-9\-]+)+$/;  

        if(value !=''){if(!myreg.test(value)){return false;}};    

        return true;     

 } ,  " 请输入有效的E_mail"); 
    
	jQuery.validator.addMethod("roleSelectChecked", function(value, element) {  
		var res=true;
		if(-1 == $('#roleSelect').val()){
			res=false;
		}
        return res;       
   }, "请选择角色");

	
	/**
	 * 同步ajax传输
	 * @param url
	 * @param jsondata
	 */
	function fnAjaxPostSync(url,jsondata,func) {
			console.log("###@@@ jsondata="+jsondata);
			$.ajax( {
				"async": false,
				"type": "post", 
				"contentType": "application/json; charset=utf-8",
				"url": url, 
				"dataType": "json",
				"data": jsondata, 
				"success": func,
				"error": function (error) {
		            console.log(error);
		        }
			});
		}
	


	//保存
	$("#saveBtn").click(saveData);  //点击元素时会发生click事件，响应saveData函数
	function saveData() {
//		var dataCheckRes=DataCheck();	
		if(/*dataCheckRes*/$('#MyForm').valid()){
			var formData;
			var json; 

			var title=$("#modal-title").text();
			var url;
			if(title=="编辑!")
				{
					var id = $('#id').val();  
					formData = $("#MyForm").serializeJSON();   //Jquery将表单转化为json对象
					formData["id"] = id;
					formData["roleId"] = $('#roleSelect').val();
					json = JSON.stringify(formData);			
					url= "<c:url value='/user/edit'/>";
				}
				else{
					formData = $("#MyForm").serializeJSON();   //Jquery将表单转化为json对象
					formData["roleId"] = $('#roleSelect').val();
					json = JSON.stringify(formData);
					url = "<c:url value='/user/save'/>";
				}		
			
			fnAjaxPost(url,json,function(res){
				var obj = JSON.parse(JSON.stringify(res));		
				if (obj.success) {
//					alert(obj.success);
					msgBox(obj.success); 
					$("#modal-table").modal('hide');  //bootstrap手动隐藏一个模态框
					resetFrom();
					oTable.fnDraw();
//					$.gritter.add({
//						title: '测试!',
//						text: 'haha.',
//						class_name: 'gritter-success  gritter-light'
//					});
			
				} else {
					alert(obj.error);
				}
			});
		}	
	}
	
	//取消
	$("#cancelBtn").click(cancelData);  //点击元素时会发生click事件，响应saveData函数
	function cancelData() {
		validator.resetForm();
	}
	
	//新增
	$("#newBtn").click(newData);
	function newData() {
			$("#modal-title").html("新增!");
			$("#modal-table").draggable({
			      handle: ".modal-header"
			  });
			document.getElementById('psw').disabled = false;
			document.getElementById('loginname').disabled = false;  //add in 160126
			$("#loginname").val(null);
			$("#psw").val(null);
			
			$("#realname").val(null);  //姓名
			var gender=document.getElementsByName("gender");
			for(var i=0;i<gender.length;i++)
				{
					gender.item(i).checked=false;

				}	
			
			$("#mobile").val(null);  //手机号
			$("#email").val(null);  //电子邮件
			var status=document.getElementsByName("status");
			for(var i=0;i<status.length;i++)
				{
					status.item(i).checked=false;
				}
			$("#id").val(null);
	}
	

	/**
	* define datatables.
	**/
	var oTable;
	var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
	               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

		jQuery(function($) {	
			var url = "<c:url value='/user/listJson'/>";
			var colJson = [
							  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
							  {"mDataProp": "loginname", "sClass":"center","bSortable":true},
							  {"mDataProp": "gender", "sClass":"center","bSortable": false,"bSearchable": false },
							  {"mDataProp": "email", "sClass":"left","bSortable": true,"bSearchable": false },
							  {"mDataProp": "mobile", "sClass":"left","bSortable": true,"bSearchable": false },
							  {"mDataProp": "roleName", "sClass":"left","bSortable": false,"bSearchable": false },
							  {"mDataProp": "status", "sClass":"center","bSortable": false,"bSearchable": false,"mRender": statusRender },
							  {"mDataProp": "id", "sClass": "left","bSearchable": false,"bSortable": false,"mRender": opRender}
							];
			var callBackFunc = callAjaxFunc;		
			//初始化 datatables
			oTable = fnInitDataTables('#data-table',url,colJson,callBackFunc);

			function chkRender(data,type,full) {
				var loginname=JSON.stringify(full.loginname);				
				if(loginname!='"admin"')
				{
					var html = '<label class="position-relative">';
				    html += '<input id="id" name="normalCB" type="checkbox" class="ace" value="'+data+'" />';
				    html += '<span class="lbl"></span>';
				    html += '</label>';
				}
				else
				{
					var html = '<label class="position-relative">';
				    html += '</label>';			    
				}
				
				return html;
			}
/*			
			function chkRender(data,type,full) {
				var html = '<label class="position-relative">';
				    html += '<input id="id" type="checkbox" class="ace" value="'+data+'"/>';
				    html += '<span class="lbl"></span>';
				    html += '</label>';
				return html;
			}
*/			
			function opRender(data,type,full) {		
				var loginname=JSON.stringify(full.loginname);
				if(loginname!='"admin"')
				{
					var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
						<shiro:hasPermission name="user:u">
						+"<a title=\'更新\' class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"+
						"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
						</shiro:hasPermission>
						<shiro:hasPermission name="user:d">
						+"<a title=\'删除\' class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"+
						"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
						</shiro:hasPermission>
						+"</div>"	
				}
				else
				{
					var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
						<shiro:hasPermission name="user:u">
						+"<a title=\'更新\' class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"+
						"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
						</shiro:hasPermission>
						+"</div>"
/*						
					var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
						<shiro:hasPermission name="user:u">
						+"<a title=\'更新\' class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"+
						"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
						</shiro:hasPermission>
						<shiro:hasPermission name="user:d">
						+"<a title=\'删除禁止\' style=\'color: rgb(0, 0, 0);\'>"+
						"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
						</shiro:hasPermission>
						+"</div>"
*/						
				}
				
				return html;		
			}
/*			
			function opRender(data,type,full) {							
				var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
				<shiro:hasPermission name="user:u">
				+"<a title=\'更新\' class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"+
				"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
				</shiro:hasPermission>
				<shiro:hasPermission name="user:d">
				+"<a title=\'删除\' class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"+
				"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
				</shiro:hasPermission>
				+"</div>"
				return html;		
			}
*/
			
			function statusRender(data,type,full) {
				var html = '';
				if (data == '1') {
					html = '<span class="label label-sm label-success">生效</span>';
				} else {
					html = '<span class="label label-sm label-warning">禁用</span>';
				}			
				return html;		
			}
			
			//回调函数
			function callAjaxFunc( sSource, aoData, fnCallback ) {
				aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) });
			    //alert(JSON.stringify(aoData)); 
			    var url = sSource;
			    var json = { 'aoData': JSON.stringify(aoData) };
			    fnAjaxGet(url,json,function(resp) {
					fnCallback(resp);
				});		    
			}							
		})
	});
</script>
