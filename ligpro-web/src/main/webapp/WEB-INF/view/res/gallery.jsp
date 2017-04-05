<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<title><fmt:message key="backStage_name" /></title>

<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/colorbox.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/fileinput.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />

<!-- ajax layout which only needs content area -->

<div class="row">
	<div class="col-xs-2">
			<div class="widget-box widget-color-blue2">
				<div class="widget-header">
					<shiro:hasPermission name="gallery:c">
					<button id="addNodeBtn" class="btn btn-white btn-info btn-round">
						<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 新增
					</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="gallery:u">
					<button id="editNodeBtn" class="btn btn-white btn-default btn-round">
						<i class="ace-icon fa fa-pencil-square-o red2"></i> 编辑
					</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="gallery:d">
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
		<div class="table-header" style="margin-bottom: 10px;padding-bottom:5px">
			<shiro:hasPermission name="gallery:c">
			<button id="upLoadBtn" class="btn btn-white btn-info btn-round">
				<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 上传图片
			</button>
			</shiro:hasPermission>
		</div>
		<div>
			<ul class="ace-thumbnails clearfix" id="picture">
			</ul>
		</div>
		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
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
	<!-- add by tl in 150116 -->
	<div id="modal-table-resource-slidePicUrl" class="modal fade" tabindex="-1">		
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header no-padding">
					<div class="table-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">
							<span class="white">&times;</span>
						</button>
						<span id="modal-title-resource-slidePicUrl">轮播图</span>
					</div>
				</div>

				<div id="modal-body" class="modal-body no-padding">
				<form id="MyResourceslidePicUrlForm" method="post" class="form-horizontal" role="form">
					<div class="form-group">
						<div class="col-sm-9">
							<input type="text" id="id" name="id" class="hidden" /> 
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label no-padding-right"
							for="slidepicdetailsurl">链接页面url</label>
						<div class="col-sm-9">
							<div class="clearfix">
							<input type="text" id="slidepicdetailsurl" name="slidepicdetailsurl" class="col-xs-10 col-sm-7"/>
							</div>
						</div>
					</div>
				</form>
				</div>

				<div class="modal-footer no-margin-top">

					<button class="btn btn-sm" data-dismiss="modal">
						<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
					</button>

					<button id="saveslidePicUrlBtn" class="btn btn-sm btn-primary">
						<i class="ace-icon fa fa-check"></i><fmt:message key="confirm" />
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /add by tl in 150116 -->
	
	<form method=post name="formx1" id="formx1" style='display:none'>
		<input type=hidden name="groupid" id="p_groupid">
		<input type=hidden name="restype" id="p_restype">
	</form>
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">

