<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
//window.UEDITOR_HOME_URL = "/ueditor/";
String path = request.getContextPath();
//alert(path);
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<title><fmt:message key="backStage_name" /></title>

<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/colorbox.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/fileinput.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/bootstrap-select.min.css'/>" />

<!-- ajax layout which only needs content area -->
<div class="row">
	<div class="col-xs-12">
		<div class="table-header">
			<c:if test="${create == true}">
			<button id="addBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
					<fmt:message key="add" />
			</button>
			</c:if>
			
			<c:if test="${delete == true}">
			<button id="delBtn" class="btn btn-white btn-default btn-round">
				<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
			</button>
			</c:if>
		</div>
		
		<div id="preview" style="position: absolute; top: 500px; width: auto; background-color: #E7F3FF; display: none; z-index: 100000; border: 1px solid #e1e3e4; padding: 5px; -moz-border-radius-topright: 10px; -moz-border-radius-bottomright: 10px; -webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -webkit-border-top-right-radius: 10px; -webkit-border-bottom-right-radius: 10px;">
		</div>
	
		<div>
			<table id="data-table"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center"><label class="position-relative">
								<input type="checkbox" class="ace" /> <span class="lbl"></span>
						</label></th>
						<th><fmt:message key="title" /></th>
						<th><fmt:message key="menuid" /></th>						
						<th><fmt:message key="keyword" /></th>
						<th><fmt:message key="content" /></th>
						<th><fmt:message key="type" /></th>
						<th><fmt:message key="menu_seqno" /></th>
						<th><fmt:message key="addtime" /></th>
						<th><fmt:message key="ischeck" /></th>
						<th><fmt:message key="operate" /></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	</div>
	<div id="modal-table" class="modal fade" tabindex="-1">		
			<div class="modal-dialog" style="height: 100%; width: 62%; margin-top:30px">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title"><fmt:message key="op.success" /></span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
					<form id="MyForm" method="post" class="form-horizontal" role="form">
						<div class="form-group">
							<div class="col-sm-9">
								<input type="text" id="id" name="id" class="hidden" />
								<input type="text" id="type" name="type" class="hidden" />
								<input type="text" id="menuid" name="menuid" class="hidden" />									
							</div>
						</div>
						
						<div class="form-group">
							<label style="font-weight:bold" class="col-sm-2 control-label no-padding-right"
								for="type">是否置顶</label>
							<div class="col-sm-10">
								<div class="clearfix">
									<select id="contentTypeSelect" class="selectpicker show-tick" data-size="5" data-style="btn btn-primary">
										<option value=1>置顶</option>
										<option value=2>不置顶</option>
									</select>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label style="font-weight:bold" class="col-sm-2 control-label no-padding-right"
								for="menuid">设备类别</label>
							<div class="col-sm-10">
								<div class="clearfix">									
									<input type="text" id="menuName" name="menuName" value="${menuName}" class="col-xs-10 col-sm-5"/>
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label style="font-weight:bold" class="col-sm-2 control-label no-padding-right" 
							for="title">设备名称</label>
							<div class="col-sm-10">
								<div class="clearfix">
								<input type="text" id="title" name="title" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label style="font-weight:bold" class="col-sm-2 control-label no-padding-right"
								for="keyword">参数信息</label>
							<div class="col-sm-10">
								<div class="clearfix">
									<%--<input type="text" id="keyword" name="keyword"
									class="col-xs-10 col-sm-5" />--%>
									<textarea class="col-xs-10 col-sm-5" id="keyword" name="keyword" rows="3"></textarea>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label style="font-weight:bold" class="col-sm-2 control-label no-padding-right">上传图片
							</label>
							<div class="col-sm-10">
								<div class="clearfix">
									<input id="htmlurl" onclick="showUploadImgModal()" readonly name="htmlurl" type="text" class="col-xs-10 col-sm-5"/>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label style="font-weight:bold" class="col-sm-2 control-label no-padding-right"
								for="content">详细内容</label>
							<div class="col-sm-10">
								<div class="clearfix">
									<input type="text" id="content" name="content" class="hidden" />
									<!-- <div class="wysiwyg-editor" id="editor1"></div> -->
									<div>
										<script id="container" name="content" style="width:90%;height:300px;" type="text/plain">这里写你的初始化内容</script>
									</div>
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label style="font-weight:bold" class="col-sm-2 control-label no-padding-right"
								for="seqno">排列顺序</label>
							<div class="col-sm-10">
								<div class="clearfix">
								<input type="text" id="seqno" name="seqno"
									class="col-xs-10 col-sm-5" />
									</div>
							</div>
						</div>


						<div class="space-4"></div>
						<div class="form-group">
							<label style="font-weight:bold" class="col-sm-2 control-label no-padding-right"
								for="ischeck"><fmt:message key="ischeck" /></label>
							<div class="col-sm-10">
								<c:if test="${audit == true}">
								<div class="radio inline">
									<label>
										<input id="checked" name="ischeck" type="radio" class="ace" value="1"/>	
										<span class="lbl"><fmt:message key="enable" /></span>								
									</label>
									
								</div>
								</c:if >
		
								<div class="radio inline">
									<label>
										<input id="unchecked" name="ischeck" type="radio" class="ace" value="0"/>
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
	
