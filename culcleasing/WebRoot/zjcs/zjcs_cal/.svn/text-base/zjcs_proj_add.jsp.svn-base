<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="java.util.Date"%> 
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- 项目立项--拟商务条件 表：contract_condition_temp  项目交易结构-->
<title>租金测算 - 项目交易结构</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<!-- 日期控件 -->
<script src="../../js/calend.js"></script>
<script language="javascript"> 
/*
    方法含义：
        根据工式：净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出-首付款 计算‘净融资额’的值，
        设备款 equip_amt,保证金 caution_money,手续费 handling_charge,
        厂商返佣 return_amt,其他收入 other_income,咨询费 consulting_fee,其他支出 other_expenditure 
        计算之前对‘租赁本金’和‘保证金’进行空判断
    return:
        将计算后的值赋给‘净融资额’字段
    author:
        sea
    date:
        2010-05-10
         租赁本金①	设备款-首付款，自动计算，不可改
		首付款	手动输入金额，收款
		保证金	手动输入金额，收款
		净融资额	净融资额=①-②-③-④-⑤-⑥-⑦+⑧+⑨-⑩+11-12

		名称	收支情况
		1-设备金额	支
		2-首付款	     收
		3-租赁保证金	收
		4-租赁手续费	收
		5-管理费	    收
		6-残值收入	收
		7-厂商返利	收
		8-租前息	    收
		9-利息补贴	收
		11-其他收入	收
		13-咨询费收入	收

		10-贴现息	    支
		12-其他支出	支
		14-咨询费支出	支
		15-保费金额	支
*/
function assignment(){ 
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备款
	var first_payment = document.getElementsByName("first_payment")[0].value;//首付款
	var caution_money_value = document.getElementsByName("caution_money")[0].value;//保证金
	var lease_capital_value = document.getElementsByName("lease_money")[0].value;//租赁本金
	var handling_charge = document.getElementsByName("handling_charge")[0].value;//手续费
	var management_fee = document.getElementsByName("management_fee")[0].value;//管理费
	var nominalprice = document.getElementsByName("nominalprice")[0].value;//残值收入
	
	var return_amt = document.getElementsByName("return_amt")[0].value;//厂商返利
	var before_interest = document.getElementsByName("before_interest")[0].value;//租前息
	var rate_subsidy = document.getElementsByName("rate_subsidy")[0].value;//利息补贴
	var discount_rate = document.getElementsByName("discount_rate")[0].value;//贴现息
	
	var other_income = document.getElementsByName("other_income")[0].value;//其他收入
	var other_expenditure = document.getElementsByName("other_expenditure")[0].value;//其他支出

	var consulting_fee_in = document.getElementsByName("consulting_fee_in")[0].value;//咨询费收入
	var consulting_fee = document.getElementsByName("consulting_fee")[0].value;//咨询费支出
	var insure_money = document.getElementsByName("insure_money")[0].value;//保费金额
	
	if((lease_capital_value == null || lease_capital_value == '') || (caution_money_value == null || caution_money_value == '')){
		alert("租赁本金和保证金不能为空,净融资额=租赁本金-保证金!");
		document.all.lease_money.focus();
		return false;
	}else{ 
		var lease_amt_value ; 
		//净融资额=设备款-首付款-保证金-手续费-管理费-残值收入-厂商返利-租前息-利息补贴-其他收入-咨询费收入+贴现息+其他支出+咨询费支出+保费金额	
		// lease_amt_value = equip_amt - caution_money_value - handling_charge - return_amt - 
		// other_income + consulting_fee + other_expenditure-before_interest-management_fee;
		var value1 = FloatSub(equip_amt,first_payment);
		
		var value2 = FloatSub(FloatSub(value1, caution_money_value),handling_charge);
		//alert("__"+value1+"----"+value2);
		
		var value3 = FloatSub(value2, management_fee);
		var value4 = FloatSub(value3, nominalprice);
		
		var value5 = FloatSub(value4, return_amt);
		var value6 = FloatSub(value5, before_interest);
		
		var value7 = FloatSub(value6, rate_subsidy) ;
		var value8 = FloatSub(value7, other_income) ;
		var value9 = FloatSub(value8, consulting_fee_in);
		//alert("value9"+value9);

		var value10 = FloatAdd(discount_rate,other_expenditure);//加法的总和
		var value11 = FloatAdd(consulting_fee,insure_money);//加法的总和
		//alert(value10+">>>>>"+value11);
		
		lease_amt_value = FloatSub(value9,value10);
		lease_amt_value = FloatSub(lease_amt_value,value11);
		
		document.getElementsByName("net_lease_money")[0].value = lease_amt_value;
		//计算‘会计核算本金=净融资额加保证金’的值 accountPrincipal
		//var str_num = FloatAdd(caution_money_value,lease_amt_value);
		//document.getElementsByName("accountPrincipal")[0].value = str_num;
	}
	getlmp_value();
}

//会计核算本金赋值
function get_APValue(){
	var caution_money = document.getElementsByName("caution_money")[0].value;//保证金
	var net_lease_money = document.getElementsByName("net_lease_money")[0].value;
	if(caution_money == null || caution_money == '' || net_lease_money == null || net_lease_money == ''){
		alert("请选输入租赁保证金和净融资额的值!");
		return false;
	}else{
		//计算‘会计核算本金=净融资额加保证金’的值 accountPrincipal
		var str_num = FloatAdd(caution_money,net_lease_money);
		document.getElementsByName("accountPrincipal")[0].value = str_num;
	}
}
//浮点数加法运算   
 function FloatAdd(arg1,arg2){   
   var r1,r2,m;   
   try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}   
   try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}   
   m=Math.pow(10,Math.max(r1,r2))   
   return (arg1*m+arg2*m)/m   
  } 
 //浮点数减法运算   
 function FloatSub(arg1,arg2){   
	 var r1,r2,m,n;   
	 try{
	 		r1 = arg1.toString().split(".")[1].length
	 	}catch(e){
	 		r1=0
	 	}   
	 try{
	 		r2=arg2.toString().split(".")[1].length
	 	}catch(e){
	 		r2=0
	 	}   
	 m = Math.pow(10,Math.max(r1,r2));   
	 //动态控制精度长度   
	 n = (r1>=r2)?r1:r2;   
	 return ((arg1*m-arg2*m)/m).toFixed(n);   
 }   
  
