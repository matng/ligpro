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
			<a href="#modal-table" role="button" class="green"
				data-toggle="modal">
				<shiro:hasPermission name="link:c">
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
			<shiro:hasPermission name="link:d">
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
						<th>网站名称</th>
						<th>网址</th>
						<th>网站logo路径</th>
						<th>链接类型</th>
						<th>排序号</th>
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
								for="sitename">网站名称</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="sitename" name="sitename"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="siteurl">网址
							</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input id="siteurl" name="siteurl" type="text" id="form-field-2"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="logourl">logo路径</label>
							<div class="col-sm-9">
								<div class="clearfix">
									<input type="text" id="logourl" name="logourl"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="linktype">链接类型</label>
							<div class="col-sm-9">
								<div class="radio inline">
									<div class="clearfix">
										<label>
											<input name="linktype" type="radio" class="ace" value="1"/>
											<span class="lbl">文字</span>
										</label>
									</div>
								</div>
		
								<div class="radio inline">
									<label>
										<input name="linktype" type="radio" class="ace" value="2"/>
										<span class="lbl">logo链接</span>
									</label>
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="seqno">排序号</label>
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
								for="isenable">状态</label>
							<div class="col-sm-9">
								<div class="radio inline">
									<div class="clearfix">
										<label>
											<input name="isenable" type="radio" class="ace" value="1"/>	
											<span class="lbl">生效</span>								
										</label>
									</div>
								</div>
		
								<div class="radio inline">
									<label>
										<input name="isenable" type="radio" class="ace" value="0"/>
										<span class="lbl">失效</span>
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

