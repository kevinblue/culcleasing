<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�޸Ŀͻ���ҵ���� - �ͻ���Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<%
String sqlstr;
String czid;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "select kh_hyml_gb.*,base_user.name from kh_hyml_gb left join base_user on kh_hyml_gb.czy=base_user.id where kh_hyml_gb.hymlbh='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">�ͻ���Ϣ���� &gt; �޸Ŀͻ���ҵ����</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="khhyml_save.jsp" onSubmit="return Validator.Validate(this,3);">

<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=getDBStr(rs.getString("hymlbh"))%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" scope="row">�ͻ���ҵ�������</td>
    <td >
      <input name="hymlbh" type="text" size="1" maxlength="3"  label=""  dataType="English"  Require="true" value="<%=getDBStr(rs.getString("hymlbh"))%>"> <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <td scope="row">�ͻ���ҵ��������</td>
    <td><input name="hymlmc" type="text" label=""  Require="true" value="<%=getDBStr(rs.getString("hymlmc"))%>"> <span class="biTian">*</span></td>
  </tr>
   <tr>
    <td scope="row">����������</td>
    <td><%=getDBDateStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <td scope="row"> ����Ա</td>
    <td><%=getDBStr(rs.getString("name"))%></td>
  </tr>
</table>



<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="����" type="submit" class="btn3_mouseout"></td>
<td width=8 width="12">
<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
   out.print("</center>������¼������!</center>");
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>


