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
	href="<c:url value='/bootstrap/assets/css/ui.jqgrid.css'/>" />

<script src='<c:url value="/bootstrap/assets/js/jqGrid/jquery.jqGrid.src.js"/>'> </script>
<script src='<c:url value="/bootstrap/assets/js/jqGrid/i18n/grid.locale-cn.js"/>'> </script>

<div class="row">
	<div class="col-xs-12">
		<div class="table-header">
		<shiro:hasPermission name="role:c">
			<a href="#modal-table" role="button" class="green"
				data-toggle="modal">
				<button id="newBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 新增
				</button>
			</a>
		</shiro:hasPermission>
			<!-- modified by tl in 150526 
			<button id="editBtn" class="btn btn-white btn-default btn-round"> 
			 <i class="ace-icon fa fa-pencil-square-o red2"></i> 更新 	
			</button> 
			-->
			<shiro:hasPermission name="role:d">
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
						<th>角色名称</th>
						<th>角色描述</th>
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
								for="rolename">角色名称</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="rolename" name="rolename"
									class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="rolename">角色描述</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="roledesc" name="roledesc"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="rolename">状态</label>
							<div class="col-sm-9">
								<div class="radio inline">
									<label>
										<input name="isenable" type="radio" class="ace" value="1"/>	
										<span class="lbl">生效</span>								
									</label>
									
								</div>
		
								<div class="radio inline">
									<label>
										<input name="isenable" type="radio" class="ace" value="0"/>
										<span class="lbl">禁用</span>
									</label>
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
			<!-- /.modal-dialog -->
	</div>
	
	<div id="modal-power" class="modal fade" tabindex="-1">		
		<div class="modal-dialog">
			<div class="modal-content" style="width:800px;">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						<span id="modal-title">权限分配</span>
					</div>
				</div>
				<div id="modal-power-body" class="modal-body no-padding">
					<table id="grid-table"></table>
					<div id="grid-pager"></div>
				</div>
				<div class="modal-footer no-margin-top">
					<button class="btn btn-sm" data-dismiss="modal">
						<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
					</button>

					<button id="powerSaveBtn" class="btn btn-sm btn-primary">
						<i class="ace-icon fa fa-check"></i><fmt:message key="save" />
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

//可拖动
$("#modal-table").draggable({
      handle: ".modal-header"
  });
