<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�޸�֧����ʽ - ������Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->


<%
String id = getStr( request.getParameter("czid") );
sqlstr = "select base_paytype.*,base_user.name from dbo.base_paytype left join base_user on base_paytype.creator=base_user.id where base_paytype.id='" + id+"'"; 
rs = db.executeQuery(sqlstr); 

String pay_type_code = "";
String pay_type_name = "";
String finance_code = "";
String gxrq = "";
String xm = "";

if ( rs.next() ) {
	pay_type_code = getDBStr( rs.getString("pay_type_code") );
	pay_type_name = getDBStr( rs.getString("pay_type_name") );
	finance_code = getDBStr( rs.getString("finance_code") );
	gxrq = getDBDateStr( rs.getString("create_date") );
	xm = getDBStr( rs.getString("name") );
}

rs.close();
db.close();

//Ȩ���ж�
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ywjcxx_paytype_mod",dqczy)>0) 
{
	canedit=1;
}
if (canedit==0) {
	response.sendRedirect("../../noright.jsp");
}
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">������Ϣ���� &gt; �޸�֧����ʽ��Ϣ</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="paytype_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="kid" value="<%=id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">֧����ʽ����</td>
    <td >
      <input name="pay_type_code" type="text" size="3" maxlength="3" value="<%=pay_type_code %>" Require="ture"><span class="biTian">*����Ψһ</span>
	</td>
  </tr>
  <tr>
    <td scope="row">֧����ʽ����</td>
    <td><input name="pay_type_name" type="text"  value="<%=pay_type_name %>" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">��Ӧ�������</td>
    <td><input name="finance_code" type="text"  value="<%=finance_code %>" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">����������</td>
    <td><%= gxrq %></td>
  </tr>
  <tr>
    <td scope="row"> ����Ա</td>
    <td><%= xm %></td>
  </tr>

</table>

<!-- end cwDataNav -->

<!-- end cwCellContent -->
<!-- end cwCell -->

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="����" type="submit" class="btn3_mouseout"></td>
<td>
<input name="btnReset" value="����" type="reset" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>