<div id="modal-table-resource" class="modal fade" tabindex="-1">		
			<div class="modal-dialog" style="height: 100%; width: 60%; margin-top:50px">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title-resource">资源库
							</span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
		
								<div class="row">
									<div class="col-sm-12">
										<div class="widget-box widget-color-blue2">
											<ul class="nav nav-tabs" role="tablist" id="maintab">
											  <li data-toggle="tab"><a href="#tabpane-resource"  onclick='showReource("image")'>图片</a></li>
											  <li class="active" data-toggle="tab"><a href="#tabpane-resource" onclick='showReource("flash")'>flash</a></li>
											  <li data-toggle="tab"><a href="#tabpane-resource" onclick='showReource("video")'>视频</a></li>
											  <li data-toggle="tab"><a href="#tabpane-resource" onclick='showReource("file")'>文件</a></li>
											</ul>
											
											<!-- Tab panes -->
											<div class="tab-content">
											  	<div class="tab-pane active" id="tabpane-resource">
											  		<div class="row">
														<div class="col-sm-3">
															<div id="resource-tree-div">
																<ul id="tree-resource" class="tree tree-folder-select" role="tree"></ul>
															</div>
														</div>
														
														<div class="col-sm-9">
															<div id="resource-table-div">
																<table id="resource-data-table"
																	class="table table-striped table-bordered table-hover">
																	<thead>
																		<tr>
																			<th class="center"><label class="position-relative">
																					<input type="checkbox" class="ace" /> <span class="lbl"></span>
																			</label></th>
																			<th><fmt:message key="restype" /></th>
																			<th><fmt:message key="fileurl" /></th>
																		</tr>
																	</thead>
																	<tbody></tbody>
																</table>
															</div>
															
															<div id="resource-colorbox-div">
																<ul class="ace-thumbnails clearfix" id="picture"></ul>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
					</div>
					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
						</button>

						<button id="insertResourceBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i><fmt:message key="confirm" />
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
	</div>
</div><!-- /.row -->

	<!-- upload images -->
	<div id="uoload-modal" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						<span id="modal-title">上传图片</span>
					</div>
				</div>

				<div id="upload-modal-body" class="modal-body">
					<form id="uploadFileId" name="uploadFileId" action=""  enctype="multipart/form-data">
						<input type="file" id="file" name="file" />
					</form>
				</div>
				<div class="modal-footer no-margin-top">
					<button id="cancelUploadBtn" class="btn btn-sm" data-dismiss="modal">
						<i class="ace-icon fa fa-times"></i> 取消
					</button>
					<button id="uploadBtn" onclick="upload()" class="btn btn-sm btn-primary">
						<i class="ace-icon fa fa-check"></i> 确定
					</button>
				</div>
			</div>
		</div>
	</div>

