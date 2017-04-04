<%@page import="java.io.Console"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<title><fmt:message key="backStage_name" /></title>
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/bootstrap-select.min.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/fileinput.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->

		<!-- #section:plugins/fuelux.treeview -->
		<div class="row">
			<div class="col-sm-2">
				<div class="widget-box widget-color-blue2">
					<div class="widget-header">
						<c:if test="${type == 2}">
					       	<shiro:hasPermission name="flash:c">
					       	<button id="addNodeBtn" class="btn btn-white btn-info btn-round">
								<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
								<fmt:message key="add" />
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="flash:u">
							<button id="editNodeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-pencil-square-o red2"></i> 编辑
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="flash:d">
							<button id="delNodeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
							</button>
							</shiro:hasPermission>
						</c:if>
						
						<c:if test="${type == 3}">
					       	<shiro:hasPermission name="video:c">
					       	<button id="addNodeBtn" class="btn btn-white btn-info btn-round">
								<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
								<fmt:message key="add" />
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="video:u">
							<button id="editNodeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-pencil-square-o red2"></i> 编辑
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="video:d">
							<button id="delNodeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
							</button>
							</shiro:hasPermission>
						</c:if>
						
						<c:if test="${type == 4}">
					       	<shiro:hasPermission name="file:c">
					       	<button id="addNodeBtn" class="btn btn-white btn-info btn-round">
								<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
								<fmt:message key="add" />
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="file:u">
							<button id="editNodeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-pencil-square-o red2"></i> 编辑
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="file:d">
							<button id="delNodeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
							</button>
							</shiro:hasPermission>
						</c:if>
					</div>

					<div class="widget-body">
						<div class="widget-main padding-8">
							<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-10">
				<div class="table-header">
						<c:if test="${type == 2}">
					       	<shiro:hasPermission name="flash:c">
					       	<button id="upLoadBtn" class="btn btn-white btn-info btn-round">
									<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
									<fmt:message key="uploadfile" />
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="flash:d">
							<button id="removeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="remove" />
							</button>
							</shiro:hasPermission>
						</c:if>
						
						<c:if test="${type == 3}">
					       	<shiro:hasPermission name="video:c">
					       	<button id="upLoadBtn" class="btn btn-white btn-info btn-round">
									<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
									<fmt:message key="uploadfile" />
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="video:d">
							<button id="removeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="remove" />
							</button>
							</shiro:hasPermission>
						</c:if>
						
						<c:if test="${type == 4}">
					       	<shiro:hasPermission name="file:c">
							<button id="upLoadBtn" class="btn btn-white btn-info btn-round">
									<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
									<fmt:message key="uploadfile" />
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="file:d">
							<button id="removeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="remove" />
							</button>
							</shiro:hasPermission>
						</c:if>							

		

				</div>
				
				<div id="show-data-table">
					<table id="data-table"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th class="center"><label class="position-relative">
										<input type="checkbox" class="ace" /> <span class="lbl"></span>
								</label></th>
								<th><fmt:message key="restype" /></th>
								<th><fmt:message key="fileurl" /></th>
								<th><fmt:message key="operate" /></th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
			</div>
		</div>

		<div id="modal-table-resource-group" class="modal fade" tabindex="-1">		
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title-resource-group">新增</span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
					<form id="MyResourceGroupForm" method="post" class="form-horizontal" role="form">
						<div class="form-group">
							<div class="col-sm-9">
								<input type="text" id="groupid" name="id" class="hidden" />
								<input type="text" id="parentgroupid" name="parentgroupid" class="hidden" />
								<input type="text" id="grouptype" name="grouptype" class="hidden" />
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="groupname">编组名称</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="groupname" name="groupname" class="col-xs-10 col-sm-5"/>
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="groupdesc">编组描述</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="groupdesc" name="groupdesc" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="menuUrl">菜单地址</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="menuUrl" name="menuUrl" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						</form>
					</div>

					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
						</button>

						<button id="saveGroupBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i><fmt:message key="confirm" />
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->


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
						<form id="MyResourceForm" method="post" class="form-horizontal" enctype="multipart/form-data">
							<div class="form-group">
								<div class="col-sm-9" style="width:100%">
									<div id="fileinput-div">
										<input id="upLoadInput" type="file" class="file" name="file" multiple data-preview-file-type="any" data-upload-url="<c:url value='/res/upload'/>">
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->


