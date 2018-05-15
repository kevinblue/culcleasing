/** 
 * 加载完毕document之后立马执行的js代码
 */
$(document).ready(function(){
	//checkBox 去边框
	$(":checkbox").css("border","none");
	var sqlIds = "";//选中数据的所有Id
	//页面全选
	$("input[name='ck_all']").click(function(){
		if($(this).attr("checked")){
			$("input[name='inverse_ck_all']").attr("checked",false);
			$("input[name='data_ck_all']").attr("checked",false);
			$("input[name='list']").attr("checked",true);
		}else{
			$("input[name='list']").attr("checked",false);
		}
	});
	//反选功能
	$("input[name='inverse_ck_all']").click(function(){
			$("input[name='ck_all']").attr("checked",false);
			$("input[name='data_ck_all']").attr("checked",false);
			$("input[name='list']").each(function(){
				$(this).attr("checked",!$(this).attr("checked"));
			});
	});
	//数据全选 -- 页面配合选中
	$("input[name='data_ck_all']").click(function(){
		if($(this).attr("checked")){
			$("input[name='inverse_ck_all']").attr("checked",false);
			$("input[name='ck_all']").attr("checked",false);
			$("input[name='list']").attr("checked",true);
		}else{
			$("input[name='list']").attr("checked",false);
		}
	});
});

/**
 * 将千分位数据恢复为无千分位数值  例如：345,324,123.87 ==> 345324123.87
 * para: dataNumb  -  要操作的值 
 *
**/
function currecyRecoverNum( dataNumb ){
   var resVal = dataNumb;
   resVal = resVal.replace(/,/g,"");
   if(isNaN(resVal)){
	   resVal = "0";
   }
   return resVal;
}

/**
 * 千分位数据的恢复数字显示  例如：345,324,123.87 ==> 345324123.87
 * para: srcNumber  -  元素域的值
 * para: name - 元素的Id的值
**/
function currecyRecoverNumShow(srcNumber,name){
	var zhi= currecyRecoverNum(srcNumber);
	$("#"+name).val(zhi);
}

/**
 * 将数据实现千分位显示  例如：345324123.87 ==> 345,324,123.87
 * para: dataNumb  -  要操作的值 
 *
**/
function numConvertCurrecy( dataNumb ){
   var srcNumber = dataNumb;
   
   //2.进行千分位拼接
	srcNumber=srcNumber.replace(/^(\d*)$/,"$1.");
	srcNumber=(srcNumber+"00").replace(/(\d*\.\d\d)\d*/,"$1");
	srcNumber=srcNumber.replace(".",",");
	var re=/(\d)(\d{3},)/;
	while(re.test(srcNumber)){
		srcNumber=srcNumber.replace(re,"$1,$2");
	}
	srcNumber=srcNumber.replace(/,(\d\d)$/,".$1");

	srcNumber = srcNumber.replace(/^\./,"0.");

   return srcNumber;
}

/** 
 * 金额千分位 拆分显示   例如：345324123.87 ===> 345,324,123.87 
 * para: srcNumber  -  元素域的值
 * para: name - 元素的Id的值
**/
function numConvertCurrecyShow(srcNumber,name){
	   var day = srcNumber;
		//1.校验输入是否为数字
		///^([1-9]+\.) | (\d\.) $/
		if (/[^0-9\.]/.test(srcNumber) || isNaN(srcNumber) ) {
			 alert("输入数据格式错误，请重新填写!");
			 $("#"+name).val("0");
			 document.getElementById(name).focus();
		}else{
			//2.进行千分位拼接
			srcNumber=srcNumber.replace(/^(\d*)$/,"$1.");
			srcNumber=(srcNumber+"00").replace(/(\d*\.\d\d)\d*/,"$1");		
			srcNumber=srcNumber.replace(".",",");
			var re=/(\d)(\d{3},)/;
			while(re.test(srcNumber)){
				srcNumber=srcNumber.replace(re,"$1,$2");
			}
			srcNumber=srcNumber.replace(/,(\d\d)$/,".$1");
			var zhi = srcNumber.replace(/^\./,"0.");
			document.getElementById(name).value = zhi;
		}
}

/**
 * 清除查询条件区域的输入信息
 */
function clearQuery(){
	$("#queryArea input").not(":button").val("");
    $("#queryArea select").val("");
}
/**
 * 点击查询条件区域的查询按钮
 */
 function query_submit(destUrl){
	 var $qForm = $("form[name='dataNav']");
	 $qForm.attr("action",destUrl);
	 $qForm.attr("target","_black");
	 $qForm.submit();
 }


