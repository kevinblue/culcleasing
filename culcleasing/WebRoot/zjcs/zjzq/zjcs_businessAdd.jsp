<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- 项目立项--拟商务条件 表：contract_condition  -->
<title> 租金测算 - 拟商务条件</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script language="javascript"> 
/*
    方法含义：
        根据工式：净融资额=租赁本金-保证金 计算‘净融资额’的值，
        计算之前对‘租赁本金’和‘保证金’进行空判断
    return:
        将计算后的值赋给‘净融资额’字段
    author:
        sea
    date:
        2010-05-10
*/
function assignment(){ 
	  //alert("join"+document.getElementsByName('lease_capital')[0].value);
	var lease_capital_value = document.getElementsByName("lease_money")[0].value;//租赁本金
	var caution_money_value = document.getElementsByName("caution_money")[0].value;//保证金
	if((lease_capital_value == null || lease_capital_value == '') || (caution_money_value == null || caution_money_value == '')){
		alert("租赁本金和保证金不能为空,净融资额=租赁本金-保证金!");
		document.all.lease_money.focus();
		return false;
	}else{ 
		var lease_amt_value = lease_capital_value - caution_money_value; 
		document.getElementsByName("net_lease_money")[0].value = lease_amt_value;
	}
}
/*
    方法含义：
        根据工式：还租次数 = 租赁期限/年还租次数 计算‘换租次数’的值，
        计算之前对‘租赁期限’和‘年换租次数’进行验证
       ‘年换租次数’是否合理的依据是:1->月付|3->季付|6->半年付|12->年付
    return:
        将计算后的值赋给‘换租次数’字段
    author:
        sea
    date:
        2010-05-10
*/
function changeLease_term(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//年还租次数(付租方式)
	//年还租次数(付租方式)空判断
	if(income_number_year_value == null || income_number_year_value == ''){
		alert("请选选择付租方式!"); 
		document.getElementsByName("lease_term")[0].value = '';
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
	if(equip_amt == null || equip_amt == ''){
		alert("请输入设备金额!");
		document.all.equip_amt.focus();
		return false;
	}
	var numValue = equip_amt - first_payment;
	document.getElementsByName("lease_money")[0].value = numValue;//租赁本金
}
//租金测算计算
//function zjcs(){
	//var proj_id = document.getElementsByName("proj_id")[0].value;
	//form1.action="../../zjcs/zjcs/condition_frame.jsp";
	//alert(form1.action);
	//form1.method = "post";
	//form1.target ="";
	//form1.submit();	
//	window.open('condition_frame.jsp','租金测算','height=300,width=400,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
//}
</script>

</head>
<body>
<%
	//针对‘拟商务条件’修改操作
	String proj_id = getStr(request.getParameter("proj_id"));//接取主键‘合同编号’ "001";//
	//接取model 做为是添加和修改判断 添加为"add"修改为"mod"删除为"del"
	String model = getStr(request.getParameter("model"));
	System.out.println("model为-->"+model+"<--############################合同编号-->"+proj_id);
	List<String> list = new ArrayList<String>();
	//项目编号不为空
	if(model == null || model.equals("") || model.equals("0")){
		model = "add";
	}
	if(model.equals("mod")){//暂时是修改才会先查询一次 增加不做查询处理
	System.out.println("-->join<--############################join-->");
		StringBuffer querySql = new StringBuffer();
		//判断主键是否为空
		querySql.append("select proj_id,currency,equip_amt,first_payment,")
		 		.append("lease_money,caution_money,net_lease_money,")
		 		.append("handling_charge,income_number_year,lease_term,")
		 		.append("income_number,nominalprice,period_type,return_amt,")
		 		.append("year_rate,rate_float_type,before_interest,")
		 		.append("rate_adjustment_modulus,pena_rate,income_day,start_date,")
		 		.append("plan_irr,measure_type,other_income,other_expenditure,creator,")
		 		.append("create_date,modify_date,modificator from contract_condition ");
	    if(proj_id != null && !proj_id.equals("")){
	    	//System.out.println(proj_id+"join1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#################################################################");
		 	querySql.append(" where proj_id = '"+proj_id+"'");//修改之前的查询
			System.out.println("增加拟商务条件增加前之修改SQL-->   "+querySql.toString());
		}
	 	ResultSet rs;
	 	rs = db.executeQuery(querySql.toString());//执行查询
	 	//rs.last(); //移到最后一行
		//int rowCount = rs.getRow(); //得到当前行号，也就是记录数
		//rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
	 	int i = 1;
	 	while(rs.next()){
	 		//循环取值 取该表的前28列，下标从1开始取
	 		for(;i <= 29;i++){
		 		list.add(getDBStr(rs.getString(i)));
	 		}
	 	}
	 	//out.println(list.size());
	 	rs.close();
	 }
%> 
<!-- form表单跳转到zjcs_businessOperating.jsp页面  -->
<form name="form1" method="post" target="qs" action="zjcs_businessOperating.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
</td></tr> 
<tr>
<td>
<!--操作按钮始-->
<table border="0" cellspacing="0" cellpadding="0">    
	<tr class="maintab_dh">
		<td nowrap >	
			<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
			<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
    	</td>
    </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>

<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
 <%
 	if(model.equals("add")){
 %>
  <td id="Form_tab_0" class="Form_tab" width=88 align=center onClick="chgTabN()"  valign="middle">&nbsp;商务条件添加&nbsp;</td>
 <%		
 	}
 	if(model.equals("mod")){
 %>
  <td id="Form_tab_0" class="Form_tab" width=88 align=center onClick="chgTabN()"  valign="middle">&nbsp;商务条件修改&nbsp;</td>
 <%		
 	}
 %>
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2">&nbsp;</td></tr>
</table>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:350px;overflow:auto;">
<div id="TD_tab_0">
<!-- 隐藏域传值  -->
<input type="hidden" name="savaType" id="savaType" value="<%=model%>"/>
<input type="hidden" name="modelType" id="modelType" value="zjcsModel"/>
<input type="hidden" name="proj_id" id="proj_id" value="<%=proj_id%>"/>
<table  border="0" cellspacing="0" cellpadding="0" width="100%" hight=70%" align="center" class="tab_table_title">
<%
if(list.size() > 0 || model.equals("mod")){
%>
  <tr>
  	<th scope="row">项目编号</th>
    <td>
    	<input name="proj_id" id="proj_id" type="text" value="<%=list.get(0)%>" 
    		  size="20" maxlength="50" readonly="readonly"/>
			<!-- dataType="Number" size="20" maxlength="50" maxB="50"  Require="true" -->
    	<span class="biTian">*</span>
     </td>
	 <th scope="row">货币类型</th>
     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
		<select name="currency" id="currency">
			<script>
				var currencyValue = <%=list.get(1)%>;
				if(currencyValue != null || currencyValue != ''){
					w(mSetOpt("<%=list.get(1)%>","人民币|美元|日元|法国法郎|德国马克|港币|加拿大元|荷兰盾|瑞士法郎|比利时法郎|欧元","0|1|2|3|4|5|6|7|8|9|10")); 
				}else{
					w(mSetOpt("0","人民币|美元|日元|法国法郎|德国马克|港币|加拿大元|荷兰盾|瑞士法郎|比利时法郎|欧元","0|1|2|3|4|5|6|7|8|9|10")); 
				}
			</script>
		</select>
    	<span class="biTian">*</span>
	</td>
  </tr> 	
  <tr>
    <th scope="row">申请金额(设备金额)</th>
    <td>
    	<input name="equip_amt" id="equip_amt" type="text" 
    		value="<%=formatNumberDoubleTwo(getDBStr(list.get(2)))%>" 
    		dataType="Money" size="20" maxlength="50" maxB="50"  Require="true"/>
       	<span class="biTian">*</span>
     </td>
      <th scope="row">首付款</th>
      <td>
    	<input name="first_payment" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(3)))%>" 
    	onchange="changeFirst_payment()" dataType="Money" size="20" maxlength="50" maxB="50"  Require="true"/>
    	<span class="biTian">*</span>
   	   </td> 
   </tr>
  
  <tr> <!--  租赁本金 = 设备金额 - 首付款   -->
   <th scope="row">租赁本金</th>
     <td>
    	<input name="lease_money" id="lease_money" value="<%=formatNumberDoubleTwo(getDBStr(list.get(4)))%>" 
    	readonly type="text" Require="true" dataType="Money" size="20" maxlength="100" maxB="100" />
    	<span class="biTian">*</span>
	 </td>
	<th  scope="row">租赁保证金</th>
	<td>
		<input name="caution_money" id="caution_money" value="<%=formatNumberDoubleTwo(getDBStr(list.get(5)))%>" 
			dataType="Money" size="20" maxlength="20" maxB="20"  Require="true" 
			onchange="assignment()" type="text"/>
		<span class="biTian">*</span>
	</td>
  </tr>

   <tr>
  	<th scope="row">净融资额</th>
    <td>
    	<!--  净融资额 = 租赁本金 - 保证金  -->
    	<input name="net_lease_money" id="net_lease_money" type="text" 
    		value="<%=formatNumberDoubleTwo(getDBStr(list.get(6)))%>" readonly 
    		dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"
    		onclick="assignment()" title="鼠标点击即可获取净融资额值"/> 
    		<span class="biTian">*</span>
	</td>
	<th  scope="row">手续费（经销商）</th>
	<td>
		<input name="handling_charge" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(7)))%>" 
		 	dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
		<span class="biTian">*</span></td>
  </tr>	

  <tr> 
  	<th scope="row">付租方式</th>
    <td>
    	 <select name="income_number_year" id="income_number_year"  onChange="changeLease_term()">
			<script>
				var inyValue = "<%=list.get(8)%>";
				if(inyValue != null || inyValue != ''){
					w(mSetOpt("<%=list.get(8)%>","-请选择-|月付|季付|半年付|年付","|1|3|6|12")); 
				}else{
					w(mSetOpt("","-请选择-|月付|季付|半年付|年付","|1|3|6|12")); 
				} 
			</script>
		</select>
    	<span class="biTian">*</span>
	</td>
	<!-- 根据付租方式判断 -->
	<th scope="row">租赁期限(月)</th>
    <td>
    	<input name="lease_term" type="text" value="<%=list.get(9)%>"  onChange="changeLease_term()"
    		dataType="Number" size="10" maxlength="10" maxB="10"  Require="true"/>
    	<span class="biTian">*</span>
	</td>
   </tr> 

  <tr>
    <!-- 还租次数=租赁期限/年还租次数 -->
  	<th scope="row">还租次数</th>
    <td>
    	<input name="income_number" type="text" value="<%=list.get(10)%>"  
    		dataType="Number" size="20" maxlength="10" maxB="10"  Require="true" readonly="readonly"/>
    	<span class="biTian">*</span>
	</td>
	<th  scope="row">期末残值(或名义留购价)</th>
	<td>
		<input name="nominalprice" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(11)))%>"  
			dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
		<span class="biTian">*</span>
	</td>
  </tr>
  
   <tr>
