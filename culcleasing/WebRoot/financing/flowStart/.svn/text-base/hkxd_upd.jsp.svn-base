<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>还款 - 修改</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script  src="../../js/sys_test_time.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%
//提取参数item_id
String item_id = getStr( request.getParameter("item_id") ); 
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">还款&gt; 修改条目</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="hkxd_upsave.jsp" onSubmit="return Validator.Validate(this,3);">

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
<% 
sqlstr = "select * from financing_refund_income where id='"+item_id+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){

%>
  <tr>
    <td scope="row">本金</td>
    <td scope="row">
     <input type="text" name="refund_corpus" value="<%=getDBStr(rs.getString("refund_corpus")) %>" 
     Require="ture" dataType="Money" style="width:150px;">
     <span class="biTian">*</span>
    </td>
    
    <td scope="row">利息</td>
    <td scope="row">
     <input type="text" name="refund_interest" value="<%=getDBStr(rs.getString("refund_interest")) %>" 
     Require="ture" dataType="Money" style="width:150px;">
     <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
   <td scope="row">其他费用</td>
    <td scope="row">
    <input name="refund_otherfee_money" id="refund_otherfee_money" style="width:150px;" type="text"
     dataType="Money" Require="ture" onblur="checkMoney()" value="<%=getDBStr(rs.getString("refund_otherfee_money")) %>">
    <span class="biTian">*</span>
    </td>
    
	<td>其他费用类型</td>
	<td>
		<select style="width:150px;" name="refund_otherfee_type">
	        <script type="text/javascript">
		        	w(mSetOpt('<%=getDBStr(rs.getString("refund_otherfee_type"))%>',"无|贴现息","无|贴现息"));
	        </script>
	     </select>
	</td>
    </tr>
    
	<tr>
   <td scope="row">实际还款日期</td>
    <td scope="row">

	<input name="fact_date" id="fact_date" type="text" value="<%=getDBDateStr(rs.getString("refund_fact_date"))%>"  
		style="width:150px;" maxlength="20" readonly="readonly" Require="ture"/>
	<img onClick="openCalendar(fact_date);return false" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
    
	<td></td>
	<td></td>
    </tr>

  <%} %>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
<input type="hidden" name="id" value="<%=getDBStr(rs.getString("id")) %>">
<input type="hidden" name="match_id" value="<%=getDBStr(rs.getString("match_id")) %>">
</form>
</div>
<!-- end cwMain -->
</body>

</html>

<%if(null != db){db.close();}%>