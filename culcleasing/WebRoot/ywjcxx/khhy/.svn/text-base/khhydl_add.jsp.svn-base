<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*" errorPage="" %>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增客户行业大类-客户信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">客户信息管理 &gt; 新增客户行业大类</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="khhydl_save.jsp" onSubmit="return Validator.Validate(this,3);">

<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" height="30" scope="row">客户行业大类代码</td>
    <td height="30" >
      <input name="hydldm" type="text" size="2" maxlength="2" label=""  dataType="Number"  Require="true" maxB="3"> <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <td height="30" scope="row">客户行业大类名称</td>
    <td height="30">
	<input name="hydlmc" type="text" s label=""  Require="true" maxB="30" > <span class="biTian">*</span></td>
  </tr>
    <tr>
    <td height="30" scope="row">所属行业门类</td>
    <td height="30">
    <input type="text" name="hymlmc" readonly Require="true">
    <input type="hidden" name="hymlbh">
    <img src="../../images/sbtn_more.gif" alt="选门类" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','门类','kh_hyml_gb','hymlmc','hymlbh','hymlmc','hymlbh','asc','form1.hymlmc','form1.hymlbh');"><span class="biTian">*</span>
    </td>
  </tr>
</table>


<!-- end cwDataNav -->
<!-- end cwCellContent -->
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