$("#modal-power").draggable({
    handle: ".modal-header"
});
	var roleName = null;
	var roleId = null;
	var remoteSource = null;

	var validator = $("#MyForm").validate({
		errorElement: 'div',
		errorClass: 'help-block',
		focusInvalid: false,
		ignore: "",
		rules: {
			rolename: {
				required: true,maxlength:50
			},
			roledesc: {
				required: true,maxlength:200
			}
		},

		messages: {
			rolename: {
				required: "不能为空.",
				maxlength:"长度不能超过50个字符."
			},
			roledesc: {
				required: "不能为空.",
				maxlength:"长度不能超过200个字符."
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

	$('#powerSaveBtn').click(savePower);
	function savePower(){
		$.gritter.add({
			title: '<fmt:message key="operate.title" />',
			text: '<fmt:message key="op.success" />',
			class_name: 'gritter-success  gritter-light'
		});
		$('#modal-power').modal('hide');
	};
	
	function managerPower(json){
		var obj = JSON.parse(decodeJson(json));
		roleId = obj.id;
		roleName = obj.rolename;
		var url = "<c:url value='/module/queryForPower?ownerId="+roleId+"'/>";  
		$("#grid-table").jqGrid('setGridParam',{url:url}).trigger("reloadGrid");
	}

	//删除方法
	function deleteObj(ids){	
		var url = "<c:url value='/role/delete'/>";
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
	function delRow(ids) {
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
		$("#rolename").val(obj.rolename);
		$("#roledesc").val(obj.roledesc);
		var isenable = document.getElementsByName("isenable");
		for(var i=0;i<isenable.length;i++)
			{
				if(isenable.item(i).value==obj.isenable)
					{
					isenable.item(i).checked=true;
					}
			}
	}



	//保存
	$("#saveBtn").click(saveData);  //点击元素时会发生click事件，响应saveData函数
	function saveData() {
		if(!$('#MyForm').valid()) {
			return;
		}
		
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
				url= "<c:url value='/role/edit'/>";
			}
			else{
				formData = $("#MyForm").serializeJSON(); 
				json = JSON.stringify(formData);
				url = "<c:url value='/role/save'/>";
			}		
		
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
				$("#modal-table").modal('hide'); 
				resetFrom();
				oTable.fnDraw();
				msgBox(obj.success);
			} else {
				errMsgBox(obj.error);
			}
		});
		
	}
	
	
	//新增
	$("#newBtn").click(newData);
	function newData() {
			$("#modal-title").html("新增!");
			$("#rolename").val(null);
			$("#roledesc").val(null);
			var status=document.getElementsByName("status");
			for(var i=0;i<status.length;i++)
				{
					status.item(i).checked=false;
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
			var url = "<c:url value='/role/listJson'/>";
			var colJson = [
							  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
							  {"mDataProp": "rolename", "sClass":"center","bSortable":true,"bSearchable": true},
							  {"mDataProp": "roledesc", "sClass":"center","bSortable": false,"bSearchable": false },
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
				<shiro:hasPermission name="role:u">+
				"<a class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"+
				"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
				</shiro:hasPermission>
				<shiro:hasPermission name="role:u">+
				"<a class=\'red\' href=\'javascript:void(0);\' onclick=managerPower(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-power\'>"+
				"<i class=\'ace-icon fa fa-lock bigger-130\'></i></a>"
				</shiro:hasPermission>
				<shiro:hasPermission name="role:d">+
				"<a class=\'red\' href=\'javascript:void(0);\' onclick=delRow(\'"+data+"\');>"+
				"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
				</shiro:hasPermission>+
				"</div>";
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
				aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) });
			    var url = sSource;
			    var json = { 'aoData': JSON.stringify(aoData) };
			    fnAjaxGet(url,json,function(resp) {
					fnCallback(resp);
				});		    
			}
	        
		})
		
		//权限设置
		jQuery(function($) {
			var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
			
			var parent_column = $(grid_selector).closest('[class*="col-"]');
			$(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
				if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
					//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
					setTimeout(function() {
						$(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
					}, 0);
				}
		    })
		
			var parentId = null;
			jQuery(grid_selector).jqGrid({
				subGrid : true,
				subGridOptions : {
					plusicon : "ace-icon fa fa-plus center bigger-110 blue",
					minusicon  : "ace-icon fa fa-minus center bigger-110 blue",
					openicon : "ace-icon fa fa-chevron-right center orange"
				},
				
				subGridRowExpanded: function (subgridDivId, rowId) {
					var subgridTableId = subgridDivId + "_t";
					$("#" + subgridDivId).html("<table id='" + subgridTableId + "'></table>");
					$("#" + subgridTableId).jqGrid({
						//datatype: 'local',
						//data: subgrid_data,
						url:"<c:url value='/menu/queryMenuByModuleId?moduleId="+rowId+"&roleId="+roleId+" '/>",
						datatype: "json",
						viewrecords : true,
						rowNum:50,
						colNames: ['菜单名称','菜单代码','菜单路径','增加','删除','修改','查询','审核','全选'],
						colModel: [
							{ name: 'menuname', width: 80 },
							{ name: 'menucode', width: 80 },
							{ name: 'menuurl', width: 80 },
							{ name: 'operate',index:'', width:40, align: 'center', fixed:true, sortable:false, resize:false,
								formatter:checkBoxAdd, 
							},
							{ name: 'operate',index:'', width:40, align: 'center', fixed:true, sortable:false, resize:false,
								formatter:checkBoxDel, 
							},
							{ name: 'operate',index:'', width:40, align: 'center', fixed:true, sortable:false, resize:false,
								formatter:checkBoxUpd, 
							},
							{ name: 'operate',index:'', width:40, align: 'center', fixed:true, sortable:false, resize:false,
								formatter:checkBoxView, 
							},
							{ name: 'operate',index:'', width:40, align: 'center', fixed:true, sortable:false, resize:false,
								formatter:checkBoxApprove, 
							},
							{ name: 'operate',index:'', width:40, align: 'center', fixed:true, sortable:false, resize:false,
								formatter:checkAllBox, 
							}
						]
					});
				},
		
				//data: grid_data, 
				//datatype: "local",
				url:"<c:url value='/module/queryForPower?ownerId=1'/>",
				datatype: "json",
				height: 500,
				width:798,
				colNames:['模板名称','模板代码','模板描述',"选中"],
				colModel:[
					{name:'modulename',index:'modulename', width:20, sorttype:"int", editable: true},
					{name:'modulecode',index:'modulecode',width:30, editable:true, sorttype:"date",unformat: pickDate},
					{name:'moduledesc',index:'moduledesc', width:30,editable: true,editoptions:{size:"20",maxlength:"30"}},
					{ name: 'operate',index:'', width:40, align: 'center', fixed:true, sortable:false, resize:false,
						formatter:checkModule, 
					}
				], 
		
				viewrecords : true,
				rowNum:40,
				rowList:[10,20,40],
				//pager : pager_selector,
				altRows: true,
				//toppager: true,
				
				//multiselect: true,
		       // multiboxonly: true,
		
				loadComplete : function() {
					var table = this;
					setTimeout(function(){
						styleCheckbox(table);
						
						updateActionIcons(table);
						updatePagerIcons(table);
						enableTooltips(table);
					}, 0);
				},
		
				editurl: "/dummy.html",
				caption: "",
				autowidth: false,
		
			});
			$(window).triggerHandler('resize.jqGrid');
			
			function aceSwitch( cellvalue, options, cell ) {
				setTimeout(function(){
					$(cell) .find('input[type=checkbox]')
						.addClass('ace ace-switch ace-switch-5')
						.after('<span class="lbl"></span>');
				}, 0);
			}
			
			function pickDate( cellvalue, options, cell ) {
				setTimeout(function(){
					$(cell) .find('input[type=text]')
							.datepicker({format:'yyyy-mm-dd' , autoclose:true}); 
				}, 0);
			}
		
			function style_edit_form(form) {
				form.find('input[name=sdate]').datepicker({format:'yyyy-mm-dd' , autoclose:true})
					.end().find('input[name=stock]')
						.addClass('ace ace-switch ace-switch-5').after('<span class="lbl"></span>');
						  
				var buttons = form.next().find('.EditButton .fm-button');
				buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();//ui-icon, s-icon
				buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
				buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')
				
				buttons = form.next().find('.navButton a');
				buttons.find('.ui-icon').hide();
				buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
				buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');		
			}
		
			function style_delete_form(form) {
				var buttons = form.next().find('.EditButton .fm-button');
				buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();//ui-icon, s-icon
				buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
				buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
			}
			
			function style_search_filters(form) {
				form.find('.delete-rule').val('X');
				form.find('.add-rule').addClass('btn btn-xs btn-primary');
				form.find('.add-group').addClass('btn btn-xs btn-success');
				form.find('.delete-group').addClass('btn btn-xs btn-danger');
			}
			function style_search_form(form) {
				var dialog = form.closest('.ui-jqdialog');
				var buttons = dialog.find('.EditTable')
				buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
				buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
				buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
			}
			
			function beforeDeleteCallback(e) {
				var form = $(e[0]);
				if(form.data('styled')) return false;
				
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
				
				style_delete_form(form);
				
				form.data('styled', true);
			}
			
			function beforeEditCallback(e) {
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
				style_edit_form(form);
			}
			
			function checkBoxAdd(cellvalue, options, cell){
				var flagA = cell.statusC==1?'checked':'';
				var valA =  cell.statusC==1?"1":"0";
				var html = "<label class=\"position-relative\">";
			    html += "<input id="+cell.id+cell.menucode+"_c type=\"checkbox\" value="+valA+" "+flagA+" onclick=\"smallChange('c','"+cell.id+"','"+cell.menucode+"','"+false+"');\" class=\"ace\" />";
			    html += "<span class=\"lbl\"></span>";
			    html += "</label>";
			return html;
			}

			function checkBoxDel(cellvalue, options, cell){
				var flagD = cell.statusD==1?'checked':'';
				var valD =  cell.statusD==1?"1":"0";
				var html = "<label class=\"position-relative\">";
			    html += "<input id="+cell.id+cell.menucode+"_d type=\"checkbox\" value="+valD+" "+flagD+" onclick=\"smallChange('d','"+cell.id+"','"+cell.menucode+"','"+false+"');\" class=\"ace\" />";
			    html += "<span class=\"lbl\"></span>";
			    html += "</label>";
			return html;
			}

			function checkBoxUpd(cellvalue, options, cell){
				var flagU = cell.statusU==1?'checked':'';
				var valU =  cell.statusU==1?"1":"0";
				var html = "<label class=\"position-relative\">";
			    html += "<input id="+cell.id+cell.menucode+"_u type=\"checkbox\" value="+valU+" "+flagU+" onclick=\"smallChange('u','"+cell.id+"','"+cell.menucode+"','"+false+"');\" class=\"ace\" />";
			    html += "<span class=\"lbl\"></span>";
			    html += "</label>";
			return html;
			}

			function checkBoxView(cellvalue, options, cell){
				var flagV = cell.statusR==1?'checked':'';
				var valR =  cell.statusR==1?"1":"0";
				var html = "<label class=\"position-relative\">";
			    html += "<input id="+cell.id+cell.menucode+"_r type=\"checkbox\" value="+valR+" "+flagV+" onclick=\"smallChange('r','"+cell.id+"','"+cell.menucode+"','"+false+"');\" class=\"ace\" />";
			    html += "<span class=\"lbl\"></span>";
			    html += "</label>";
			return html;
			}
			
			function checkBoxApprove(cellvalue, options, cell){
				if(1 == cell.moduleid){
					var flagP = cell.statusA==1?'checked':'';
					var val =  cell.statusK==1?'1':'0';
					var html = "<label class=\"position-relative\">";
				    html += "<input id="+cell.id+cell.menucode+"_a type=\"checkbox\" value="+val+" "+flagP+" onclick=\"smallChange('a','"+cell.id+"','"+cell.menucode+"','"+false+"');\" class=\"ace\" />";
				    html += "<span class=\"lbl\"></span>";
				    html += "</label>";
				return html;
				}else{
					return "";
				}
				
			}
			
			function checkAllBox(cellvalue, options, cell){
				var flagK = cell.statusK==1?'checked':'';
				var val =  cell.statusK==1?"1":"0";
				var html = "<label class=\"position-relative\">";
			    html += "<input id="+cell.id+cell.menucode+"_k type=\"checkbox\" value="+val+" "+flagK+" onclick=\"checkAllRadio(\'"+encodeJson(JSON.stringify(cell))+"\');\" class=\"ace\" />";
			    html += "<span class=\"lbl\"></span>";
			    html += "</label>";
				return html;
			}
			
			function checkModule(cellvalue, options, cell){
				var flagM = cell.count==1?'checked':'';
				var html = "<label class=\"position-relative\">";
			    html += "<input id=\"\" type=\"checkbox\" "+flagM+" onclick=\"smallChange('1','"+cell.id+"','"+cell.modulecode+"','"+false+"');\" class=\"ace\" />";
			    html += "<span class=\"lbl\"></span>";
			    html += "</label>";
			return html;
			}
			
			function styleCheckbox(table) {
			
			}
			
			function updateActionIcons(table) {
				
			}
			
			function updatePagerIcons(table) {
				var replacement = 
				{
					'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
					'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
					'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
					'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
				};
				$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
					var icon = $(this);
					var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
					
					if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
				})
			}
		
			function enableTooltips(table) {
				$('.navtable .ui-pg-button').tooltip({container:'body'});
				$(table).find('.ui-pg-div').tooltip({container:'body'});
			}
		
			$(document).on('ajaxloadstart', function(e) {
				$(grid_selector).jqGrid('GridUnload');
				$('.ui-jqdialog').remove();
			});
		});
	});
	
	function smallChange(flag,id,code,auto){

		var url= "<c:url value='/power/saveOrUpdatePower'/>";
		var json = null;
		if(flag == 1){
			json= {'owner':roleName,'ownerid':roleId,'resource':code,'resourceid':id};
		}else{
			json = {'owner':roleName,'ownerid':roleId,'resource':code+":"+flag,'resourceid':id};
			if(flag != "k" && auto){
				var oldVal = $("#"+id+code+"_"+flag).val();
				$("#"+id+code+"_"+flag).val(oldVal=="1"?"0":"1");
			}
			
		}
		
		json = JSON.stringify(json);
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			if (obj.success) {
			/*	$.gritter.add({
					title: '<fmt:message key="operate.title" />',
					text: obj.success,
					class_name: 'gritter-success  gritter-light'
				});*/
			} else {
				errMsgBox(obj.error);
			}
		});
	};
	function checkAllRadio(json){
		var obj = JSON.parse(decodeJson(json));
		smallChange('k',obj.id,obj.menucode,true);
		
		var flag = $("#"+obj.id+obj.menucode+"_k").val();
		//全部取消
		if("1" == flag){
			if($("#"+obj.id+obj.menucode+"_c").val() == "1"){
				setTimeout(function(){
					smallChange('c',obj.id,obj.menucode,true);
					$("#"+obj.id+obj.menucode+"_c").prop("checked",false);
				},100);
				
			}
			if($("#"+obj.id+obj.menucode+"_d").val() == "1"){
				setTimeout(function(){
					smallChange('d',obj.id,obj.menucode,true);
					$("#"+obj.id+obj.menucode+"_d").prop("checked",false);
				},200);
			}
			if($("#"+obj.id+obj.menucode+"_u").val() == "1"){
				setTimeout(function(){
					smallChange('u',obj.id,obj.menucode,true);
					$("#"+obj.id+obj.menucode+"_u").prop("checked",false);
				},300);
			}
			if($("#"+obj.id+obj.menucode+"_r").val() == "1"){
				setTimeout(function(){
					smallChange('r',obj.id,obj.menucode,true);
					$("#"+obj.id+obj.menucode+"_r").prop("checked",false);
				},400);
			}
			if(1 == obj.moduleid){
				if($("#"+obj.id+obj.menucode+"_a").val() == "1"){
					setTimeout(function(){
						smallChange('a',obj.id,obj.menucode,true);
						$("#"+obj.id+obj.menucode+"_a").prop("checked",false);
					},500);
				}
			}
			$("#"+obj.id+obj.menucode+"_k").val("0");
		//全部勾选
		}else{
			if($("#"+obj.id+obj.menucode+"_c").val() == "0"){
				setTimeout(function(){
					smallChange('c',obj.id,obj.menucode,true);
					$("#"+obj.id+obj.menucode+"_c").prop("checked",true);
				},100);
			}
			if($("#"+obj.id+obj.menucode+"_d").val() == "0"){
				setTimeout(function(){
					smallChange('d',obj.id,obj.menucode,true);
					$("#"+obj.id+obj.menucode+"_d").prop("checked",true);
				},200);
			}
			if($("#"+obj.id+obj.menucode+"_u").val() == "0"){
				setTimeout(function(){
					smallChange('u',obj.id,obj.menucode,true);
					$("#"+obj.id+obj.menucode+"_u").prop("checked",true);
				},300);
			}
			if($("#"+obj.id+obj.menucode+"_r").val() == "0"){
				setTimeout(function(){
					smallChange('r',obj.id,obj.menucode,true);
					$("#"+obj.id+obj.menucode+"_r").prop("checked",true);
				},400);
			}
			if(1 == obj.moduleid){
				if($("#"+obj.id+obj.menucode+"_a").val() == "0"){
					setTimeout(function(){
						smallChange('a',obj.id,obj.menucode,true);
						$("#"+obj.id+obj.menucode+"_a").prop("checked",true);
					},500);
				}
			}
			$("#"+obj.id+obj.menucode+"_k").val("1");
		}

	}
</script>
