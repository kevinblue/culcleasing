<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="/public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ͬ���ʽ�ƻ���Ϣ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->
<%
String proj_id = getStr( request.getParameter("proj_id") );
String id = getStr( request.getParameter("id") );
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">���ѽӿ�&gt; �ʽ�ƻ���Ϣͬ��</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="fund_info_sync.jsp" onSubmit="return Validator.Validate(this,3);">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">	
 <tr>
    <td scope="row">����ERP��Ŀ��ţ�</td>
    <td scope="row">
	    <input style="width:150px;" name="proj_id" type="text" value="<%=proj_id%>">
        <input style="width:150px;" style="visibility:hidden" name="id" type="text"  value="<%=id%>">

   </td>
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="ִ��" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close();" class="btn3_mouseout">
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

