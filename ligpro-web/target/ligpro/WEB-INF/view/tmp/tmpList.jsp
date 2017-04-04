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
	href="<c:url value='/bootstrap/assets/css/fileinput.min.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/bootstrap-select.min.css'/>" />

<div class="row">
	<div class="col-xs-2">
			<div class="widget-box widget-color-blue2">
				<div class="widget-header">
					<shiro:hasPermission name="tmp:c">
						<button id="addNodeBtn" class="btn btn-white btn-info btn-round">
							<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 新增
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="tmp:u">
						<button id="editNodeBtn" class="btn btn-white btn-default btn-round">
							<i class="ace-icon fa fa-pencil-square-o red2"></i> 编辑
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="tmp:d">
						<button id="delNodeBtn" class="btn btn-white btn-default btn-round">
							<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> 删除
						</button>
					</shiro:hasPermission>
				</div>

				<div class="widget-body">
					<div class="widget-main padding-8" id="tree_div">
						<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>
					</div>
				</div>
			</div>
	</div>
	<div class="col-xs-10">
		<div class="table-header">
			<shiro:hasPermission name="tmp:c">
				<button id="newBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 新增
				</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="tmp:d">
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
								<input type="checkbox" class="ace" /> <span class="lbl"></span>
						</label></th>
						<th><fmt:message key="tmp_name" /></th>
						<th><fmt:message key="tmp_type" /></th>
						<th><fmt:message key="tmp_url" /></th>
						<th><fmt:message key="tmp_operate" /></th>
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
					<form id="MyForm" method="post" class="form-horizontal" role="form" enctype="multipart/form-data">
						<div class="form-group">
							<div class="col-sm-9">
								<input type="text" id="id" name="id"
									class="hidden" />
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="name"><fmt:message key="tmp_name" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="name" name="name"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
					 
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="menuname"><fmt:message key="tmp_type" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
									<select id="tmp_type" class="selectpicker" data-size="6" data-style="btn btn-primary">
										<option value=0><fmt:message key="tmp_type_home"/></option>
										<option value=1><fmt:message key="tmp_type_grade_1"/></option>
										<option value=2><fmt:message key="tmp_type_grade_2"/></option>
										<option value=3><fmt:message key="tmp_type_grade_3"/></option>
										<option value=4><fmt:message key="tmp_type_grade_4"/></option>
										<option value=5><fmt:message key="tmp_type_grade_5"/></option>
									</select>
								</div>
							</div>
						</div>
					 	
						<div class="space-4"></div>
						<div class="form-group" id="upload_file_div">
							<label class="col-sm-3 control-label no-padding-right"
								for="url"><fmt:message key="tmp_url" /></label>
							<div class="col-sm-9">
								<!--  <input type="file" id="url" name="url"
									class="col-xs-10 col-sm-5" />-->
								<input id="url" type="file" class="file" name="file"
								data-preview-file-type="any" multiple
								data-upload-url="<c:url value='/tmp/upload'/>">
							</div>
						</div>
						</form>
					</div>

					<div class="modal-footer no-margin-top">
						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
						</button>
						<button id="saveBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i> <fmt:message key="confirm" />
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
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

</div>
<!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">

$('.selectpicker').selectpicker();


$("#modal-table").draggable({
    handle: ".modal-header"
});
$("#modal-table-resource-group").draggable({
    handle: ".modal-header"
});


var globalGroupId = null;
var globalFileUrl = '';
var remoteSource = null;


jQuery.validator.addMethod("stringCheck", function(value, element) {       
    return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);       
}, "只能包含英文、数字、下划线等字符");

