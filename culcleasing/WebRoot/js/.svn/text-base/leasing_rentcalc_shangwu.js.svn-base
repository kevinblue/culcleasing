/**
 *初始化一些表单事件
 */
$(document).ready(function(){
	$(":radio[name='before_interest_type']").click(function(){
		var $bit_val = $(":radio[name='before_interest_type']:checked").val();
		//alert("被选中"+$bit_val);
		changeTwoData();
	});
	//禁止某几项不让更改
	$("#proj_id").attr("readonly","readonly");
	$("#contract_id").attr("readonly","readonly");
	$(":input[name='free_defa_inter_day']").attr("readonly","readonly");
	//添加几项失去焦点判断值是否正确

	$(":input[name='income_number']").blur(function(){//年还租次数
		if( $(this).val()=="0" || isNaN($(this).val()) ){//!/^\d+$/.test($(this).val())
			alert("年还租次数填写正整数");
			$(this).val(0);
			//$(this).focus();
		}
	});
	//租金公比参数 ratio_param
	$(":input[name='ratio_param']").blur(function(){//公比
		//先取出测算方式
		var stm = $("#settle_method").val();
		var ratio_param = $(this).val();

		if( stm=="RentCalcType3" || stm=="RentCalcType6" ){
			if( isNaN(ratio_param) ){
				alert("抱歉，公比只能不能填写字符");
				$(this).val(0.51);
				$(this).focus();
			}else if( ratio_param<=0.5 || ratio_param>=1.5 ){
				alert("公比只允许0.5到1.5之间");
				//$(this).val(0);
				$(this).val(0.51);
				$(this).focus();
			}
		}else if( stm=="RentCalcType2" || stm=="RentCalcType5" ){
			if( isNaN(ratio_param) ){
				alert("抱歉，公差只能不能填写字符");
				$(this).val(0);
				$(this).focus();
			}else if( ratio_param==0 ){
				alert("公差不允许填0");
				//$(this).val(0);
				$(this).focus();
			}
		}
	});
	
	//保险方式切换选择
//	$("#insure_type").change(function(){
	//	if($(this).val()=="insure_type1"){
	//		$(":input[name='insure_money']").removeAttr("readonly");
	//	}else if($(this).val()=="insure_type2"){
	//		$(":input[name='insure_money']").removeAttr("readonly");
	//	}else{
			//$(":input[name='insure_money']").val("0");
			//$(":input[name='insure_money']").attr("readonly","readonly");
	//	}
//	});
	
	//保险方式切换选择
	$("#insure_type").change(function(){
		if($(this).val()=="insure_type1"){
			$(":input[name='insure_money']").removeAttr("readonly");
			$("#insure_pay_type").val("root.insurPayType.004");
			//$("select[name='insure_pay_type']").val("root.insurPayType.004");
		}else if($(this).val()=="insure_type2"){
			$(":input[name='insure_money']").removeAttr("readonly");
		}else{
			//$(":input[name='insure_money']").val("0");
			//$(":input[name='insure_money']").attr("readonly","readonly");
			$("select[name='insure_pay_type']").val("root.insurPayType.004");
		}
	});
	//起租日期与每月偿付日
	$(":input[name='start_date']").bind("propertychange",function(){
		var staDate = $(this).val();
		var incDay = staDate.substr(staDate.length-2);

		if(incDay.substr(0,1)=="0"){
			incDay = incDay.substr(1,1);
		}
		//alert("dd"+incDay);
		$("select[name='income_day2']").val(incDay);
		$("#income_day").val(incDay);
		$("select[name='income_day2']").attr("disabled","disabled");
	});
});

//项目金额校验
function checkDataInvalid(totalM,usedM){
	var equipAmt= dataBack($("#equip_amt").val());
	
	if(totalM==""){
		totalM=0;
	}
	if(usedM==""){
		usedM=0;
	}
	//校验金额填写正确
	if(isNaN(equipAmt) || equipAmt<=0){
		alert("请输入正确金额，设备金额必须大于0！");
		$("#equip_amt").val("0");
	}else{
		//alert("je1: "+equipAmt+"  je2: "+usedM+"  je3: "+ totalM);
		var uM = FloatSub(totalM*1.0,FloatAdd(equipAmt*1.0,usedM*1.0));
	}

}
	

/**
 * 租金测算方法改变
 */