<!-- page specific plugin scripts -->
<script type="text/javascript">
$(function(){
	$('.selectpicker').selectpicker();
	$('#contentTypeSelect').selectpicker('val', 1);
	$('#contentTypeSelect').selectpicker('refresh');
});
//定义编辑器根目录
window.UEDITOR_HOME_URL = "ueditor/";
var view_source = false;
var toolBarViewSource;
var validator = $("#MyForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	focusInvalid: false,
	ignore: "",
	rules: {
		title: {
			required: true,
			maxlength:300
		},
		keyword: {
			required: true,
			maxlength:400
		},
		seqno: {
			required: true,
			number: true
		},		
		ischeck: {
			required: true
		}
	},

	messages: {
		title: {
			required: "不能为空.",
			maxlength:"标题长度不能超过300个字符!"
		},
		keyword: {
			required:"不能为空.",
			maxlength:"关键字长度不能超过400个字符!"
		},
		seqno: {
			required: "不能为空.",
			number:"只能为数字!"
		},
		ischeck: "请选择状态。"
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

//初始化弹出表格
$('maintab').tab();
var globalGroupID = null;
var GlobleResourceType = 2;
function showReource(tabid)
{
	//alert(tabid);
	if (tabid == 'image')
	{
		$('#resource-table-div').show();
		$('#resource-colorbox-div').hide();
		globalGroupID = null;
		GlobleResourceType = 1;
		//getGalleryDate(globalGroupID);
	}
	else if (tabid == 'flash')
	{
		$('#resource-colorbox-div').hide();
		$('#resource-table-div').show();
		globalGroupID = null;
		GlobleResourceType = 2;
	}
	else if (tabid == 'video')
	{
		$('#resource-colorbox-div').hide();
		$('#resource-table-div').show();
		globalGroupID = null;
		GlobleResourceType = 3;
	}
	else if (tabid == 'file')
	{
		$('#resource-colorbox-div').hide();
		$('#resource-table-div').show();
		globalGroupID = null;
		GlobleResourceType = 4;
	}
	else
	{
		GlobleResourceType = null;
	}
	
	$('#resource-tree-div').html('');
	$('#resource-tree-div').append('<ul id="tree-resource" class="tree tree-folder-select" role="tree"></ul>');
	
	$('#tree-resource').ace_tree({
		'dataSource': remoteSource_Resource, 
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
	
	$('#tree-resource').on('selected.fu.tree',treeSelected);
	
	$('#tree-resource').on('deselected.fu.tree', treeDeselected);
	
	//重新加载表格数据
	oResourceTable.fnDraw();
	return false;
}

//插入资源
$('#insertResourceBtn').click(insertResource);
function insertResource()
{
	//alert(GlobleResourceType);
	var ids = fnGetIDs('#resource-data-table');
	if (ids.length > 0)
	{
		var url = "<c:url value='/res/insert'/>";		
		var json = {"idList":ids};
		fnAjaxPost(url,JSON.stringify(json),function(res){
			var obj = JSON.parse(JSON.stringify(res));
			for (var i=0; i < obj.length;i++)
			{
				switch (obj[i].restype)
				{
				case 1:
					{
						var html = '<a target="_blank" href=<%=path%>'+obj[i].fileurl+'>'+'<img src=<%=path%>'+obj[i].bigpicurl+' width=100%'+'>'+'</a>';
						//$('#editor1').append(htm);
						uEditor.execCommand("inserthtml",html);
					}

					break;
				case 2:
					{
						var html = '<embed src=<%=path%>'+obj[i].fileurl+' width=80% height="300" wmode="transparent" autostart="false" loop="false" />';							
						//$('#editor1').append(html);
						uEditor.execCommand("inserthtml",html);
					}
					break;
				case 3:
					{
						var html =   '<br>'+'<video id="vedio_preview" class="video-js vjs-default-skin" controls="controls" preload="none" width=100% height="300" '+'poster=<c:url value="/html/vedio-js/vedioDefault.png"/>'+
						         ' data-setup={example_option:true}>'+
						        '<source src=<%=path%>'+obj[i].fileurl+' type="video/mp4" /><p class="vjs-no-js">您的浏览器不支持html5</p></video>';
						//$('#editor1').append(htm);
						uEditor.execCommand("inserthtml",html);
					}
					break;
				case 4:
					{
						var fileurl = obj[i].fileurl;
						var filename = obj[i].resname;
						//var filename = fileurl.substr(fileurl.lastIndexOf("/")+1, fileurl.length);
						var html = '<a href=\"<%=path%>/res/download/'+obj[i].id+'\">'+filename+'</a>&nbsp;&nbsp;&nbsp;&nbsp;';
						//$('#editor1').append(htm);
						uEditor.execCommand("inserthtml",html);
					}
					break;
				}
			}
			$("#modal-table-resource").modal('hide');
		});
	
	}else {
		errMsgBox('请选择一条资源操作!');
	}
}
//插入资源
function onclickFunc() {
	//可拖动
	$("#modal-table-resource").draggable({
	      handle: ".modal-header"
	  });
	$("#modal-table-resource").modal('show');
}
//删除方法
function deleteObj(ids){	
	var url = "<c:url value='/cms/delete'/>";
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

function showErrorAlert (reason, detail) {
	var msg='';
	if (reason==='unsupported-file-type') { 
		msg = "Unsupported format " +detail; 
	}else {
		//console.log("error uploading file", reason, detail);
	}
	
	$('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
	 '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
}

//预览功能
function previewData(data) {
	var url = "<c:url value='/cms/queryMenuUrlById'/>";
	var json = {"id":data};
	var params = "left=0,screenX=0,top=0,screenY=0,scrollbars=1";
	  if (window.screen) {
	     var ah = screen.availHeight - 30;
	     var aw = screen.availWidth - 10;
	     params += ",height=" + ah;
	     params += ",innerHeight=" + ah;
	     params += ",width=" + aw;
	     params += ",innerWidth=" + aw;
	     params += ",resizable"
	 } else {
		 params += ",resizable"; 
	 }
	fnAjaxPost(url,JSON.stringify(json),function(res){
		if (res) {
			var obj = JSON.parse(JSON.stringify(res));		
			var newUrl = '/'+obj.menuurl+'/'+data;
			
			var winUrl = '<%=path%>'+newUrl;
			//alert('winUrl='+winUrl);
			window.open(winUrl, 'newwindow', params);
		}		
	});	
}

function initViewSource()
{
	view_source = false;
}

//新增
$('#addBtn').click(addData);
function addData() {
	initViewSource();
	$('#saveBtn').removeAttr("disabled");
	validator.resetForm();
	resetFrom();
	var menuid = ${menuid};
	//alert(menuid);
	$('#menuName').attr("disabled",true);
	$("#modal-title").html("新增!");
	$("#modal-table").draggable({
	      handle: ".modal-header"
	  });
	$("#modal-table").modal("show");
	//$('#editor1').html('');
	uEditor.setContent('');
	$('#id').val(null);
	$('#menuid').val(menuid);
	
	//$('#menuid').attr("disabled",true);	
}

//审核
function auditOne(id) {
	initViewSource();
	// init data
	validator.resetForm();
	resetFrom();
	//clean editor
	//$('#editor1').html('');
	//清空编辑器内容
	uEditor.setContent('');
	// init data
	var idJson = {"id":id};
	var url = "<c:url value='/cms/queryById'/>";	
	fnAjaxPost(url,JSON.stringify(idJson),function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		//$('#menuid').attr("disabled",false);
		$("#menuid").val(obj.menuid);
		$("#title").val(obj.title);
		$("#contentTypeSelect").selectpicker('val',obj.type);
		$("#type").val(obj.type);
		$("#keyword").val(obj.keyword);
		//$("#htmlurl").val(obj.htmlurl);
		$("#seqno").val(obj.seqno);
		//$('#editor1').append(html_decode(obj.content));
		uEditor.setContent(html_decode(obj.content));
		if (obj.ischeck == 1)
		{
			$("#checked").attr("checked","checked");
		}
		else
		{
			$("#unchecked").attr("checked","checked");
		}
		$("#id").val(obj.id);
		$('#menuName').attr("disabled",true);
		$("#modal-title").html("审核!");
		$("#modal-table").modal("show");
	});
}

//更新编辑
function updateObj(id) {
	initViewSource();
	$('#saveBtn').removeAttr("disabled");
	// init data
	validator.resetForm();
	resetFrom();
	//clean editor
	//$('#editor1').html('');
	uEditor.setContent('');
	// init data
	var idJson = {"id":id};
	var url = "<c:url value='/cms/queryById'/>";	
	fnAjaxPost(url,JSON.stringify(idJson),function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		//$('#menuid').attr("disabled",false);
		$("#menuid").val(obj.menuid);
		$("#title").val(obj.title);
		$("#contentTypeSelect").selectpicker('val',obj.type);
		$("#type").val(obj.type);
		$("#keyword").val(obj.keyword);
		//$("#htmlurl").val(obj.htmlurl);
		$("#seqno").val(obj.seqno);
		//$('#editor1').append(html_decode(obj.content));
		uEditor.setContent(html_decode(obj.content));
		if (obj.ischeck == 1)
		{
			$("#checked").attr("checked","checked");
		}
		else
		{
			$("#unchecked").attr("checked","checked");
		}
		$("#id").val(obj.id);
		$('#menuName').attr("disabled",true);
		$("#modal-title").html("编辑!");
		$("#modal-table").modal("show");
	});
}

//保存
$("#saveBtn").click(saveData);
function saveData() {
	if(!$('#MyForm').valid()) {
		return;
	}
	
	if (view_source != false)
	{
		alert(view_source);
		if (toolBarViewSource != null)
		{
			alert('toolBarViewSource not null');
			toolBarViewSource.trigger("click");
		}
	}
	$("#saveBtn").attr("disabled","true");
	var contentTypeObj = document.getElementById("contentTypeSelect");
	var contentType = contentTypeObj.value;
	
	var id = $('#id').val();
	var formData = $("#MyForm").serializeJSON();
	formData.id = id;
	formData.type = contentType;
	formData.menuid = ${menuid};
	var editorContent = uEditor.getContent();
	//var editorContent = $('#editor1').html();
	//alert(editorContent);
	formData.content = html_encode(editorContent);
	var json = JSON.stringify(formData);
	var url = "<c:url value='/cms/save'/>";		
	
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

//弹出预览图片的窗口
//var resoureData = null;
function createDiv(json) {
	//alert(url);
	//resoureData = val;
	//var filetype = val.substr(val.lastIndexOf("/")+1, val.length);
	//var fileUrlNew = val.substr(0,val.lastIndexOf("/"));
	//alert(fileUrlNew);
	var val = JSON.parse(decodeJson(json));
    var e = window.event
    // //这里可得到鼠标X坐标
    var pointX = e.pageX;
    //这里可以得到鼠标Y坐标
    var pointY = e.pageY;
    $("#preview").css("top", pointY-50);
    $("#preview").css("margin-left", pointX-180);
    switch (val.restype)
	{
	case 1:
		{
			var html = '<img src=\"<%=path%>'+val.smallpicurl+'\" width=\"100%\" >';
			//alert(html);
			$("#preview").html(html);
			$("#preview").show();
		}

		break;
	case 2:
		{
			var html = '<embed src=<%=path%>'+val.fileurl+' width=100% height="300" wmode="transparent" autostart="false" loop="false" />';
			//alert(html);
			$("#preview").html(html);
			$("#preview").show();
		}
		break;
	case 3:
		{
			var html =   '<video id="vedio_preview" class="video-js vjs-default-skin" controls="controls" preload="none" autoplay="autoplay" width="100%" '+'poster=<c:url value="/html/vedio-js/vedioDefault.png"/>'+
			         ' data-setup={example_option:true}>'+
			        '<source src=\"<%=path%>'+val.fileurl+'\" type=\"video/mp4\" /><p class=\"vjs-no-js\">您的浏览器不支持html5</p></video>';
			//alert(html);
			$("#preview").html(html);
			$("#preview").show();
		}
		break;
	case 4:
		{
			return;
		}
		break;
	}
    
}

function removeDiv(val) {
	var myVedio = document.getElementById("vedio_preview");
	if(myVedio != null)
	{
		myVedio.pause();
	}
	
    $("#preview").hide();
}

/**
* define datatables.
**/
var oTable;
var oResourceTable;
var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>"]
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

	jQuery(function($) {	
		var url = "<c:url value='/cms/listJson'/>";
		var colJson = [
						  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
						  {"mDataProp": "title", "sClass":"center","bSortable": false,"bSearchable": false },
						  {"mDataProp": "menuid", "sClass":"center","bSortable":false, "mRender": menuIdRender },
						  {"mDataProp": "keyword", "sClass":"center","bSortable": false,"bSearchable": false },
						  {"mDataProp": "content", "sClass":"center","bVisible": false, "bSortable": true,"bSearchable": false, "mRender": contentRender },
						  {"mDataProp": "type", "sClass":"center","bSortable":false,"mRender": typeRender},
						  {"mDataProp": "seqno", "sClass":"center","bSortable": false,"bSearchable": false },
						  {"mDataProp": "addtime", "sClass":"center","bSortable": false,"bSearchable": false, "mRender": timeRender},
						  {"mDataProp": "ischeck", "sClass":"center","bSortable": false,"bSearchable": false, "mRender": checkRender },
						  {"mDataProp": "id", "sClass": "center","bSearchable": false,"bSortable": false,"mRender": opRender}
						];
		var callBackFunc = callAjaxFunc;		
		//初始化 datatable
		oTable = fnInitDataTables('#data-table',url,colJson,callBackFunc);		
		
		function chkRender(data,type,full) {
			var html = '<label class="position-relative">';
			    html += '<input id="id" type="checkbox" class="ace" value="'+data+'"/>';
			    html += '<span class="lbl"></span>';
			    html += '</label>';
			return html;
		}
		
		
		function checkRender(data,type,full) {
			if (data == '1') {
				html = '已审核';
			} else {
				html = '未审核';
			}			
			return html;		
		}
		
		function menuIdRender(data,type,full) {
			var html = $("#menuName").val();
			return html;		
		}
		
		function contentRender(data,type,full) {
			if (data.length > 100)
			{
				return data.substr(0,100)+'...';
			}
			else
			{
				return data;
			}
		}
		
		function timeRender(data,type,full) {
			return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
		}
		
		
		function typeRender(data,type,full) {
			var info = null;
			switch(data)
			{
				case 1:
					info = "置顶";break;
				case 2:
					info = "不置顶";break;
				default: info = "数据出错";
			}
			return info;
		}
		
		//<a href="${link.siteurl}" target='_blank'></a>
		function opRender(data,type,full) {		
			//alert('full='+JSON.stringify(full));
			var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
			<c:if test="${update == true}">
				+"<a title=\'更新\' class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+data+"\') >"
				+"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
			</c:if>
				+"<a title=\'预览\' class=\'green\' href=\'javascript:void(0);\'; onclick=previewData(\'"+data+"\')>"
				+"<i class=\'ace-icon fa fa-eye bigger-130\'></i></a>"
			<c:if test="${delete == true}">
				+"<a title=\'删除\' class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
				+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
			</c:if>
			<c:if test="${audit == true}">
				+"<a title=\'审核\' class=\'red\' href=\'javascript:void(0);\' onclick=auditOne(\'"+data+"\');>"
				+"<i class=\'ace-icon fa fa-check-square-o bigger-130\'></i></a>"
			</c:if>
				+"</div>"
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
			var menuid = ${menuid};
			//alert(type);
			aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) });
		    //alert(JSON.stringify(aoData)); 
		    var url = sSource;
		    var json = { 'aoData': JSON.stringify(aoData),"menuid": menuid };
		    fnAjaxGet(url,json,function(resp) {
		    	//alert(JSON.stringify(resp));
				fnCallback(resp);
			});		    
		}
		
		
		var resourceUrl = "<c:url value='/res/listJson'/>";
		var resourceColJson = [
						  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
						  {"mDataProp": "restype", "sClass":"center","bSortable":true, "mRender": resourceTypeRender},
						  {"mDataProp": "resname", "sClass":"center","bSortable": false,"bSearchable": false, "mRender": previewRender},
						];		
		//初始化 datatables
		var resourceCallBackFunc = resourceCallAjaxFunc;
		oResourceTable = fnInitDataTables('#resource-data-table',resourceUrl,resourceColJson,resourceCallBackFunc);
		
		function chkRender(data,type,full) {
			var html = '<label class="position-relative">';
			    html += '<input id="id" type="checkbox" class="ace" value="'+data+'"/>';
			    html += '<span class="lbl"></span>';
			    html += '</label>';
			return html;
		}
		
		function resourceTypeRender(data,type,full) {
			var info = null;
			switch(data)
			{
				case 1:
					info = "图片";break;
				case 2:
					info = "flash";break;
				case 3:
					info = "视频";break;
				case 4:
					info = "附件";break;
				default: info = "数据出错";
			}
			return info;
		}

		
		function previewRender(data,type,full) {
			//alert(JSON.stringify(full));encodeJson(JSON.stringify(full))
			/*
			if (full.restype == 1)
			{
				return "<span onmouseover=\"createDiv('" + full.smallpicurl+"/"+ full.restype + "')\" onmouseout=\"removeDiv('" + full + "')\">" + full.resname + "</span>";
			}
			else{
				return "<span onmouseover=\"createDiv('" + full.fileurl+"/"+ full.restype + "')\" onmouseout=\"removeDiv('" + full + "')\">" + full.resname + "</span>";
			}
			*/
			
			
			return "<span onmouseover=\"createDiv('" + encodeJson(JSON.stringify(full)) + "')\" onmouseout=\"removeDiv('" + full + "')\">" + full.resname + "</span>";

		}
		
		//回调函数
		function resourceCallAjaxFunc( sSource, aoData, fnCallback ) {
			aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) }); 
		    var url = sSource;
		    //alert(globalGroupID);
		    var json = { 'aoData': JSON.stringify(aoData),"restype": GlobleResourceType, "groupid":globalGroupID};
		    fnAjaxGet(url,json,function(resp) {
		    	//alert(JSON.stringify(resp));
				fnCallback(resp);
			});	
		}
				
	
	})
});


