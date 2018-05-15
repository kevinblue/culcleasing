<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增授信单位 - 融资基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<%
	//获取待投保的保单Id
	String id = getStr(request.getParameter("priId"));

	//查询保单相关信息
	sqlstr = "select * from vi_insur_unxbf where id = "+id;
	rs = db.executeQuery(sqlstr);
	String insur_no = "";
	String insur_money = "";
	String insur_type_c = "";

	String project_name = "";
	String insur_period = "";
	String insur_date = "";
	String insur_charge_money = "";
	String insur_term = "";

	if(rs.next()){
		insur_no = getDBStr(rs.getString("insur_no"));
		insur_money = CurrencyUtil.convertFinance(rs.getString("insur_money"));

		insur_type_c = getDBStr(rs.getString("insur_type_c"));
		insur_period = getDBStr(rs.getString("insur_period"));
		insur_term = CurrencyUtil.convertIntAmount( rs.getString("insur_term" ));

		project_name = getDBStr(rs.getString("project_name"));
		insur_charge_money = CurrencyUtil.convertFinance(rs.getString("insur_charge_money"));
	}
rs.close();
db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
	<td class="tree_title_txt"  height=26 valign="middle" align="left">保险管理&gt; 保费支付&gt; 支付</td>
</tr>
<tr>

<td align=center width=100% height=100% valign="top">
<form name="form1" method="post" action="insur_unxbf_KH_save.jsp" onSubmit="return Validator.Validate(this,3);">

<input type="hidden" name="id" value="<%=id%>">

<div class="mydivtab" id="mydiv">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">保单号</td>
    <td scope="row">
      <input name="insur_no" type="text" disabled="disabled" value="<%=insur_no%>">
	</td>
  </tr>
  <tr>
    <td scope="row">投保金额</td>
    <td scope="row">
      <input name="insur_charge_money" type="text" disabled="disabled" value="<%=insur_charge_money%>">
	</td>
  </tr>
  <tr>
    <td scope="row">投保期限</td>
    <td scope="row">
      <input name="insur_term" type="text" disabled="disabled" value="<%=insur_term%>">
	</td>
  </tr>

  <tr>
    <td scope="row">项目名称</td>
    <td scope="row">
      <input name="project_name" type="text" size="70" disabled="disabled" value="<%=project_name%>">
	</td>
  </tr>
   <tr>
    <td scope="row">险种</td>
    <td scope="row">
      <input name="insur_type_c" type="text" disabled="disabled" value="<%=insur_type_c%>">
	</td>
  </tr>

  <tr>
    <td scope="row">投保支付周期</td>
    <td scope="row">
      <input name="insur_period" type="text" disabled="disabled" value="<%=insur_period%>">
	</td>
  </tr>

  <tr>
    <td scope="row">下次续保日期</td>
    <td scope="row">
      <input name="next_pay_date" type="text" size="30" maxlength="20" readonly="readonly" Require="ture">
	  <img  onClick="openCalendar(next_pay_date);return false" style="cursor:pointer; " 
	  src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span>
	</td>
  </tr>

  <tr>
    <td scope="row">保费金额</td>
    <td scope="row">
      <input name="insur_money" type="text" disabled="disabled" value="<%=insur_money%>">
	</td>
  </tr>

</table></div>
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保费支付" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->

</form>
</td></tr></table>
<!-- end cwMain -->
</body>
</html>

