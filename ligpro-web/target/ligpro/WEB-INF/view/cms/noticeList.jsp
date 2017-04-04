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
			<c:if test="${type == 1}">
				<shiro:hasPermission name="company:c">
		       	<button id="addBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
					<fmt:message key="add" />
				</button>
				</shiro:hasPermission>
				
				<shiro:hasPermission name="company:d">
				<button id="delBtn" class="btn btn-white btn-default btn-round">
					<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
				</button>
				</shiro:hasPermission>
			</c:if>
			
			<c:if test="${type == 2}">
				<shiro:hasPermission name="news:c">
		       	<button id="addBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
					<fmt:message key="add" />
				</button>
				</shiro:hasPermission>
				
				<shiro:hasPermission name="news:d">
				<button id="delBtn" class="btn btn-white btn-default btn-round">
					<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
				</button>
				</shiro:hasPermission>
			</c:if>
			
			<c:if test="${type == 3}">
		       	<shiro:hasPermission name="pro:c">
		       	<button id="addBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
					<fmt:message key="add" />
				</button>
				</shiro:hasPermission>
				
				<shiro:hasPermission name="pro:d">
				<button id="delBtn" class="btn btn-white btn-default btn-round">
					<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
				</button>
				</shiro:hasPermission>
			</c:if>
			
			<c:if test="${type == 4}">
		       	<shiro:hasPermission name="ser:c">
		       	<button id="addBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
					<fmt:message key="add" />
				</button>
				</shiro:hasPermission>
				
				<shiro:hasPermission name="ser:d">
				<button id="delBtn" class="btn btn-white btn-default btn-round">
					<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
				</button>
				</shiro:hasPermission>
			</c:if>
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
		
		<div id="titie"
			style="position: absolute; top: 500px; width: auto; background-color: #E7F3FF; display: none; z-index: 100000; border: 1px solid #e1e3e4; padding: 5px; -moz-border-radius-topright: 10px; -moz-border-radius-bottomright: 10px; -webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -webkit-border-top-right-radius: 10px; -webkit-border-bottom-right-radius: 10px;">
		</div>
		
	</div>



	<div id="modal-table" class="modal fade" tabindex="-1">		
			<div class="modal-dialog" style="height: 60%; width: 80%;">
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
								<input type="text" id="menuid" name="menuid" class="hidden"/>									
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="type"><fmt:message key="type" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="typeText" name="typeText" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="menuid"><fmt:message key="menuid" /></label>
							<div class="col-sm-9">
								<div class="clearfix">									
									<input type="text" id="menuname" name="menuname" class="col-xs-10 col-sm-5"/>
									<button id="addMenuBtn" class="btn btn-sm btn-primary"><fmt:message key="menuName" /></button>
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="title"><fmt:message key="title" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="title" name="title" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="keyword"><fmt:message key="keyword" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="keyword" name="keyword"
									class="col-xs-10 col-sm-5" />
									</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="content"><fmt:message key="content" /></label>
							<div class="col-sm-9" style="width:70%">
								<div class="clearfix">
									<input type="text" id="content" name="content" class="hidden" />
									<div class="wysiwyg-editor" id="editor1"></div>
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="seqno"><fmt:message key="menu_seqno" /></label>
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
								for="ischeck"><fmt:message key="ischeck" /></label>
							<div class="col-sm-9">
								<div class="radio inline">
									<label>
										<input id="checked" name="ischeck" type="radio" class="ace" value="1"/>	
										<span class="lbl"><fmt:message key="enable" /></span>								
									</label>
									
								</div>
		
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
	
	<div id="modal-table-tree" class="modal fade" tabindex="-1">		
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title-tree"><fmt:message key="op.success" />
							</span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
					<form id="MyTreeForm" method="post" class="form-horizontal" role="form">
						<div class="form-group">
							<div id="treeShowDiv" class="col-sm-9">
								<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>								
							</div>
						</div>
					</form>
					</div>
					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
						</button>

						<button id="saveMenuBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i><fmt:message key="confirm" />
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
	</div>
	
	
	<div id="modal-table-resource" class="modal fade" tabindex="-1">		
			<div class="modal-dialog" style="height: 100%; width: 60%; margin-top:200px">
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
											  <li data-toggle="tab"><a href="#tabpane-resource" onclick='showReource("video")'>影音</a></li>
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
		menuid: {
			required: true
		},
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
		
		type: {
			required: true,
			numberCheck: true
		},

		ischeck: {
			required: true
		}
	},

	messages: {
		menuid: {
			required: "不能为空."
		},
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
		type: {
			required: "不能为空."
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

	jQuery.validator.addMethod("numberCheck", function(value, element) {       
	    return this.optional(element) || /^[1-4]+$/.test(value);       
	}, "只能输入1-4的数字!");
	
	jQuery.validator.addMethod("stringCheck", function(value, element) {       
        return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);       
   }, "只能包含英文、数字、下划线等字符");
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
	
	$('maintab').tab();
	var globalGroupID = null;
	var GlobleResourceType = 2;
	
	var colorbox_params = null;
	
	function getGalleryDate(groupId){
		var url = "<c:url value='/res/listGallery'/>";
		var json = {'groupid':groupId,'restype': 1,'iDisplayLength':20,'iDisplayStart':0};
		json = JSON.stringify(json);
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));
			var html = "";
			for(var i = 0;i< obj.length;i++){
				var picUrl = '<fmt:message key="Base_Path" />'+obj[i].bigpicurl;
				console.log(picUrl);
				html += "<li>"+
					"<a href="+picUrl+" title=\"图片名称\" data-rel=\"colorbox\">"+
					"<img width=\"150\" height=\"150\" alt=\"150x150\" src="+picUrl+" />"+
					"</a>"+
					"<div class=\"tags\">"+
					"<span class=\"label-holder\">"+
					"<span class=\"label label-warning arrowed-in\">图片名称</span>"+
					"</span>"+
					"</div>"+
					"<div class=\"tools\">"+
					"<a href=\"#\">"+
					"<i class=\"ace-icon fa fa-link\"></i>"+
					"</a>"+
					"<a href=\"#\">"+
					"<i class=\"ace-icon fa fa-paperclip\"></i>"+
					"</a>"+
					"<a href=\"#\">"+
					"<i class=\"ace-icon fa fa-pencil\"></i>"+
					"</a>"+
					"<a href=\"#\" onclick=\"deletePic("+obj[i].id+")\">"+
					"<i class=\"ace-icon fa fa-times red\"></i>"+
					"</a>"+
					"</div>";
			}
			$('#picture').html(html);
			$('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
		});
	}
	
	function showReource(tabid)
	{
		//alert(tabid);
		if (tabid == 'image')
		{
			$('#resource-table-div').show();
			$('#resource-colorbox-div').hide();
			globalGroupID = null;
			GlobleResourceType = 1;
			getGalleryDate(globalGroupID);
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
							var htm = '<img src=<%=path%>'+obj[i].fileurl+'>';
							$('#editor1').append(htm);
						}

						break;
					case 2:
						{
							var srcFile = '<%=path%>'+obj[i].fileurl;
							var html = '<embed src='+srcFile+' width="600" height="300" wmode="transparent" autostart="false" loop="false" />';

						   // alert(html);
								
							$('#editor1').append(html);
						}
						break;
					case 3:
						{
							var htm =   '<video id="example_video_1" class="video-js vjs-default-skin" controls="controls" preload="none" width="650" height="300" '+'poster=<c:url value="/html/vedio-js/vedioBg.jpg"/>'+
							         ' data-setup={example_option:true}>'+
							        '<source src=<%=path%>'+obj[i].fileurl+' type="video/mp4" /><p class="vjs-no-js">您的浏览器不支持html5</p></video>';
							$('#editor1').append(htm);
						}
						break;
					case 4:
						{
							var fileurl = obj[i].fileurl;
							var filename = fileurl.substr(fileurl.lastIndexOf("/")+1, fileurl.length);
							var htm = '<a href="<%=path%>/res/download/'+obj[i].id+'">'+filename+'</a>';
							$('#editor1').append(htm);
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
	
	//解决内容过长的问题
	function rowformaterdir(value) {
	    if (value == null || value == undefined){
	    	return '';
	    }else{
	    	if(value.length > 25){
	    		return "<span onmouseover=\"createDiv('" + transferString(value) + "')\" onmouseout=\"removeDiv('" + transferString(value) + "')\">" + value.substring(0,25)+"......" + "</span>";
	    	}else{
	    		return value;
	    	}
	    }
	}
	
	function createDiv(val) {
	    var e = window.event
	    // //这里可得到鼠标X坐标
	    var pointX = e.pageX;
	    //这里可以得到鼠标Y坐标
	    var pointY = e.pageY;
	    $("#titie").css("top", pointY + 20);
	    $("#titie").css("margin-left", pointX);
	    $("#titie").html("<span>" + val + "</span>");
	    $("#titie").show();
	}
	function removeDiv(val) {
	    $("#titie").hide();
	}
	//替换文本所有的换行符
	function transferString(content)  
	{  
	    var string = content;  
	    try{  
	        string=string.replace(/\r\n/g,"<BR>")  
	        string=string.replace(/\n/g,"<BR>");  
	    }catch(e) {  
	        alert(e.message);  
	    }  
	    return string;  
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
				deleteObj(idList);
			}
		});
	}
	
	//更新编辑
	function updateObj(id) {
		// init data
		validator.resetForm();
		resetFrom();
		//clean editor
		$('#menuid').attr("disabled",false);
		$('#editor1').html('');
		// init data
		var idJson = {"id":id};
		var url = "<c:url value='/cms/queryById'/>";	
		fnAjaxPost(url,JSON.stringify(idJson),function(res){
			var obj = JSON.parse(JSON.stringify(res));		
			$('#typeText').attr("disabled",false);
			//*
			//alert(html_encode(json));
			//var obj = JSON.parse(json);
			$("#menuid").val(obj.menuid);
			$("#title").val(obj.title);
			$("#type").val(obj.type);
			var info = null;
			switch(obj.type)
			{
				case 1:
					info = "公司动态";break;
				case 2:
					info = "行业新闻";break;
				case 3:
					info = "服务";break;
				case 4:
					info = "产品";break;
				default: info = "数据出错";
			}
			$('#typeText').val(info);
			$('#typeText').attr("disabled",true);
			$("#keyword").val(obj.keyword);
			$("#seqno").val(obj.seqno);
			
			$('#editor1').append(html_decode(obj.content));
			if (obj.ischeck == 1)
			{
				$("#checked").attr("checked","checked");
			}
			else
			{
				$("#unchecked").attr("checked","checked");
			}
			$("#id").val(obj.id);
			$('#menuid').attr("disabled",true);
			$("#modal-title").html("编辑!");
			$("#modal-table").modal("show");
		});
	}
	
	
	//新增
	$('#addBtn').click(addData);
	function addData() {
		$('#menuid').attr("disabled",true);
		$('#type').attr("disabled",false);
		$("#modal-title").html("新增!");
		$("#modal-table").modal("show");
		validator.resetForm();
		resetFrom();
		$('#editor1').html('');
		$('#id').val(null);
		var type = ${type};
		var info = null;
		switch(type)
		{
			case 1:
				info = "公司动态";break;
			case 2:
				info = "行业新闻";break;
			case 3:
				info = "服务";break;
			case 4:
				info = "产品";break;
			default: info = "数据出错";
		}
		$('#typeText').val(info);
		$('#type').val(type);
		
		$('#typeText').attr("disabled",true);
		
		
	}
	

	//保存
	$("#saveBtn").click(saveData);
	function saveData() {
		if(!$('#MyForm').valid()) {
			return;
		}

		var type = ${type};
		var id = $('#id').val();
		var formData = $("#MyForm").serializeJSON();
		formData.id = id;
		formData.type = type;
		formData.menuid = $('#menuid').val();
		var editorContent = $('#editor1').html();
		//alert(editorContent);
		formData.content = html_encode(editorContent);
		var json = JSON.stringify(formData);
		//console.log(editorContent);
		//alert(json);
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
	
	//选择菜单
	$("#addMenuBtn").click(addMenu);
	function addMenu(){
		//alert('测试');
		$("#modal-title-tree").html("选择菜单!");
		$("#modal-table-tree").modal('show');
				
		$('#treeShowDiv').html('');
		$('#treeShowDiv').append('<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>');
		
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
			'folderSelect': true
		});	
		
		return false;
		

	}

	//保存
	$("#saveMenuBtn").click(saveMenuData);
	function saveMenuData() {
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
			errMsgBox("请选择一个菜单!");
		}
		
		//alert(item.id+" 菜单名称："+item.menuname);
		$('#menuname').attr("disabled",false);
		$('#menuid').val(item.id);
		$('#menuname').val(item.menuname);
		$('#menuname').attr("disabled",true);
		//$('#menuid').attr("disabled",true);
		$("#modal-table-tree").modal('hide');
	}

	function onclickFunc() {
		$("#modal-table-resource").modal('show');
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
							  {"mDataProp": "menuid", "sClass":"center","bSortable":true},
							  {"mDataProp": "keyword", "sClass":"left","bSortable": true,"bSearchable": false },
							  {"mDataProp": "content", "sClass":"left","bSortable": true,"bSearchable": false, "mRender": contentRender},
							  {"mDataProp": "type", "sClass":"center","bSortable":true,"mRender": typeRender},
							  {"mDataProp": "seqno", "sClass":"left","bSortable": true,"bSearchable": false },
							  {"mDataProp": "addtime", "sClass":"left","bSortable": true,"bSearchable": false, "mRender": timeRender},							  
							  {"mDataProp": "ischeck", "sClass":"center","bSortable": false,"bSearchable": false , "mRender": checkRender},
							  {"mDataProp": "id", "sClass": "left","bSearchable": false,"bSortable": false,"mRender": opRender}
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
				//var html = '';
				var date = new Date(data);
				return date.toLocaleString();
			}
			
			function typeRender(data,type,full) {
				var info = null;
				switch(data)
				{
					case 1:
						info = "公司动态";break;
					case 2:
						info = "行业新闻";break;
					case 3:
						info = "服务";break;
					case 4:
						info = "产品";break;
					default: info = "数据出错";
				}
				return info;
			}
			
			
			function opRender(data,type,full) {			
				//alert('full='+JSON.stringify(full));
				var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
				<c:if test="${type == 1}">
					<shiro:hasPermission name="company:u">
					+"<a class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+data+"\') >"
					+"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
					</shiro:hasPermission>
					
					<shiro:hasPermission name="company:d">
					+"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
					+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
					</shiro:hasPermission>					
				</c:if>
				
				<c:if test="${type == 2}">
					<shiro:hasPermission name="news:u">
					+"<a class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+data+"\') >"
					+"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
					</shiro:hasPermission>
					
					<shiro:hasPermission name="news:d">
					+"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
					+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
					</shiro:hasPermission>
					
				</c:if>
				
				<c:if test="${type == 3}">
			       	<shiro:hasPermission name="pro:u">
					+"<a class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+data+"\') >"
					+"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
					</shiro:hasPermission>
					
					<shiro:hasPermission name="pro:d">
					+"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
					+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
					</shiro:hasPermission>
					
				</c:if>
				
				<c:if test="${type == 4}">
					<shiro:hasPermission name="ser:u">
						+"<a class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+data+"\') >"
						+"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
					</shiro:hasPermission>
					
					<shiro:hasPermission name="ser:d">
					+"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
					+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
					</shiro:hasPermission>
				</c:if>
				+"</div>";
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
				var type = ${type};
				//alert(type);
				aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) });
			    //alert(JSON.stringify(aoData)); 
			    var url = sSource;
			    var json = { 'aoData': JSON.stringify(aoData),"type": type };
			    fnAjaxGet(url,json,function(resp) {
			    	//alert(JSON.stringify(resp));
					fnCallback(resp);
				});		    
			}
			
			
			var resourceUrl = "<c:url value='/res/listJson'/>";
			var resourceColJson = [
							  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
							  {"mDataProp": "restype", "sClass":"center","bSortable":true, "mRender": resourceTypeRender},
							  {"mDataProp": "fileurl", "sClass":"center","bSortable": false,"bSearchable": false },
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
						info = "影音";break;
					case 4:
						info = "附件";break;
					default: info = "数据出错";
				}
				return info;
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
		});
	});
	
	
	//init tree
	var remoteSource = function(options, callback) {	
		var parent_id = null
		if( !('text' in options || 'type' in options) ){
			parent_id = 0;//load first level data
		}
		else if('type' in options && options['type'] == 'folder') {//it has children
			if('additionalParameters' in options && 'children' in options.additionalParameters)
				parent_id = options.additionalParameters['id']
		}	
		
		var url = "<c:url value='/menu/listJsonWithoutFirst'/>";
		
		var json = {'id':parent_id};		
		
		////alert(JSON.stringify(json));
		
		if(parent_id !== null) {
			fnAjaxPost(url,JSON.stringify(json),function(resp){
				//alert(JSON.stringify(resp));
				callback({ data: resp })
			});	
		}			
			
	}
	
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
	
	var treeScripts = ["<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"];
	$('.page-content-area').ace_ajax('loadScripts', treeScripts, function() {

	jQuery(function($){
		
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
		});
	
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
			var selectedId = null;
		
			$('#tree-resource').on('selected.fu.tree', function(e) {
				var items = $('#tree-resource').tree('selectedItems');
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
						globalGroupID = item.id;
						if (item.grouptype == 1)
						{
							getGalleryDate(globalGroupID);
						}
						else
						{
							selectedId = item.id;
							oResourceTable.fnDraw();
						}
						
					}
				}
				else
				{
					//alert('123');
				}
				
			});
			
			$('#tree-resource').on('deselected.fu.tree', function(e) {
				var items = $('#tree-resource').tree('selectedItems');
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
					if (item.grouptype == 1)
					{
						getGalleryDate(globalGroupID);
					}
					else
					{
						selectedId = null;
						oResourceTable.fnDraw();
					}
				}
				
			});
				
		});

</script>
