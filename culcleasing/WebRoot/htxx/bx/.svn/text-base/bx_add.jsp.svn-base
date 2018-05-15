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
<form name="form1" enctype="multipart/form-data" method="post" action="bx_save.jsp"  onSubmit="return Validator.Validate(this,3);">
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

<!--
<input type="hidden" name="savetype" value="id">
-->
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
  <tr>
    <td scope="row">合同编号：</td>
    <td>
        <input class="text" type="text" name="contract_id" readonly Require="true" >
		<input class="text" type="hidden" name="proj_id" onPropertychange="";/>
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','合同编号','contract_info','contract_id','proj_id','contract_id','contract_id','asc','form1.contract_id','form1.proj_id');"><span class="biTian">*</span></td>
  
 <td>是否我司代买保险：</td>
<td>
	<input  name="insurance_my" type="radio" value="是" checked="checked">
												是
													<input name="insurance_my" type="radio" value="否">
											否
	</td>
 </tr>
     <tr>
     	<td>保险类型：</td>
    	<td><input class="text" id="insurance_type" name="insurance_type" type="text" size="30"  value="" maxB="30" Require="true"  ><span class="biTian">*</span></td>
     	<td>保险公司：</td>
     <td><input class="text" id="insurance_company" name="insurance_company" type="text" size="50"  value="" maxB="50" Require="true" ><span class="biTian">*</span></td>
     	</tr>
     	
     	 <tr>
     	<td>保险单号：</td>
	<td><input class="text" id="insurance_id" name="insurance_id" type="text" size="30"  value=""  maxB="50" Require="true"><span class="biTian">*</span></td>
     	<td>投保人：</td>
     <td><input class="text" id="insured" name="insured" type="text" size="50"  value="" maxB="50" Require="true" ><span class="biTian">*</span></td>
     	</tr>
     	
     		
     	 <tr>
     	<td>被保险人：</td>
	<td><input class="text" id="b_insured" name="b_insured" type="text" size="30"  value=""  maxB="30"  Require="true"><span class="biTian">*</span></td>
      <td>保险期限(月)：</td>
	<td><input class="text" id="period_insurance" name="period_insurance" type="text" size="30"  value="" maxB="30" Require="true" dataType="Number"><span class="biTian">*</span></td>
     	</tr>
     	<tr>
     	<td>开始日期</td>
     		<td><input class="text" name="start_date" type="text" size="30" readonly Require="true">
	<img onClick="openCalendar(start_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle"><span class="biTian">*</span>
 			</td>
     	<td>结束日期</td>
     		<td><input class="text" name="end_date" type="text" size="30" readonly Require="true">
	<img onClick="openCalendar(end_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle"><span class="biTian">*</span>
 			</td>
     	</tr>
     	 <tr>
     	<td>保险项目：</td>
	<td><input class="text" id="insurance_coverage" name="insurance_coverage" type="text" size="30"  value=""  maxB="100" ></td>
      <td>保险项目原价：</td>
	<td><input class="text" id="price_coverage" name="price_coverage" type="text" size="30"  value="" maxB="30"  dataType="Money"></td>
     	</tr>
     	
     		 <tr>
     	<td>保险项目评估价：</td>
	<td><input class="text" id="price_appraisal" name="price_appraisal" type="text" size="30"  value=""  maxB="30" dataType="Money"></td>
      <td>保险项目评估公司：</td>
	<td><input class="text" id="assessment_company" name="assessment_company" type="text" size="30"  value="" maxB="30"  ></td>
     	</tr>
     	
     		 <tr>
     	<td>保险项目生产日期：</td>
	<td><input class="text" name="production_date" type="text" size="30" readonly >
	<img onClick="openCalendar(production_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
 </td>
     <td width="130px">保险金额：</td>
	<td><input class="text" id="payments" name="payments" type="text" size="30"  value="" Require="true" dataType="Money" ><span class="biTian">*</span></td>
     	</tr>
     	 <tr>
     	<td>总保险金额：</td>
	<td><input class="text" id="total_insurance" name="total_insurance" type="text" size="30"  value=""  maxB="30" dataType="Money" Require="true"></td>
      <td>每次事故免赔额：</td>
	<td><input class="text" id="deductible_accident" name="deductible_accident" type="text" size="30"  value="" maxB="30"  ></td>
     	</tr>
     	 <tr>
     	<td>保险费率：</td>
	<td><input class="text" id="premium_rate" name="premium_rate" type="text" size="30"  value=""  maxB="30" dataType="Money">%</td>
      <td>总保险费：</td>
	<td><input class="text" id="general_insurance" name="general_insurance" type="text" size="30"  value="" maxB="30"  ></td>
     	</tr>
     	 <tr>
     	<td>付费日期：</td>
	<td><input class="text" name="pay_date" type="text" size="30" readonly Require="true">
	<img onClick="openCalendar(pay_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle"><span class="biTian">*</span>
 </td>
      <td>司法管辖：</td>
	<td><input class="text" id="jurisdiction" name="jurisdiction" type="text" size="30"  value="" maxB="30"  ></td>
     	</tr>
    <tr>
     	<td>受益人：</td>
	<td><input class="text" id="beneficiaries" name="beneficiaries" type="text" size="30"  value=""  maxB="100" ></td>
     	<td>附加被保险人：</td>
	<td><input class="text" id="add_beneficiaries" name="add_beneficiaries" type="text" size="30"  value=""  maxB="50" ></td>	
     	</tr>
     	<tr>
	<td>备注：</td>
	<td colspan="40" nowrap><textarea class="text" id="memo" name="memo" rows="10" value=""  maxB="500"></textarea></td>
	<td></td>
	<td></td>
   </tr>
   <tr>
    <td scope="row">附件：</td>
    <td><!-- 上传组件 -->
	<!--
<input type="button" onclick="insRow('tabUpFile')" value="增加上传数"  name="addFileNum" >
-->
<table id="tabUpFile" border="0" cellpadding="0" cellspacing="0"></table><script>insRow('tabUpFile')</script>
<!-- End 上传组件 --><span class="biTian">允许上传的文件类型.zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt</span></td>
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
