<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�޸Ļ������� - ���ʻ�����Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
String priId = getStr( request.getParameter("czid") );
sqlstr = "Select financing_config_refundtype.*,dbo.GETUSERNAME(financing_config_refundtype.creator) as oper_name,financing_config_loantype.loan_name from financing_config_refundtype left join financing_config_loantype on financing_config_loantype.code=financing_config_refundtype.loan_code where financing_config_refundtype.id='"+priId+"'"; 

rs = db.executeQuery(sqlstr); 

String code = "";
String loan_name = "";
String oper_name = "";
String refund_name = "";
if ( rs.next() ) {
	code = getDBStr( rs.getString("code") );
	loan_name = getDBStr( rs.getString("loan_name") );
	refund_name = getDBStr( rs.getString("refund_name") );
	oper_name = getDBStr( rs.getString("oper_name") );
}

rs.close();
db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">���ʻ�����Ϣ����&gt; �޸Ļ�������</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<form name="form1"  method="post" action="baseconfig_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="priId" value="<%=priId %>">
<div class="mydivtab" id="mydiv">


<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
    <tr>
    <td scope="row">������������</td>
    <td><%=loan_name %></td>
  </tr>
  <tr>
    <td scope="row">�������ͱ��</td>
    <td>
      <input name="code" type="text" size="5" maxlength="20" value="<%=code %>" Require="ture">
      <span class="biTian">*����Ψһ</span>
	</td>
  </tr>
  <tr>
    <td scope="row">������������</td>
    <td><input name="refund_name" type="text"  value="<%=refund_name %>" Require="ture">
    	<span class="biTian">*</span></td>
  </tr>
  
  <tr>
    <td scope="row"> ����Ա</td>
    <td><%=oper_name %></td>
  </tr>
</table>
<!-- end cwDataNav -->

<!-- end cwCellContent -->
</div>
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

</td></tr></table>
<!-- end cwMain -->

</body>
</html>