<!--   -->
  	<th scope="row">付租类型</th>
    <td><select name="period_type">
        <script>
        	var perTypeValue = <%=list.get(12)%>;
        	if(perTypeValue != null || perTypeValue != ''){
	        	w(mSetOpt('<%=list.get(12)%>;',"期初|期末","1|0"));
        	}else{
	        	w(mSetOpt('0',"期初|期末","1|0"));
        	}
        </script>
        </select><span class="biTian">*</span>
	</td> 
    <th  scope="row">厂商返利</th>
	<td>
		<input name="return_amt" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(13)))%>"  
			dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
		<span class="biTian">*</span>
	</td>
  </tr>	
  <tr>
	<th  scope="row">租赁年利率</th>
	<td>
		<input name="year_rate" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(14)))%>"  
			dataType="Money" size="10" maxlength="10" maxB="10"  Require="true"/>%
			<!--  	暂时不确定该方法是否有用   
			onPropertychange="getMoney(document.forms[0].first_payment_ratio.value,document.forms[0].first_payment)"
			--> 
		<span class="biTian">*</span>
	</td>  
  	<th scope="row">利率浮动类型</th>
    <td>
    	<select name="rate_float_type">
        <script>
        	var rateTypeValue = <%=list.get(15)%>;
        	if(rateTypeValue != null || rateTypeValue != ''){
	        	w(mSetOpt('<%=list.get(15)%>',"固定|浮动","1|0"));
        	}else{
	        	w(mSetOpt('0',"固定|浮动","1|0"));
        	}
        </script>
        </select> 
    	<span class="biTian">*</span>
	</td>
