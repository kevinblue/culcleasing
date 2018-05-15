<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租赁物件明细 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">基础信息管理</td>
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
        <td id="cwCellTopTitTxt">租赁物件明细</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
<%
String sqlstr;
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
%>
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
<td></td>
<%
if (1==1)
{
%>
        <td><a href="zlwj_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)"><img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" > 修改</a></td>
<%
}
%>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->

<div id="cwCellContent" >
<%
sqlstr = "SELECT V_yhxx.xm AS xm, jb_zlwjlb.lxmc AS lbmc, jb_zlwjlx.lxmc AS lxmc,jb_zlwjzzs.zzsmc AS zzsmc, jb_zlwjxx.*,jb_zlwjcptx.lxmc AS cptxmc FROM jb_zlwjxx LEFT OUTER JOIN jb_zlwjcptx ON jb_zlwjxx.cptx = jb_zlwjcptx.id LEFT OUTER JOIN jb_zlwjzzs ON jb_zlwjxx.zzs = jb_zlwjzzs.id LEFT OUTER JOIN jb_zlwjlx ON jb_zlwjxx.wjlx = jb_zlwjlx.id LEFT OUTER JOIN jb_zlwjlb ON jb_zlwjxx.wjlb = jb_zlwjlb.id LEFT OUTER JOIN V_yhxx ON jb_zlwjxx.czy = V_yhxx.id where jb_zlwjxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>


<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th class="cwDDLabel" width="20%">租赁物件编号</th>
    <td class="cwDDValue" width="80%"><%=getDBStr(rs.getString("id"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" width="20%">租赁物件名称</th>
    <td class="cwDDValue" width="80%"><%=getDBStr(rs.getString("wjmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">总类</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lbmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">产品名称</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("lxmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">产品特性</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("cptxmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">计件单位名称</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("jjdw"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">参考价</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("ckj"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">规格</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("wjgg"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">制造商</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zzsmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">物件长度</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("cd"))%>厘米</td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">物件宽度</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("kd"))%>厘米</td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">物件高度</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("gd"))%>厘米</td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">物件内部产品编码</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("nbcpbm"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">注册证到期日</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("wjdqr"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">物件产地</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("wjcd"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">信息状态</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zt"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">最后更新日期</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">操作员</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("xm"))%></td>
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





<div id="cwToolbar">
<input class="btn" name="btnClose" value="关闭" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
