$(document).ready(function(){
		$("tbody[id='data']>tr").each(function(i){
			$(this).attr("checked","0");
			$(this).attr("row",i+1);
			//��td�� row\col����
			$(this).children("td").each(function(j){
				$(this).addClass("noNewLine");//ǿ�Ʋ�����  break-all�Զ�����
			});
		});
		//���ñ��������еı�����ɫ
		$("table[class='maintab_content_table'] > tbody[id='data'] > tr:even").addClass("tr_even");
		$("table[class='maintab_content_table'] > tbody[id='data'] > tr:odd").addClass("tr_odd");
		//��꾭���и���
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

		//����и�����ʾ
		$("#data > tr").mousedown( function(){//���������
			var row = $(this).attr("row");
			if($(this).attr("checked")=="0"){
				//���ԭ��ѡ�е��е���ʽ
				$("tbody[id='data'] > tr[checked='1']").css("background-color", "");
				$("tbody[id='data'] > tr").attr("checked", "0");

				$("tbody[id='data'] > tr:nth-child("+ row +")").attr("checked", "1");
				$("tbody[id='data'] > tr:nth-child("+ row +")").css("background-color", "#FFE49F");
			}});
});