</div>
<!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
//删除方法
function deleteObj(ids){	
	var url = "<c:url value='/link/delete'/>";
	var json = {"idList":ids};
	fnAjaxPost(url,JSON.stringify(json),function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		if (obj.success) {
//			alert(obj.success);
			msgBox(obj.success); 
			oTable.fnDraw();
//			$.gritter.add({
//				title: '测试!',
//				text: 'haha.',
//				class_name: 'gritter-success  gritter-light'
//			}); 
	
		} else {
//			alert(obj.error);
			msgBox(obj.error); 
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
        alert('请选择一条记录操作。');
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
	// init data
	$("#modal-title").html("编辑!");
	$("#modal-table").draggable({
	      handle: ".modal-header"
	  });
	var obj = JSON.parse(decodeJson(json));
	$("#sitename").val(obj.sitename);
	$("#siteurl").val(obj.siteurl);  
	$("#logourl").val(obj.logourl);  

	var linktype=document.getElementsByName("linktype");
	for(var i=0;i<linktype.length;i++)
		{
			if(linktype.item(i).value==obj.linktype)
				{
				linktype.item(i).checked=true;
				}
		}
	
	$("#seqno").val(obj.seqno);  
	
	var isenable=document.getElementsByName("isenable");
	for(var i=0;i<isenable.length;i++)
		{
			if(isenable.item(i).value==obj.isenable)
				{
				isenable.item(i).checked=true;
				}
		}
	$("#id").val(obj.id);
}

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

	var validator = $("#MyForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	
	focusInvalid: false,
	ignore: "",
	rules: {
		sitename: {
			stringCheck:true,
			sitenameCheck:true,
			required: true,
			maxlength:100  
		},
		siteurl: {
			required: true,
			maxlength:200
		},
		logourl: {
			required: true,
			maxlength:200
		},
		linktype: {
			required: true,
		},
		seqno: {
			digits: true,
			required: true
		},		
		isenable:{
			required:true
		}
	},

	messages: {
		sitename: {
			required: "不能为空.",
			maxlength:"输入长度应小于100字符",
		},
		siteurl: {
			required: "不能为空.",
			maxlength:"输入长度应小于200字符"
		},
		logourl: {
			required:"不能为空.",
			maxlength:"输入长度应小于200字符"
		},
		linktype: {
			required: "请选择状态."
		},
		seqno: {
			required: "不能为空.",
			digits: "请输入整数"
		},
		isenable: {
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

	jQuery.validator.addMethod("sitenameCheck", function(value, element) {    
		var res=true;
		//后台查询名称是否重复------------
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
		url = "<c:url value='/link/check'/>";
		fnAjaxPostSync(url,json,function(data){
			var obj = JSON.parse(JSON.stringify(data));	
			if (!obj.success) {
				res=false;
			} 
		});
		
        return this.optional(element) || res;       
   }, "网站名称已存在 请重新输入");

	jQuery.validator.addMethod("stringCheck", function(value, element) {       
//        return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);  //英文、数字、下划线等字符       
//   }, "只能包含英文、数字、下划线等字符");
      return this.optional(element) || /^[\u4e00-\u9fa5a-zA-Z0-9 ]+$/.test(value);  //中文英文数字和空格等字符       
   }, "只能包含中文英文数字和空格等字符");






//保存
$("#saveBtn").click(saveData);  //点击元素时会发生click事件，响应saveData函数
function saveData() {
//	var dataCheckRes=DataCheck();	
	if(/*dataCheckRes*/$('#MyForm').valid()){
		var formData;
		var json; 

		var title=$("#modal-title").text();
		var url;
		if(title=="编辑!")
			{
				var id = $('#id').val(); 
				formData = $("#MyForm").serializeJSON();   //Jquery将表单转化为json对象
				formData["id"]=id;
				json = JSON.stringify(formData);			
				url= "<c:url value='/link/edit'/>";
			}
			else{
				formData = $("#MyForm").serializeJSON();   //Jquery将表单转化为json对象
				json = JSON.stringify(formData);
				url = "<c:url value='/link/save'/>";
			}	
		fnAjaxPost(url,json,function(res){
			var obj = JSON.parse(JSON.stringify(res));	
			if (obj.success) {
//				alert(obj.success);
				msgBox(obj.success); 
				$("#modal-table").modal('hide');  //bootstrap手动隐藏一个模态框
				resetFrom();
				oTable.fnDraw();
//				$.gritter.add({
//					title: '测试!',
//					text: 'haha.',
//					class_name: 'gritter-success  gritter-light'
//				});
		
			} else {
//				alert(obj.error);
				msgBox(obj.success); 
			}
		});
	}

}


//新增                              
$("#newBtn").click(newData);
function newData() {
		$("#modal-title").html("新增!");
		$("#modal-table").draggable({
		      handle: ".modal-header"
		  });
		$("#sitename").val(null);
		$("#siteurl").val(null);		
		$("#logourl").val(null);  
		var linktype=document.getElementsByName("linktype");
		for(var i=0;i<linktype.length;i++)
			{
				linktype.item(i).checked=false;
			}	
		
		$("#seqno").val(null);  
		var isenable=document.getElementsByName("isenable");
		for(var i=0;i<isenable.length;i++)
			{
				isenable.item(i).checked=false;
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
		var url = "<c:url value='/link/listJson'/>";
		var colJson = [
						  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
						  {"mDataProp": "sitename", "sClass":"center","bSortable":true},
						  {"mDataProp": "siteurl", "sClass":"left","bSortable": true,"bSearchable": true },
						  {"mDataProp": "logourl", "sClass":"left","bSortable": false,"bSearchable": false },
						  {"mDataProp": "linktype", "sClass":"left","bSortable": false,"bSearchable": false,"mRender": linkRender},
						  {"mDataProp": "seqno", "sClass":"center","bSortable": true,"bSearchable": false},
						  {"mDataProp": "isenable", "sClass": "left","bSearchable": false,"bSortable": false,"mRender": statusRender},
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
			<shiro:hasPermission name="link:u">
			+"<a title=\'更新\' class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"
			+"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
			</shiro:hasPermission>
			<shiro:hasPermission name="link:d">
			+"<a title=\'删除\' class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
			+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
			</shiro:hasPermission>
			+"</div>"
			return html;		
		}
		
		function linkRender(data,type,full) {
			var html = '';
			if (data == '1') {
				html = '<span >文字</span>';
			} else if (data == '2')	{
				html = '<span >logo链接</span>';
			}			
			return html;		
		}
		
		function statusRender(data,type,full) {
			var html = '';
			if (data == '1') {
				html = '<span class="label label-sm label-success">生效</span>';
			} else {
				html = '<span class="label label-sm label-warning">失效</span>';
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