</tr>
  
  <tr>
	<th scope="row">租前息</th>
    <td>
    	<input name="before_interest" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(16)))%>"  
    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />
    	<span class="biTian">*</span>
	</td>
  	<th scope="row">利率调整系数</th>
    <td> 
    	<!-- 关于利率调整系数radio的默认初始化 -->
    	<%
    		String ramValue = list.get(17);
    		if(ramValue.equals("365/360")){
    	%>	
    		<input type="radio" name="rate_adjustment_modulus" value="360/360" style="border:none;">360/360
			<input type="radio" name="rate_adjustment_modulus" value="365/360" checked style="border:none;">365/360
    	<%	
    		}else{ 
    	%>
    		<input type="radio" name="rate_adjustment_modulus" value="360/360" checked style="border:none;">360/360
			<input type="radio" name="rate_adjustment_modulus" value="365/360" style="border:none;">365/360
    	<%
    		}
    	%>	
    	<span class="biTian">*</span>
	</td>
  </tr>

  <tr>
  	<th scope="row">罚息利率</th>
    <td colspan="">
    	<input name="pena_rate" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(18)))%>"  
         size="20" maxlength="20" dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%%
         <!-- 另外的判断输入方式 只能输入整数 onKeyUp="value=value.replace(/[^\d]/g,'')"
         	onblur="if(isNaN(document.all.tolerance_date.value)){
            alert('免息期请正确输入天数');document.all.tolerance_date.focus();}"  
          -->
    	<span class="biTian">*</span>
	</td>  
	<th  scope="row">每月偿付日</th>
	<td>
		<input name="income_day" type="text" value="<%=list.get(19)%>"  
			 size="20" maxlength="20" onKeyUp="value=value.replace(/[^\d]/g,'')"/>
		<span class="biTian">*</span>
	</td>
  </tr>
  <tr>
	<th  scope="row">起租日</th>
	<td>
		<input name="start_date" type="text" value="<%=getDBDateStr(list.get(20))%>"  
			 size="20" maxlength="20" />
		<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
		 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<span class="biTian">*</span>
	</td>
		<th  scope="row">计划IRR</th>
	<td>
		<input name="plan_irr" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(21)))%>"  
			dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />
		<span class="biTian">*</span>
	</td> 
  </tr> 
  
  <tr> 
	<th  scope="row">租金计算方法</th>
	<td>
		<select name="measure_type">
        <script>
        	var measureValue = <%=list.get(22)%>;
        	if(measureValue != null || measureValue != ''){
	        	w(mSetOpt('<%=list.get(22)%>',"等额|等本|不规则","0|1|2"));
        	}else{
	        	w(mSetOpt('0',"等额|等本|不规则","0|1|2"));
        	}
        </script>
        </select>
		<span class="biTian">*</span>
	</td> 
	<th  scope="row">其他收入</th>
	<td>
		<input name="other_income" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(23)))%>"  
			dataType="Money" size="20" maxlength="20" maxB="20"  Require=""/>
	</td>
  </tr>
  
  <tr>  
	<th scope="row">其他支出</th>
    <td>
    	<input name="other_expenditure" type="text" value="<%=formatNumberDoubleTwo(getDBStr(list.get(24)))%>"  
    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" /> 
	</td>
	<th  scope="row">登记人</th>
	<td>
		<input name="creator" type="text" value="<%=list.get(25)%>"  
		  size="20" maxlength="20" />
		<span class="biTian">*</span>
	</td>
  </tr>

  <tr>  
	<th  scope="row">登记时间</th>
	<td>
		<input name="create_date" type="text" value="<%=getDBDateStr(list.get(26))%>"  
		  dataType="Date" size="20" maxlength="20" maxB="20"  Require="true"/> 
		 <img  onClick="openCalendar(create_date);return false" style="cursor:pointer; " 
		 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<span class="biTian">*</span>
	</td>
	<th  scope="row">更新日期</th>
	<td>
		<input name="modify_date" type="text" value="<%=getDBDateStr(list.get(27))%>"  
		  dataType="Date" size="20" maxlength="20" maxB="20"  Require=""/> 
		 <img  onClick="openCalendar(modify_date);return false" style="cursor:pointer; " 
		 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
  </tr>
  <tr>  
	<th  scope="row">更新人</th>
	<td colspan="2">
		<input name="modificator" type="text" value="<%=list.get(28)%>"  
		  size="20" maxlength="20" /> 
	</td>  
  </tr>