function changeCalcWay(){
	var settle_methodVal = $("#settle_method").val();
	if( settle_methodVal=="RentCalcType2" ){
		$("#bj_1").text("租金公差");
		$("#bj_2").show();
		$("#bj_3").text("不允许填0");
	}else if( settle_methodVal=="RentCalcType5" ){
		$("#bj_1").text("本金公差");
		$("#bj_2").show();
		$("#bj_3").text("不允许填0");
	}else if( settle_methodVal=="RentCalcType3" ){
		$("#bj_1").text("租金公比");
		$("#bj_2").show();
		$("#bj_3").text("只允许0.5到1.5之间");
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("本金公比");
		$("#bj_2").show();
		$("#bj_3").text("只允许0.5到1.5之间");
	}else if( settle_methodVal=="RentCalcType7" ){
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$("input[name='ratio_param']").val("0");
		$("#period_type").val("0");
	}else{
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$("input[name='ratio_param']").val("0");
	}
}

/**
 * 租金测算方法改变
 */
function changeCalcWay2(){
	var settle_methodVal = $("#settle_method2").val();
	if( settle_methodVal=="RentCalcType2" ){
		$("#bj_1").text("租金公差");
		$("#bj_2").show();
		$("#bj_3").text("不允许填0");
	}else if( settle_methodVal=="RentCalcType5" ){
		$("#bj_1").text("本金公差");
		$("#bj_2").show();
		$("#bj_3").text("不允许填0");
	}else if( settle_methodVal=="RentCalcType3" ){
		$("#bj_1").text("租金公比");
		$("#bj_2").show();
		$("#bj_3").text("只允许0.5到1.5之间");
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("本金公比");
		$("#bj_2").show();
		$("#bj_3").text("只允许0.5到1.5之间");
	}else if( settle_methodVal=="RentCalcType7" ){
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$("input[name='ratio_param']").val("0");
		$("#period_type").val("0");
	}else{
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$("input[name='ratio_param']").val("0");
	}
}

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

	var equip_amt = dataBack( $("#equip_amt").val());//设备款
	var first_payment = dataBack( $("#first_payment").val());//首付款
	var caution_money_value =dataBack( $("#caution_money").val()); //保证金
	var lease_capital_value =dataBack( $("#lease_money").val());  //租赁本金
	var handling_charge =dataBack( $("#handling_charge").val());//手续费
	var management_fee = dataBack( $("#management_fee").val());//管理费
	
//	var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备款
//	var first_payment = document.getElementsByName("first_payment")[0].value;//首付款
//	var caution_money_value = document.getElementsByName("caution_money")[0].value;//保证金
//	var lease_capital_value = document.getElementsByName("lease_money")[0].value;//租赁本金
//	var handling_charge = document.getElementsByName("handling_charge")[0].value;//手续费
//	var management_fee = document.getElementsByName("management_fee")[0].value;//管理费
	
	
	//sys 残值获取取消2011.12.27
	//var nominalprice = huifu( $("#nominalprice").val());//残值收入\
	//var nominalprice = document.getElementsByName("nominalprice")[0].value;//残值收入
	
	var return_amt = dataBack( $("#return_amt").val());//厂商返利
	var before_interest = dataBack( $("#before_interest").val());//租前息
	var rate_subsidy = dataBack( $("#rate_subsidy").val());//利息补贴
	var discount_rate = dataBack( $("#discount_rate").val());//贴现息

//	var return_amt = document.getElementsByName("return_amt")[0].value;//厂商返利
//	var before_interest = document.getElementsByName("before_interest")[0].value;//租前息
//	var rate_subsidy = document.getElementsByName("rate_subsidy")[0].value;//利息补贴
//	var discount_rate = document.getElementsByName("discount_rate")[0].value;//贴现息
	
	var other_income = dataBack( $("#other_income").val());//其他收入
	var other_expenditure = dataBack( $("#other_expenditure").val());//其他支出

//	var other_income = document.getElementsByName("other_income")[0].value;//其他收入
//	var other_expenditure = document.getElementsByName("other_expenditure")[0].value;//其他支出

	var consulting_fee_in = dataBack( $("#consulting_fee_in").val());//咨询费收入
	var consulting_fee_out = dataBack( $("#consulting_fee_out").val());//咨询费支出
	var insure_money =dataBack( $("#insure_money").val());//保费金额
	
