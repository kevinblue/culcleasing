/**
 * 指定网页显示的编码
 * @param charset
 */
function addContentMeta(charset) {
    document.write('<meta http-equiv="content-type" content="text/html; charset=' + charset + '">');
}
/**
 * 加载js脚本
 */
function loadScript(url){
 	document.write('<script type="text/javascript" src="' + url + '" charset="utf-8"></script>');
}

/**
 * 加载css脚本
 */ 
function loadStyle(url){
    document.write('<link rel="stylesheet" type="text/css" href="' + url + '" charset="utf-8">');
}  

/*
// commons
loadScript(getBasePath()+"jquery.js");
loadScript(getBasePath()+"validator.js");
loadScript(getBasePath()+"calend.js");
loadStyle("../../css/global.css");

// datepicker
loadScript(getBasePath()+"widgets/jquery.datepicker/ui.datepicker.js");
loadScript(getBasePath()+"widgets/jquery.datepicker/zh-cn.js");
loadStyle(getBasePath()+"widgets/jquery.datepicker/ui.datepicker.css");

// js
loadScript("/tenwa/js/publicEvent.js");

// css
*/

/***********************************************************************************
 *** 加载完网页文档后做的事情
 *** 不要忘了加载query.js文件
 ***********************************************************************************/
if(typeOf($) == "undefined"){
	window.status = "~~~~~~~~~~~~~~~~~~ [" + window.document.title + "] 请加载 jquery.js 文件 !!!";
}else{
	$(document).ready(function(){
		//设置表格的奇数行的背景颜色
		//$("table[class=maintab_content_table] > tbody[id=data] > tr:even").addClass("tr_even");
		//$("table[class=maintab_content_table] > tbody[id=data] > tr:odd").addClass("tr_odd");
		//给tbody[id=data]的tr\td添加属性
		$("tbody[id='data']>tr").each(function(i){
			//给td加 row\col属性
			$(this).children("td").each(function(j){
				$(this).attr("row",i+1);
				$(this).attr("col",j+1);
				$(this).attr("checked","false");
				$(this).css("word-break","keep-all");//强制不换行  break-all自动换行
			});
		});

		//鼠标经过离开时颜色的交替变化
		$("table[class='maintab_content_table'] > tbody > tr>td").hover(
     		function(){//鼠标经过
				if($(this).attr("checked")=="false"){
					var row = $(this).attr("row");
					var col = $(this).attr("col");
						
					$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "#D6ECE4");
					$("tbody[id='data'] > tr > td:nth-child("+ col +")").css("background-color", "#D6ECE4");
				}
     		},function(){//鼠标离开
				if($(this).attr("checked")=="false"){
					var row = $(this).attr("row2");
					var col = $(this).attr("col2");
					
					$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "");
					$("tbody[id='data'] > tr > td:nth-child("+ col +")").css("background-color", "");
				}
     		});
     	//鼠标点击后的颜色变化
     	$("table[class=maintab_content_table] > tbody > tr>td").mousedown(
			function(){//鼠标点击按下
				var row = $(this).attr("row");
				var col = $(this).attr("col");
				if($(this).attr("checked")=="false"){
					$("tbody[id='data'] > tr > td").attr("checked", "false");
					$("tbody[id='data'] > tr > td:nth-child("+ col +")").attr("checked", "true");
					$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "#B4DDDC");
					$("tbody[id='data'] > tr > td:nth-child("+ col +")").css("background-color", "#B4DDDC");
				}
			});
     	
		// 使用datepicker
		$(".datepicker_input").datepicker();
	});
}

//
function getBasePath(){
	return "../../js/";
}





