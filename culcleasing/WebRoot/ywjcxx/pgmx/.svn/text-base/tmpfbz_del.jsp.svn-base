<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>删除评估条目评分标准信息 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String czid;
czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
   czid="0";
}
%>
<body>

<div id="cwMain" >
<form name="form1" method="post" action="tmpfbz_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >基础信息管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">





<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">删除评估条目评分标准信息</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td></td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%
String sqlstr;
ResultSet rs;
sqlstr = "SELECT jb_pgmx_tmxx.pjys AS pjys, jb_pgmx_tmpfbz.*, jb_yhxx.xm AS djrxm, jb_yhxx_1.xm AS gxrxm FROM jb_pgmx_tmpfbz LEFT OUTER JOIN";
sqlstr+=" jb_yhxx jb_yhxx_1 ON jb_pgmx_tmpfbz.gxr = jb_yhxx_1.id LEFT OUTER JOIN jb_yhxx ON jb_pgmx_tmpfbz.djr = jb_yhxx.id LEFT OUTER JOIN";
sqlstr+=" jb_pgmx_tmxx ON jb_pgmx_tmpfbz.tmid = jb_pgmx_tmxx.id  where jb_pgmx_tmpfbz.id="+czid; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>


<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th width="16%" class="cwDDLabel">评价要素</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("pjys"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">评分依据</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("pfyj"))%></td>
  </tr>
    <tr>
    <th class="cwDDLabel" scope="row">分值</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("fz"))%></td>
    </tr>
  <tr>
    <th  width="20%" class="cwDDLabel">序号</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("xh"))%></td>
  </tr>
  <tr>
    <th  width="20%" class="cwDDLabel">当前是否有效</th>
    <td class="cwDDValue"><%=formatBooleanStr(getDBStr(rs.getString("his")),0)%></td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">登记人</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("djr"))%>&nbsp;</td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">登记日期</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("djrq"))%>&nbsp;</td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">更新人</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("gxr"))%>&nbsp;</td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">更新日期</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("gxrq"))%>&nbsp;</td>
  </tr>
</table>

<%
}
else
{
   out.print("<center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>

<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->






<div id="cwToolbar">
<input class="btn" name="submit" value="删除" type="submit"  onClick="return(confirm('确定删除吗?'))">
<input class="btn" name="btnClose" value="关闭" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>
