<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>城市信息明细 - 城市信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String czid;
czid=getStr(request.getParameter("czid"));
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 城市信息明细</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<!-- end cwCellTop -->


<%
String sqlstr;
ResultSet rs;
sqlstr = "select jb_csxx.*,jb_ssxx.id,jb_ssxx.sfmc,jb_qyxx.qyid,jb_qyxx.qymc,jb_gjxx.id,jb_gjxx.gjmc,base_user.name from dbo.jb_csxx left join jb_ssxx on jb_csxx.sfid=jb_ssxx.id left join jb_qyxx on jb_ssxx.qyid=jb_qyxx.qyid left join jb_gjxx on jb_qyxx.gjid=jb_gjxx.id left join base_user on jb_csxx.czy=base_user.id  where jb_csxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>




<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
   <tr>
    <td width="16%" height="30" class="cwDDLabel">所属国家</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("gjmc"))%></td>
  </tr>
     <tr>
    <td width="16%" height="30" class="cwDDLabel">所在地区</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("qymc"))%></td>
  </tr>
   <tr>
    <td width="16%" height="30" class="cwDDLabel">省/直辖市</td>
    <td width="84%" height="30" class="cwDDValue"><%=getDBStr(rs.getString("sfmc"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">城市代码</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("id"))%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">名称</td>
    <td height="30" class="cwDDValue"><%=getDBStr(rs.getString("csmc"))%></td>
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
<tr valign="top">
<form action="csxx_mod.jsp?czid=<%=czid%> " target="_self">
<input name="czid" value="<%=czid%>" type="hidden">
<td>
<input name="btnMod" value="修改" type="submit" class="btn3_mouseout">
</td>
</form>
<td>
<input name="btnClose" value="关闭" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
