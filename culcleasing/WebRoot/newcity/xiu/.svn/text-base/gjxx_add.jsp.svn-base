<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增国家信息 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
	String base_user_id = getStr( request.getParameter("id") );
	LogWriter.logDebug(request,"我需要的:"+base_user_id);
 %>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 新增国家信息</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="gjxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">对应基础编号</td>
    <td><input name=base_user_id type="text"  value="<%= base_user_id %>" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td nowrap class="text">区域：</td>
    <td nowrap class="text"><input class="text" type="text"   name="area" value="" readonly Require="true" />
	    <input type="hidden" name="qymc" onPropertychange="form1.province.value='';form1.sfmc.value='';form1.city.value='';form1.csmc.value='';"/> 
	    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','区域','jb_qyxx','qymc','qyid','qymc','qymc','asc','form1.area','form1.qymc');">
		<span class="biTian">*</span>
	</td>
  </tr>
  

  <tr>
   <td>省份：</td>
    <td nowrap class="text"><input class="text" type="text"   name="provice"  value="" readonly Require="true"/>
	    <input type="hidden" name="sfmc" onPropertychange="form1.city.value='';form1.csmc.value='';"/> 
	    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" 
	    onClick="OpenDataWindow('form1.qymc','区域','qyid','string','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.provice','form1.sfmc');">
		<span class="biTian">*</span>
	</td>
  </tr>
  <tr>
 	 <td nowrap class="text">城市：</td>
    <td nowrap class="text"><input class="text" type="text"  name="city" value="" readonly  Require="true" >
	    <input type="hidden" name="csmc" value=""> 
	    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" 
	    onClick="OpenDataWindow('form1.sfmc','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.city','form1.csmc');">
		<span class="biTian">*</span>
	</td>
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