/*
    方法含义：
        根据工式：租赁期限 = ( 换租次数*付租方式 ) 
       if(付租类型==期末,则‘租赁期限’= 租赁期限 + 付租方式),计算出‘租赁期限’的值，
        计算之前对‘付租类型’,‘付租方式’,‘还租次数’进行验证
       ‘付租方式’是否合理的依据是:1->月付|3->季付|6->半年付|12->年付
        在‘还租次数’input输入框触发该事件onchange
        在‘租赁期限(月)’input输入框触发该事件onclick
    return:
        将计算后的值赋给‘租赁期限’字段
    author:
        sea
    date:
        2010-05-14
*/
function changLease_term_value(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//付租方式
	var income_number_value = document.getElementsByName("income_number")[0].value;//还租次数
	//var lease_term_value = document.getElementsByName("lease_term")[0].value; //租赁期限(月)
	var period_type_value = document.getElementsByName("period_type")[0].value; //付租类型 为期末加一月OR一季度OR一年
	// 还租次数 = 租赁期限/付租方式 //租赁期限 = 换租次数*付租方式
	if(income_number_year_value != null || income_number_year_value != ''){
		if(income_number_value == null || income_number_value == ''){
			alert("请输入还租次数!");
			return false;
		}else{
			var lt_value = income_number_value * income_number_year_value;
			//付租类型为‘期末支付’，‘付租期限’需加上对应‘付租方式’期限
			if(period_type_value == 0 || period_type_value == '0'){
				var int_lt_value = parseInt(lt_value);
				lt_value = int_lt_value + parseInt(income_number_year_value);
			}
			document.getElementsByName("lease_term")[0].value = lt_value; 
		}
	}else{
		alert("请选择付租方式!");
		return false;
	}
}
//
function changLeaseT_value(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//付租方式
	var income_number_value = document.getElementsByName("income_number")[0].value;//还租次数
	// 还租次数 = 租赁期限/付租方式 //租赁期限 = 还租次数*付租方式
	if(income_number_year_value != null || income_number_year_value != ''){
		if(income_number_value == null || income_number_value == ''){
			alert("请输入还租次数!");
			return false;
		}else{
			var lt_value = income_number_value * income_number_year_value;
			document.getElementsByName("lease_term")[0].value = lt_value; 
		}
	}else{
		alert("请选择付租方式!");
		return false;
	}
}
/***************同上一个函数changLease_term_value 需求更改该函数暂时未用到
    方法含义：
        根据工式：还租次数 = 租赁期限/年还租次数 计算‘换租次数’的值，
        计算之前对‘租赁期限’和‘年换租次数’进行验证
       ‘付租方式(年换租次数)’是否合理的依据是:1->月付|3->季付|6->半年付|12->年付
    return:
        将计算后的值赋给‘换租次数’字段
    author:
        sea
    date:
        2010-05-10
*/
function changeLease_term(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//年还租次数(付租方式)
	var income_number_value = document.getElementsByName("income_number")[0].value;//还租次数
	//年还租次数(付租方式)空判断
	if(income_number_year_value == null || income_number_year_value == ''){
		alert("请选选择付租方式!"); 
		document.getElementsByName("lease_term")[0].value = '';//租赁期限
		document.all.income_number_year.focus();
		return false;
		
	}
	var lease_term_value = document.getElementsByName("lease_term")[0].value; //租赁期限(月)
	//if(income_number_year_value == 1){//月付不需要判断 }
	if(income_number_year_value == 3){//季付
		if(lease_term_value%3 != 0){
			alert("付租方式为按季时:租赁期限减宽限期不是3的整数倍！");
			document.all.lease_term.focus();
			return false;
		}
	} 
	if(income_number_year_value == 6){//半年付
		if(lease_term_value%6 != 0){
			alert("付租方式为半年付时:租赁期限减宽限期不是6的整数倍！");
			document.all.lease_term.focus();
			return false;
		}
	}
	if(income_number_year_value == 12){//年付
		if(lease_term_value%12 != 0){
			alert("付租方式为年付时:租赁期限减宽限期不是12的整数倍！");
			document.all.lease_term.focus();
			return false;
		}
	} 
	// 还租次数 = 租赁期限/年还租次数
	var income_number_value = lease_term_value/income_number_year_value;  
	document.getElementsByName("income_number")[0].value = income_number_value;//赋值
} 
/*
    方法含义：
        根据工式：租赁本金 = 设备金额 - 首付款 计算租赁本金的值，
        计算之前对‘设备金额’和‘首付款’进行验证
    param:
    return:
        将计算后的值赋给‘租赁本金’字段
    author:
        sea
    date:
        2010-05-10
*/
function changeFirst_payment(){
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备金额 
	var first_payment = document.getElementsByName("first_payment")[0].value;//首付款
	//判断是否输入
	if(equip_amt == null || equip_amt == ''){
		alert("请输入设备金额!");
		document.all.equip_amt.focus();
		return false;
	}
	//判断输入是否合法
	var reg_money = /^[+]?\d+(\.[0-9]{1,2})?$/;
	if(reg_money.test(equip_amt)== false){
		str = "设备金额-货币格式错误";//
		alert(str);
		document.all.equip_amt.focus();
		return false;
	}
	if(reg_money.test(first_payment)== false){
		str = "首付款-货币格式错误";//
		alert(str);
		document.all.first_payment.focus();
		return false;
	}
	//计算租赁本金
	var numValue = equip_amt - first_payment;
	//留2位小数 forcepos()注意 154951705.36 30990341.00
	numValue = forcepos(numValue,2);
	document.getElementsByName("lease_money")[0].value = numValue;//租赁本金
	//调用计算净融资额的函数
	//if(first_payment != null && first_payment != ''){// 首付款不为空
	//	assignment();
	//}
	//将‘净融资额’为空 净融资额=租赁本金-保证金 无论首付款 还是设备金额的更改 净融资额 必须致空重新计算
	document.getElementsByName("net_lease_money")[0].value = '';
}
//付租方式值改变清空换租次数的值
function changIncome_number_year_value(){	
	var income_number_year = document.getElementsByName("income_number_year")[0].value;
	if(income_number_year == null || income_number_year == ''){
		alert("请选择具体的付租方式!");
		return false;
	}
	document.getElementsByName("income_number")[0].value = '';
	document.getElementsByName("lease_term")[0].value = '';
}


//利率调整值输入后在利率调整值后面显示出数据
function alertChange(){
	var rate_float_amt = document.getElementsByName("rate_float_amt")[0].value;//利率调整值
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var div_rate = document.getElementById('div_rate');
	var name;
	//
	if(rate_float_amt == '' || rate_float_amt == null){
		div_rate.style.displa = 'block';
	}else{
		if(rate_float_type == '0'){//2010-11-23需求修改
			name = "按央行利率浮动比率";
			div_rate.innerHTML = "<font color='red'>按央行利率浮动比率调整为：(央行基础利率+幅度)×"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '1'){
			name = "按央行利率加点";
			div_rate.innerHTML = "<font color='red'>按央行利率加点调整为：(央行基础利率+幅度)+"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '2'){
			name = "固定调整租金金额";
			div_rate.innerHTML = "<font color='red'>固定调整租金金额:"+rate_float_amt+"</font>";
		}
		
	}
	//document.getElementById('div2').style.display='none'
	//document.getElementById('div2').style.display='block'
}
function changeOne(){
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var rate = document.getElementById('rate_float_amt');
	var div_rate = document.getElementById('div_rate');
	if(rate_float_type == '3'){
		document.getElementsByName("rate_float_amt")[0].value = '0';
		rate.disabled = true;
		div_rate.innerHTML = "";
	}else{
		rate.disabled = false;
		alertChange();
		//return true;
	}
}
//计算增加净融资额比例=净融资额/设备金额
function getlmp_value(){
	var net_lease_money = document.getElementsByName("net_lease_money")[0].value;//净融资额
	var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备金额
	var result;
	if(net_lease_money == 0 && equip_amt == 0){
		result = "0";
	}else{
		result = round2places((net_lease_money/equip_amt)*100);
	}
	document.getElementsByName("lease_money_proportion")[0].value = result;
}
//四舍五入
function round2places(numToRound) 
{ 
	//var numToRound=document.getElementById("numToRound").value;
	var result; 
	result=numToRound*100; 
	result=Math.round(result); 
	result=result/100; 
	return result;
} 


