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
	href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->

		<!-- #section:plugins/fuelux.treeview -->
		<div class="row">
			<div class="col-sm-12">
				<div class="widget-box widget-color-blue2">
					<div class="widget-header">
						<shiro:hasPermission name="menu:c">
						<button id="addNode" class="btn btn-white btn-info btn-round">
							<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 新增节点
						</button>
						</shiro:hasPermission>
						
						<shiro:hasPermission name="menu:u">
						<button id="editBtn" class="btn btn-white btn-default btn-round">
							<i class="ace-icon fa fa-pencil-square-o red2"></i> 编辑
						</button>
						</shiro:hasPermission>
						
						<shiro:hasPermission name="menu:d">
						<button id="delBtn" class="btn btn-white btn-default btn-round">
							<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> 删除
						</button>
						</shiro:hasPermission>
					</div>

					<div class="widget-body">
						<div class="widget-main padding-8">
							<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>
						</div>
					</div>
				</div>
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
								<input type="text" id="id" name="id" class="hidden" />
								<input type="text" id="parentmenuid" name="parentmenuid" class="hidden" />
								<input type="text" id="moduleid" name="moduleid" class="hidden" />
								<input type="text" id="templateid" name="templateid" class="hidden" />
							</div>
						</div>
						
						<!-- 
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="menuname">所属栏目</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<select id="moduleSelect" class="selectpicker show-tick" data-size="5" data-style="btn btn-primary">
									</select>
								</div>
							</div>
						</div>
						 -->
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="menuname">菜单名称</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="menuname" name="menuname" class="col-xs-10 col-sm-5"/>
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="menucode">菜单编码</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="menucode" name="menucode" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="menuurl">菜单地址</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="menuurl" name="menuurl" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="menuname">模板ID</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<select id="templateSelect" onchange="onSelectTmp()" class="selectpicker show-tick" data-size="5" data-style="btn btn-primary">
										<!-- 
										<option value=1>模板1</option>
										<option value=2>模板2</option>
										<option value=3>模板3</option>
										 -->
									</select>
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="templateurl">模板地址</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="templateurl" name="templateurl" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="seqno">排序号</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="seqno" name="seqno" class="col-xs-10 col-sm-5" />
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
		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
var globalTempData = null;
//var globaltemplateurl = null;
$(function(){
	$('.selectpicker').selectpicker();
	/*
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
	
	*/
	$.ajax({
		type:'POST',
		url: "<c:url value='/tmp/queryAll'/>",
		cache:false,
		dataType: 'json',
		success: function(data){
			globalTempData = data;
			var option = new Option("选择模板",-1);
			$('#templateSelect').append(option);
			for(var i = 0;i < data.length; i++) {
				var item = new Option(data[i].name,data[i].id);
				$('#templateSelect').append(item);
            }
			$('#templateSelect').selectpicker('val', -1);
			$('#templateSelect').selectpicker('refresh');
		}
	});
});

//选择模板的时候更新模板地址
function onSelectTmp()
{
	$("#templateurl").attr("disabled",false);
	var templateObj = document.getElementById("templateSelect");
	var templateId = templateObj.value;
	if (templateId == -1)
	{
		$("#templateurl").val(null);
	}
	else
	{
		for(var i = 0;i < globalTempData.length; i++) {
			if (globalTempData[i].id == templateId)
			{
				//globaltemplateurl = globalTempData[i].url;
				$('#templateurl').val(globalTempData[i].url);
				break;
			}
        }
	}
	
	$("#templateurl").attr("disabled",true);
		
}
//删除
$("#delBtn").click(deleteSelectObj);
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
				var url = "<c:url value='/menu/delete'/>";
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
		errMsgBox('请选择一个菜单结点!');
	}
}

//编辑
$("#editBtn").click(updateSelectObj);
function updateSelectObj() {
	//$("#moduleSelect").attr("disabled",false);
	$("#templateSelect").attr("disabled",false);
	$("#templateurl").attr("disabled",true);
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
		$('#id').val(item.id);
		//$("#moduleSelect").selectpicker('val',item.moduleid);
		$("#templateSelect").selectpicker('val',item.templateid);
		//$("#templateSelect").val(item.templateid);
		$('#parentmenuid').val(item.parentmenuid);
		$('#menucode').val(item.menucode);
		$('#menuname').val(item.menuname);
		$('#menuurl').val(item.menuurl);
		$('#templateurl').val(item.templateurl);
		$('#seqno').val(item.seqno);
		if (item.isenable == 1)
		{
			//alert('1');
			$("#enable").attr("checked","checked");
		}
		else
		{
			//alert('0');
			$("#disable").attr("checked","checked");
		}
		////alert('124');
		//$("#moduleSelect").attr("disabled",true);
	}
	else
	{
		errMsgBox('请选择一个菜单结点!');
		return;
	}
	
	$("#modal-title").html("编辑!");
	
	$('#modal-table').modal('show');
}

