<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改客户对照表 - 客户对照表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">客户信息维护 &gt; 修改客户对照</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="khdz_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  //dqczy="无认证";
  //response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gszh_mod",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<%
String sqlstr;
String czid;
String cust_id;
String cust_name;
String short_name;
String cust_num;
String modify_date;
String modificator;

ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "select * from dbo.inter_cust_info where id='"+czid+"' ";  
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
	cust_id=getDBStr(rs.getString("cust_id"));
	cust_name=getDBStr(rs.getString("cust_name"));
	short_name=getDBStr(rs.getString("short_name"));
	cust_num=getDBStr(rs.getString("cust_num"));
	modificator=getDBStr(rs.getString("modificator"));
%> 
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="79" height="30" scope="row">租赁系统用户ID</td>
    <td height="30" ><input name="cust_id" type="text" value="<%=getDBStr(rs.getString("cust_id"))%>"  label="租赁系统用户ID" Require="true"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td height="30" scope="row">财务系统用户名</td>
    <td height="30"><input name="cust_name" type="text" value="<%=getDBStr(rs.getString("cust_name"))%>"  label="开户名" Require="true"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td height="30" scope="row">财务系统用户名简称</td>
    <td height="30"><input name="short_name" type="text"  value="<%=short_name%>"  label="财务系统用户名简称" Require="true"> <span class="biTian">*</span></td>
  </tr>
    <tr>
    <td height="30" scope="row">财务系统用户名ID</td>
    <td height="30"><input name=cust_num type="text"  value="<%=cust_num%>"  label="财务系统用户名ID" Require="true"> <span class="biTian">*</span></td>
  </tr>

  <tr>
    <td height="30" scope="row">最后更新日期</td>
    <td height="30"><%=getDBDateStr(rs.getString("modify_date"))%></td>
  </tr>
  <tr>
    <td height="30" scope="row"> 操作员</td>
    <td height="30"><%=modificator%></td>
  </tr>
</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
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
    </form>
    <%
}
else
{
%>
 <center>该条记录不存在!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>