//租金计算方法选为平息法则将一些输入框灰选掉
function change_disable(){
	var measure_type = document.getElementsByName("measure_type_tem")[0].value;

	if(measure_type == 0 || measure_type == '0'){//不规则
		//要将下面的租金不规则界面调出来	
	}else if(measure_type == 5 || measure_type == '5'){//平息法情况下灰选部分输入框
		document.getElementById('first_payment').disabled = true;//首付款
		document.getElementById('handling_charge').disabled = true;//租赁手续费
		document.getElementById('nominalprice').disabled = true;//资产余值
		document.getElementById('return_amt').disabled = true;//厂商返利
		document.getElementById('before_interest').disabled = true;//租前息
		document.getElementById('pena_rate').disabled = true;//罚息日利率
		document.getElementById('accountPrincipal').disabled = true;//会计核算本金
		document.getElementById('liugprice').disabled = true;//留购价款
		document.getElementById('consulting_fee').disabled = true;//咨询费
	}else{
		document.getElementById('first_payment').disabled = false;//首付款
		document.getElementById('handling_charge').disabled = false;//租赁手续费
		document.getElementById('nominalprice').disabled = false;//资产余值
		document.getElementById('return_amt').disabled = false;//厂商返利
		document.getElementById('before_interest').disabled = false;//租前息
		document.getElementById('pena_rate').disabled = false;//罚息日利率
		document.getElementById('accountPrincipal').disabled = false;//会计核算本金
		document.getElementById('liugprice').disabled = false;//留购价款
		document.getElementById('consulting_fee').disabled = false;//咨询费
	}
}


function change_disable2(){
    var measure_type = document.getElementsByName("measure_type")[0].value;
    var doc_id = document.getElementById("doc_id").value;
    var proj_id = document.getElementById("proj_id").value;
	//window.parent.frames["con"].location.reload();
	//window.parent.frames["rentplan"].location="bgz_zjcs_div_list.jsp";
	//window.parent.frames["rentplan"].location.replace("bgz_zjcs_div_list.jsp").reload();
	 if( "0"==measure_type ){
		window.parent.frames["rentplan"].location.replace("bgz_zjcs_div_list.jsp?proj_id="+proj_id+"&doc_id"+doc_id);
		//window.parent.frames["con"].location.reload();
		//window.parent.frames["rentplan"].location="bgz_zjcs_div_list.jsp";
		//window.parent.frames["rentplan"].location.replace("bgz_zjcs_div_list.jsp");
	}else{
		//alert("222_"+window.parent.frames["rentplan"].location);
		window.parent.frames["rentplan"].location= "zics_div_list.jsp?proj_id="+proj_id+"&doc_id"+doc_id;
		//window.parent.frames["rentplan"].location="zics_div_list.jsp";
	}
}

//租金测算按钮跳转的区分判断
function submitForm(){
	//2011-04-07新加
	changeFirst_payment();
	assignment();
	//先检测
	if(check_allInput()){
		var type = document.getElementById('measure_type').value;//租金计算方法
		if(type == '0' || type == 0){
			form1.target ="rentplan";
		}else{
			form1.target ="_blank";
		}
		form1.submit();	
	}
}

//验证双精度数字  
function check_double(obj,obj_name,obj_id){  
    var reg = /^[0-9]+(\.[0-9]+)?$/;  
    if(obj.value!=""&&!reg.test(obj.value)){  
        alert(obj_name+'所填必须为有效的双精度数字');  
        obj.value = "";
        document.getElementById(obj_id).value = ""; 
        obj.focus();  
        return false;  
    }  
} 
	//验证所有的输入框
	//function check_input(){
	//equip_amt 设备金额 , first_payment 首付款,lease_money租赁本金,caution_money 租赁保证金,handling_charge 租赁手续费,management_fee 管理费
	//net_lease_money 净融资额,lease_money_proportion 净融资额比例,income_number 还租次数(整数),lease_term 租赁期限(月)(整数),nominalprice 资产余值,	
	//return_amt 厂商返利,year_rate 租赁年利率,rate_float_amt 利率调整值,before_interest 租前息,pena_rate 罚息日利率,market_irr 市场IRR,plan_irr 财务IRR
	//accountPrincipal 会计核算本金,liugprice 留购价款,other_income 其他收入,other_expenditure 其他支出,consulting_fee 咨询费,delay 延迟期数(整数),grace 宽限期数(整数)
	//	var first_payment = document.getElementById('first_payment').value ;//首付款
	//	var handling_charge = document.getElementById('handling_charge').value ;//租赁手续费
	//	var nominalprice = document.getElementById('nominalprice').value ;//资产余值
	//	var return_amt = document.getElementById('return_amt').value ;//厂商返利
	//	var before_interest = document.getElementById('before_interest').value ;//租前息
	//	var pena_rate = document.getElementById('pena_rate').value ;//罚息日利率
	//	var accountPrincipal = document.getElementById('accountPrincipal').value ;//会计核算本金
	//	var liugprice = document.getElementById('liugprice').value ;//留购价款
	//	var consulting_fee = document.getElementById('consulting_fee').value ;//咨询费
