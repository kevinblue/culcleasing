<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>

<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改掉期时间 - 融资管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
String col_str="id,swap_start_date_t,swap_currency_t,swap_delivery_date_t,swap_nominal_money_t,swap_fix,swap_lib,swap_rate_t,rate_diff,isnull(interest_day_amount,datediff(dd,swap_start_date_t,swap_delivery_date_t)) interest_day_amount,interest_diff,fact_bank_diff,(select name from base_user where id=modifactor) modifactor ";

	String id = getStr( request.getParameter("Id") );
	String sqlstr = "select "+col_str+" from financing_change_date_info where id='"+id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
	if(rs.next()){}
%>

<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="financing_dqAccount_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
修改掉期时间 - 融资管理
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td scope="row" nowrap class="text">
	    	
<BUTTON class="btn_2" name="btnSave" value="提交" type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修改信息</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
  <script language="javascript">
ShowTabN(0);
</script></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=id%>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">  
  <tr>
   <td nowrap class="text">起息日：</td>
	<td nowrap class="text">
    <input name="swap_start_date_t" type="text" style="width:150px;" readonly="readonly" dataType="Date" Require="ture" value="<%=getDBDateStr(rs.getString("swap_start_date_t")) %>">
    <img  onClick="openCalendar(swap_start_date_t);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
	
   <td nowrap class="text">交割日：</td>
   <td nowrap class="text">
	<input name="swap_delivery_date_t" type="text" style="width:150px;" readonly="readonly" dataType="Date" Require="ture" value="<%=getDBDateStr(rs.getString("swap_delivery_date_t")) %>">
    <img  onClick="openCalendar(swap_delivery_date_t);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
   </tr>
    <tr>
	<td nowrap class="text">名义金额：</td>
	<td nowrap class="text"><input class="text" id="swap_nominal_money_t" onpropertychange='calRate2();'  name="swap_nominal_money_t" <%if("".equals(id)){ %>readonly="readonly"<%} %> type="text" value="<%=getDBStr(rs.getString("swap_nominal_money_t")) %>" Require="true">
	<span class="biTian">*</span></td>
   <td nowrap class="text">FIX：</td>
	<td nowrap class="text"><input class="text" id="swap_fix" name="swap_fix" onpropertychange='calRate1();' dataType="Double" type="text" value="<%=getDBStr(rs.getString("swap_fix")) %>" Require="true">%
	<span class="biTian">*</span></td>
   </tr>
    <tr>
	<td nowrap class="text">LIB：</td>
	<td nowrap class="text"><input class="text" id="swap_lib" name="swap_lib" <%if("".equals(id)){ %>readonly="readonly"<%} %> type="text" value="<%=getDBStr(rs.getString("swap_lib")) %>" Require="true">%
	<span class="biTian">*</span></td>
   <td nowrap class="text">合同利率：</td>
	<td nowrap class="text"><input class="text" id="swap_rate_t" name="swap_rate_t" onpropertychange='calRate1();' dataType="Double" size="18" maxlength="18" maxB="18"  type="text" value="<%=getDBStr(rs.getString("swap_rate_t")) %>" Require="true">%
	<span class="biTian">*</span></td>
   </tr>
   <tr>
	<td nowrap class="text">利率差：</td>
	<td nowrap class="text"><input class="text" id="rate_diff"  name ="rate_diff"  onpropertychange='calRate2();'  dataType="Double"  size="15" maxlength="15" maxB="15"  Require="true" type="text" value="<%=getDBStr(rs.getString("rate_diff")) %>"  Require="true">%
	</td>
	<td nowrap class="text">计息天数 ：</td>
	<td nowrap class="text"><input class="text" id="interest_day_amount"  name="interest_day_amount"  onpropertychange='calRate2();'  Require="true" dataType="Integer" size="10" maxlength="10" maxB="10"  type="text" value="<%=getDBStr(rs.getString("interest_day_amount")) %>"></td>
   </tr>
   <tr>
	<td nowrap class="text">息差：</td>
	<td nowrap class="text"><input class="text" id="interest_diff" name="interest_diff" type="text" dataType="Double"  size="15" maxlength="15" maxB="15"  value="<%=getDBStr(rs.getString("interest_diff")) %>">
	</td>
	<td nowrap class="text">银行实际利差 ：</td>
	<td nowrap class="text"><input class="text" id="fact_bank_diff"  name="fact_bank_diff" type="text" dataType="Double" size="15" maxlength="15" maxB="15"  value="<%=getDBStr(rs.getString("fact_bank_diff")) %>"></td>
   </tr>
 
</table>
</div>
</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right"></td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->
</form>
<%
db.close();
rs.close(); 

%>
<!-- end cwMain -->
</body>
<script>
	function calRate1(){
		var swap_fix = document.getElementById("swap_fix").value;
		var swap_rate_t = document.getElementById("swap_rate_t").value;
		if(swap_fix!=""&&swap_fix!=null&&swap_rate_t!=""&swap_rate_t!=null){
			var num = swap_rate_t-swap_fix;//要四舍五入的数字  
			var fixNum = new Number(num+1).toFixed(8);//四舍五入之前加1  
			var fixedNum = new Number(fixNum - 1).toFixed(8);//四舍五入之后减1，再四舍五入一下
			document.getElementById("rate_diff").value=fixedNum;
			}

		}
	function calRate2(){
		var swap_nominal_money_t = document.getElementById("swap_nominal_money_t").value;
		var rate_diff = document.getElementById("rate_diff").value;
		var interest_day_amount = document.getElementById("interest_day_amount").value;
		//alert(swap_nominal_money_t);
		//alert(rate_diff);
		//alert(interest_day_amount);
		if(swap_nominal_money_t!=""&&swap_nominal_money_t!=null&&rate_diff!=""&rate_diff!=null&&interest_day_amount!=""&interest_day_amount!=null){
			var num = swap_nominal_money_t*rate_diff*interest_day_amount/36000;//要四舍五入的数字  
			var fixNum = new Number(num+1).toFixed(8);//四舍五入之前加1  
			var fixedNum = new Number(fixNum - 1).toFixed(8);//四舍五入之后减1，再四舍五入一下
			document.getElementById("interest_diff").value=fixedNum;
			}

		}
	function changeDay(){
			

		}
</script>
</html>