<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增区县信息 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 新增区县信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="qxxx_save.jsp" onSubmit="return Validator.Validate(this,3);">


<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
<tr>
    <td width="16%" height="30" class="cwDDLabel">所属国家</td>
    <td width="84%" height="30" class="cwDDValue">
        <input type="text" name="gjmc" readonly Require="true" >
    <input type="hidden" name="gjid" >
    <img src="../../images/sbtn_more.gif" alt="选国家" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjmc','form1.gjid');">
    <span class="biTian">*</span>
    </td>
  </tr>
     <tr>
    <td width="16%" height="30" class="cwDDLabel">所在地区</td>
    <td width="84%" height="30" class="cwDDValue">
    <input type="text" name="qymc" readonly Require="true" >
    <input type="hidden" name="qyid" >
    <img src="../../images/sbtn_more.gif" alt="选地区" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('form1.gjid','国家','gjid','string','地区','jb_qyxx','qymc','qyid','qymc','qymc','asc','form1.qymc','form1.qyid');">
    <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
   <td height="30"  scope="row">省/直辖市</td>
   <td height="30">
	<input type="text" name="sfmc" readonly Require="true" >
    <input type="hidden" name="sfid" >
    <img src="../../images/sbtn_more.gif" alt="选地区" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('form1.qyid','地区','qyid','string','省/直辖市','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfmc','form1.sfid');">
    <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
	<td width="79" height="30" scope="row">城市</td>
	<td width="241" height="30">
        <input type="text" name="csmc" readonly Require="true" >
    <input type="hidden" name="csid" >
    <img src="../../images/sbtn_more.gif" alt="选地区" width="19" height="19" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('form1.sfid','省/直辖市','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csmc','form1.csid');">
    <span class="biTian">*</span>
	</td>
  </tr>
  <tr>
  	 <td height="30" scope="row">区县代码</td>
    <td height="30"><input name="id" type="text" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td height="30" scope="row">区县名称</td>
    <td height="30"><input name="qxmc" type="text" Require="ture"><span class="biTian">*</span></td>
  </tr>
</table></div>

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