//init editors
/*
var editorScripts = ["<c:url value='/bootstrap/assets/js/bootstrap-wysiwyg.js'/>",
               "<c:url value='/bootstrap/assets/js/jquery-ui.custom.js'/>",
               "<c:url value='/bootstrap/assets/js/jquery.ui.touch-punch.js'/>",
               "<c:url value='/bootstrap/assets/js/jquery.hotkeys.js'/>",	               
               "<c:url value='/bootstrap/assets/js/bootbox.js'/>",
               "<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>",
               "<c:url value='/bootstrap/assets/js/jquery.colorbox.js'/>"]

$('.page-content-area').ace_ajax('loadScripts', editorScripts, function() {

	 jQuery(function($){
		 
		//初始化colorbox
		var $overflow = '';
		colorbox_params = {
			rel: 'colorbox',
			reposition: true,
			scalePhotos:false,
			scrolling:false,
			previous:'<i class="ace-icon fa fa-arrow-left"></i>',
			next:'<i class="ace-icon fa fa-arrow-right"></i>',
			close:'&times;',
			current:'{current} of {total}',
			maxWidth:'50%',
			maxHeight:'50%',
			onOpen:function(){
				$overflow = document.body.style.overflow;
				document.body.style.overflow = 'hidden';
			},
			onClosed:function(){
				document.body.style.overflow = $overflow;
			},
			onComplete:function(){
				$.colorbox.resize();
			}
		};

		$('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
		$("#cboxLoadingGraphic").html("<i class='ace-icon fa fa-spinner orange fa-spin'></i>");//let's add a custom loading icon
	
	
		$(document).one('ajaxloadstart.page', function(e) {
			$('#colorbox, #cboxOverlay').remove();
	   	});

		//初始化editor
		$('#editor1').ace_wysiwyg({
			toolbar:
			[
				'font',
				null,
				'fontSize',
				null,
				'foreColor',
				null,
				{name:'bold', className:'btn-info'},
				{name:'italic', className:'btn-info'},
				{name:'strikethrough', className:'btn-info'},
				{name:'underline', className:'btn-info'},
				null,
				{name:'insertunorderedlist', className:'btn-success'},
				{name:'insertorderedlist', className:'btn-success'},
				{name:'outdent', className:'btn-purple'},
				{name:'indent', className:'btn-purple'},
				null,
				{name:'justifyleft', className:'btn-primary'},
				{name:'justifycenter', className:'btn-primary'},
				{name:'justifyright', className:'btn-primary'},
				{name:'justifyfull', className:'btn-inverse'},
				null,
				{name:'createLink', className:'btn-pink'},
				{name:'unlink', className:'btn-pink'},
				null,
				{name:'insertImage', className:'btn-success',button_text:'onclickFunc()'},
				null,
				{name:'undo', className:'btn-grey'},
				{name:'redo', className:'btn-grey'},
				'viewSource'
			],
			'wysiwyg': {
				fileUploadError: showErrorAlert
			}
		}).prev().addClass('wysiwyg-style3');
	});
});
*/

