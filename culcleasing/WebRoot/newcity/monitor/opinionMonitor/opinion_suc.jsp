<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ - ���ִ�м��</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
String item_id = getStr( request.getParameter("item_id") );
sqlstr = "select * from vi_opinion_list where id='" + item_id+"'"; 
rs = db.executeQuery(sqlstr); 

String proj_id = "";
String proj_name = "";
String raiser = ""; 
String raiser_date = "";
String operation_dept = "";
String flow = "";
String idea = "";

if ( rs.next() ) {
	proj_id = getDBStr( rs.getString("proj_id") );
	proj_name = getDBStr( rs.getString("project_name") );
	raiser = getDBStr( rs.getString("raiser") );
	raiser_date = getDBDateStr( rs.getString("raiser_date") );
	operation_dept = getDBStr( rs.getString("operation_dept") );
	flow = getDBStr( rs.getString("flow") );
	idea = getDBStr( rs.getString("idea") );
}

rs.close();
//db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">������ &gt; ���ִ�м��</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1"  method="post" action="opinion_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->
<input type="hidden" name="savetype" value="suc">
<input type="hidden" name="kid" value="<%=item_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
 
 <tr>
    <td scope="row">��Ŀ���</td>
    <td scope="row">
      <input name="proj_id" type="text" value="<%=proj_id %>" readonly="readonly" Require="ture">
	</td>
    <td scope="row">��Ŀ����</td>
    <td scope="row">
     <input name="project_name" type="text" value="<%=proj_name %>" readonly="readonly">
   	</td>
  </tr>

  <tr>
    <td scope="row">�����</td>
    <td scope="row">
    <input style="width:150px;" name="raiser" id="raiser" type="text" readonly="readonly" value="<%=raiser %>">
    </td>

    <td scope="row">���ʱ��</td>
    <td scope="row">
     <input id="raiser_date" name="raiser_date" value="<%=raiser_date %>" type="text" readonly Require="ture">
    </td>
  </tr>
  
  <tr>
    <td scope="row">ִ�в���</td>
    <td scope="row">
    <input style="width:150px;" name="operation_dept" id="operation_dept" type="text" readonly="readonly" value="<%=operation_dept %>">
    </td>
    
    <td scope="row">����</td>
    <td scope="row">
       <input style="width:150px;" name="flow" id="flow" type="text" readonly="readonly" value="<%=flow %>">
    </td>
  </tr>
  
  <tr>
    <td scope="row">���</td>
    <td scope="row" colspan="3">
  		<textarea rows="6" cols="4" name="idea" disabled="disabled"><%=idea %></textarea>
  		<span class="biTian">*</span>
    </td>
  </tr>
  
  <tr>
    <td scope="row">ִ�н��</td>
    <td scope="row">
    <input name="result" type="text" Require="ture">
    </td>
    
    <td scope="row">���ʱ��</td>
    <td scope="row">
    <input id="end_time" name="end_time" type="text" readonly Require="ture">
	<img onClick="openCalendar(end_time);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
    </td>
  </tr>
  <tr>
    <td scope="row">������</td>
    <td scope="row" colspan="3">
  		<textarea rows="6" cols="4" name="remark"></textarea>
  		<span class="biTian">*</span>
    </td>
  </tr>
  
</table>
<!-- end cwDataNav -->

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


