<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>省/直辖市信息明细 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<%
String sqlstr;
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
%>
</head>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 删除省/直辖市信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

	

<!-- end cwCellTop -->



<%

sqlstr = "select jb_ssxx.*,jb_qyxx.qymc,jb_gjxx.id,jb_gjxx.gjmc,base_user.name from dbo.jb_ssxx left join dbo.jb_qyxx on jb_ssxx.qyid=jb_qyxx.qyid left join jb_gjxx on jb_qyxx.gjid=jb_gjxx.id left join base_user on jb_ssxx.czy=base_user.id where jb_ssxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>

<form name="form1"  method="post" action="sjxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="del">
        <input type="hidden" name="id" value="<%=czid%>" >

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" height="30" class="cwDDLabel">所属国家</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("gjmc"))%></td>
  </tr>
    <tr>
    <td width="16%" height="30" class="cwDDLabel">所在区域</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("qymc"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">省/直辖市代码</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("id"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">名称</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("sfmc"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">最后更新日期</td>
    <td height="30" class="cwDDValue"><%=getDBDateStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">操作员</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("name"))%></td>
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
<tr valign="top"><td>
<input name="btndel" value="删除" type="submit" onClick="return(confirm('确定删除吗?'))" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
</div><!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>
