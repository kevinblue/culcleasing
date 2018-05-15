<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>帐户资金收支明细 - 资金信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >资金信息管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">

<%
String czid=getStr(request.getParameter("czid"));
String sqlstr;
ResultSet rs;

String czy=(String) session.getAttribute("czyid");//取得操作员ID
if ((czy==null) || (czy.equals(""))) czy="0";
//czy="AFEE-6A6CWE";//资金管理部张惠华
sqlstr="select bmbh from v_yhxx where id='"+czy+"'";
String bmid="";//部门id

rs=db.executeQuery(sqlstr);
if (rs.next()) bmid=rs.getString("bmbh");
if ((bmid==null) || (bmid.equals(""))) bmid="0";
if (bmid.equals("0"))//未找到部门
{
%>
			
<%}%>



<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">帐户资金收支明细</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
<%
if (bmid.equals("AFEE-6A6CME"))//资金部人有权限修改
{
%>
        <td><a href="yemx_mod.jsp?czid=<%=czid%>"  accesskey="m" title="修改(Alt+M)"><img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" > 修改</a></td>
<%
}
%>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%

sqlstr = "SELECT * from v_zh_xjyemx where id='"+czid+"'";
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>


<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
<tr>
    <th class="cwDDLabel" scope="row">帐户</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zh"))%></td>
  </tr>
<tr>
    <th class="cwDDLabel" scope="row">帐户名称</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhmc"))%></td>
  </tr>
    <tr>
    <th class="cwDDLabel" scope="row">收支方式</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("szfs"))%></td>
    </tr>
  <tr>
    <th class="cwDDLabel" scope="row">记录录入日期</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("jlrq"))%></td>
  </tr>

   <tr>
    <th class="cwDDLabel" scope="row">金额(人民币)</th>
    <td class="cwDDValue"><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("jebb",2))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">金额(外币)</th>
    <td class="cwDDValue"><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("jewb",2))%></td>
  </tr>

  <tr>
    <th class="cwDDLabel" scope="row">收付款人</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("memo"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">录入时间</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("lrsj"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">备注</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("memo2"))%></td>
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
<input class="btn" name="btnClose" value="关闭" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