var remoteSource_Resource = function(options, callback) {	
	var parent_id = null
	if( !('text' in options || 'type' in options) ){
		parent_id = 0;//load first level data
	}
	else if('type' in options && options['type'] == 'folder') {//it has children
		if('additionalParameters' in options && 'children' in options.additionalParameters)
			parent_id = options.additionalParameters['id']
	}	
	
	var url = "<c:url value='/res/treeListJson'/>";
	var json = {'id':parent_id,'grouptype':GlobleResourceType};		
	
	////alert(JSON.stringify(json));
	
	if(parent_id !== null) {
		fnAjaxPost(url,JSON.stringify(json),function(resp){
			//alert(JSON.stringify(resp));
			callback({ data: resp })
		});	
	}			
		
}

function treeSelected(e) {
	var items = $('#tree-resource').tree('selectedItems');
	var json = JSON.stringify(items);
	//alert('selected');
	
	var item = null;
	for(var i in items) {
		item = items[i];
		//pid = item.id;
	}
	
	if (item != null)
	{
		if (globalGroupID != item.id)
		{
			//alert(item.id);
			globalGroupID = item.id;
			//selectedId = item.id;
			oResourceTable.fnDraw();						
		}
	}
	else
	{
		//alert('123');
	}
}

function treeDeselected(e) {
	var items = $('#tree-resource').tree('selectedItems');
	var json = JSON.stringify(items);
	//alert('deselected');
	
	var item = null;
	for(var i in items) {
		item = items[i];
		//pid = item.id;
	}
	
	if (item == null)
	{
		globalGroupID = null;
		//selectedId = null;
		oResourceTable.fnDraw();
	}		
}