//======#########=======导出excel对数据不进行操作，所以无需刷新界面======#########=======
/**
 * 选中数据导出excel,对选中的数据不做处理
 */
function validata_exp() {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});
  	
  	if (check_amount==0)  {
		alert("请勾选您要导出的项目!");
		return false;
	}else{
		var oldAction = $("form[name='dataNav']").attr("action"); 
		$("form[name='dataNav']").attr("action","../../func/exp_check.jsp");
		$("form[name='dataNav']").attr("target","_blank");
		if (confirm("您已勾选["+ check_amount +"]个项目,是否导出Excel?")) {//导出Excel
			var oVal = $("input[name='expsqlstr']").val();
			$("input[name='expsqlstr']").val(oVal+" ("+sqlIds.substring(0,sqlIds.length-1)+" )");
			//alert($("input[name='expsqlstr']").val());
			dataNav.submit();
		//	window.location.reload(true);
			$("form[name='dataNav']").attr("action",oldAction);
			$("form[name='dataNav']").attr("target","_self");
		}
		return false;
	} 
}

/**
 * 页面全选、数据全选功能加入
 * 选中数据导出excel,对选中的数据不做处理
 */
function validata_data_exp() {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

	//得到复选框的集合
	sqlIds="";
	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});
  	if (check_amount==0)  {
		alert("请勾选您要导出的项目!");
		return false;
	}else{
		var oldAction = $("form[name='dataNav']").attr("action"); 
		$("form[name='dataNav']").attr("action","../../func/exp_data_check.jsp");
		$("form[name='dataNav']").attr("target","_blank");
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否将数据全部导出为Excel?")) {//导出Excel
				$("input[name='expsqlstr']").val($.trim($("#export_type2").val()));
			
				dataNav.submit();
				$("form[name='dataNav']").attr("action",oldAction);
				$("form[name='dataNav']").attr("target","_self");
//				window.location.reload(true);
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否导出Excel?")) {//导出Excel
				$("input[name='expsqlstr']").val($.trim($("#export_type1").val())+" ("+sqlIds.substring(0,sqlIds.length-1)+" )");
				dataNav.submit();
				//window.location.reload(true);
				$("form[name='dataNav']").attr("action",oldAction);
				$("form[name='dataNav']").attr("target","_self");
			}
			return false;
		}
	} 
}


/**
 * 页面数据全部
 * 选中数据导出excel,对选中的数据不做处理
 */
function validata_data_report(destUrl,selfUrl) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	
	$("form[name='dataNav']").attr("action",destUrl);
	$("form[name='dataNav']").attr("target","_blank");
	//判断是否数据全选
	if (confirm("是否将数据全部导出为Excel?")) {//导出Excel
		dataNav.submit();
		$("form[name='dataNav']").attr('action',selfUrl);
		$("form[name='dataNav']").attr('target','_self');
	}
}

//========#######################=====导出excel对数据进行操作，需刷新界面======#######################=======
/**
 * 选中数据导出excel,对选中的数据会做处理
 * destUrl -- 做处理的jsp路径
 */
function validata_exp_do(destUrl) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});
  	
  	if (check_amount==0)  {
		alert("请勾选您要操作的选项!");
		return false;
	}else{
		if (confirm("您已勾选["+ check_amount +"]个项目,是否导出Excel?")) {//导出Excel
			var oVal = $("input[name='expsqlstr']").val();
			$("input[name='expsqlstr']").val(oVal+" ("+sqlIds.substring(0,sqlIds.length-1)+" )");
			//alert($("input[name='expsqlstr']").val()+"-------");
			
			$("form[name='dataNav']").attr("action",destUrl);
			$("form[name='dataNav']").attr("target","_blank");
			$("form[name='dataNav']").attr("method","post");
			//$("form[name='dataNav']").submit();

			dataNav.submit();
			window.location.reload(true);
		}
		return false;
	} 
}

/**
 * 选中数据审核
 */
function validata_sh(destUrl,saveType) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds+=id+"_";
	});
  	
  	if (check_amount==0)  {
		alert("请勾选您要操作的选项!");
		return false;
	}else{
		if (confirm("您已勾选["+ check_amount +"]个项目,是否审核通过?")) {//驳回
			$("#sqldata").val(sqlIds.substring(0,sqlIds.length-1));
			$("#savetype").val(saveType);
			
			$("form[name='dataNav']").attr("action",destUrl);
			$("form[name='dataNav']").attr("target","_blank");
	
 			dataNav.submit();
			window.location.reload(true);
		}
		return false;
	} 
}
/**
 * 选中数据驳回
 */
