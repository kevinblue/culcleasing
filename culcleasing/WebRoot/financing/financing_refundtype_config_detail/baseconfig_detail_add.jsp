<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增还款类型明细 - 融资基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">融资基础信息管理&gt; 新增还款类型明细</td>
</tr>
<tr>

<td align=center width=100% height=100% valign="top">

<form name="form1" method="post" action="baseconfig_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="add">
<div class="mydivtab" id="mydiv">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title" align="left">
    <tr>
    <td scope="row">还款方式名称</td>
    <td scope="row">
      <input name="refund_name" type="text" size="20" maxlength="20" Require="ture" readonly="readonly">
    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
			style="cursor:pointer" onclick="popUpWindow('select_info.jsp',400,450)">
    <span class="biTian">*</span>
    <input type="hidden" name="refund_code">
	</td>
  </tr>
  <tr>
    <td scope="row">还款方式明细编号</td>
    <td scope="row">
      <input name="code" type="text" size="5" maxlength="20" Require="ture"><span class="biTian">*必须唯一</span>
	</td>
  </tr>
  <tr>
    <td scope="row">还款方式明细名称</td>
    <td scope="row"><input name="refund_detail_name" type="text"  Require="ture"><span class="biTian">*</span></td>
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
</td></tr></table>
<!-- end cwMain -->

</body>
</html>

