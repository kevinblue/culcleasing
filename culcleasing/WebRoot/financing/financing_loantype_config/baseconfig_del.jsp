<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>删除贷款类型 - 融资基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String priId = getStr( request.getParameter("czid") );
sqlstr = "Select financing_config_loantype.*,dbo.GETUSERNAME(creator) as oper_name from financing_config_loantype where id='"+priId+"'"; 

rs = db.executeQuery(sqlstr); 

String code = "";
String loan_name = "";
String oper_name = "";

if ( rs.next() ) {
	code = getDBStr( rs.getString("code") );
	loan_name = getDBStr( rs.getString("loan_name") );
	oper_name = getDBStr( rs.getString("oper_name") );
}

rs.close();
db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<form name="form1" method="post" action="baseconfig_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="priId" value="<%=priId %>">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">融资基础信息管理&gt; 删除贷款类型</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<!-- end cwCellTop -->

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td height="30" scope="row">贷款类型编号</td>
    <td width="84%" height="30" class="cwDDValue"><%=code %></td>
  </tr>
  <tr>
    <td height="30" scope="row">贷款类型名称</td>
    <td height="30" class="cwDDValue"><%=loan_name %></td>
  </tr>
  <tr>
    <td height="30" scope="row">操作员</td>
    <td height="30" class="cwDDValue"><%=oper_name %></td>
  </tr>
</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btndel" value="删除" type="submit" onClick="return(confirm('确定删除吗?'))" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
</td></tr></table></form>
<!-- end cwMain -->

</body>
</html>
