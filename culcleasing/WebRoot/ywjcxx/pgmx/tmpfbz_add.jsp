<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����������Ŀ���ֱ�׼��Ϣ - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="tmpfbz_save.jsp" onSubmit="return Validator.Validate(this,3);">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >������Ϣ����</td>
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
        <td id="cwCellTopTitTxt">����������Ŀ���ֱ�׼��Ϣ</td>
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

<%
String sqlstr;
String czid;
String pjys="";
ResultSet rs;
czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
   czid="0";
}
sqlstr = "SELECT pjys FROM jb_pgmx_tmxx where id="+czid; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
    pjys=getDBStr(rs.getString("pjys"));
}
rs.close();
db.close();
%>

<div id="cwCellContent" >

<input type="hidden" value="add" name="savetype">
<table width="487"  border="0" cellpadding="2" cellspacing="5" class="cwDataInput">
  <tr>
    <th scope="row">����Ҫ��</th>
    <td><%=pjys%><input name="tmid" type="hidden" value="<%=czid%>"></td>
  </tr>
  <tr>
    <th scope="row">��������</th>
    <td><textarea name="pfyj"  Require="true" maxB="200" rows=3></textarea><span class="biTian">*</span></td>
  </tr>
    <tr>
    <th scope="row">��ֵ</th>
    <td><textarea name="fz"  Require="true" maxB="200" rows=3></textarea><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">���</th>
    <td><input name="xh" type="text" size="3" maxlength="3" dataType="Integer" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">��ǰ�Ƿ���Ч</th>
    <td>
        <select name="his">
            <script>w(mSetOpt('',"��|��","0|1"));</script>
        </select>
    </td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="btnSave" value="����" type="submit"> <input class="btn" name="btnClose" value="ȡ��" type="button" onclick="window.close();"><input class="btn" name="btnReset" value="����" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
</div>
<!-- end cwMain -->
</body>
</html>