<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-结算保证金管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/calend.js"></script>



</head>
<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="jsbzj_save.jsp"  onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
结算保证金管理 &gt; 结算保证金增加
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
   
    <td scope="row" nowrap>项目编号：</td>
    <td>
        <input class="text" type="text" name="z_proj_id" readonly Require="true" >
		<input class="text" type="hidden" name="proj_id" onPropertychange="form1.z_contract_id.value='',form1.contract_id.value='';"/>
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','项目编号','vi_mproj_info','z_proj_id','proj_id','z_proj_id','z_proj_id','asc','form1.z_proj_id','form1.proj_id');"><span class="biTian">*</span></td>
  <td scope="row">合同编号：</td>
    <td>
	   <input class="text" type="text" name="z_contract_id" readonly Require="true">
	    <input class="text" type="hidden" name="contract_id"/>
		<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onClick="OpenDataWindow('form1.proj_id','项目编号','proj_id','string','合同编号','vi_mproj_info','z_contract_id','contract_id','z_contract_id','z_contract_id','asc','form1.z_contract_id','form1.contract_id');">
	

 
		</tr>
		
  <tr>
    <td scope="row" nowrap>日期：</td>
    <td><input class="text" name="sign_date" type="text" size="20" Require="true" maxlength="40" readonly ><span class="biTian">*</span>
    <img  onClick="openCalendar(sign_date);return false" style="cursor:pointer; " src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle"></td>
  
    <td scope="row" nowrap>授信总额度：</td>
    <td><input class="text" name="lineof_credit" type="text" size="20" Require="true" maxlength="40" dataType="Money"><span class="biTian">*</span></td>
  </tr>
  
    <tr>
    <td scope="row" nowrap>授信发生额：
    <td><input class="text" name="credit_fact" type="text" size="20" Require="true" dataType="Money" maxlength="20"><span class="biTian">*</span></td>
 
    <td scope="row" nowrap>授信余额：</td>
    <td><input class="text" name="credit_remain" type="text" size="20" maxlength="30" dataType="Money"></td>
 </tr>
  
  <tr>
    <td scope="row" nowrap>应收保证金：</td>
    <td><input class="text" name="guarantee_plan" type="text" size="20" maxlength="50" dataType="Money"></td>
  
    <td scope="row" nowrap>应收保证金余额：</td>
    <td><input class="text" name="plan_remain" type="text" size="20" maxlength="50" dataType="Money"></td>
    
  </tr>
  <tr>
   <td scope="row" nowrap> 实收保证金余额：</td>
    <td><input class="text" name="income_remian" type="text" size="20" maxlength="50" dataType="Money"></td>
   
    <td scope="row" nowrap>实收保证金发生额：</td>
    <td><input class="text" name="guarantee_income" type="text" size="20" maxlength="50" dataType="Money"></td>
</tr>
<tr>
<td scope="row" nowrap>备注：</td>
    <td><textarea class="text" name="remark" type="text"  maxlength="500" maxB="500" ></textarea></td>
    <td></td><td></td>
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