var globalGroupId = null;
var colorbox_params = null;
var nodeName = null;
var remoteSource = null;


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


	function changePicType(id,type,dbType){
		var newType;
		console.log(type == dbType);
		console.log(type);
		if(type == dbType){
			newType = 0;
		}else{
			newType = type;
		}
		var url = "<c:url value='/res/changePictureType'/>";
		var json = {'id':id,'usetype': newType};
		json = JSON.stringify(json);
		console.log(json);
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));
			if(obj.success){
				msgBox(obj.success);
				getGalleryDate(globalGroupId);
			}else{
				errMsgBox(obj.error);
			}
		});
		
		
		//return false;
		
	}
	
	//--------add by tl in 151116
	    //轮播图按钮点击并弹出url输入框
		function changePicTypeSlidePic(id,type,dbType,slidePicDetailsUrl){  
		var newType;
		console.log(type == dbType);
		console.log(type);
		if(type == dbType){
			newType = 0;
		}else{
			newType = type;
		}
		var url = "<c:url value='/res/changePictureType'/>";
		//151116
		if(newType!=0)
		{
			//打开模态框
			$('#slidepicdetailsurl').val(slidePicDetailsUrl);
			$('#id').val(id);
			$('#modal-table-resource-slidePicUrl').modal('show');
			$("#modal-table-resource-slidePicUrl").draggable({
			      handle: ".modal-header"
			  });
		}
		var json = {'id':id,'usetype': newType};
		json = JSON.stringify(json);
		console.log(json);
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));
			if(obj.success){
				msgBox(obj.success);
				getGalleryDate(globalGroupId);
			}else{
				errMsgBox(obj.error);
			}
		});
		//return false;
		
	}

	//校验URL
	function IsURL(str_url){ 
/*	        var strRegex = "^((https|http|ftp|rtsp|mms)?://)"  
	        + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@  
	        + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184  
	        + "|" // 允许IP和DOMAIN（域名） 
	        + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.  
	        + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名  
	       + "[a-z]{2,6})" // first level domain- .com or .museum  
	       + "(:[0-9]{1,4})?" // 端口- :80  
	       + "((/?)|" // a slash isn't required if there is no file name  
	       + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$"; 
*/
		   var strRegex = "^((https|http|ftp|rtsp|mms)?://)"; 
	       var re=new RegExp(strRegex);  
	       if (re.test(str_url)){ 
	           return (true);  
	       }else{  
	    	   errMsgBox("请输入以http://或https://开头的完整网址");
	           return (false);  
	       } 
	   } 
	
	
	//保存url数据
	$("#saveslidePicUrlBtn").click(saveslidePicUrlData);
	function saveslidePicUrlData() {
		var id=$('#id').val();
		var formData = $("#MyResourceslidePicUrlForm").serializeJSON();
		formData.id = id;
		
		if(IsURL(formData.slidepicdetailsurl))
		{
			var json = JSON.stringify(formData);
			var url = "<c:url value='/res/changePictureType'/>";		
			
			fnAjaxPost(url,json,function(res){
				var obj = JSON.parse(JSON.stringify(res));		
				if (obj.success) {
					$("#modal-table-resource-slidePicUrl").modal('hide');
					resetFrom();
					msgBox(obj.success);	
				} else {
					errMsgBox(obj.error);
				}
			});		
		}
	}
	

	
	//---------------------------

	//图片显示类型
	function showPicType(flag){
		var info;
		switch(flag){
		case 1 : info="<fmt:message key='picture_logo_info' />";break;
		case 2 : info="<fmt:message key='picture_slider_info' />";break;
		case 3 : info="<fmt:message key='picture_hot_info' />";break;
		default : info = "";
		}
		return info;
	}
	
	function getGalleryDate(groupId){
		var url = "<c:url value='/res/listGallery'/>";
		var json = {'groupid':groupId,'restype': 1,'iDisplayLength':20,'iDisplayStart':0};
		json = JSON.stringify(json);
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));
			var html = "";
			var set = "<fmt:message key='picture_set'/>";
			var unset = "<fmt:message key='picture_set'/>";
			for(var i = 0;i< obj.length;i++){
				var picUrl = '<fmt:message key="Base_Path" />'+obj[i].bigpicurl;
				//var ob = obj[i].usetype==1?"<fmt:message key='picture_unset'/>":"<fmt:message key='picture_set'/>";
				var ob1 = obj[i].usetype==2?"<fmt:message key='picture_unset'/>":"<fmt:message key='picture_set'/>";  //151113
				var ob2 = obj[i].usetype==3?"<fmt:message key='picture_unset'/>":"<fmt:message key='picture_set'/>";
				console.log("picUrl====="+picUrl);
				html += "<li>"+
					"<a href="+picUrl+" title="+obj[i].resname+" data-rel=\"colorbox\">"+
					"<img width=\"150\" height=\"150\" alt=\"150x150\" src="+picUrl+" />"+
					"</a>"+
					"<div class=\"tags\">"+
					"<span class=\"label-holder\">"+
					"<span class=\"label label-danger arrowed-in\">"+showPicType(obj[i].usetype)+"</span>"+
					"</span>"+
					"<span class=\"label-holder\">"+
					"<span class=\"label label-success arrowed-in\">"+obj[i].resname+"</span>"+
					"</span>"+
					"</div>"+
					"<div class=\"tools\">"+
					//"<a href=\"#\" title="+ob+"<fmt:message key='picture_logo_info' /> onclick=\"changePicType("+obj[i].id+",1,"+obj[i].usetype+");\" >"+
					//"<i class=\"ace-icon fa fa-leaf\"></i>"+
					//"</a>"+
					"<a href=\"#\" title="+ob1+"<fmt:message key='picture_slider_info' /> onclick=\"changePicTypeSlidePic("+obj[i].id+",2,"+obj[i].usetype+",\'"+obj[i].slidePicDetailsUrl+"\');\" >"+  //151116 tl  
					"<i class=\"ace-icon fa fa-desktop\"></i>"+
					"</a>"+
					"<a href=\"#\" title="+ob2+"<fmt:message key='picture_hot_info' /> onclick=\"changePicType("+obj[i].id+",3,"+obj[i].usetype+");\" >"+
					"<i class=\"ace-icon fa fa-bullhorn\"></i>"+
					"</a>"
					<shiro:hasPermission name="gallery:d">
					+"<a href=\"#\" title=<fmt:message key='picture_delete' /> onclick=\"deletePic("+obj[i].id+")\">"+
					"<i class=\"ace-icon fa fa-times red\"></i>"+
					"</a>"
					</shiro:hasPermission>
					+"</div>";
			}
			$('#picture').html(html);
			$('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
		});
	}
	
	function deletePic(id){
		var ids=[id];
		bootbox.confirm("确定删除？", function(result) {
			if(result){
				var url = "<c:url value='/res/delete'/>";
				var json = {"idList":ids};
				fnAjaxPost(url,JSON.stringify(json),function(res){
					var obj = JSON.parse(JSON.stringify(res));		
					if (obj.success) {
						getGalleryDate(globalGroupId);
						msgBox(obj.success);
					} else {
						errMsgBox(obj.error);
					}
				});
	  		}else{
	  			return;
	  		}
		});
	}
	//上传图片
	$("#upLoadBtn").click(upLoader);
	function upLoader() {
		if (globalGroupId == null)
		{
			bootbox.alert("请选择一个分组上传!");
			return;
		}
		var json = {"restype":1,"groupid":globalGroupId,'bigpicurl':nodeName};
		$("#fileinput-div").html('');
		$("#fileinput-div").html('<input id="upLoadInput" type="file" class="file" name="file" multiple data-preview-file-type="any" data-upload-url="<c:url value="/res/upload"/>">');
		$("#upLoadInput").fileinput({
			uploadExtraData:{"extraData":JSON.stringify(json)},
			allowedFileTypes:['image'],
			ajaxSettings:{
				'success':mysuccess
			}
		});
		$('#modal-table').modal('show');
		$("#modal-table").draggable({
		      handle: ".modal-header"
		  });
	}

	function mysuccess()
	{
		$('#modal-table').modal('hide');
		getGalleryDate(globalGroupId);
	}
	//添加节点
	$("#addNodeBtn").click(addGroupNode);
	function addGroupNode() {
		validator.resetForm();
		resetFrom();
		$("#modal-title-resource-group").html("新增!");
		$('#modal-table-resource-group').modal('show');
		$("#modal-table-resource-group").draggable({
		      handle: ".modal-header"
		  });
		$('#groupid').val(null);
		var groupType = 1;
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
		formData.grouptype = 1;
	
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
			    nodeName = item.text;
			    getGalleryDate(globalGroupId);
		   }else{
		   }
	  }); 
	}
	
	//编辑
	$("#editNodeBtn").click(updateSelectObj);
	function updateSelectObj() {
		validator.resetForm();
		resetFrom();
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
			$('#menuUrl').val(item.menuUrl);
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
		$("#modal-table-resource-group").draggable({
		      handle: ".modal-header"
		  });
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
	
	var scripts = ["<c:url value='/bootstrap/assets/js/jquery.colorbox.js'/>",
	               "<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		jQuery(function($) {
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
		})
		
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
			
			var json = {'id':parent_id,'grouptype': 1};		
			
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
				nodeName = item.text;
				getGalleryDate(globalGroupId);
			}else{
			}
        });	
		
	});
</script>
