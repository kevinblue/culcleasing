<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>厂商保证金管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/calend.js"></script>



</head>
<body onLoad="public_onload();fun_winMax();">
<form name="form1"  method="post" action="csbzj_save_tt.jsp"  onSubmit="return Validator.Validate(this,3);" >
<style type="text/css">
body {overflow:hidden;}
</style>



<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
厂商保证金管理 &gt; 厂商保证金增加
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
 <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  
<tr>
 

                <td>厂商名称：</td>
		<td>
	
		<input class="text" type="text" name="manuf_name" id="manuf_name" Require="true"/>
		<input class="text" type="hidden" name="cust_id" onPropertychange="">
		<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onClick="OpenDataWindow('','','','','厂商名称','vi_cust_all_info','cust_name','cust_id','cust_name','cust_name','asc','form1.manuf_name','form1.cust_id');">
		<span class="biTian">*</span></td>
</tr>
<tr>
		   <td>保证金比率：</td>
			 <td><input class="text" name="margin_per" id="margin_per" type="text" size="20"  dataType="Money" maxlength="20" Require="true">%
 <span class="biTian">*</span></td>
</tr>
<tr>
  <td scope="row" nowrap>保证金初始额：</td>
 <td><input class="text" name="initial_margin" id="initial_margin" type="text" size="20"  dataType="Money" maxlength="20" Require="true">
 <span class="biTian">*</span></td>
</tr>
  
   
</table>
</div>


</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->
</form>

<!-- end cwMain -->
</body>
</html>
