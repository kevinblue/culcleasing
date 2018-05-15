<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>新增满意度模型</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="mydmx_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
	<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
		<tr>
		  <td id="cwTopTitLeft"></td>
		  <td id="cwTopTitTxt"  >满意度模型</td>
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
        <td id="cwCellTopTitTxt">新增满意度模型</td>
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
    <th scope="row">部门</th>
    <td><input type="text" name="bmmc" readonly Require="ture"><input type="hidden" name="dept_id" onPropertychange=""> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','部门','jb_gsbm','bmmc','id','bmmc','bmmc','asc','form1.bmmc','form1.dept_id');"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>项目</th>
    <td><textarea name="item" rows="3" maxB="200" Require="ture"></textarea><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>指标定义</th>
    <td><textarea name="indicator_def" rows="5" maxB="500"></textarea></td>
  </tr>
  <tr>
    <th>评价标准</th>
    <td><textarea name="standard" rows="5" maxB="500"></textarea></td>
  </tr>
  <tr>
    <th>考核频度</th>
    <td><input name="frequency" type="text" size="30" maxB="60"></td>
  </tr>
  <tr>
    <th>评分人</th>
    <td><input name="examiner" type="text" size="30" maxB="60"></td>
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