function validata_bh(destUrl,saveType) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds+=id+"_";
	});
  	
  	if (check_amount==0)  {
		alert("请勾选您要操作的选项!");
		return false;
	}else{
		if (confirm("您已勾选["+ check_amount +"]个项目,是否驳回?")) {//驳回
			$("#sqldata").val(sqlIds.substring(0,sqlIds.length-1));
			$("#savetype").val(saveType);
			//alert($("#sqldata").val()+"-------");
			
			$("form[name='dataNav']").attr("action",destUrl);
			$("form[name='dataNav']").attr("target","_blank");
			//$("form[name='dataNav']").submit();

			dataNav.submit();
			window.location.reload(true);
		}
		return false;
	} 
}
/**
 * 选中数据驳回
 */
function validata_bh3(destUrl,saveType) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds+="'"+id+"',";
	});
  	
  	if (check_amount==0)  {
		alert("请勾选您要操作的选项!");
		return false;
	}else{
		if (confirm("您已勾选["+ check_amount +"]个项目,是否驳回?")) {//驳回
			$("#sqldata").val(sqlIds.substring(0,sqlIds.length-1));
			$("#savetype").val(saveType);
			
			$("form[name='dataNav']").attr("action",destUrl);
			$("form[name='dataNav']").attr("target","_blank");
			//$("form[name='dataNav']").submit();

			dataNav.submit();
			window.location.reload(true);
		}
		return false;
	} 
}

/**
 * 选中数据驳回
 */
function validata_data_bh(destUrl,saveType) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds+=id+"_";
	});
  	
	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

  	if (check_amount==0)  {
		alert("请勾选您要操作的选项!");
		return false;
	}else{
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否撤销所有数据?")) {
				$("#choiceType").val("allData");
				$("input[name='expsqlstr']").val($.trim($("#bh_sqlstr").val()));
				$("#savetype").val(saveType);
				
				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");

				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否撤销?")) {//驳回
				$("#sqldata").val(sqlIds.substring(0,sqlIds.length-1));
				$("#savetype").val(saveType);
				
				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");

				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}
	} 
}

/**
 * 选中数据驳回
 */
function validata_data_bh2(destUrl,saveType) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds+="'"+id+"',";
	});
  	
	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

  	if (check_amount==0)  {
		alert("请勾选您要操作的选项!");
		return false;
	}else{
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否撤销所有数据?")) {
				$("#choiceType").val("allData");
				$("input[name='expsqlstr']").val($.trim($("#bh_sqlstr").val()));
				$("#savetype").val(saveType);
				
				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");

				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否撤销?")) {//驳回
				$("#sqldata").val(sqlIds.substring(0,sqlIds.length-1));
				$("#savetype").val(saveType);
				
				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");

				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}
	} 
}

/**
 * 选中数据审核
 */
function validata_data_sh(destUrl,saveType) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds+=id+"_";
	});
  	
  	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

	if (check_amount==0)  {
		alert("请勾选您要操作的选项!");
		return false;
	}else{
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否所有数据审核通过?")) {
				$("#choiceType").val("allData");
				$("input[name='expsqlstr']").val($.trim($("#bh_sqlstr").val()));
				$("#savetype").val(saveType);
				
				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");

				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否审核通过?")) {//驳回
				$("#sqldata").val(sqlIds.substring(0,sqlIds.length-1));
				$("#savetype").val(saveType);
				
				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");
		
				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}
	} 
}


/**
 * 财务数据转换公用函数
 * 页面全选、数据全选功能加入
 * 选中数据导出excel,刷新界面
 */
function finance_data_convert_exp(destUrl) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

	//得到复选框的集合
	sqlIds="";
	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});
  	if (check_amount==0)  {
		alert("请勾选您要导出的项目!");
		return false;
	}else{
		$("form[name='dataNav']").attr("action",destUrl);
		$("form[name='dataNav']").attr("target","_blank");
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否将数据全部导出为Excel?")) {//导出Excel
				$("input[name='choiceType']").val("allData");
				
				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否导出Excel?")) {//导出Excel
				$("#sqldata").val(sqlIds.substring(0,sqlIds.length-1));
				$("input[name='datasqlstr']").val("");
				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}
	} 
}

//###############=================报表导出功能函数===============#################

/**
 * 报表功能界面
 * 页面全选、数据全选功能加入
 * 选中数据导出excel,对选中的数据不做处理
 */
function validata_data_exp_big(url) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

	//得到复选框的集合
	sqlIds="";
	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});
  	if (check_amount==0)  {
		alert("请勾选您要导出的项目!");
		return false;
	}else{
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否将数据全部导出为Excel?")) {//导出Excel
				$("form[name='dataNav']").attr("action",url+"?exportType=all");
				$("form[name='dataNav']").attr("target","_blank");
			
				dataNav.submit();
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否导出Excel?")) {//导出Excel
				//付给隐藏域
				$("export_data_id").val(sqlIds.substring(0,sqlIds.length-1));
				dataNav.submit();
			}
			return false;
		}
	} 
}