</div>
		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
$(function(){
	$('.selectpicker').selectpicker();
	$.ajax({
		type:'POST',
		url: "/hxdsite-web/module/queryAll",
		cache:false,
		dataType: 'json',
		success: function(data){
			var option = new Option("选择模块",-1);
			$('#moduleSelect').append(option);
			//$('#moduleSelect').append('<option value=-1>选择模块</option>');
			for(var i = 0;i < data.length; i++) {
				var item = new Option(data[i].modulename,data[i].id);
				$('#moduleSelect').append(item);
				//$('#moduleSelect').append('<option value="' + data[i].id + '">' + data[i].modulename + '</option>');
            }
			$('#moduleSelect').selectpicker('val', -1);
			$('#moduleSelect').selectpicker('refresh');
		}
	});
});


var validator = $("#MyResourceGroupForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	focusInvalid: false,
	ignore: "",
	rules: {
		groupname: {
			required: true,
			maxlength:200
		},
		groupdesc: {
			required: true,
			maxlength:600
		},
		menuUrl:{
			maxlength:200
		}
	},

	messages: {
		groupname: {
			required: "不能为空.",
			maxlength:"分组名称不能超过200个字符！"
		},
		groupdesc: {
			required: "不能为空.",
			maxlength:"分组描述不能超过600个字符！"
		},
		menuUrl:{
			maxlength:"菜单地址不能超过200个字符!"
		}
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

function ajaxgo(url) {
	
}

var globalGroupID = null;

//编辑
$("#upLoadBtn").click(upLoader);
function upLoader() {
	var items = $('#tree1').tree('selectedItems');
	var json = JSON.stringify(items);
	////alert(json);

	var selectedItem = null;
	var groupid = null;
	for(var i in items) {
		selectedItem = items[i];
	}
	
	if (selectedItem == null)
	{
		//errMsgBox("请选择一个分组!");
		bootbox.alert("请选择一个分组上传!");
		return;
	}
	else
	{
		var type = ${type};
		var myTypes = [];
		var myMaxFileCount = 10;
		switch(type)
		{
		case 2:
			myTypes= ['flash'];break;
		case 3:
			myMaxFileCount = 2;
			myTypes= ['video','audio'];break;
		case 4:
			myTypes= null;break;
			default:
				break;
		
		}
		var json = {"restype":type,"groupid":selectedItem.id,"bigpicurl":selectedItem.groupname};
		$('#fileinput-div').html('');
		$('#fileinput-div').append('<input id="upLoadInput" type="file" class="file" name="file" multiple data-preview-file-type="any" data-upload-url="<c:url value='/res/upload'/>">');
		$("#upLoadInput").fileinput({
			uploadExtraData:{"extraData":JSON.stringify(json)},
			allowedFileTypes:myTypes,
			maxFileCount:myMaxFileCount,
			ajaxSettings:{
				'success':mysuccess
			}
		});
		$('#modal-table').modal('show');
	}
}

function mysuccess()
{
	$('#modal-table').modal('hide');
	oTable.fnDraw();
}


//编辑
$("#delNodeBtn").click(deleteSelectObj);
function deleteSelectObj() {

	var items = $('#tree1').tree('selectedItems');
	var json = JSON.stringify(items);
	////alert(json);
	
	var id = '';
	for(var i in items) {
		var item = items[i];
		id = item.id;
	}
	
	if (id != '')
	{
		bootbox.confirm("确定删除吗? ", function(result) {
			if(result) {
				var url = "<c:url value='/res/deleteResourceGroup'/>";
				var json = {"id":id};
				
				fnAjaxPost(url,JSON.stringify(json),function(res){
					var obj = JSON.parse(JSON.stringify(res));		
					if (obj.success) {
						msgBox(obj.success);
						refreshTreeItem();
				
					} else {
						errMsgBox(obj.error);
					}
				});				
			}
		});
	}
	else
	{
		errMsgBox('请选择一个编组结点!');
	}

}

//编辑
$("#editNodeBtn").click(updateSelectObj);
function updateSelectObj() {
	validator.resetForm();
	resetFrom();
	var items = $('#tree1').tree('selectedItems');
	var json = JSON.stringify(items);
	////alert(json);
	
	var item = null;
	for(var i in items) {
		item = items[i];
		//pid = item.id;
	}

	//只有根节点才需要选择模块
	if (item != null)
	{
		//alert(item.menuUrl);
		$('#groupid').val(item.id);
		$('#parentgroupid').val(item.parentgroupid);
		$('#groupdesc').val(item.groupdesc);
		$('#menuUrl').val(item.menuUrl);
		$('#groupname').val(item.groupname);
		$('#grouptype').val(item.grouptype);
	}
	else
	{
		errMsgBox('请选择一个菜单结点!');
		return;
	}
	
	$("#modal-title-resource-group").html("编辑!");
	
	$('#modal-table-resource-group').modal('show');
}

//添加节点
$("#addNodeBtn").click(addGroupNode);
function addGroupNode() {
	validator.resetForm();
	resetFrom();
	//alert('@@@@@@123');
	$("#modal-title-resource-group").html("新增!");
	$('#modal-table-resource-group').modal('show');
	$('#groupid').val(null);
	var groupType = ${type};
	$('#grouptype').val(groupType);
	//清空列表项
	//*/
	
	var items = $('#tree1').tree('selectedItems');
	var json = JSON.stringify(items);
	////alert(json);
	
	var item = null;
	for(var i in items) {
		item = items[i];
		//pid = item.id;
	}

	//只有根节点才需要选择模块
	if (item != null)
	{
		$('#parentgroupid').val(item.id);
		
	}
	else
	{
		$('#parentgroupid').val(0);
	}

}


function refreshTreeItem() {

	window.location.reload();
}

//保存
$("#saveGroupBtn").click(saveGroupData);
function saveGroupData() {
	if(!$('#MyResourceGroupForm').valid()) {
		return;
	}

	
	var groupid = $('#groupid').val();
	var pid = $('#parentgroupid').val();
	var formData = $("#MyResourceGroupForm").serializeJSON();
	formData.id = groupid;
	formData.parentgroupid = pid;

	var json = JSON.stringify(formData);
	
	//json.push({"moduleid":moduleId});
	
	//json.push({"templateid":templateId});
	//alert(json);
	var url = "<c:url value='/res/saveResourceGroup'/>";		
	
	fnAjaxPost(url,json,function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		if (obj.success) {
			msgBox(obj.success);
			$("#modal-table-resource-group").modal('hide');
			resetFrom();
			refreshTreeItem();	
		} else {
			errMsgBox(obj.error);
		}
	});
	
}

//删除方法
function deleteObj(ids){	
	var url = "<c:url value='/res/delete'/>";
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
$('#removeBtn').click(batchDelete);
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
			deleteObj(idList);
		}
	});
}

	
	/**
	* define datatables and tree.
	**/
	
	//*
	var oTable;
	var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
	               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>",
	               "<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

		jQuery(function($) {
			//var dataUrlStr = $('#dataUrlStr').val();
			var url = "<c:url value='/res/listJson'/>";
			var colJson = [
							  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
							  {"mDataProp": "restype", "sClass":"center","bSortable":true, "mRender": typeRender},
							  {"mDataProp": "resname", "sClass":"center","bSortable": false,"bSearchable": false },
							  {"mDataProp": "id", "sClass": "left","bSearchable": false,"bSortable": false,"mRender": opRender}
							];		
			//初始化 datatables
			var callBackFunc = callAjaxFunc;
			oTable = fnInitDataTables('#data-table',url,colJson,callBackFunc);
			
			function chkRender(data,type,full) {
				var html = '<label class="position-relative">';
				    html += '<input id="id" type="checkbox" class="ace" value="'+data+'"/>';
				    html += '<span class="lbl"></span>';
				    html += '</label>';
				return html;
			}
			
			function typeRender(data,type,full) {
				var info = null;
				switch(data)
				{
					case 1:
						info = "图片";break;
					case 2:
						info = "flash";break;
					case 3:
						info = "影音";break;
					case 4:
						info = "附件";break;
					default: info = "数据出错";
				}
				return info;
			}
			
			
			function opRender(data,type,full) {			
				var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
					<c:if test="${type == 2}">					
						<shiro:hasPermission name="flash:d">
						+"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
						+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
						</shiro:hasPermission>
						
					</c:if>
					
					<c:if test="${type == 3}">						
						<shiro:hasPermission name="video:d">
						+"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
						+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
						</shiro:hasPermission>
						
					</c:if>
					
					<c:if test="${type == 4}">						
						<shiro:hasPermission name="file:d">
						+"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
						+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
						</shiro:hasPermission>
					</c:if>
					+"</div>";
				return html;		
			}
			
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
				var type = ${type};
				aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) }); 
			    var url = sSource;
			    var json = { 'aoData': JSON.stringify(aoData),"restype": type, "groupid":globalGroupID};
			    fnAjaxGet(url,json,function(resp) {
			    	//alert(JSON.stringify(resp));
					fnCallback(resp);
				});	
			}
			
			
			var remoteSource = function(options, callback) {	
				var parent_id = null
				if( !('text' in options || 'type' in options) ){
					parent_id = 0;//load first level data
				}
				else if('type' in options && options['type'] == 'folder') {//it has children
					if('additionalParameters' in options && 'children' in options.additionalParameters)
						parent_id = options.additionalParameters['id']
				}	
				
				var url = "<c:url value='/res/treeListJson'/>";
				var grouptype = ${type};
				var json = {'id':parent_id,'grouptype':grouptype};		
				
				////alert(JSON.stringify(json));
				
				if(parent_id !== null) {
					fnAjaxPost(url,JSON.stringify(json),function(resp){
						//alert(JSON.stringify(resp));
						callback({ data: resp })
					});	
				}			
					
			}
		
			$('#tree1').ace_tree({
				'dataSource': remoteSource, //sampleData['dataSource1'],
				'multiSelect': false,
				'cacheItems': true,
				'open-icon' : 'ace-icon tree-minus',
				'close-icon' : 'ace-icon tree-plus',
				'selectable' : true,
				'selected-icon' : 'ace-icon fa fa-check',
				'unselected-icon' : 'ace-icon fa fa-times',
				'loadingHTML' : '<div class="tree-loading"><i class="ace-icon fa fa-refresh fa-spin blue"></i></div>',
				'selectable' : true ,  
				'folderSelect': true
			});
			
		
		
			//避免关闭包结点时也刷新数据
			var selectedId = null;
		
			$('#tree1').on('selected.fu.tree', function(e) {
				var items = $('#tree1').tree('selectedItems');
				var json = JSON.stringify(items);
				////alert(json);
				
				var item = null;
				for(var i in items) {
					item = items[i];
					//pid = item.id;
				}
				
				if (item != null)
				{
					if (selectedId != item.id)
					{
						//alert(item.id);
						selectedId = item.id;
						globalGroupID = item.id;
						oTable.fnDraw();
						//refreshDataTable(selectedId);
						
					}
				}
				else
				{
					//alert('123');
				}
				
			});
			
			$('#tree1').on('deselected.fu.tree', function(e) {
				var items = $('#tree1').tree('selectedItems');
				var json = JSON.stringify(items);
				////alert(json);
				
				var item = null;
				for(var i in items) {
					item = items[i];
					//pid = item.id;
				}
				
				if (item == null)
				{
					globalGroupID = null;
					oTable.fnDraw();
					//refreshDataTable(null);
					selectedId = null;
				}
				
			});
					
		
		})
	});
	
	//*/
</script>
