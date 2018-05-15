<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-保险管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/calend.js"></script>

</head>
<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="bx_save.jsp"  onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
资产管理 &gt; 保险增加
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
 <script language="javascript">
ShowTabN(0);
</script>
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
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="savetype" value="id">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
  <tr>
    <td scope="row">合同编号：</td>
    <td>
        <input class="text" type="text" name="contract_id" readonly Require="true" >
		<input class="text" type="hidden" name="proj_id" onPropertychange="";/>
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','合同编号','contract_info','contract_id','proj_id','contract_id','contract_id','asc','form1.contract_id','form1.proj_id');"><span class="biTian">*</span></td>
  
 <td>是否我司代买保险</td>
<td>
	<input  name="insurance_my" type="radio" value="是" checked="checked">
												是
													<input name="insurance_my" type="radio" value="否">
											否
	</td>
 </tr>
  <tr>
	</tr>
   
    <tr>
    <td>保险期限:</td>
	<td><input class="text" id="period_insurance" name="period_insurance" type="text" size="30"  value="" maxB="30" Require="true" dataType="Number"><span class="biTian">*</span></td>
	
	<td>我司收取日期:</td>
	<td><input class="text" id="colleaction_date" name="colleaction_date" type="text" size="30"  value="" readonly>
<img onClick="openCalendar(colleaction_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
</td>
   </tr>
   
    <tr>
    <td>险种:</td>
	<td><input class="text" id="insurance_type" name="insurance_type" type="text" size="30"  value="" maxB="10" Require="true"><span class="biTian">*</span></td>
	
	<td>支付保险公司日期:</td>
		<td><input class="text" name="pay_date" type="text" size="30" readonly Require="true">
	<img onClick="openCalendar(pay_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle"><span class="biTian">*</span>
 </td>
   </tr>
   
   <tr>
   <td width="130px">支付金额:</td>
	<td><input class="text" id="payments" name="payments" type="text" size="30"  value="" dataType="Money" Require="true"><span class="biTian">*</span></td>
 
  <td>保险单号:</td>
	<td><input class="text" id="insurance_id" name="insurance_id" type="text" size="30"  value=""  maxB="20" Require="true"><span class="biTian">*</span></td>
	
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
