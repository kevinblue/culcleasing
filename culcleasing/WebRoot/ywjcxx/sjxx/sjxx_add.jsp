<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>添加省/直辖市信息 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 添加省/直辖市信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="sjxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->

<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="109" height="30" scope="row">所属国家</td>
    <td width="246" height="30">
    <input type="text" name="gjmc" readonly Require="true" >
    <input type="hidden" name="gjid" >
    <img src="../../images/sbtn_more.gif" alt="选国家" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjmc','form1.gjid');">
    <span class="biTian">*</span>
</td>
  </tr>
    <tr>
    <td width="109" height="30" scope="row">所在地区</td>
    <td width="246" height="30">
    <input type="text" name="qymc" readonly Require="true">
    <input type="hidden" name="qyid">
    <img src="../../images/sbtn_more.gif" alt="选地区" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('form1.gjid','国家','gjid','string','地区','jb_qyxx','qymc','qyid','qymc','qymc','asc','form1.qymc','form1.qyid');">
    <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <td width="109" height="30" scope="row">省/直辖市代码</td>
    <td width="246" height="30">
      <input name="id" type="text" size="3" maxlength="3" Require="true" > <span class="biTian">*</span>
	</td>
  </tr>
 <tr>
    <td width="109" height="30" scope="row">名称</td>
    <td width="246" height="30">
      <input name="sfmc" type="text"  Require="true" > 
      <span class="biTian">*</span>
	</td>
  </tr>
</table>


<!-- end cwDataNav -->
<!-- end cwCell -->




<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td>
<input name="btnReset" value="重置" type="reset" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close()" class="btn3_mouseout">
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
