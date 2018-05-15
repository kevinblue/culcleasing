<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>新增保险费率</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="bxfl_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
	<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
		<tr>
		  <td id="cwTopTitLeft"></td>
		  <td id="cwTopTitTxt"  >保险费率</td>
		  <td id="cwTopTitRight"></td>
		</tr>
	</table>  
</div>
<!-- end cwTop -->


<div id="cwCell">

<div id="cwCellTop">
	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">新增保险费率</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
	<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
	  <tr>
		<td>&nbsp;</td>
	  </tr>
	</table>
</div>
<!-- end cwCellTop -->


<div id="cwCellContent" >

<input type="hidden" value="add" name="savetype">
<table   border="0" cellpadding="2" cellspacing="5" class="cwDataInput">
  <tr>
    <th scope="row">保险公司</th>
    <td><input type="text" name="bxgs_name" readonly Require="ture"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="SpecialDataWindow1('保险公司','ifelc_conf_dictionary','title','title','','','','parentid = \'insur_company\'','title','form1.bxgs_name','form1.bxgs_name');"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">保险费率</th>
    <td><input name="bxfl" type="text" size="20" maxlength="20" dataType="Rate" Require="ture">&nbsp;%<span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>开始日期</th>
    <td><input name="rq" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture"><img  onClick="openCalendar(rq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>
  
</table>

<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->

<div id="cwToolbar" >
<input class="btn" name="btnSave" value="保存" type="submit"> <input class="btn" name="btnClose" value="取消" type="button" onclick="window.close();"><input class="btn" name="btnReset" value="重置" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
</div>
<!-- end cwMain -->
</body>
</html>
