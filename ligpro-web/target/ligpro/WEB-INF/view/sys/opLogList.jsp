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
		</div>

		<div>
			<table id="data-table"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
					<!-- 
						<th class="center"><label class="position-relative">
								<input type="checkbox" class="ace" /> <span class="lbl"></span>
						</label></th>
					 -->
					 	<th>ID </th>   <!-- add by tl in 150602 -->
						<th>操作项</th>
						<th>登陆IP地址</th>
						<th>登陆用户ID</th>
						<th>登陆账号</th>
						<th>操作时间</th>
						<th>日志内容</th>
						<th>详细</th>
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
							<span id="modal-title">详细</span>
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
								for="title">操作项</label>
							<div class="col-sm-9">
								<textarea id="title" name="title" rows="2"
									class="col-xs-10 col-sm-5" readonly></textarea>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="loginIP">登陆IP地址
							</label>
							<div class="col-sm-9">
								<textarea id="loginIP" name="loginIP" rows="1"
									class="col-xs-10 col-sm-5" readonly></textarea>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="userId">登陆用户ID</label>
							<div class="col-sm-9">
								<textarea  id="userId" name="userId" rows="1"
									class="col-xs-10 col-sm-5" readonly></textarea>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="loginName">登陆账号</label>
							<div class="col-sm-9">
								<textarea  id="loginName" name="loginName" rows="1"
									class="col-xs-10 col-sm-5" readonly></textarea>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="opTime">操作时间</label>
							<div class="col-sm-9">
								<textarea id="opTime" name="opTime" rows="1"
									class="col-xs-10 col-sm-5"  readonly></textarea>
							</div>
						</div>
						

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="content">日志内容</label>
							<div class="col-sm-9">
								<textarea id="content" name="content"  rows="5" 
								class="col-xs-10 col-sm-10"  readonly></textarea>
							</div>
						</div>
						</form>
					</div>

					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm btn-primary" data-dismiss="modal">
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

//显示明细                   
function Details(rowData) {
	// init data
	$("#title").val(null);
	$("#loginIP").val(null);  
	$("#userId").val(null);  
	$("#loginName").val(null);
	$("#opTime").val(null);  
	$("#content").val(null);
	$("#id").val(null);	
	
	var obj = JSON.parse(unescape(rowData));
	
	$("#title").val(obj.title);
	$("#loginIP").val(obj.loginip);  
	$("#userId").val(obj.userid);  
	$("#loginName").val(obj.loginname);
	$("#opTime").val(obj.optimeStr);  
	$("#content").val(obj.content);
	$("#id").val(obj.id);
}




/**
* define datatables.
**/
var oTable;
var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>"]
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

	jQuery(function($) {	
		var url = "<c:url value='/oplog/listJson'/>";
		var colJson = [
						  {"mDataProp": "id","sWidth":"3%","sClass":"center", "bSortable": true,"bSearchable": false}, 
						  {"mDataProp": "title","sWidth":"12%","sClass":"center","bSortable":false,"bSearchable": false,"mRender": displayRenderTitle},
						  {"mDataProp": "loginip","sWidth":"10%","sClass":"center","bSortable": false,"bSearchable": false },
						  {"mDataProp": "userid","sWidth":"10%","sClass":"center","bSortable": false,"bSearchable": false },
						  {"mDataProp": "loginname","sWidth":"10%","sClass":"center","bSortable": false,"bSearchable": true},
						  {"mDataProp": "optimeStr","sWidth":"15%", "sClass":"center","bSortable": false,"bSearchable": false},
						  {"mDataProp": "content","sWidth":"35%", "sClass": "left","bSearchable": true,"bSortable": false,"mRender": displayRenderContent},
						  {"mDataProp": "id","sWidth":"5%","sClass": "center","bSearchable": false,"bSortable": false,"mRender": opRender}
						 ];
		
		var callBackFunc = callAjaxFunc;	
		//初始化 datatables
		oTable = fnInitDataTables('#data-table',url,colJson,callBackFunc);
	
		//title列固定显示14字符，超过五十个字符可在最右端点击查看详细
		function displayRenderTitle(data,type,full) {		
			var html = '';	
			var showLength=30;
			
			if (data.length<=showLength) {
				html = data;
			} else {
				var showData=data.substr(0,showLength);
				html =showData;
			}			
			return html;		
		}
		
		
		
		//日志内容列固定显示40字符，超过五十个字符可在最右端点击查看详细
		function displayRenderContent(data,type,full) {		
			var html = '';	
			var showLength=40;
			
			if (data.length<=showLength) {
				html = data;
			} else {
				var showData=data.substr(0,showLength);
				html =showData;
			}			
			return html;		
		}
		
		
		function opRender(data,type,full) {		
			var row_data=escape(JSON.stringify(full));
			var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"+
			"<a title=\'详细\' class=\'green\' href=\'javascript:void(0);\' onclick=Details(\'"+row_data+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"+
			"<i class=\'ace-icon fa fa-search bigger-130\'></i></a></div>"
			return html;		
		}
		
		
		//回调函数
		function callAjaxFunc( sSource, aoData, fnCallback ) {
			aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) });
		    //alert(JSON.stringify(aoData)); 
		    var url = sSource;
		    var json = { 'aoData': JSON.stringify(aoData) };
		    fnAjaxGet(url,json,function(resp) {
		    	//alert(JSON.stringify(resp));
				fnCallback(resp);
			});		    
		}					
	
	})
});

</script>
