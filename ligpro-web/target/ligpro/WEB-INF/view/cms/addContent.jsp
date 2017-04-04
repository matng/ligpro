<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<title><fmt:message key="backStage_name" /></title>

<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/jquery-ui.custom.css'/>" />

<div class="row">
	<div class="col-xs-12">		
		<div class="row">
			<div class="col-sm-12">
				<div class="widget-box widget-color-blue2">
					<div class="widget-header">
						<!-- shiro:hasPermission name="menu:add" -->
						<button id="addNode" class="btn btn-white btn-info btn-round">
							<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 新增节点
						</button>

						<button id="editBtn" class="btn btn-white btn-default btn-round">
							<i class="ace-icon fa fa-pencil-square-o red2"></i> 编辑
						</button>
						<button id="delBtn" class="btn btn-white btn-default btn-round">
							<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> 删除
						</button>
					</div>

					<div class="widget-body">
						<div class="widget-main padding-8">
							<div class="wysiwyg-editor" id="editor1"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

</div><!-- /.row -->

<script src="<c:url value='/bootstrap/assets/js/ace-elements.js'/>"></script>

<script type="text/javascript">
	//添加节点
	$("#addNode").click(addNode);
	function addNode() {
		var html = $("#editor1").html();
		alert(html);
		$("#editor1").append(html);
	}
	var scripts = ["<c:url value='/bootstrap/assets/js/bootstrap-wysiwyg.js'/>",
	               "<c:url value='/bootstrap/assets/js/jquery-ui.custom.js'/>",
	               "<c:url value='/bootstrap/assets/js/jquery.ui.touch-punch.js'/>",
	               "<c:url value='/bootstrap/assets/js/jquery.hotkeys.js'/>",	               
	               "<c:url value='/bootstrap/assets/js/bootbox.js'/>"]
	
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

		 jQuery(function($){
	

			$('#editor1').ace_wysiwyg({
				toolbar:
				[
					'font',
					null,
					'fontSize',
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
					{name:'insertImage', className:'btn-success', button_text:'onclickFunc()'},
					null,
					'foreColor',
					null,
					{name:'undo', className:'btn-grey'},
					{name:'redo', className:'btn-grey'}
				],
				'wysiwyg': {
					fileUploadError: showErrorAlert
				}
			}).prev().addClass('wysiwyg-style3');
		
			
			
			/**
			//make the editor have all the available height
			$(window).on('resize.editor', function() {
				var offset = $('#editor1').parent().offset();
				var winHeight =  $(this).height();
				
				$('#editor1').css({'height':winHeight - offset.top - 10, 'max-height': 'none'});
			}).triggerHandler('resize.editor');
			*/
			
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
	
	function onclickFunc() {
		alert('@@@@@@@@@@123');
	}
	
</script>