//	var consulting_fee_in = document.getElementsByName("consulting_fee_in")[0].value;//咨询费收入
//	var consulting_fee_out = document.getElementsByName("consulting_fee_out")[0].value;//咨询费支出
//	var insure_money = document.getElementsByName("insure_money")[0].value;//保费金额
	//2012-4-5 Jaffe修改，杨舒提出 保险费根据保费支付类型 本司付款 则为支出 其他都不考虑
	var insure_type = $("#insure_type").val();
	
	if((lease_capital_value == null || lease_capital_value == '') || (caution_money_value == null || caution_money_value == '')){
		alert("租赁本金和保证金不能为空,净融资额=租赁本金-保证金!");
		document.all.lease_money.focus();
		return false;
	}else{ 
		var lease_amt_value ; 
		//净融资额=设备款-首付款-保证金-手续费-管理费-残值收入-厂商返利-租前息-利息补贴-其他收入-咨询费收入+贴现息+其他支出+咨询费支出+保费金额	
		// lease_amt_value = equip_amt - caution_money_value - handling_charge - return_amt - 
		// other_income + consulting_fee_out + other_expenditure-before_interest-management_fee;
		var value1 = FloatSub(equip_amt,first_payment);
		
		var value2 = FloatSub(FloatSub(value1, caution_money_value),handling_charge);
		//alert("__"+value1+"----"+value2);
		
		var value3 = FloatSub(value2, management_fee);
		var value4 = value3;
		//==不加不减==
		//var value4 = FloatSub(value3, nominalprice);
		
		var value5 = FloatSub(value4, return_amt);
		var value6 = FloatSub(value5, before_interest);
		
		var value7 = FloatSub(value6, rate_subsidy) ;
		var value8 = FloatSub(value7, other_income) ;
		var value9 = FloatSub(value8, consulting_fee_in);
		//alert("value9"+value9);

		var value10 = FloatAdd(discount_rate,other_expenditure);//加法的总和
		
		//2012-4-5 Jaffe修改  insure_type1
		var value11 = "0";
		//var value11 = FloatAdd(consulting_fee_out,insure_money);//加法的总和
		if( (insure_type != null && insure_type == 'insure_type1') ){
			value11  = FloatAdd(consulting_fee_out, insure_money);//减去
		}else{
			value11 = consulting_fee_out;
		}

		//alert(value10+">>>>>"+value11);
		
		lease_amt_value = FloatAdd(value9,value10);
		lease_amt_value = FloatAdd(lease_amt_value,value11);
		
		document.getElementsByName("actual_fund")[0].value = lease_amt_value;
		//计算‘会计核算本金=净融资额加保证金’的值 accountPrincipal
		//var str_num = FloatAdd(caution_money_value,lease_amt_value);
		//document.getElementsByName("accountPrincipal")[0].value = str_num;
	}
	getlmp_value();
}

