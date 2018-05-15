<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>罚息制定&gt;新增</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script src="/dict/js/js_dictionary.js"></script>

</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">罚息制定&gt; 新增</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="penalty_make_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
  <td scope="row">项目名称</td>
    <td scope="row">
	<input style="width:250px;" name="project_name" id="project_name" type="text" readonly="readonly" style="width: 100">
	<input name="proj_id" type="hidden">
	<input name="contract_id" type="hidden">
	<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="popUpWindow('project_info.jsp',250,350)" >  
		<span class="biTian">*</span>
   	</td>
   </tr>

  <tr>
	 <td scope="row">罚息期次</td>
	<td scope="row">
		<input name="rent_list" type="text" id="rent_list" Require="ture" dataType="Number"><span class="biTian">*</span>
	</td>
	<td scope="row">逾期租金</td>
	<td scope="row" colspan="3">
		<input name="penalty_rent" type="text" id="penalty_rent" dataType="Money" Require="ture"><span class="biTian">*</span>
	</td>
  </tr>
  <tr>
	<td scope="row">计收日期</td>
	<td scope="row">
		<input id="penalty_rent_planDate" name="penalty_rent_planDate" type="text" readonly Require="ture">
		<img onClick="openCalendar(penalty_rent_planDate);return false;" style="cursor:pointer; " 
		src="../../images/fdmo_63.gif" border="0" align="absmiddle">
		<span class="biTian">*</span>
	</td>
	<td scope="row">实收日期</td>
	<td scope="row">
		<input id="penalty_rent_hireDate" name="penalty_rent_hireDate" type="text" readonly Require="ture">
		<img onClick="openCalendar(penalty_rent_hireDate);return false;" style="cursor:pointer; " 
		src="../../images/fdmo_63.gif" border="0" align="absmiddle">
		<span class="biTian">*</span>
	</td>
  </tr>
   <tr>
	<td scope="row">罚息</td>
	<td scope="row">
		<input name="penalty" type="text" id="penalty" dataType="Money" Require="ture"><span class="biTian">*</span>
	</td>
	
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<input name="savetype" type="hidden" value="add">
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

