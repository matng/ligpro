

function html_encode(str)   
{   
  var s = "";   
  if (str.length == 0) return "";   
  s = str.replace(/&/g, "&amp;");   
  s = s.replace(/</g, "&lt;");   
  s = s.replace(/>/g, "&gt;");   
  s = s.replace(/ /g, "&nbsp;");   
  s = s.replace(/\'/g, "&#39;");   
  s = s.replace(/\"/g, "&quot;");   
  s = s.replace(/\n/g, "<br>");   
  return s;   
}   
 
function html_decode(str)   
{ 
  var s = "";   
  if (str.length == 0) return "";   
  s = str.replace(/&amp;/g, "&");
  s = s.replace(/&lt;/g, "<");
  s = s.replace(/&gt;/g, ">"); 
  s = s.replace(/&nbsp;/g, " ");
  s = s.replace(/&#39;/g, "\'");
  s = s.replace(/&quot;/g, "\"");
  s = s.replace(/<br>/g, "\n"); 
  return s;   
}


/**
 * 把form表单值转json串
 */

(function($) {
	$.fn.serializeJSON = function() {
		var serializeObj = {};
		var array = this.serializeArray();
		var str = this.serialize();
		$(array).each(
				function() {
					if (serializeObj[this.name]) {
						if ($.isArray(serializeObj[this.name])) {
							serializeObj[this.name].push(this.value);
						} else {
							serializeObj[this.name] = [
									serializeObj[this.name], this.value ];
						}
					} else {
						serializeObj[this.name] = this.value;
					}
				});
		return serializeObj;
	};
})(jQuery);

/**
 * 把json串的双引号编码
 */
function encodeJson(json) {
	json = json.replace(/\"/g, "~");
	json = json.replace(/"/g, "~");
	return json;
}

/**
 * 把json串的双引号解码
 */
function decodeJson(json) {
	return json.replace(/~/g, "\"");
}

/**
 * 取datatables 选中的checkbox的id值
 */
function fnGetIDs(tableId) {
	var ids = new Array();
	$(tableId).find('tr > td:first-child input:checkbox').each(function() {
		if (this.checked) {
			ids.push(this.value);
		}
	});
	return ids;
}

/**
 * Post ajax
 * @param url
 * @param jsondata
 */
function fnAjaxPost(url, jsondata, func) {
	console.log("###@@@ jsondata=" + jsondata);
	$.ajax({
		"type" : "post",
		"contentType" : "application/json; charset=utf-8",
		"url" : url,
		"dataType" : "json",
		"data" : jsondata,
		"success" : func,
		"error" : function(error) {
			console.log(error);
		}
	});
}

/**
 * get ajx
 * @param url
 * @param jsondata
 */
function fnAjaxGet(url, jsondata, func) {
	$.ajax({
		"type" : "get",
		"contentType" : "application/json; charset=utf-8",
		"url" : url,
		"dataType" : "json",
		"data" : jsondata,
		"success" : func,
		"error" : function(error) {
			console.log(error);
		}
	});
}

/**
 * 初始化 dataTables.
 * @param tableId
 * @param ajaxUrl
 * @param colJsonDef
 * @param func
 * @returns
 */
function fnInitDataTables(tableId, ajaxUrl, colJsonDef, func) {
	var oTable = $(tableId).dataTable(
					{
						"bAutoWidth" : false,
						"sServerMethod" : "POST",
						"bPaginate" : true,
						"bFilter" : true,
						"bSort" : true,
                        "aoColumnDefs": [
                            {
                                sDefaultContent: '',
                                aTargets: [ '_all' ]
                            }
                        ],
						"aaSorting" : [],
						"bSortClasses" : false,
						//"bStateSave": true,		
						"aoColumns" : colJsonDef,
						"bProcessing" : true,
						"bServerSide" : true,
						"sAjaxSource" : ajaxUrl,
						"fnServerData" : func,
						"language" : {
							"sLengthMenu" : "每页 _MENU_ 条记录",
							"sZeroRecords" : "没有找到记录",
							"sInfo" : "当前显示 _START_ 到 _END_ 条，(共 _TOTAL_ 条记录), 当前第 _PAGE_ 页,共 _PAGES_ 页",
							"sInfoEmpty" : "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
							"sEmptyTable" : "无记录",
							"sInfoFiltered" : "(从 _MAX_ 条记录过滤)",
							//"sProcessing":"数据加载中...",
							"sSearch" : "搜索",
							"oPaginate" : {
								"sPrevious" : "上一页",
								"sNext" : "下一页",
								"sFirst" : "首页",
								"sLast" : "末页"
							}
						}
					});

	$(document).on(
			'click',
			'th input:checkbox',
			function() {
				var that = this;
				$(this).closest('table').find(
						'tr > td:first-child input:checkbox').each(function() {
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
			});
	return oTable;
}

/**
 * 取datatables columns
 * @param jsonObj
 * @returns
 */
function getDataTablesColumns(jsonObj) {
	var cols = '';
	for ( var i in jsonObj) {
		cols += jsonObj[i].mDataProp + ',';
	}
	return cols.substr(0, cols.length - 1);
}

/**
 * reset all the form
 */
function resetFrom() {
	$('form').each(function(index) {
		$('form')[index].reset();
	});
}

//对Date的扩展，将 Date 转化为指定格式的String 
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1, //月份 
		"d+" : this.getDate(), //日 
		"h+" : this.getHours(), //小时 
		"m+" : this.getMinutes(), //分 
		"s+" : this.getSeconds(), //秒 
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
		"S" : this.getMilliseconds()
	//毫秒 
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

function msgBox(text){
	$.gritter.add({
		title: '提示',
		text: text,
		class_name: 'gritter-success gritter-light'
	});
}

function errMsgBox(text){
	$.gritter.add({
		title: '提示',
		text: text,
		class_name: 'gritter-error gritter'
	});
}