function changeTwoData(){
	changeFirst_payment();
	assignment();
}
//会计核算本金赋值
function get_APValue(){
	var caution_money = document.getElementsByName("caution_money")[0].value;//保证金
	var actual_fund = document.getElementsByName("actual_fund")[0].value;
	if(caution_money == null || caution_money == '' || actual_fund == null || actual_fund == ''){
		alert("请选输入租赁保证金和净融资额的值!");
		return false;
	}else{
		//计算‘会计核算本金=净融资额加保证金’的值 accountPrincipal
		var str_num = FloatAdd(caution_money,actual_fund);
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

/*
    方法含义：
     // 根据工式：租赁本金 = 设备金额 - 首付款 计算租赁本金的值，
      CULC-环球特有： 根据工式：租赁本金 = 设备金额 - 首付款 + 租前息 + 考核调整 计算租赁本金的值，
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
	var equip_amt = dataBack($("#equip_amt").val());//设备金额 
	var first_payment =dataBack( $("#first_payment").val());//首付款
	var before_interest =dataBack( $("#before_interest").val());//租前息
	var before_interest_type = $(":radio[name='before_interest_type']:checked").val();//租前息-类型-是否算本
	//sys考核调整获值取消 12.27
	//var assess_adjust = document.getElementsByName("assess_adjust")[0].value;//考核调整
	
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
	var numValue = FloatSub(equip_amt,first_payment);
	if(before_interest_type!=null && "是"==before_interest_type ){
		numValue = FloatAdd(numValue,before_interest);
		//numValue = FloatSub(numValue,before_interest);
	}
	//sys考核调整取消12.27
	//numValue = FloatAdd(numValue,assess_adjust);
	
	//var numValue = equip_amt - first_payment;
	//留2位小数 forcepos()注意 154951705.36 30990341.00
	numValue = forcepos(numValue,2);
	document.getElementsByName("lease_money")[0].value = numValue;//租赁本金
	//将‘净融资额’为空 净融资额=租赁本金-保证金 无论首付款 还是设备金额的更改 净融资额 必须致空重新计算
	document.getElementsByName("actual_fund")[0].value = '0.00';
	//assignment();
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
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|隐含利率|隐含加点|保持不变","0|1|2|4|3"
	//按央行利率浮动比率  - 		央行调整值 * (1+浮动值) + 旧利率
	//按央行利率加点			央行调整值 + 旧利率
	//隐含利率 			1+央行调整值/上次利率值 * 浮动值 -- 上次利率值 = 本次基础值 - 央行调整值
	//隐含加点			央行调整值 + 旧利率
	//固定不变  			
	
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var div_rate = document.getElementById('div_rate');
	var name;
	//
	if(rate_float_amt == '' || rate_float_amt == null){
		div_rate.style.displa = 'block';
	}else{
		if(rate_float_type == '0'){//2010-11-23需求修改
			name = "按央行利率浮动比率";
			div_rate.innerHTML = "<font color='red'>按央行利率浮动比率调整为：央行调整值×(1+"+rate_float_amt+")+旧利率</font>";
		}
		if(rate_float_type == '1'){
			name = "按央行利率加点";
			div_rate.innerHTML = "<font color='red'>按央行利率加点调整为：(央行基础利率+幅度)</font>";
		}
		if(rate_float_type == '2'){
			name = "隐含利率";
			div_rate.innerHTML = "<font color='red'>隐含利率调整为: 1+央行调整值/上次利率值*"+rate_float_amt+"</font>";
		}
		if(rate_float_type == '3'){
			name = "固定不变";
			div_rate.innerHTML = "<font color='red'>固定不变: "+($(":input[name='year_rate']").val())+"</font>";
		}
		if(rate_float_type == '4'){
			name = "隐含加点";
			div_rate.innerHTML = "<font color='red'>隐含加点: (央行基础利率+幅度)</font>";
		}
	}
}
function changeOne(){
	//利率浮动类型 "按央行利率浮动比率|按央行利率加点|固定调整租金金额|保持不变","0|1|2|3"
	var rate_float_type = document.getElementsByName("rate_float_type")[0].value;
	var rate = document.getElementById('rate_float_amt');
	var div_rate = document.getElementById('div_rate');

	/**
	if(rate_float_type == '1' || rate_float_type == '3' || rate_float_type=='4' ){
		document.getElementsByName("rate_float_amt")[0].value = '0';
		rate.disabled = true;
		div_rate.innerHTML = "";
	}else{
		rate.disabled = false;
		//return true;
	}
	**/

	alertChange();
}
//计算增加净融资额比例=净融资额/设备金额
function getlmp_value(){
	var actual_fund =dataBack( $("#actual_fund").val());//净融资额
	//var actual_fund = document.getElementsByName("actual_fund")[0].value;//净融资额
	var equip_amt =dataBack( $("#equip_amt").val());//净融资额
	//var equip_amt = document.getElementsByName("equip_amt")[0].value;//设备金额
	var result;
	if(actual_fund == 0 || equip_amt == 0){
		result = "0";
	}else{
		result = round2places((actual_fund/equip_amt)*100);
	}
	document.getElementsByName("actual_fund_ratio")[0].value = result;
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


	/**
	*  验证所有的input输入框，验证各种格式
	*/
	function check_allInput(){
		//判断测算方式|付租类型
		if($("#settle_method").val()==""){
			alert("租金计算方法必填！");
			return false;
		}else if($("#period_type").val()==""){
		
			alert("付租类型必填！");
			return false;
		}else if($("#income_number").val()<=0){
		
			alert("还租次数必填，并且大于0！");
			return false;
		}

		var savaType = document.getElementById('savaType').value ;//判断添加还是修改
		var list = document.getElementsByTagName("input");
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
	
	//租金测算按钮跳转的区分判断
	function submitForm(){
		//HUIFU QIAN FEN WEI
		//$("#equip_amt").focus();	
		//return false;
		 $("input[type='text']").focus();
		 	//alert("租赁本金:"+$("#lease_money").val());
		 //	alert("设备额金:"+$("#equip_amt").val());
		//判断几个核心数据
		var str = "";
		//设备额、租赁本金 不能<=0
		if($("#equip_amt").val()<=0){
			str = "设备额不能填写<=0";
			alert(str);
			$("#equip_amt").focus();
			//create_span(str,equip_amt);
			return false;
		}else if($("#lease_money").val()<=0){
			str = "租赁本金不能<=0";
			alert(str);
			$("#lease_money").focus();
			//create_span(str,lease_money);
			return false;
//		}
//		//租赁年利率、还租次数
//		else if( !/^[0-9]+.?[0-9]*$/.test($(":input[name='year_rate']").val()) ){
//			str = "租赁年利率不合法";
//			alert(str);
//			$(":input[name='year_rate']").focus();
//			//create_span(str,year_rate);
//			return false;
		}else if( !/^\d+$/.test($(":input[name='income_number']").val()) ){
			str = "年还租次数填写正整数";
			alert(str);
			$(":input[name='income_number']").focus();
			//create_span(str,income_number);
			return false;
		}
		
		changeFirst_payment();
		assignment();
		
		//先检测
		if(check_allInput()==true){
			form1.onsubmit();	
		}
	}

