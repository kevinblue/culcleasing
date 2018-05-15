<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增客户类别小类 - 客户信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">客户信息管理 &gt; 新增客户类别小类</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="khlbxl_save.jsp" onSubmit="return Validator.Validate(this,3);">


<input type="hidden" name="savetype" value="add">

<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" height="30" scope="row">客户类别小类代码</td>
    <td height="30" >
      <input name="id" type="text" size="3" maxlength="3" label="" dataType="" Require="true"> <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <td height="30" scope="row">客户类别小类名称</td>
    <td height="30"><input name="lbxlmc" type="text"   label="" dataType="" Require="true"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td height="30" scope="row">所属行业大类</td>
    <td height="30">
 <input type="text" name="ssdldata" readonly Require="true">
    <input type="hidden" name="ssdl">
    <img src="../../images/sbtn_more.gif" alt="选行业大类" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','行业大类','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.ssdldata','form1.ssdl');">
    <span class="biTian">*</span>
 </td>
  </tr>
</table>



<!-- end cwDataNav -->
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->




<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
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
