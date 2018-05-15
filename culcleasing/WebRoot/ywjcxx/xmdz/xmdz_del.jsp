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
<title>项目对照表 - 项目对照表</title>
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
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 项目对照表</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="xmdz_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<!-- end cwCellTop -->

<%
sqlstr = "select * from dbo.inter_leasing_project_join where id='"+czid+"' "; 
rs=db.executeQuery(sqlstr); 
String auxiliary_account;
String flow_name;
String handle_flag;
if (rs.next()) 
{ 

%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr >
    <td width="120" height="30" scope="row">项目名</td>
    <td height="30" >
     <input name="subject_name" type="text" label="项目名" value="<%=getDBStr(rs.getString("subject_name")) %>" Require="true" readonly="readonly"><span class="biTian">*</span>
	</td>
  </tr>
   <tr>
    <td height="30" scope="row">项目编码</td>
    <td height="30"><input name="subject_number" type="text" label="项目编码"  value="<%=getDBStr(rs.getString("subject_number")) %>"  Require="ture" readonly="readonly"><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td height="30" scope="row">项目编号</td>
    <td height="30"><input name="project_id" type="text" label="项目编号"  value="<%=getDBStr(rs.getString("project_id")) %>"  Require="ture" readonly="readonly"><span class="biTian">*</span></td>
  </tr>
  

  <tr>
    <td height="30" scope="row">最后更新日期</td>
    <td height="30"><%=getDBDateStr(rs.getString("modify_date"))%></td>
  </tr>
  <tr>
    <td height="30" scope="row"> 操作员</td>
    <td height="30"><%=getDBStr(rs.getString("modificator"))%></td>
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