var uEditor;
var uEditorScripts = ["<c:url value='/ueditor/ueditor.config.js'/>",
                      "<c:url value='/ueditor/ueditor.all.js'/>",
                      "<c:url value='/ueditor/lang/zh-cn/zh-cn.js'/>"]
$('.page-content-area').ace_ajax('loadScripts', uEditorScripts, function() {

	jQuery(function($){
			//自定义按钮
			var uiName = "资源库";
			UE.registerUI(uiName,function(uEditor,uiName){
			    //注册按钮执行时的command命令，使用命令默认就会带有回退操作
			    uEditor.registerCommand(uiName,{
			        execCommand:function(){
			            alert('execCommand:' + uiName)
			        }
			    });

			    //创建一个button
			    var btn = new UE.ui.Button({
			        //按钮的名字
			        name:uiName,
			        //提示
			        title:uiName,
			        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
			        cssRules :'background-position: -726px -77px;',
			        //点击时执行的命令
			        onclick:function () {
			            //这里可以不用执行命令,做你自己的操作也可
			           //uEditor.execCommand(uiName);
			        	$("#modal-table-resource").draggable({
			      	      handle: ".modal-header"
				      	  });
				      	$("#modal-table-resource").modal('show');
			        }
			    });

			    //当点到编辑内容上时，按钮要做的状态反射
			    uEditor.addListener('selectionchange', function () {
			        var state = uEditor.queryCommandState(uiName);
			        if (state == -1) {
			            btn.setDisabled(true);
			            btn.setChecked(false);
			        } else {
			            btn.setDisabled(false);
			            btn.setChecked(state);
			        }
			    });

			    //因为你是添加button,所以需要返回这个button
			    return btn;
			}/*index 指定添加到工具栏上的那个位置，默认时追加到最后,editorId 指定这个UI是那个编辑器实例上的，默认是页面上所有的编辑器都会添加这个按钮*/);
			//初始化 
			if (uEditor)
			{
				uEditor.destroy();
			}
			uEditor = UE.getEditor('container',{
				toolbars: [[
				            'source', '|', 'undo', 'redo', '|',
				            'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
				            'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
				            'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
				           	'indent', 'justifyleft', 'justifycenter', 'justifyright', '|', 'touppercase', 'tolowercase', '|',
				            'link', 'unlink', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', 'template',
				            'horizontal', 'date', 'time', 'spechars',
				            'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols',
				            'preview', 'searchreplace'
				        ]],
				 enableContextMenu: true,
				 autoHeightEnabled:false,
				 allowDivTransToP: false,
				 zIndex:9999
			});
		});			
	});
var treeScripts = ["<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"];
$('.page-content-area').ace_ajax('loadScripts', treeScripts, function() {

	jQuery(function($){
			$('#tree-resource').ace_tree({
				'dataSource': remoteSource_Resource, //sampleData['dataSource1'],
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
			//var selectedId = null;
	
			$('#tree-resource').on('selected.fu.tree',treeSelected);
			
			$('#tree-resource').on('deselected.fu.tree', treeDeselected);
		
		});
			
	});



	//弹出上传窗口
	function showUploadImgModal(){
		$('#uoload-modal').modal('show');
	}

	//上传图片
	function upload(){
		var form = new FormData(document.getElementById("uploadFileId"));
		$.ajax({
			url:"<c:url value='/cms/upload'/>",
			type:"post",
			data:form,
			processData:false,
			contentType:false,
			success:function(data){
				$('#htmlurl').val(data);
				console.log("result is :"+data)
				$('#uoload-modal').modal('hide');
			},
			error:function(e){
				errMsgBox("上传失败");
			}
		});
	}
</script>