//	} 
	
	/**
	*  验证所有的input输入框，验证各种格式
	*/
	function check_allInput(){
		var savaType = document.getElementById('savaType').value ;//判断添加还是修改
		var delay = document.getElementById('delay').value ;//延迟期数
		var list = document.getElementsByTagName("input");
		//alert("list.lengthe==>"+list.length);
		var str = "0";
		var count = 0;
		for(var i=0;i<list.length && list[i];i++)
 		{
 			//alert("list[i].type==>"+list[i].type);
 			if(list[i].type == "text"){
 				var text_value = list[i].value;
 				text_value = trim(text_value);//除去空格
				 //非法字符的验证 				
 				 var reg_ff = /\/{2}|\/\*|-{2}|[';\"%<>]+/;
                 if(text_value.match(reg_ff)) { 
                     str = "输入框所填的字符串不能包含特殊字符:。-- /* ';\"% < > // \"等" ;
                     alert(str);
                     count = count + 1;
                     break;
                  }
 				//alert(list[i].name+"="+text_value+"----"+list[i].dataType);
	 			//货币格式 : /^[+]?\d+(\.[0-9]{1,2})?$/ 金额格式不正确，必须为正实数并且小数在两位以内
	 			if(list[i].dataType == 'Money' || list[i].dataType == 'money'){
	 				var reg_money = /^[+]?\d+(\.[0-9]{1,2})?$/;
	 				//alert("MONEY验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_money.test(text_value));
	 				if(reg_money.test(text_value)== false){
	 					str = "货币格式错误";//
	 					//var pos = getElementPos(list[i].name);  //测算该字段的坐标 
						//alert("距左边距离"+ pos.x +",距上边距离"+pos.y); 
						create_span(str,list[i].name);//进行对应字段的错误提示
						count = count + 1;
	 					break;
	 				}else{
	 					str = "";
						create_span(str,list[i].name);//正确情况置为空
	 				}
	 			}
	 			//数字类型: /^\d+$/    
	 			if(list[i].dataType == 'Number' || list[i].dataType == 'number'){
	 				//var reg_number = /^\d+$/;
	 				//alert("Number验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_number.test(text_value));
	 				if(isNaN(text_value) == false){
	 					str = "必须为数字";//
	 					create_span(str,list[i].name);//进行对应字段的错误提示
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//正整数格式包括0：^\d+$   验证非正整数（负整数 + 0） ^((-\d+)|(0+))$ 
	 			if(list[i].dataType == 'Integer' || list[i].dataType == 'integer'){
	 				var reg_Integer =  /^\d+$/;
	 				//alert("Integer验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_Integer.test(text_value));
	 				if(reg_Integer.test(text_value) == false){
	 					str = "必须为正整数包含0";
	 					create_span(str,list[i].name);//进行对应字段的错误提示
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//double格式：/^[-\+]?\d+(\.\d+)?$/
	 			if(list[i].dataType == 'Double' || list[i].dataType == 'double'){
	 				var reg_Double =  /^[-\+]?\d+(\.\d+)?$/;
	 				//alert("Double验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_Double.test(text_value));
	 				if(reg_Double.test(text_value) == false){
	 					str = "必须为实数";
	 					create_span(str,list[i].name);//进行对应字段的错误提示
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
	 			//利率格式: /^\d+(\.[0-9]{1,8})?$/,
	 			if(list[i].dataType == 'Rate' || list[i].dataType == 'rate'){
	 				var reg_Rate =  /^\d+(\.[0-9]{1,8})?$/;
	 				//alert("reg_Rate验证->"+list[i].name+"="+text_value+"----"+list[i].dataType+"--结果是："+reg_Rate.test(text_value));
	 				if(reg_Rate.test(text_value) == false){
	 					str = "必须为正实数并且小数在八位以内";
	 					create_span(str,list[i].name);//进行对应字段的错误提示
	 					count = count + 1;
	 					break;
	 				}else{
	 					str = "";
	 					create_span(str,list[i].name);// 
	 				}
	 			}
 			}//input是输入框的判断结束
 		}//for 循环结束
 		//alert("str1====>"+str);
 		str = trim(str);//除去空格
		if(count > 0){
			//alert("join1");
			return false; 
		}else{
			//alert("join2");
			return true;
		}
	}
	/**
	*判断错误的条件下插入一个span节点，并显示错误原因，输入正确则将该节点置为空
	*参数1：str 错误原因
	*参数2：name 节点属性名称或者id
	*/
	function create_span(str,name){
		var tem_name = name+"_msg";
		//如果节点span不存在就创建一个，如果存在就将值置为空
		if (null==document.getElementById(tem_name) || document.getElementById(tem_name)=='undefined') {
		    var newSpan = document.createElement("span");
			newSpan.id = name+"_msg";
			document.getElementById(name).parentNode.appendChild(newSpan);//找到父节点TD下创建一个span元素
		} else {
		   document.getElementById(tem_name).innerHTML ="";
		}
		document.getElementById(tem_name).innerHTML =  "<br><font color='red'>"+str+"</font>";//
	}
	/*
    方法描述： 去除多余空格函数
    	return: s 2边的多余的空格已经去除掉
    	author:  sea
    	date: 2010-04-13
	*/
	function trim(s){  
  		return s.replace(/(^\s*)|(\s*$)/g,"");      
	}
	//获取元素对应的坐标方法
	function getElementPos(elementId) {   
		 var ua = navigator.userAgent.toLowerCase();   
		 var isOpera = (ua.indexOf('opera') != -1);   
		 var isIE = (ua.indexOf('msie') != -1 && !isOpera); // not opera spoof   
		 var el = document.getElementById(elementId);   
		 if(el.parentNode === null || el.style.display == 'none') {   
		  return false;   
		 }         
		 var parent = null;   
		 var pos = [];        
		 var box;        
		 if(el.getBoundingClientRect)    //IE   
		 {            
		  box = el.getBoundingClientRect();   
		  var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);   
		  var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);   
		  return {x:box.left + scrollLeft, y:box.top + scrollTop};   
		 }else if(document.getBoxObjectFor)    // gecko       
		 {   
		  box = document.getBoxObjectFor(el);    
		  var borderLeft = (el.style.borderLeftWidth)?parseInt(el.style.borderLeftWidth):0;    
		  var borderTop = (el.style.borderTopWidth)?parseInt(el.style.borderTopWidth):0;    
		  pos = [box.x - borderLeft, box.y - borderTop];   
		 } else    // safari & opera       
		 {   
		  pos = [el.offsetLeft, el.offsetTop];     
		  parent = el.offsetParent;        
		  if (parent != el) {    
		   while (parent) {     
		    pos[0] += parent.offsetLeft;    
		    pos[1] += parent.offsetTop;    
		    parent = parent.offsetParent;   
		   }     
		  }      
		  if (ua.indexOf('opera') != -1 || ( ua.indexOf('safari') != -1 && el.style.position == 'absolute' )) {    
		   pos[0] -= document.body.offsetLeft;   
		   pos[1] -= document.body.offsetTop;            
		  }       
		 }                 
		 if (el.parentNode) {    
		    parent = el.parentNode;   
		   } else {   
		    parent = null;   
		   }   
		 while (parent && parent.tagName != 'BODY' && parent.tagName != 'HTML') { // account for any scrolled ancestors   
		  pos[0] -= parent.scrollLeft;   
		  pos[1] -= parent.scrollTop;   
		  if (parent.parentNode) {   
		   parent = parent.parentNode;   
		  } else {   
		   parent = null;   
		  }   
		 }   
		 return {x:pos[0], y:pos[1]};   
    }   


	/**
	 * 检查输入的字符是否具有特殊字符
	 * 输入:str  字符串
	 * 返回:true 或 flase; true表示包含特殊字符
	 * 主要用于注册信息的时候验证
	 */
	
	function checkQuote(str){
	    var items = new Array("~", "`", "!", "@", "#", "$", "%", "^", "&", "*", "{", "}", "[", "]", "(", ")");
	    items.push(":", ";", "'", "|", "\\", "<", ">", "?", "/", "<<", ">>", "||", "//");
	    items.push("admin", "administrators", "administrator", "管理员", "系统管理员");
	    items.push("select", "delete", "update", "insert", "create", "drop", "alter", "trancate");
	    str = str.toLowerCase();//所有大写字符全部被转换为了小写字符
        //alert(str);
        //029-03-02-2010-00002-0000010
	    for (var i = 0; i < items.length; i++) {
	        if (str.indexOf(items[i]) >= 0) {
	            return true;
	        }
	    }
	    return false;
	}
</script>

</head>
<body onload="alertChange();">

<%
	//change_disable();	
	String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
 	ResultSet rs;
 	String user_name = "";
	rs = db.executeQuery(" select name from base_user where id = '"+user_id+"' ");//
	if(rs.next()){
		user_name = getDBStr(rs.getString("name"));
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	//针对‘拟商务条件’修改操作
	String proj_id = getStr(request.getParameter("proj_id"));//接取主键‘合同编号’ "001";//
	//接取model 做为是添加和修改判断 添加为"add"修改为"mod"删除为"del"
	String model = getStr(request.getParameter("model"));
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 measure_id
	LogWriter.logDebug(request, "商务条件zjcs_proj_add_JSP：输出proj_id:"+proj_id+" model:"+model+" doc_id:"+doc_id);

	//【2011-01-10 平息法增加】 START //////////////////////////////////////////////////////////////////
	//增加一个变量用于判断是否是平息法的操作，如果是平息法则不分字段需要编程只读
	String pinxi = "flase";
	//默认为等额租金计算方式
	String q_px = " select isnull(measure_type,'1') as measure_type from  proj_condition_temp where proj_id = '"+proj_id+"'  and measure_id = '"+doc_id+"' ";
	ResultSet rs_px = db.executeQuery(q_px);
	String measure_type  = "";//取租金计算方法 5 表示平息法
	while(rs_px.next()){
		measure_type  = getDBStr(rs_px.getString("measure_type"));//取租金计算方法 5 表示平息法
		if("5".equals(measure_type)){//平息法
			pinxi = "true";
		}
	}
	rs_px.close();
	//【2011-01-10 平息法增加】 END //////////////////////////////////////////////////////////////////
	List<String> list = new ArrayList<String>();
	//项目编号不为空
	if(model == null || model.equals("") || model.equals("0")){
		model = "add";
	}
	if(model.equals("mod")){//暂时是修改才会先查询一次 增加不做查询处理
		StringBuffer querySql = new StringBuffer();
		//判断主键是否为空
		querySql.append("select proj_id,currency,equip_amt,first_payment,")//0-3
		 		.append("lease_money,caution_money,net_lease_money,")//4-6
		 		.append("handling_charge,income_number_year,lease_term,")//7-9
		 		.append("income_number,nominalprice,period_type,return_amt,")//10-13
		 		.append("year_rate,rate_float_type,before_interest,")//14-16
		 		.append("rate_adjustment_modulus,pena_rate,income_day,start_date,")//17-20
		 		.append("plan_irr,measure_type,other_income,other_expenditure,creator,")//21-25
		 		.append("create_date,modify_date,modificator,rate_float_amt,consulting_fee, ")//26-30
		 		.append("market_irr,  ")//新增字段 市场irr 31
		 		.append("lease_money_proportion,  ")//【新增字段 2010-07-27】32 净融资额比例
		 		.append("accountPrincipal,  ")//【新增字段 2010-08-06】33 会计核算本金
		 		.append("rentScale,  ")//【新增字段 2010-08-20】34 圆整到
		 		.append("liugprice,  ")//【新增字段 2010-09-21】35 留购价（原本的留购价改成残值）
		 		.append("delay,  ")//【新增字段 2010-10-20】36 延迟期数
		 		.append("grace,  ")//【新增字段 2010-10-20】37 宽限期数
		 		.append("management_fee,  ")//【新增字段 2010-11-11】38 管理费 
		 		.append("isnull(ajdustStyle,'0'),  ")//【新增字段 2010-11-23】39 调息方式
		 		.append("isnull(amt_return,'否') as amt_return  ")//【新增字段 2011-01-10】40 设备是否退还
		 	   //--新增
		 		.append(" ,into_batch  ")//【新增字段 2011-05-01】41 是否批量调息
			   .append(" ,discount_rate  ")//【新增字段 2011-05-01】42 贴现息
			   .append(" ,insure_type  ")//【新增字段 2011-05-01】43 投保方式
			   .append(" ,insure_money  ")//【新增字段 2011-05-01】44 保费金额
			   .append(" ,consulting_fee_in  ")//【新增字段 2011-05-01】45 咨询费收入
			   .append(" ,free_defa_inter_day  ")//【新增字段 2011-05-01】46 逾期宽限日
			   .append(" ,rate_subsidy  ")//【新增字段 2011-05-01】47 利息补贴
		 		.append(" from proj_condition_temp ")
		 	    .append(" where proj_id = '"+proj_id+"'")//合同编号
		 	    .append(" and measure_id = '"+doc_id+"' ");//文档编号
			System.out.println("修改项目交易结构之前的查询SQL-->   "+querySql.toString());
	 	rs = db.executeQuery(querySql.toString());//执行查询
	 	//rs.last(); //移到最后一行
		//int rowCount = rs.getRow(); //得到当前行号，也就是记录数
		//rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
	 	int i = 1;
	 	while(rs.next()){
	 		//循环取值 取该表的前35列，下标从1开始取
	 		for(;i <= 48;i++){
		 		list.add(getDBStr(rs.getString(i)));
	 		}
	 	} 
	 	rs.close();
	 	db.close();
	 }
%> 
<!-- form表单跳转到zjcs_projSave.jsp页面    doCument.forms[0].onsubmit()-->
<form name="form1" method="post" target="rentplan" action="zjcs_projSave.jsp" onSubmit="return Validator.Validate(this,2);check_allInput();">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	
	<input type="hidden" name="is_ok" id="is_ok" value="no"/>
	<!-- 隐藏域传值  -->
	<input type="hidden" name="modelType" id="modelType" value="zjcsModel"/>
	<input type="hidden" name="savaType" id="savaType" value="<%=model%>"/>
	<input type="hidden" name="doc_id" id="doc_id" value="<%=doc_id%>"/>
	<input type="hidden" name="measure_type_tem" id="measure_type_tem" value="<%=measure_type%>"/>

	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
		<%
			if(list.size() > 0 || model.equals("mod")){
		%>
 			 <tr>
 				<!-- 隐藏域开始 -->
	 			<input name="rate_adjustment_modulus" type="hidden" value="0"/>
			  	<input name="plan_irr" type="hidden" value="<%=getDBStr(list.get(21)) %>"/>
			  	<input name="accountPrincipal" type="hidden" value="<%=formatNumberDoubleTwo(getDBStr(list.get(33))) %>"/>
			  	<input name="liugprice" type="hidden" value="<%=formatNumberDoubleTwo(getDBStr(list.get(35)))%>" />
			  	<input name="rentScale" type="hidden" value="<%=list.get(34) %>"/>
			  	<input name="delay" type="hidden" value="<%=getDBStr(list.get(36))%>" />
			  	<input name="grace" type="hidden" value="<%=getDBStr(list.get(37))%>"/>
			  	<input name="amt_return" type="hidden" value="<%=list.get(40)%>"/>
			  	<!-- 隐藏域结束 -->
  				<td scope="row" nowrap>项目编号</td>
    			<td>
	    			<input name="proj_id" id="proj_id" type="text" value="<%=list.get(0)%>" 
	    		 	 size="35" maxlength="50" readonly="readonly"/>
	    			<span class="biTian">*</span>
     			</td>
	 			<td scope="row" nowrap>货币类型</td>
    		    <td> 
					<select name="currency" id="currency" Require="true" style="width: 100px;"></select>
					<script language="javascript">
					dict_list("currency","currency_type","<%=list.get(1) %>","name");
					</script>
    				<span class="biTian">*</span>
				</td>
    			<td scope="row" nowrap>设备金额</td>
    				<td>
    					<input name="equip_amt" id="equip_amt" type="text" 
    						value="<%=formatNumberDoubleTwo(getDBStr(list.get(2)))%>" 
    						dataType="Money" size="13" maxlength="50" maxB="50"  Require="true"
    						onchange="changeFirst_payment()"   />
       				<span  class="biTian">*</span>
     			</td>
      			<td scope="row" nowrap>首付款</td>
      			<td>
    				<input name="first_payment" type="text" 
    				value="<%=formatNumberDoubleTwo(getDBStr(list.get(3)))%>" 
    				onchange="changeFirst_payment()"            
    				dataType="Money" size="13" maxlength="50" maxB="50"  Require="true" />
    				<span class="biTian">*</span>
   	   			</td> 
  			</tr> 
  				
  			<tr>
   				<td scope="row" nowrap>租赁本金</td><!--  租赁本金 = 设备金额 - 首付款   -->
    			 <td>
    				<input name="lease_money" id="lease_money" 
    				value="<%=formatNumberDoubleTwo(getDBStr(list.get(4)))%>" 
    				readonly type="text" Require="true"     
    				dataType="Money" size="13" maxlength="100" maxB="100" Require="true"/>
    				<span class="biTian">*</span>
	 			</td>
				<td  scope="row" nowrap>租赁保证金</td>
				<td>
					<input name="caution_money" id="caution_money"    
					 value="<%=formatNumberDoubleTwo(getDBStr(list.get(5)))%>" 
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" 
					onchange="assignment()" type="text"/>
					<span class="biTian">*</span>
				</td>
				<td  scope="row" nowrap>租赁手续费</td>
				<td>
					<input name="handling_charge" type="text" 
				    value="<%=formatNumberDoubleTwo(getDBStr(list.get(7)))%>" 
		 			dataType="Money" size="13" maxlength="20" 
		 			maxB="20"  Require="true" onchange="assignment()"/>
					<span class="biTian">*</span>
				</td>
				<td scope="row" nowrap>管理费</td><!-- onPropertyChange -->
			    <td colspan="">
			    	<input name="management_fee" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(38)))%>"  
			    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" /> 
					<span class="biTian">*</span>
				</td>
  			</tr>
  			
  			<tr>
		   
			<td scope="row" nowrap>咨询费收入</td>
		  	<td>
		  		<input name="consulting_fee_in" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(45)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>咨询费支出</td>
		  	<td>
		  		<input name="consulting_fee" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(30)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>其他收入</td>
			<td>
				<input name="other_income" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(23)))%>"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
			</td>
			<td scope="row" nowrap>其他支出</td>
		    <td colspan="">
		    	<input name="other_expenditure" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(24)))%>"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" onchange="assignment()"/> 
			</td>
		</tr>
		  
		  <tr>	
			<td  scope="row" nowrap>残值收入</td>
			<td>
				<input name="nominalprice" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(11)))%>"   
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>厂商返利</td>
			<td>
				<input name="return_amt" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(13)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			
			<td  scope="row" nowrap>投保方式</td>
			<td>
				<select name="insure_type" id="insure_type" Require="true" style="width: 100px;"></select>
				<script language="javascript" class="text">
				dict_list("insure_type","insure_type","<%=list.get(43) %>","name");
				</script>
   				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>保费金额</td>
		    <td colspan="">
		    	<input name="insure_money" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(44)))%>"  
					dataType="Money" size="13" maxlength="20" 
					maxB="20"  Require="true" onchange="assignment()"/>
			</td>
		  </tr>
		  
  			
		  <tr> 
   				<!-- 净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出  -->
  				<td scope="row" nowrap>净融资额</td>
   	 			<td>
    				<!-- onclick="assignment()"  净融资额 = 租赁本金 - 保证金  -->
    				<input name="net_lease_money" id="net_lease_money" type="text" 
    				value="<%=formatNumberDoubleTwo(getDBStr(list.get(6)))%>" readonly 
    				dataType="Money" size="13" maxlength="20" maxB="20"  
    				Require="true" onclick="assignment()"/> 
    				净融资额比例
    				<input name="lease_money_proportion" id="lease_money_proportion" type="text" 
					value="<%=formatNumberDoubleTwo(getDBStr(list.get(32)))%>" size="5" 
					maxlength="10" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>% 
    				<span class="biTian">*</span>
				</td>
			
				<!-- 根据付租方式、付租类型、租赁期限和设备退还从主协议报价信息中导入，允许手工修改 -->
				<td  scope="row" nowrap>租赁年利率</td>
				<td>
					<input name="year_rate" type="text" value="<%=formatNumberStr(getDBStr(list.get(14)),"#,##0.000000")%>"   
						dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true" />%
						<!--  	    --> 
					<div id="" style="display: none;"> 
						<input type="button" value="从主协议报价信息中导入" onclick=""/>
					</div>	
					<span class="biTian">*</span>
				</td>  
				
				<td scope="row" nowrap>罚息日利率</td>
			    <td colspan="">
			    	<input name="pena_rate" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(18)))%>"  
			         size="13" maxlength="20" dataType="Money" size="13" maxlength="10" maxB="10"  Require="true"/>%%
			         <!-- 另外的判断输入方式 只能输入整数 onKeyUp="value=value.replace(/[^\d]/g,'')"
			         	onblur="if(isNaN(document.all.tolerance_date.value)){
			            alert('免息期请正确输入天数');document.all.tolerance_date.focus();}"  
			          -->
			    	<span class="biTian">*</span>
				</td>  
				
				<td scope="row" nowrap>逾期宽限日</td>
			    <td> 
			    	<input name="free_defa_inter_day" type="text" value="<%=list.get(46) %>"  
			    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" 
			    		onKeyUp="value=value.replace(/[^\d]/g,'')"
			         	onblur="if(isNaN(document.all.free_defa_inter_day.value)){
			            alert('请正确输入逾期宽限日');document.all.free_defa_inter_day.focus();}"/>
			    	<span class="biTian">*</span>
				</td>
		  </tr>	
		  
		   <tr>
			   <td scope="row" nowrap>付租方式</td>
	    			<td>
	    	 			<select name="income_number_year" id="income_number_year" 
	    	 				onchange="changIncome_number_year_value()" style="width:100px;">
						<script type="text/javascript">
								w(mSetOpt("<%=list.get(8)%>","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
						</script>
						</select>
	    				<span class="biTian">*</span>
					</td>
				<td scope="row" nowrap>付租类型</td>
			    <td>
			    <select style="width:100px;" name="period_type" onchange="changLeaseT_value()">
			        <script type="text/javascript">
				        	w(mSetOpt('<%=list.get(12)%>',"期初|期末","1|0"));
			        </script>
			     </select>
			     <span class="biTian">*</span>
				</td> 
			    <!-- 还租次数=租赁期限/年还租次数 -->
			  	<td scope="row" nowrap>还租次数</td>
			    <td>
			    	<input name="income_number" type="text" value="<%=list.get(10)%>" onChange="changLeaseT_value()"
			    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
			    	<span class="biTian">*</span>
				</td>
			
			<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" type="text" value="<%=list.get(9)%>" onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly="readonly"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
			
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
		    <td>
		    	<select name="rate_float_type" onblur="changeOne()">
		        <script type="text/javascript">
			        	w(mSetOpt('<%=list.get(15)%>',"按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利率调整值</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="<%=getDBStr(list.get(29))%>" onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			
			<td scope="row" nowrap>预计IRR</td>
		  	<td>
		  		<input name="market_irr" type="text" value="<%=formatNumberStr(getDBStr(list.get(31)),"#,##0.000000")%>"  
					size="13" maxlength="10" readonly="readonly" />%
			</td>
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>租前息</td>
		    <td>
		    	<input name="before_interest" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(16)))%>"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true"  onchange="assignment()"/>
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利息补贴</td>
		  	<td>
		  		<input name="rate_subsidy" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(47)))%>"
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>贴现息</td>
		  	<td>
		  		<input name="discount_rate" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(42)))%>"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=getDBDateStr(list.get(20))%>"    
					dataType="Date" size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
				<td  scope="row" nowrap>每月偿付日</td>
				<td>
					<select name="income_day" style="width:100px;">
						<% 
							for(int i = 1;i <= 31;i++){
								int num_temp = Integer.parseInt(getDBStr(list.get(19)));
								if(num_temp == i){
						%>
							<option value="<%=getDBStr(list.get(19))%>" selected><%=getDBStr(list.get(19))%></option>
						<% 
								}else{
						%>
							<option value="<%=i%>"><%=i%></option>	
						<% 
								}
							}
						%>
					</select>	
					<span class="biTian">*</span>
				</td>
				
			<td  scope="row" nowrap>租金计算方法</td>
			<td><!-- 等额本金2  暂时隐藏掉 不规则0|手工调整3  2010-08-12  -->
		        <select name="measure_type" onchange="change_disable2()" style="width:100px;">
		        <script type="text/javascript">
			        	w(mSetOpt('<%=list.get(22)%>',
			        	"等额租金|等额租金后付(均息法)|不规则",
			        	"1|5|0"));
			       <%--
			       "等额租金|等差租金|等比租金|等额本金|等差本金|等比本金|等额租金后付(均息法)|不等额租金|不等额本金|不规则",
			        	"1|2|3|4|7|6|5|8|9|0"));
			        --%> 	
		        </script>
		        </select>
				<span class="biTian">*</span>
			</td> 
			<td scope="row" nowrap>是否批量调息</td>
		    <td colspan="">
		    	<select name="into_batch" onchange="" style="width:100px;">
			        <script type="text/javascript">
				        	w(mSetOpt('<%=list.get(41) %>',"是|否","是|否"));
			        </script>
		        </select>
			</td>
			
			<%-- 
			<td scope="row" nowrap>调息方式</td>
		    <td>
		    	<select name="adjust_style" style="width:100px;">
		        <script type="text/javascript">
			        	w(mSetOpt('<%=list.get(39)%>',"按次日|按次月|按次期|按次年","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			--%>
		  	<td></td><td>
			<input type="hidden" name="ajdust_style" value="2">
			</td>
		</tr>	
		  
		  <tr>  
			 <!-- 跳转到租金测算开始页  type="submit" onClick="submitForm()"   document.forms[0].onsubmit() -->
		  	  <td colspan="8" align="right">
				<BUTTON class="btn_2" name="btnSave" value="租金测算" onClick="submitForm()" >
				<img src="../../images/save.gif" align="absmiddle" border="0">租金测算</button>
				
				<!-- 登记人  取登录人的姓名 -->
				<input type="hidden" name="creator" value="<%=getDBStr(list.get(25)) %>"  />
				<!-- 登记时间 -->
				<input name="create_date" type="hidden" value="<%=getDBStr(list.get(26))%>"/> 
				<!-- 更新人 -->
				<input name="modificator" type="hidden" value="<%=user_name%>" />
				<!-- 更新日期 -->
				<input name="modify_date" type="hidden" value="<%=nowDateTime%>" /> 
			  </td>
		  </tr>
		<% 		
		}else{
		%>
		  <tr>
		  	<!-- 隐藏字段开始 -->
		  	<input name="rate_adjustment_modulus" type="hidden" value="0"/>
		  	<input name="plan_irr" type="hidden" value="0.00"/>
		  	<input name="accountPrincipal" type="hidden" value="0"/>
		  	<input name="liugprice" type="hidden" value="0"/>
		  	<input name="rentScale" type="hidden" value="0"/>
		  	<input name="delay" type="hidden" value="0"/>
		  	<input name="grace" type="hidden" value="0"/>
		  	<input name="amt_return" type="hidden" value="否"/>
		  	<!-- 隐藏字段结束 -->
		  	<td scope="row" nowrap>项目编号</td>
		    <td>
		    	<input name="proj_id" id="proj_id" type="text" value="<%=proj_id%>" 
		    		  size="35" maxlength="50"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>货币类型</td>
		     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
				<select style="width:100px;" name="currency" id="currency" Require="true"></select>
				<script language="javascript" class="text">
				dict_list("currency","currency_type","currency_type1","name");
				</script>
    				
		    	<span class="biTian">*</span>
			</td>
		    <td scope="row" nowrap>设备金额</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" 
		    		value="0" onchange="changeFirst_payment()"
		    		dataType="Money" size="13" maxlength="50" maxB="50"  Require="true"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>首付款</td>
		      <td>
		    	<input name="first_payment" type="text" value="0" 
		    	onchange="changeFirst_payment()" dataType="Money" size="13" maxlength="50" 
		    	maxB="50"  Require="true"/>
		    	<span class="biTian">*</span>
		   	   </td> 
		  </tr> 
		  	
		  <tr>
		  	<!--  租赁本金 = 设备金额 - 首付款 onclick="changeFirst_payment()"   -->
		   <td scope="row" nowrap>租赁本金</td>
		     <td>
		    	<input name="lease_money" id="lease_money" value="0" 
		    	readonly type="text" Require="true" dataType="Money" size="13" maxlength="100" maxB="100" 
		    	Require="true"/>
		    	<span class="biTian">*</span>
			 </td>
			<td  scope="row" nowrap>租赁保证金</td>
			<td>
				<input name="caution_money" id="caution_money" value="0" 
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" 
					onchange="assignment()" type="text"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>租赁手续费</td>
			<td>
				<input name="handling_charge" type="text" value="0" 
				 	dataType="Money" size="13" maxlength="20" 
				 	maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>管理费</td>
		    <td colspan="">
		    	<input name="management_fee" type="text" value="0"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" onchange=""/> 
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
			<td scope="row" nowrap>咨询费收入</td>
		  	<td>
		  		<input name="consulting_fee_in" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>咨询费支出</td>
		  	<td>
		  		<input name="consulting_fee" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<!--  onKeyUp="value=value.replace(/[^\d]/g,'')"   -->
			<td  scope="row" nowrap>其他收入</td>
			<td>
				<input name="other_income" type="text" value="0" dataType="Money"
					  size="13" maxlength="20" onchange="assignment()" />
			</td>
			<td scope="row" nowrap>其他支出</td>
		    <td colspan="">
		    	<input name="other_expenditure" type="text" value="0" dataType="Money"
		    		  size="13" maxlength="10" onchange="assignment()"/> 
			</td>
		  </tr>	
		  
		  <tr>	
		  	<td  scope="row" nowrap>残值收入</td>
			<td>
				<input name="nominalprice" type="text" value="0" onchange="assignment()"
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>厂商返利</td>
			<td>
				<input name="return_amt" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>投保方式</td>
			<td>
				<select style="width: 100px;" name="insure_type" id="insure_type" Require="true"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>
   				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>保费金额</td>
		    <td colspan="">
		   	 <input name="insure_money" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
			</td>
		  </tr>
		  
		  <tr>
		   	<td scope="row" nowrap>净融资额</td>
		    <td>
		    	<!--  净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出 【2010-07-23修改，增加需要 减去租前息】 -->
		    	<input name="net_lease_money" id="net_lease_money" type="text" value="" readonly onclick="assignment()" 
		    	dataType="Money" size="13" maxlength="20" maxB="20"/> 
		    		净融资额比例
    				<input name="lease_money_proportion" id="lease_money_proportion" type="text" 
					value="" size="5" 
					maxlength="10" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>% 
    				<span class="biTian">*</span>
			</td>
		  	<td  scope="row" nowrap>租赁年利率</td>
			<td nowrap="nowrap">
				<input name="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true"/>%
				<!--  	display: none; 
				<div id="" style="" align="right"> 
					<input type="button"class="button" value="导入" alt="从主协议报价信息中导入" onclick=""/>
				</div>	   --> 
				<span class="biTian">*</span>
			</td>  
			
		  	<td scope="row" nowrap>罚息日利率</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" />%%
		         <!-- 另外的判断输入方式 只能输入整数 onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.tolerance_date.value)){
		            alert('免息期请正确输入天数');document.all.tolerance_date.focus();}"  
		          -->
		    	<span class="biTian">*</span>
			</td>  
			
			<td scope="row" nowrap>逾期宽限日</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="0"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" 
		    		onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.free_defa_inter_day.value)){
		            alert('请正确输入逾期宽限日');document.all.free_defa_inter_day.focus();}"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  
		   
		  
		   <tr>
		   <td scope="row" nowrap>付租方式</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>付租类型</td>
		    <td><select name="period_type" style="width: 100px;">
		        <script type="text/javascript">
			        w(mSetOpt('0',"期初|期末","1|0"));
		        </script>
		        </select>
		        <span class="biTian">*</span>
			</td> 
		    <!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap>还租次数</td>
		    <td>
		    	<input name="income_number" type="text" value="0"    onChange="changLeaseT_value()"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
		   	<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
			
		  </tr>	
		  
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
		    <td>
		    	<select name="rate_float_type" onchange="changeOne()">
		        <script>
			        w(mSetOpt('0',"按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利率调整值</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0"  onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td  scope="row" nowrap>预计IRR</td>
			<td>
				<input name="market_irr" type="text" value="0"  
				  size="13" maxlength="10" readonly/>
			</td> 
		  </tr>
		
		  <tr>
		  	<td scope="row" nowrap>租前息</td>
		    <td>
		    	<input name="before_interest" type="text" value="0"  onchange="assignment()"
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利息补贴</td>
		  	<td>
		  		<input name="rate_subsidy" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>贴现息</td>
		  	<td>
		  		<input name="discount_rate" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian"></span>
			</td>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		  	
			<td  scope="row" nowrap>每月偿付日</td>
			<td>
				<select name="income_day" style="width: 100px;">
					<% 
						for(int i = 1;i <= 31;i++){
					%>
						<option value="<%=i%>"><%=i%></option>
					<% 
						}
					%>
				</select>	 
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>租金计算方法</td>
			<td><!-- 等额本金2  暂时隐藏掉 不规则0|手工调整3  2010-08-12  -->
			
				<select style="width: 100px;" name="measure_type" Require="true" onchange="change_disable2()">
		        <script type="text/javascript">
			        	w(mSetOpt('1',
			        	"等额租金|等额租金后付(均息法)|不规则",
			        	"1|5|0"));
		        </script>
		        </select>
				<span class="biTian">*</span>
			</td> 
			<td scope="row" nowrap>是否批量调息</td>
	   		<td>
	    	<select name="into_batch" style="width: 100px;">
		        <script type="text/javascript">
			        	w(mSetOpt('是',"是|否","是|否"));
		        </script>
	        </select>
			</td>
			
			<td></td><td>
			<input type="hidden" name="ajdust_style" value="2">
			</td>
			<%-- 
			<td scope="row" nowrap>调息方式</td>
		    <td>
		    	<select name="ajdust_style" style="width: 100px;">
		        <script type="text/javascript">
		        	w(mSetOpt('0',"按次日|按次月|按次期|按次年","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			--%>
			
		</tr>
		  
		  <tr>  
			 <!-- 跳转到租金测算开始页  type="submit" onClick="submitForm()"-->
		  	  <td colspan="8" align="right">
				<BUTTON class="btn_2" name="btnSave" value="租金测算" onClick="submitForm()">
				<img src="../../images/save.gif" align="absmiddle" border="0">租金测算</button>
				<!-- 登记人  取登录人的姓名 -->
				<input type="hidden" name="creator" value="<%=user_name %>"/>
				<!-- 登记时间 -->
				<input name="create_date" type="hidden" value="<%=nowDateTime %>" /> 
				<!-- 更新人 -->
				<input name="modificator" type="hidden" value=""/>
				<!-- 更新日期 -->
				<input name="modify_date" type="hidden" value="" /> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  </td>
		  </tr>
		<%
		}
		%>
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
</html>