/**
 * 报表界面，页面、数据全选操作，有数据经过计算
 */
function validata_report_data_exp(destUrl,selfUrl) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

	//得到复选框的集合
	sqlIds="";
	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});

  	if (check_amount==0)  {
		alert("请勾选您要导出的项目!");
		return false;
	}else{
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否将数据全部导出为Excel?")) {//导出Excel
				$("#choiceType").val("allData");

				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");

				dataNav.submit();
				$("form[name='dataNav']").attr("action",selfUrl);
				$("form[name='dataNav']").attr("target","_self");
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否导出Excel?")) {//导出Excel
				$("#sqldata").val(sqlIds.substring(0,sqlIds.length-1));
			
				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");
				
				dataNav.submit();
				$("form[name='dataNav']").attr("action",selfUrl);
				$("form[name='dataNav']").attr("target","_self");
			}
			return false;
		}
	} 
}

/**
 * 标准export_type1 与 export_type2
 * 页面全选、数据全选功能加入
 * 选中数据导出excel,对选中的数据不做处理
 */
function validata_data_report_exp(destUrl,selfUrl) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

	//得到复选框的集合
	sqlIds="";
	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});
  	if (check_amount==0)  {
		alert("请勾选您要导出的项目!");
		return false;
	}else{
		$("form[name='dataNav']").attr("action",destUrl);
		$("form[name='dataNav']").attr("target","_blank");
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否将数据全部导出为Excel?")) {//导出Excel
				$("input[name='expsqlstr']").val($.trim($("#export_type2").val()));
				dataNav.submit();
				$("form[name='dataNav']").attr('action',selfUrl);
				$("form[name='dataNav']").attr('target','_self');
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否导出Excel?")) {//导出Excel
				$("input[name='expsqlstr']").val($.trim($("#export_type1").val())+" ("+sqlIds.substring(0,sqlIds.length-1)+" )");
				dataNav.submit();
				$("form[name='dataNav']").attr('action',selfUrl);
				$("form[name='dataNav']").attr('target','_self');
			}
			return false;
		}
	} 
}

/**
 * 页面全选、数据全选功能加入，单独的导出功能
 * 选中数据导出excel,对选中的数据不做处理
 */
function validata_data_report_stand_exp(destUrl) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//判断是哪种选择方案
	var choiceType = $(":checkbox[name$='ck_all']:checked").attr("name");

	//得到复选框的集合
	sqlIds="";
	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});

  	if (check_amount==0)  {
		alert("请勾选您要导出的项目!");
		return false;
	}else{
		//判断是否数据全选
		if(choiceType=="data_ck_all"){
			if (confirm("是否将数据全部导出为Excel?")) {//导出Excel
			
				$("form[name='dataNav']").attr("action",destUrl+"?choiceType=allData");
				$("form[name='dataNav']").attr("target","_blank");

				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}else{
			if (confirm("您已勾选["+ check_amount +"]个项目,是否导出Excel?")) {//导出Excel
				$("input[name='sqldata']").val(sqlIds.substring(0,sqlIds.length-1));
			
				$("form[name='dataNav']").attr("action",destUrl);
				$("form[name='dataNav']").attr("target","_blank");
				
				dataNav.submit();
				window.location.reload(true);
			}
			return false;
		}
	} 
}


//======特别处理导出=========
/**
 * 租金网银核销全部导出
 * destUrl -- 做处理的jsp路径
 */
function validata_exp_do_all(destUrl) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//判断是否开户银行相同
	if( $("select[name='bank']").val()=="" ){
		alert("请您选择开户银行以保证当前数据正确！");
		return false;
	}
	//判断是否选择核销银行
	if( $("select[name='hxBank']").val()=="" ){
		alert("对不起，请您选择核销银行！");
		return false;
	}
	var flag = 0;
	//判断栓选的数据是否一致
	$("#data>tr").each(function(){
		if( $(this).find("td:eq(2)").text()!=$("select[name='bank']").val() ){
			flag = 1;
			alert("请您选择银行并执行查询！");
			return false;
		}
	});
	if(flag==1){
		return false;
	}

	//得到复选框的集合
	if (confirm("是否导出文件?")) {//导出Excel
		$("form[name='dataNav']").attr("action",destUrl);
		$("form[name='dataNav']").attr("target","_blank");

		dataNav.submit();
		window.location.reload(true);
	}
	return false;
}



