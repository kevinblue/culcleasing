$(document).ready(function(){
		$("tbody[id='data']>tr").each(function(i){
			$(this).attr("checked","0");
			$(this).attr("row",i+1);
			//给td加 row\col属性
			$(this).children("td").each(function(j){
				$(this).addClass("noNewLine");//强制不换行  break-all自动换行
			});
		});
		//设置表格的奇数行的背景颜色
		$("table[class='maintab_content_table'] > tbody[id='data'] > tr:even").addClass("tr_even");
		$("table[class='maintab_content_table'] > tbody[id='data'] > tr:odd").addClass("tr_odd");
		//鼠标经过行高亮
		$("#data > tr").mouseover(function(){
			var row = $(this).attr("row");
			if($("tbody[id='data'] > tr:nth-child("+ row +")").attr("checked")=="0"){
				$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "#CBEEFE");
			}
		  // $(this).css("FILTER","progid:DXImageTransform.Microsoft.Gradient(startColorStr='#FFD975', endColorStr='#F7B600', gradientType='0')");
		  // $(this).addClass("yt");
		 }).mouseout(function(){
			var row = $(this).attr("row");
			if($("tbody[id='data'] > tr:nth-child("+ row +")").attr("checked")=="0"){
				$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "");
			}
		 })

		//点击行高亮显示
		$("#data > tr").mousedown( function(){//鼠标点击按下
			var row = $(this).attr("row");
			if($(this).attr("checked")=="0"){
				//清除原先选中的列的样式
				$("tbody[id='data'] > tr[checked='1']").css("background-color", "");
				$("tbody[id='data'] > tr").attr("checked", "0");

				$("tbody[id='data'] > tr:nth-child("+ row +")").attr("checked", "1");
				$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "#FFE49F");
			}});
});