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

<div class="row">
	<div class="col-xs-12">
		<div class="table-header">
	
			<shiro:hasPermission name="module:c">
			<button id="addBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
					<fmt:message key="add" />
			</button>
			</shiro:hasPermission>
			
			<shiro:hasPermission name="module:d">
			<button id="delBtn" class="btn btn-white btn-default btn-round">
				<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
			</button>
			</shiro:hasPermission>
		</div>

		<div>
			<table id="data-table"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center"><label class="position-relative">
								<input type="checkbox" class="ace" /> <span class="lbl"></span>
						</label></th>
						<th><fmt:message key="modulecode" /></th>
						<th><fmt:message key="modulename" /></th>
						<th><fmt:message key="moduledesc" /></th>
						<th><fmt:message key="module_seqno" /></th>
						<th><fmt:message key="status" /></th>
						<th><fmt:message key="operate" /></th>
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
							<span id="modal-title"><fmt:message key="op.success" />
</span>
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
								for="modulecode"><fmt:message key="modulecode" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="modulecode" name="modulecode"
									class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="modulename"><fmt:message key="modulename" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="modulename" name="modulename" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="moduledesc"><fmt:message key="moduledesc" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="moduledesc" name="moduledesc"
									class="col-xs-10 col-sm-5" />
									</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="seqno"><fmt:message key="module_seqno" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="seqno" name="seqno"
									class="col-xs-10 col-sm-5" />
									</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="isenable"><fmt:message key="status" /></label>
							<div class="col-sm-9">
								<div class="radio inline">
									<label>
										<input id="enable" name="isenable" type="radio" class="ace" value="1"/>	
										<span class="lbl"><fmt:message key="enable" /></span>								
									</label>
									
								</div>
		
								<div class="radio inline">
									<label>
										<input id="disable" name="isenable" type="radio" class="ace" value="0"/>
										<span class="lbl"><fmt:message key="disable" /></span>
									</label>
								</div>
							</div>
						</div>
						</form>
					</div>

					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
						</button>

						<button id="saveBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i><fmt:message key="confirm" />
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
	var validator = $("#MyForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	focusInvalid: false,
	ignore: "",
	rules: {
		modulecode: {
			stringCheck:true,
			required: true,
			maxlength:20
		},
		modulename: {
			required: true,
			maxlength:50
		},
		moduledesc: {
			required: true,
			maxlength:200
		},
		seqno: {
			required: true,
			numberCheck: true
		},

		isenable: {
			required: true
		}
	},

	messages: {
		modulecode: {
			required: "不能为空.",
			maxlength:"模块编码不能超过20个字符！"
		},
		modulename: {
			required: "不能为空.",
			maxlength:"模块名称不能超过50个字符！"
		},
		moduledesc: {
			required:"不能为空.",
			maxlength:"模块描述不能超过200个字符！"
		},
		seqno: {
			required: "不能为空."
		},
		isenable: "请选择状态。"
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

	jQuery.validator.addMethod("numberCheck", function(value, element) {       
	    return this.optional(element) || /^[0-9]+$/.test(value);       
	}, "只能输入数字!");
	
	jQuery.validator.addMethod("stringCheck", function(value, element) {       
        return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);       
   }, "只能包含英文、数字、下划线等字符");
	//删除方法
	function deleteObj(ids){	
		var url = "<c:url value='/module/delete'/>";
		var json = {"idList":ids};
		fnAjaxPost(url,JSON.stringify(json),function(res){
			
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
				msgBox(obj.success);
				oTable.fnDraw();
		
			} else {
				errMsgBox(obj.error);
			}
			
		});
	}

	//批量删除
	$('#delBtn').click(batchDelete);
	function batchDelete() {
		var ids = fnGetIDs('#data-table');
		if (ids.length > 0) {
			bootbox.confirm("确定删除吗? ", function(result) {
				if(result) {
					deleteObj(ids);
				}
			});
			 	
		} else {
	        errMsgBox('请选择一条记录操作。');
	    }
	}
	
	//删除一条
	function delOne(ids) {
		bootbox.confirm("确定删除吗? ", function(result) {
			if(result) {
				var idList = new Array();
				idList.push(ids);
				//alert(idList);
				deleteObj(idList);
			}
		});
	}
	
	//更新编辑
	function updateObj(json) {
		// init data
		validator.resetForm();
		resetFrom();
		// init data
		$("#modal-title").html("编辑!");
		$("#modal-table").modal("show");
		//alert(decodeJson(json));
		var obj = JSON.parse(decodeJson(json));		
		$("#modulecode").val(obj.modulecode);
		$("#modulename").val(obj.modulename);
		$("#moduledesc").val(obj.moduledesc);
		$("#seqno").val(obj.seqno);
		if (obj.isenable == 1)
		{
			$("#enable").attr("checked","checked");
		}
		else
		{
			$("#disable").attr("checked","checked");
		}
		$("#id").val(obj.id);
	}
	
	
	//新增
	$('#addBtn').click(addData);
	function addData() {
		validator.resetForm();
		resetFrom();
		$('#id').val(null);
		$("#modal-title").html("新增!");
		$("#modal-table").modal("show");
	}
	

	//保存
	$("#saveBtn").click(saveData);
	function saveData() {
		if(!$('#MyForm').valid()) {
			return;
		}

		var id = $('#id').val();
		var formData = $("#MyForm").serializeJSON();
		formData.id = id;
		var json = JSON.stringify(formData);
		//alert(json);
		var url = "<c:url value='/module/save'/>";		
		
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
				msgBox(obj.success);
				$("#modal-table").modal('hide');
				resetFrom();
				oTable.fnDraw();
		
			} else {
				errMsgBox(obj.error);
			}
		});
		
	}


	//编辑
	/*
	$("#editBtn").click(updateSelectObj);
	function updateSelectObj() {
		var ids = fnGetIDs('#data-table');
		if (ids.length==1) {
	 		$("#modal-table").modal("show");
			$("#modal-title").html("编辑!");
	       	$("#loginname").val(selected.loginname); 		       
		
	    } else if(ids.length>1){
			alert('只能选择一条数据编辑');
		} else {
	        alert('请选择一条记录操作。');
	    }
	}
	//*/



	/**
	* define datatables.
	**/
	var oTable;
	var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
	               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

		jQuery(function($) {	
			var url = "<c:url value='/module/listJson'/>";
			var colJson = [
							  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
							  {"mDataProp": "modulecode", "sClass":"center","bSortable":true},
							  {"mDataProp": "modulename", "sClass":"center","bSortable": false,"bSearchable": false },
							  {"mDataProp": "moduledesc", "sClass":"left","bSortable": true,"bSearchable": false },
							  {"mDataProp": "seqno", "sClass":"left","bSortable": true,"bSearchable": false },
							  {"mDataProp": "isenable", "sClass":"center","bSortable": false,"bSearchable": false,"mRender": statusRender },
							  {"mDataProp": "id", "sClass": "left","bSearchable": false,"bSortable": false,"mRender": opRender}
							];
			var callBackFunc = callAjaxFunc;		
			//初始化 datatables
			oTable = fnInitDataTables('#data-table',url,colJson,callBackFunc);

			function chkRender(data,type,full) {
				var html = '<label class="position-relative">';
				    html += '<input id="id" type="checkbox" class="ace" value="'+data+'"/>';
				    html += '<span class="lbl"></span>';
				    html += '</label>';
				return html;
			}
			
			
			function opRender(data,type,full) {			
				var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
				<shiro:hasPermission name="ssmodule:u">+
				"<a class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\')>"+
				"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
				</shiro:hasPermission>
				<shiro:hasPermission name="module:d">+
				"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"+
				"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
				</shiro:hasPermission>+"</div>";
				return html;		
			}
			
			function statusRender(data,type,full) {
				var html = '';
				//alert(data);
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
