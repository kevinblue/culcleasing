<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�޸�����ģ������С�� - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1"  method="post" action="pglxxl_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">������Ϣ����</td>
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
        <td id="cwCellTopTitTxt">�޸�����ģ������С��</td>
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
String czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
   czid="0";
}

String sqlstr;

ResultSet rs;

sqlstr = "SELECT jb_pgmx_pglxxl.*, jb_pgmx_pglx.pglxmc AS pglxmc FROM jb_pgmx_pglx RIGHT OUTER JOIN jb_pgmx_pglxxl ON jb_pgmx_pglx.id = jb_pgmx_pglxxl.pglxid where jb_pgmx_pglxxl.id="+czid; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
%>
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%=czid%>">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
   <tr>
    <th scope="row">��������</th>
    <td><%=getDBStr(rs.getString("pglxmc"))%><input name="pglxid" type="hidden" value="<%=getDBStr(rs.getString("pglxid"))%>"></td>
  </tr>
  <tr>
    <th scope="row">��������С������</th>
    <td><input name="pglxxlmc" type="text" size="30" maxB="100" Require="ture" value="<%=getDBStr(rs.getString("pglxxlmc"))%>"><span class="biTian">*</span>&nbsp;&nbsp;&nbsp;������С���������*</td>
  </tr>
  <tr>
    <th scope="row">���</th>
    <td><input name="xh" type="text" size="3" maxlength="3" dataType="Integer" Require="ture" value="<%=getDBStr(rs.getString("xh"))%>"><span class="biTian">*</span>&nbsp;&nbsp;������С���������1</td>
  </tr>
  <tr>
    <th scope="row">��ǰ�Ƿ���Ч</th>
    <td>
        <select name="his">
            <script>w(mSetOpt('<%=getDBStr(rs.getString("his"))%>',"��|��","0|1"));</script>
        </select>
    </td>
  </tr>
  <tr>
    <th scope="row" align="left">�Ǽ���</th>
    <td><%=getDBStr(rs.getString("djr"))%>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row" align="left">�Ǽ�����</th>
    <td><%=getDBDateStr(rs.getString("djrq"))%>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row" align="left">������</th>
    <td><%=getDBStr(rs.getString("gxr"))%>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row" align="left">��������</th>
    <td><%=getDBDateStr(rs.getString("gxrq"))%>&nbsp;</td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="submit" value="����" type="submit">
<input class="btn" name="btnClose" value="ȡ��" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="����" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
%>
 <center>������¼������!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="�ر�" type="button" onClick="window.close()">
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


