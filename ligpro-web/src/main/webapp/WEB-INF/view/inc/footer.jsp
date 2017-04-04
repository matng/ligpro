<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!-- basic scripts -->
		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='<c:url value='/bootstrap/js/jquery.min.js'/>'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
		<script type="text/javascript">
		 window.jQuery || document.write("<script src='<c:url value='/bootstrap/js/jquery1x.min.js'/>'>"+"<"+"/script>");
		</script>
		<![endif]-->
		
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='<c:url value='/bootstrap/js/jquery.mobile.custom.min.js'/>'>"+"<"+"/script>");
		</script>
		
		
		<script src="<c:url value='/bootstrap/js/bootstrap.min.js'/>"></script>

		<!-- page specific plugin scripts -->

		<!--[if lte IE 8]>
		  <script src="<c:url value='/bootstrap/js/excanvas.min.js'/>"></script>
		<![endif]-->
		<script src="<c:url value='/bootstrap/assets/js/fileinput.js'/>"></script>
		<script src="<c:url value='/bootstrap/assets/js/fileinput_locale_LANG.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/bootstrap-select.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/jquery.gritter.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/bootbox.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/jquery.validate.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/Jslib.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/jquery-ui.custom.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/jquery.ui.touch-punch.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/jquery.easypiechart.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/jquery.sparkline.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/flot/jquery.flot.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/flot/jquery.flot.pie.min.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/flot/jquery.flot.resize.min.js'/>"></script>

		<script src="<c:url value='/bootstrap/js/ace.js'/>"></script>
		<script src="<c:url value='/bootstrap/assets/js/ace-elements.js'/>"></script>
		<script src="<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"></script>
		
		
		<!-- ace scripts
		<script src="<c:url value='/bootstrap/js/ace/elements.scroller.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/elements.colorpicker.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/elements.fileinput.js'/>'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/elements.typeahead.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/elements.wysiwyg.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/elements.spinner.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/elements.treeview.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/elements.wizard.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/elements.aside.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.ajax-content.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.touch-drag.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.sidebar.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.sidebar-scroll-1.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.submenu-hover.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.widget-box.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.settings.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.settings-rtl.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.settings-skin.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.widget-on-reload.js'/>"></script>
		<script src="<c:url value='/bootstrap/js/ace/ace.searchbox-autocomplete.js'/>"></script>
		-->
		
		
		
		
		
		