<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>公司银行账户明细 - 公司银行账户</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<%
String dqczy=(String) session.getAttribute("czyid");
String sqlstr;
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 公司银行账户明细</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv"><!-- end cwCellTop -->
<div id="cwCellContent">
<%
sqlstr = "select id, bank_name, isnull(bank_money,0.00) as bank_money, account, acc_number, modificator, modify_date from dbo.base_account where id='"+czid+"' "; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" height="30" class="cwDDLabel">开户银行</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("bank_name"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">开户名</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("account"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">银行账号</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("acc_number"))%></td>
  </tr>
    <tr>
    <td height="30" scope="row">帐号余额</td>
    <td height="30"><%=getMoneyStr(rs.getString("bank_money"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">最后更新日期</td>
    <td height="30" class="cwDDValue"><%=getDBDateStr(rs.getString("modify_date"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">操作员</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("modificator"))%></td>
  </tr>
</table>

<%
}
else
{
   out.print("</center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>

<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top">
<form action="gszh_mod.jsp?czid=<%=czid%> " target="_self">
<input name="czid" value="<%=czid%>" type="hidden">
<%if(right.CheckRight("gszh_mod",dqczy)>0){%>
<td>
<input name="btnMod" value="修改" type="submit" class="btn3_mouseout">
</td><%}%>
</form>
<td>
<input name="btnClose" value="关闭" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table><!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
