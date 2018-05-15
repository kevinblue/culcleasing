$(document).ready(function(){
		//设置表格的奇数行的背景颜色
		$("table[class='maintab_content_table'] > tbody[id='data'] > tr:even").addClass("tr_even");
		$("table[class='maintab_content_table'] > tbody[id='data'] > tr:odd").addClass("tr_odd");
		//给tbody[id=data]的tr\td添加属性
		$("tbody[id='data']>tr").each(function(i){
			$(this).attr("checked","0");
			//给td加 row\col属性
			$(this).children("td").each(function(j){
				$(this).attr("row",i+1);
				$(this).attr("col",j+1);
				$(this).attr("checked","0");
				$(this).addClass("noNewLine");//强制不换行  break-all自动换行
			});
		});

		//鼠标经过离开时颜色的交替变化
		$("table[class='maintab_content_table'] > tbody[id='data'] > tr>td").hover(
     		function(){//鼠标经过
				var row = $(this).attr("row");
				var col = $(this).attr("col");
				if($("tbody[id='data'] > tr:nth-child("+ row +")").attr("checked")=="0"){
					$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "#D6F2FC");//#D6F2FC
				}
				if($("tbody[id='data'] > tr > td:nth-child("+ col +")").attr("checked")=="0"){
					$("tbody[id='data'] > tr > td:nth-child("+ col +")").css("background-color", "#D6F2FC");
				}
     		},function(){//鼠标离开
				var row = $(this).attr("row");
				var col = $(this).attr("col");
				if($("tbody[id='data'] > tr:nth-child("+ row +")").attr("checked")=="0"){
					$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "");
				}
				if($("tbody[id='data'] > tr > td:nth-child("+ col +")").attr("checked")=="0"){
					$("tbody[id='data'] > tr > td:nth-child("+ col +")").css("background-color", "");
				}
     		});
     	//鼠标点击后的颜色变化
     	$("table[class='maintab_content_table'] > tbody[id='data'] > tr>td").mousedown(
			function(){//鼠标点击按下
				var row = $(this).attr("row");
				var col = $(this).attr("col");
				if($(this).attr("checked")=="0"){
					//清除原先选中的列的样式
					$("tbody[id='data'] > tr[checked='1']").css("background-color", "");
					$("tbody[id='data'] > tr > td[checked='1']").css("background-color", "");
					$("tbody[id='data'] > tr").attr("checked", "0");
					$("tbody[id='data'] > tr > td").attr("checked", "0");

					$("tbody[id='data'] > tr:nth-child("+ row +")").attr("checked", "1");
					$("tbody[id='data'] > tr > td:nth-child("+ col +")").attr("checked", "1");
					$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "#D6E7F7");
					$("tbody[id='data'] > tr > td:nth-child("+ col +")").css("background-color", "#D6E7F7");
				}
			});
	});