//树形添加验证
var validator = $("#MyResourceGroupForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	focusInvalid: false,
	ignore: "",
	rules: {
		groupname: {
			required: true,maxlength:200
		},
		groupdesc: {
			required: true,maxlength:600
		}
	},

	messages: {
		groupname: {
			required: "不能为空.",
			maxlength:"长度不能超过200个字符."
		},
		groupdesc: {
			required: "不能为空.",
			maxlength:"长度不能超过600个字符."
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

//模板添加验证
var validatorTmp = $("#MyForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	focusInvalid: false,
	ignore: "",
	rules: {
		name: {
			required: true,maxlength:100
		}
	},

	messages: {
		name: {
			required: "不能为空.",
			maxlength:"长度不能超过100个字符."
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
	
	//删除方法
	function deleteObj(ids){	
		var url = "<c:url value='/tmp/delete'/>";
		var json = {"idList":ids};
		
		fnAjaxPost(url,JSON.stringify(json),function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
				oTable.fnDraw();
				msgBox(obj.success);
			} else {
				errMsgBox(obj.error);
			}
		});	
	}
	
	//批量删除
	$('#delBtn').click(batchDelete);
	function batchDelete() {
		var ids = fnGetIDs('#data-table');
		var json = {"idList":ids};
		if (ids.length > 0) {
			bootbox.confirm("确定删除吗? ", function(result) {
				if(result) {
					deleteObj(ids);					
				}
			});
			 	
		} else {
	        bootbox.alert('请选择一条记录操作。');
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
	
	//更新编辑
	function updateObj(json) {
		$("#modal-title").html("编辑!");
		var obj = JSON.parse(decodeJson(json));
		$('#name').val(obj.name);
		$('#id').val(obj.id);
		$('#tmp_type').selectpicker('val', obj.type);
		$('#upload_file_div').hide();
	}
	$('#newBtn').click(function(){
		
		var items = $('#tree1').tree('selectedItems');
		if(items.length > 0 && items[0].type == 'item'){
			$("#url").fileinput({
				ajaxSettings:{
					'success':mysuccess
				}
			});
			$('#name').val('');
			$('#tmp_type').selectpicker('val', 0);
			$("#modal-table").modal('show');
		}else{
			bootbox.alert("请选择一个菜单结点!");
			return;
		}
	})
	function mysuccess(data, textStatus, jqXHR){
		globalFileUrl += data + "|";
	}
	//保存
	$("#saveBtn").click(saveData);
	function saveData() {

		if(!$('#MyForm').valid()) {
			return;
		}
		var title=$("#modal-title").text();
		var urlName = null;
		if(title=="新增"){
			if(globalFileUrl.length == 0){
				bootbox.alert("请选择模板！");
				return;
			}
			urlName = globalFileUrl.substring(0,globalFileUrl.lastIndexOf('|'));
		}
		
		var formData;
		var json; 
		var url;
		var groupId = globalGroupId;
		
		if(title=="编辑!"){
				var id = $('#id').val();  
				formData = $("#MyForm").serializeJSON();   //Jquery将表单转化为json对象
				formData.id=id;
				formData.groupid=groupId;
				formData.type=$('#tmp_type').val();
				json = JSON.stringify(formData);			
				url= "<c:url value='/tmp/save'/>";
		}else{
				formData = $("#MyForm").serializeJSON(); 
				formData.id=id;
				formData.groupid=groupId;
				formData.url=urlName;
				formData.type=$('#tmp_type').val();
				json = JSON.stringify(formData);
				url = "<c:url value='/tmp/save'/>";
		}		
		console.log(json);
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
				$("#modal-table").modal('hide');
				resetFrom();
				oTable.fnDraw();
				msgBox(obj.success);
				globalFileUrl = '';
			} else {
				errMsgBox(obj.error);
			}
		});
	}		
	
	//添加节点
	$("#addNodeBtn").click(addGroupNode);
	function addGroupNode() {
		validator.resetForm();
		resetFrom();
		$("#modal-title-resource-group").html("新增!");
		$('#modal-table-resource-group').modal('show');
		$('#groupid').val(null);
		var groupType = 5;
		$('#grouptype').val(groupType);
		
		var items = $('#tree1').tree('selectedItems');
		var json = JSON.stringify(items);
		
		var item = null;
		for(var i in items) {
			item = items[i];
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
		formData.grouptype = 5;

		var json = JSON.stringify(formData);
		var url = "<c:url value='/res/saveResourceGroup'/>";		
		
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
				$("#modal-table-resource-group").modal('hide');
				resetFrom();
				refreshTreeItem();	
				msgBox(obj.success);
			} else {
				errMsgBox(obj.error);
			}
		});
	}

	function refreshTreeItem() {
		$('#tree_div').html('');
		$('#tree_div').html('<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>');
		$('#tree1').ace_tree({
		   'dataSource': remoteSource,
		   'multiSelect': false,
		   'cacheItems': true,
		   'open-icon' : 'ace-icon tree-minus',
		   'close-icon' : 'ace-icon tree-plus',
		   'selectable' : true,
		   'selected-icon' : 'ace-icon fa fa-check',
		   'unselected-icon' : 'ace-icon fa fa-times',
		   'loadingHTML' : '<div class="tree-loading"><i class="ace-icon fa fa-refresh fa-spin blue"></i></div>',
		   'selectable' : true ,  
		   'folderSelect': true
		  });	 
		$('#tree1').on('selected.fu.tree.item', function(e) {
			var items = $('#tree1').tree('selectedItems');
			var item = items[0];
			if(item.type == 'item'){
				globalGroupId = item.id;
				oTable.fnDraw();
			}else{
			}
        });	
	}

	//编辑
	$("#editNodeBtn").click(updateSelectObj);
	function updateSelectObj() {
		validator.resetForm();
		var items = $('#tree1').tree('selectedItems');
		var json = JSON.stringify(items);
		var item = null;
		for(var i in items) {
			item = items[i];
		}
		//只有根节点才需要选择模块
		if (item != null)
		{
			$('#groupid').val(item.id);
			$('#parentgroupid').val(item.parentgroupid);
			$('#groupdesc').val(item.groupdesc);
			$('#groupname').val(item.groupname);
			$('#grouptype').val(item.grouptype);
		}
		else
		{
			bootbox.alert('请选择一个菜单结点!');
			return;
		}
		$("#modal-title-resource-group").html("编辑!");
		$('#modal-table-resource-group').modal('show');
	}

	//删除
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
							refreshTreeItem();
							msgBox(obj.success);
						} else {
							errMsgBox(obj.error);
						}
					});				
				}
			});
		}
		else
		{
			bootbox.alert('请选择一个编组结点!');
		}

	}
	/**
	* define datatables.
	**/
	var oTable;
	var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
	               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>",
	               "<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		jQuery(function($) {	
			var url = "<c:url value='/tmp/listJson'/>";
			var colJson = [
							  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
							  {"mDataProp": "name", "sClass":"center","bSortable":true},
							  {"mDataProp": "type", "sClass":"center","bSortable": false,"bSearchable": false,"mRender": typeRender },
							  {"mDataProp": "url", "sClass":"left","bSortable": true,"bSearchable": false },
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
				<shiro:hasPermission name="tmp:u">+
				"<a class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"+
				"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
				</shiro:hasPermission>
				<shiro:hasPermission name="tmp:d">+
				"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"+
				"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
				</shiro:hasPermission>+
				"</div>";
				return html;		
			}
			function typeRender(data,type,full) {
				var html = '';
				switch(data){
				case 0 : html = '<fmt:message key="tmp_type_home" />';break;
				case 1 : html = '<fmt:message key="tmp_type_grade_1" />';break;
				case 2 : html = '<fmt:message key="tmp_type_grade_2" />';break;
				case 3 : html = '<fmt:message key="tmp_type_grade_3" />';break;
				case 4 : html = '<fmt:message key="tmp_type_grade_4" />';break;
				case 5 : html = '<fmt:message key="tmp_type_grade_5" />';break;
				default: html = '';
				}
				return html;		
			}
			
			//回调函数
			function callAjaxFunc( sSource, aoData, fnCallback ) {
				aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) });
			    var url = sSource;
			    var json = { 'aoData': JSON.stringify(aoData), 'groupid': globalGroupId};
			    fnAjaxGet(url,json,function(resp) {
					fnCallback(resp);
				});		    
			}			


			//树形列表
			remoteSource = function(options, callback) {	
				var parent_id = null
				if( !('text' in options || 'type' in options) ){
					parent_id = 0;//load first level data
				}
				else if('type' in options && options['type'] == 'folder') {//it has children
					if('additionalParameters' in options && 'children' in options.additionalParameters)
						parent_id = options.additionalParameters['id']
				}	
				
				var url = "<c:url value='/res/treeListJson'/>";
				
				var json = {'id':parent_id,'grouptype': 5};		
				
				if(parent_id !== null) {
					fnAjaxPost(url,JSON.stringify(json),function(resp){
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
			$('#tree1').on('selected.fu.tree.item', function(e) {
				var items = $('#tree1').tree('selectedItems');
				var item = items[0];
				if(item.type == 'item'){
					globalGroupId = item.id;
					oTable.fnDraw();
				}else{
				}
	        });	
		})
	});
</script>
