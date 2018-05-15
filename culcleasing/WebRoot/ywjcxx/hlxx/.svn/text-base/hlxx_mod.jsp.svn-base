<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改汇率信息 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="hlxx_save.jsp" onSubmit="return chkInputDate(this);">


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
        <td id="cwCellTopTitTxt">修改汇率信息</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td>&nbsp;</td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">

<%
String sqlstr;
String czid;
String bz;
String hl;
String ksrq;
String jsrq;
String xgrq;
String czy;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "SELECT jb_hlxx.*, jb_bzxx.bz, V_yhxx.xm FROM V_yhxx RIGHT OUTER JOIN jb_hlxx ON V_yhxx.id = jb_hlxx.czy LEFT OUTER JOIN jb_bzxx ON jb_hlxx.bzid = jb_bzxx.id where jb_hlxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
        ksrq=getDBStr(rs.getString("ksrq"));
        ksrq=ksrq.substring(0,10);
        jsrq=getDBStr(rs.getString("jsrq"));
        if (jsrq!="")
        jsrq=jsrq.substring(0,10);
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=getDBStr(rs.getString("id"))%>">

<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th width="79" scope="row">币种</th>
    <td >
    <input type="text" name="bziddata" readonly label="币种" conttyp="" isopt="0" value="<%=getDBStr(rs.getString("bz"))%>"><input type="hidden" name="bzid"  value="<%=getDBStr(rs.getString("bzid"))%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="SimpleDataWindow('','','jb_bzxx','bz','id','','','id','form1.bziddata','form1.bzid');"> <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
    <th scope="row">汇率</th>
    <td><input name="hl" type="text" size="30" maxlength="30" label="汇率" conttyp="double" isopt="0" value="<%=getDBStr(rs.getString("hl"))%>"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">开始执行日期</th>
    <td><input name="ksrq" type="text" size="10" maxlength="10" label="开始执行日期" conttyp="date" isopt="0" value="<%=ksrq%>"><img  onClick="openCalendar(ksrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">执行截止日期</th>
    <td><input name="jsrq" type="text" size="10" maxlength="10" label="执行截止日期" conttyp="date"  value="<%=jsrq%>" ><img  onClick="openCalendar(jsrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
    <th scope="row">最后更新日期</th>
    <td><%=getDBStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <th scope="row"> 操作员</th>
    <td><%=getDBStr(rs.getString("xm"))%></td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="submit" value="保存" type="submit" onClick="return chkDate();">
<input class="btn" name="btnClose" value="取消" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="重置" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
   out.print("</center>该条记录不存在!</center>");
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>