//添加节点
$("#addNode").click(addNode);
function addNode() {
	resetFrom();
	//$("#moduleSelect").attr("disabled",false);
	$("#templateSelect").attr("disabled",false);
	$("#templateurl").attr("disabled",true);
	$("#modal-title").html("新增!");
	$('#modal-table').modal('show');
	$('#id').val(null);
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
		//alert(item.moduleid);
		//$("#moduleSelect").selectpicker('val',item.moduleid);
		//$("#moduleSelect").attr("disabled",true);
		$("#templateSelect").selectpicker('val',item.templateid);
		$("#templateSelect").attr("disabled",true);
		$('#parentmenuid').val(item.id);
		
	}
	else
	{
		$('#parentmenuid').val(null);
		//alert('123');
		//$("#moduleSelect").attr("disabled",false);
		$("#templateSelect").attr("disabled",false);
		$("#templateSelect").attr("val",-1);
	}

}

function refreshTreeItem() {

	window.location.reload();
}

//保存
$("#saveBtn").click(saveData);
function saveData() {
	if(!$('#MyForm').valid()) {
		return;
	}
	
	//恢复，否则不能取值
	//$("#moduleSelect").attr("disabled",false);
	$("#templateurl").attr("disabled",false);
	
	//var moduleObj = document.getElementById("moduleSelect");
	//var moduleId = moduleObj.value;
	/*
	if (moduleId == -1)
	{
		alert("请选择一个模块!");
		return;
	}
	*/
	
	var templateObj = document.getElementById("templateSelect");
	var templateId = templateObj.value;
	if (templateId == -1)
	{
		errMsgBox("请选择一个模板!");
		return;
	}

	var id = $('#id').val();
	var pid = $('#parentmenuid').val();
	var formData = $("#MyForm").serializeJSON();
	formData.id = id;
	formData.parentmenuid = pid;
	//只有菜单管理才有动态生成，固定为1
	formData.moduleid = 1;
	formData.templateid = templateId;

	var json = JSON.stringify(formData);
	
	//alert(json);
	var url = "<c:url value='/menu/save'/>";		
	
	fnAjaxPost(url,json,function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		if (obj.success) {
			msgBox(obj.success);
			$("#modal-table").modal('hide');
			resetFrom();
			refreshTreeItem();	
		} else {
			errMsgBox(obj.error);
		}
	});
	
}

jQuery.validator.addMethod("numberCheck", function(value, element) {       
    return this.optional(element) || /^[0-9]+$/.test(value);       
}, "只能输入数字!");

jQuery.validator.addMethod("stringCheck", function(value, element) {       
    return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);       
}, "只能包含英文、数字、下划线等字符");

var validator = $("#MyForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	focusInvalid: false,
	ignore: "",
	rules: {
		menuname: {
			required: true,
			maxlength:50
		},
		menuurl: {
			required: true, 
			equalTo: "#menucode",
			maxlength:100
		},
		menucode: {
			required: true,
			maxlength:100
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
		menuname: {
			required: "不能为空.",
			maxlength:"菜单名称不能超过50个字符！"
		},
		menuurl: {
			required: "不能为空.",
			equalTo:"要和菜单编码相同!",
			maxlength:"菜单地址不能超过100个字符！"
		},
		menucode: {
			required: "不能为空.",
			maxlength:"菜单编码不能超过100个字符！"
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




	var scripts = ["<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"];
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

	jQuery(function($){

		var remoteSource = function(options, callback) {	
			var parent_id = null
			if( !('text' in options || 'type' in options) ){
				parent_id = 0;//load first level data
			}
			else if('type' in options && options['type'] == 'folder') {//it has children
				if('additionalParameters' in options && 'children' in options.additionalParameters)
					parent_id = options.additionalParameters['id']
			}	
			
			var url = "<c:url value='/menu/listJson'/>";
			
			var json = {'id':parent_id};		
			
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
		
	
	
	
	
	
	
	/**
	//please refer to docs for more info
	$('#tree1')
	.on('loaded.fu.tree', function(e) {
	})
	.on('updated.fu.tree', function(e, result) {
	})
	.on('selected.fu.tree', function(e) {
	})
	.on('deselected.fu.tree', function(e) {
	})
	.on('opened.fu.tree', function(e) {
	})
	.on('closed.fu.tree', function(e) {
	});
	*/
	
	
	

	});
	});
</script>