<% 		
}else{
%>
  <tr>
  	<th scope="row">项目编号</th>
    <td>
    	<input name="proj_id" id="proj_id" type="text" value="" 
    		  size="20" maxlength="50"/>
			<!-- dataType="Number" size="20" maxlength="50" maxB="50"  Require="true" -->
    	<span class="biTian">*</span>
     </td>
	 <th scope="row">货币类型</th>
     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
		<select name="currency" id="currency">
			<script>
				w(mSetOpt("0","人民币|美元|日元|法国法郎|德国马克|港币|加拿大元|荷兰盾|瑞士法郎|比利时法郎|欧元","0|1|2|3|4|5|6|7|8|9|10")); 
			</script>
		</select>
    	<span class="biTian">*</span>
	</td>
  </tr> 	
  <tr>
    <th scope="row">申请金额(设备金额)</th>
    <td>
    	<input name="equip_amt" id="equip_amt" type="text" 
    		value="" 
    		dataType="Money" size="20" maxlength="50" maxB="50"  Require="true"/>
       	<span class="biTian">*</span>
     </td>
      <th scope="row">首付款</th>
      <td>
    	<input name="first_payment" type="text" value="" 
    	onchange="changeFirst_payment()" dataType="Money" size="20" maxlength="50" maxB="50"  Require="true"/>
    	<span class="biTian">*</span>
   	   </td> 
   </tr>
  
  <tr> <!--  租赁本金 = 设备金额 - 首付款   -->
   <th scope="row">租赁本金</th>
     <td>
    	<input name="lease_money" id="lease_money" value="" 
    	readonly type="text" Require="true" dataType="Money" size="20" maxlength="100" maxB="100" />
    	<span class="biTian">*</span>
	 </td>
	<th  scope="row">租赁保证金</th>
	<td>
		<input name="caution_money" id="caution_money" value="" 
			dataType="Money" size="20" maxlength="20" maxB="20"  Require="true" 
			onchange="assignment()" type="text"/>
		<span class="biTian">*</span>
	</td>
  </tr>

   <tr>
  	<th scope="row">净融资额</th>
    <td>
    	<!--  净融资额 = 租赁本金 - 保证金  -->
    	<input name="net_lease_money" id="net_lease_money" type="text" 
    		value="" readonly 
    		dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"
    		onclick="assignment()" title="鼠标点击即可获取净融资额值"/> 
    		<span class="biTian">*</span>
	</td>
	<th  scope="row">手续费（经销商）</th>
	<td>
		<input name="handling_charge" type="text" value="" 
		 	dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
		<span class="biTian">*</span></td>
  </tr>	

  <tr> 
  	<th scope="row">付租方式</th>
    <td>
    	 <select name="income_number_year" id="income_number_year"  onChange="changeLease_term()">
			<script>
				w(mSetOpt("","-请选择-|月付|季付|半年付|年付","|1|3|6|12")); 
			</script>
		</select>
    	<span class="biTian">*</span>
	</td>
	<!-- 根据付租方式判断 -->
	<th scope="row">租赁期限(月)</th>
    <td>
    	<input name="lease_term" type="text" value=""  onChange="changeLease_term()"
    		dataType="Number" size="10" maxlength="10" maxB="10"  Require="true"/>
    	<span class="biTian">*</span>
	</td>
   </tr> 

  <tr>
    <!-- 还租次数=租赁期限/年还租次数 -->
  	<th scope="row">还租次数</th>
    <td>
    	<input name="income_number" type="text" value=""  
    		dataType="Number" size="20" maxlength="10" maxB="10"  Require="true" readonly="readonly"/>
    	<span class="biTian">*</span>
	</td>
	<th  scope="row">期末残值(或名义留购价)</th>
	<td>
		<input name="nominalprice" type="text" value=""  
			dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
		<span class="biTian">*</span>
	</td>
  </tr>
  
   <tr>
<!--   -->
  	<th scope="row">付租类型</th>
    <td><select name="period_type">
        <script>
	        w(mSetOpt('0',"期初|期末","1|0"));
        </script>
        </select>
        <span class="biTian">*</span>
	</td> 
    <th  scope="row">厂商返利</th>
	<td>
		<input name="return_amt" type="text" value=""  
			dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
		<span class="biTian">*</span>
	</td>
  </tr>	
  <tr>
	<th  scope="row">租赁年利率</th>
	<td>
		<input name="year_rate" type="text" value=""  
			dataType="Money" size="10" maxlength="10" maxB="10"  Require="true"/>%
			<!--  	暂时不确定该方法是否有用   
			onPropertychange="getMoney(document.forms[0].first_payment_ratio.value,document.forms[0].first_payment)"
			--> 
		<span class="biTian">*</span>
	</td>  
  	<th scope="row">利率浮动类型</th>
    <td>
    	<select name="rate_float_type">
        <script>
	        w(mSetOpt('0',"固定|浮动","1|0"));
        </script>
        </select> 
    	<span class="biTian">*</span>
	</td>
</tr>
  
  <tr>
	<th scope="row">租前息</th>
    <td>
    	<input name="before_interest" type="text" value=""  
    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />
    	<span class="biTian">*</span>
	</td>
  	<th scope="row">利率调整系数</th>
    <td> 
    	<!-- 关于利率调整系数radio的默认初始化 -->
    	<input type="radio" name="rate_adjustment_modulus" value="360/360" checked style="border:none;">360/360
		<input type="radio" name="rate_adjustment_modulus" value="365/360" style="border:none;">365/360
    	<span class="biTian">*</span>
	</td>
  </tr>

  <tr>
  	<th scope="row">罚息利率</th>
    <td colspan="">
    	<input name="pena_rate" type="text" value=""  
         size="20" maxlength="20" dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />%%
         <!-- 另外的判断输入方式 只能输入整数 onKeyUp="value=value.replace(/[^\d]/g,'')"
         	onblur="if(isNaN(document.all.tolerance_date.value)){
            alert('免息期请正确输入天数');document.all.tolerance_date.focus();}"  
          -->
    	<span class="biTian">*</span>
	</td>  
	<th  scope="row">每月偿付日</th>
	<td>
		<input name="income_day" type="text" value=""  
			 size="20" maxlength="20" onKeyUp="value=value.replace(/[^\d]/g,'')"/>
		<span class="biTian">*</span>
	</td>
  </tr>
  <tr>
	<th  scope="row">起租日</th>
	<td>
		<input name="start_date" type="text" value=""  
			 size="20" maxlength="20" />
		<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
		 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<span class="biTian">*</span>
	</td>
		<th  scope="row">计划IRR</th>
	<td>
		<input name="plan_irr" type="text" value=""  
			dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" />
		<span class="biTian">*</span>
	</td> 
  </tr> 
  
  <tr> 
	<th  scope="row">租金计算方法</th>
	<td>
		<select name="measure_type">
        <script>
	        w(mSetOpt('0',"等额|等本|不规则","0|1|2"));
        </script>
        </select>
		<span class="biTian">*</span>
	</td> 
	<th  scope="row">其他收入</th>
	<td>
		<input name="other_income" type="text" value=""  
			dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"/>
		<span class="biTian">*</span>
	</td>
  </tr>
  
  <tr>  
	<th scope="row">其他支出</th>
    <td>
    	<input name="other_expenditure" type="text" value=""
    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" /> 
		<span class="biTian">*</span>
	</td>
	<th  scope="row">登记人</th>
	<td>
		<input name="creator" type="text" value=""  
		  size="20" maxlength="20" />
		<span class="biTian">*</span>
	</td>
  </tr>

  <tr>  
	<th  scope="row">登记时间</th>
	<td>
		<input name="create_date" type="text" value=">"  
		  dataType="Date" size="20" maxlength="20" maxB="20"  Require="true"/> 
		 <img  onClick="openCalendar(create_date);return false" style="cursor:pointer; " 
		 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<span class="biTian">*</span>
	</td>
	<th  scope="row">更新日期</th>
	<td>
		<input name="modify_date" type="text" value=""  
		   size="20" maxlength="20" /> 
		 <img  onClick="openCalendar(modify_date);return false" style="cursor:pointer; " 
		 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
  </tr>
  <tr>  
	<th  scope="row">更新人</th>
	<td colspan="2">
		<input name="modificator" type="text" value=""  
		  size="20" maxlength="20" /> 
	</td>  
  </tr>
<%
}
%>
  <tr>
	  <!-- 跳转到租金测算开始页  -->
  	  <td colspan="6" align="right">
		<BUTTON class="btn_2" name="btnSave" value="租金测算"  type="submit">
		<img src="../../images/save.gif" align="absmiddle" border="0">租金测算</button>
	  </td>
   </tr> 
</table>
</div>
</div>
</form>
</body>
</html>
<%if(null != db){db.close();}%>