<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改评估条目信息 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1"  method="post" action="pgtmxx_save.jsp" onSubmit="return Validator.Validate(this,3);">

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
        <td id="cwCellTopTitTxt">修改评估条目信息</td>
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
String czid;
String sqlstr;

ResultSet rs;
czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
   czid="0";
}


sqlstr = "SELECT jb_pgmx_tmxx.*, jb_pgmx_pglxxl.pglxxlmc AS pglxxlmc,jb_yhxx.xm AS djrxm, jb_yhxx_1.xm AS gxrxm ";
sqlstr+=" FROM jb_yhxx jb_yhxx_1 RIGHT OUTER JOIN jb_pgmx_tmxx ON jb_yhxx_1.id = jb_pgmx_tmxx.gxr LEFT OUTER JOIN jb_yhxx ON jb_pgmx_tmxx.djr = jb_yhxx.id ";
sqlstr+=" LEFT OUTER JOIN jb_pgmx_pglxxl ON jb_pgmx_tmxx.pglxxlid = jb_pgmx_pglxxl.id where jb_pgmx_tmxx.id="+czid; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="id" value="<%=getDBStr(rs.getString("id"))%>">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th scope="row">评估类型小类</th>
    <td><%=getDBStr(rs.getString("pglxxlmc"))%><input name="pglxxlid" type="hidden"  value="<%=getDBStr(rs.getString("pglxxlid"))%>"></td>
  </tr>
  <tr>
    <th scope="row">评价要素</th>
    <td><textarea name="pjys"  Require="true" maxB="100"><%=getDBStr(rs.getString("pjys"))%></textarea><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">计算口径</th>
    <td><textarea name="jskj"  maxB="300"><%=getDBStr(rs.getString("jskj"))%></textarea></td>
  </tr>
  <tr>
    <th scope="row">评分说明</th>
    <td><textarea name="pfsm"  maxB="500"><%=getDBStr(rs.getString("pfsm"))%></textarea></td>
  </tr>
    <tr>
    <th scope="row">权重</th>
    <td><input name="qz" type="text" size="9" maxlength="9"  dataType="Number" value="<%=getDBStr(rs.getString("qz"))%>"></td>
  </tr>
  <tr>
    <th scope="row">序号</th>
    <td><input name="xh" type="text" size="3" maxlength="3" dataType="Integer" Require="ture" value="<%=getDBStr(rs.getString("xh"))%>"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">当前是否有效</th>
    <td>
        <select name="his">
            <script>w(mSetOpt('<%=getDBStr(rs.getString("his"))%>',"是|否","0|1"));</script>
        </select>
    </td>
  </tr>
  <tr>
    <th scope="row" align="left">登记人</th>
    <td><%=getDBStr(rs.getString("djr"))%>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row" align="left">登记日期</th>
    <td><%=getDBDateStr(rs.getString("djrq"))%>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row" align="left">更新人</th>
    <td><%=getDBStr(rs.getString("gxr"))%>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row" align="left">更新日期</th>
    <td><%=getDBDateStr(rs.getString("gxrq"))%>&nbsp;</td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="submit" value="保存" type="submit">
<input class="btn" name="btnClose" value="取消" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="重置" type="reset">
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


