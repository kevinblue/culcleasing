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
<form name="form1" enctype="multipart/form-data" method="post" action="csbzj_save.jsp"  onSubmit="return Validator.Validate(this,3);" >
<style type="text/css">
body {overflow:hidden;}
</style>

<script type="text/javascript">
function makeValue(){
var total=0.00;
var margin_per = document.getElementsByName("margin_per")[0].value;//
var vendor_payment=document.getElementsByName("vendor_payment")[0].value;//厂商设备金额
//var caution_money_ratio=document.getElementsByName("caution_money_ratio")[0].value;//保证金比率
total=total+parseFloat(vendor_payment*margin_per/100);
document.getElementById("min_payment").value=total;
//alert(total);

}

function makeV()
{
	

    var totals=0.00;
	var ensure_payment=parseFloat(document.getElementsByName("ensure_payment")[0].value);//初始金额
    var deposit_amount=parseFloat(document.getElementsByName("deposit_amount")[0].value);//汇入金额
	var deposit_export=parseFloat(document.getElementsByName("deposit_export")[0].value);//汇出金额
	//var margin_amount=document.getElementsByName("margin_amount")[0].value;//汇出金额
  
	//alert(totals);
	if((ensure_payment == null || ensure_payment == "") || (deposit_export == null || deposit_export == "")||(deposit_amount==null||deposit_amount=="")){
	alert("初始金额、汇入金额、汇出金额不能为空,现金额=初始金额+汇入金额-汇出金额!");
		document.all.deposit_export.focus();
		return false;
	}
	else{
	  totals=totals+ensure_payment+deposit_amount-deposit_export;
	document.getElementsByName("margin_amount")[0].value=totals;//汇出金额
	}
}
</script>

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
    <td scope="row">合同编号：</td>
    <td>
        <input class="text" type="text"  name="contract_id" readonly Require="true" >
		<input class="text" type="hidden" name="contract_id_t" onPropertychange="";/>
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','合同编号','contract_info_t','contract_id','contract_id_t','contract_id','contract_id','asc','form1.contract_id','form1.contract_id_t');"><span class="biTian">*</span></td>

                <td>厂商名称：</td>
		<td>
	
		<input class="text" type="text" name="manuf_name" Require="true"/>
		<input class="text" type="hidden" name="cust_name">
		<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onClick="OpenDataWindow('form1.contract_id_t','合同编号','contract_id_t','string','厂商名称','vi_cust_name','manuf_name','cust_name','manuf_name','manuf_name','asc','form1.manuf_name','form1.cust_name');">
		<span class="biTian">*</span></td>
</tr>
<tr>
		   <td>厂商设备金额：</td>
	
<td>
		<input class="text" name="vendor_payment" id="vendor_payment" />
		<input class="text" type="hidden" name="equip_amt">
		<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onClick="OpenDataWindow('form1.contract_id_t','合同编号','contract_id_t','string','厂商设备金额','vi_contract_equip','vendor_payment','equip_amt','vendor_payment','vendor_payment','asc','form1.vendor_payment','form1.equip_amt');">
	
		</td>

		   <td>保证金比率：</td>
			 <td><input class="text" name="margin_per" id="margin_per" type="text" size="20"  dataType="Money" maxlength="20" Require="true">%
 <span class="biTian">*</span></td>

		
</tr>
  
<tr>
   <td scope="row" nowrap>保证金汇入金额：</td>
 <td><input class="text" name="deposit_amount" type="text" size="20"  dataType="Money" maxlength="20" Require="true" onchange="makeV()">
 <span class="biTian">*</span></td>
   <td scope="row" nowrap>保证金汇出金额：</td>
 <td><input class="text" name="deposit_export" type="text" size="20"  dataType="Money" maxlength="20" Require="true" onchange="makeV()">
 <span class="biTian">*</span></td>
  <tr>

  <td scope="row" nowrap>保证金初始额：</td>
 <td><input class="text" name="ensure_payment" id="ensure_payment" type="text" size="20"  dataType="Money" maxlength="20" Require="true" onchage="makeV()">
 <span class="biTian">*</span></td>
  
  <td scope="row" nowrap>保证金现金额：</td>
 <td><input class="text" name="margin_amount" type="text" size="20"  dataType="Money" maxlength="20" Require="true" readonly onclick="makeV()">
 <span class="biTian">*</span></td>

</tr>
  
  </tr>
    <tr>
<td scope="row" nowrae="row" nowrap>保证金汇入时间：</td>
    <td><input class="text" name="margin_time" type="text" size="20"  maxlength="40" readonly >
    <img  onClick="openCalendar(margin_time);return false" style="cursor:pointer; " src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle"></td>
  
  <td scope="row" nowrap>保证金汇出时间：</td>
  <td><input class="text" name="export_time" type="text" size="20"  maxlength="40" readonly >
    <img  onClick="openCalendar(export_time);return false" style="cursor:pointer; " src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
    <tr>
    <td scope="row" nowrap>最低保证金额：</td>
 <td><input class="text" name="min_payment" type="text" size="20"  dataType="Money" maxlength="20" readonly onclick="makeValue()"></td>
  </tr>
<tr>

    <td scope="row" nowrap>保证金汇入原因：</td>
  <td><textarea class="text" name="margin_reason" type="text"  maxlength="500" maxB="500" ></textarea></td>
    <td scope="row" nowrap>保证金汇出原因：</td>
  <td><textarea class="text" name="export_reason" type="text"  maxlength="500" maxB="500" ></textarea></td>
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
