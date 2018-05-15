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
<script src="../../js/validator.js"></script>
</head>
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
 // dqczy="无认证";
  //response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gszh_del",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");

%>

<%
String czid;
String sqlstr;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 删除公司银行账户</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="gszh_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<!-- end cwCellTop -->

<%
sqlstr = "select id, bank_name, isnull(bank_money,0.00) as bank_money, account, acc_number, modificator, modify_date,ncbank_code from dbo.base_account where id='"+czid+"' "; 
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
    <td height="30" class="cwDDLabel" scope="row">NC编码</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("ncbank_code"))%></td>
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
<!-- end cwCellContent -->
</div>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input class="btn3_mouseout" name="submit" value="删除" type="submit"  onClick="return(confirm('确定删除吗?'))">
</td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>d cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>