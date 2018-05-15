<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.*"%>
<%@ include file="../../public/headImport.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增开票信息</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<style type="text/css">
.abc { 
    color:#cc0000; 
	background: red;
	require:true;
} 

</style>
<%
 UUID uuid = UUID.randomUUID();
 String out_no=uuid.toString().replace("-", "");
 String creator=(String) session.getAttribute("czyid");
%>
<script src="../../js/calend.js"></script>

<script type="text/javascript">   


</script>
<style type="text/css">
body {overflow:hidden;}
</style>
</head>



<%
String dqczy=(String) session.getAttribute("czyid");
SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd");
String date=formater.format(new Date());
%>

<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="manual_invoice_save.jsp" onclick="chk()" onSubmit="return checkinfo(this);">
<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
新增开票信息
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
	
<div style="width:100%;margin-left:12px;margin-right:12px">
<table align=center width=100% border="0" cellspacing="0" cellpadding="0">
<tr>
<td>
<!--操作按钮开始-->
<div style="height:30px;padding-top:5px;">
<table border="0" cellspacing="0" cellpadding="0" width=100%>    
<tr><td >	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>
    </td></tr>
</table>
</div>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
  
 </tr>
 </table>
 <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
</div>
<center>
<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
  <tr>
	<td nowrap class="text">erp单据号：</td>
	<td nowrap class="text"><input class="text" id="out_no" name="out_no" type="text"   value="<%=out_no %>"  maxB="100" Require="true" ReadOnly onBlur="namecheck()">
             <span class="biTian">*</span></td>
  <td nowrap class="text">客户编码：</td>
	<td nowrap class="text"><input class="text" id="cust_id" name="cust_id" type="text"  value=""  maxB="50"></td>
	<td nowrap class="text">客户名称：</td>
	<td nowrap class="text"><input class="text" id="cust_name" name="cust_name" type="text"  Require="true" value="" maxB="100">
	<span class="biTian">*</span></td>
	</tr>
	
	<tr>
	<td nowrap class="text">纳税人税号：</td>
	<td nowrap class="text"><input class="text" id="tax_payer_no" name="tax_payer_no" type="text"   value=""  maxB="100"  onBlur="namecheck()">
    </td>
   <td nowrap class="text">地址：</td>
	<td nowrap class="text"><input class="text" id="address" name="address" type="text"  value=""  maxB="200"></td>
	<td nowrap class="text">电话：</td>
	<td nowrap class="text"><input class="text" id="phone" name="phone" type="text"   value="" maxB="15"></td>

  </tr>

	<tr>
   <td nowrap class="text">纳税人基本开户行：</td>
	<td nowrap class="text"><input class="text" id="bank_name" name="bank_name" type="text"   value=""  maxB="100" onBlur="namecheck()">
    </td>
   <td nowrap class="text">纳税人账号：</td>
	<td nowrap class="text"><input class="text" id="account_number" name="account_number" type="text"  value=""  maxB="50"></td>
	<td nowrap class="text">备注：</td>
	<td nowrap class="text"><input class="text" id="remark" name="remark" type="text"   value="" maxB="100">
	</td>
   
</tr>  
	<tr>
   <td nowrap class="text">商品编码：</td>
	<td nowrap class="text"><input class="text" id="product_number" name="product_number" type="text"   value=""  maxB="100"  >
    </td>
   <td nowrap class="text">商品名称：</td>
	<td nowrap class="text"><input class="text" id="product_name" name="product_name" type="text" Require="true"  value=""  maxB="50">
	<span class="biTian">*</span></td>
	<td nowrap class="text">规格型号：</td>
	<td nowrap class="text"><input class="text" id="commercial_specification" name="commercial_specification" type="text"   value="" maxB="50"></td>
   
</tr>  
<tr>
   <td nowrap class="text">计量单位：</td>
	<td nowrap class="text"><input class="text" id="unit" name="unit" type="text"   value=""  maxB="100" >
    </td>
   <td nowrap class="text">税率：</td>
	<td nowrap class="text"><select class="text" Require="true" name="rate"><script>w(mSetOpt(" ","|0.03|0.06|0.17"));</script></select>
     <span class="biTian">*</span></td>
	<td nowrap class="text">销售数量：</td>
	<td nowrap class="text"><input class="text" id="quantity" name="quantity" type="text"   value="" maxB="50"></td>
   
</tr>  
<tr>
   <td nowrap class="text">含税金额：</td>
	<td nowrap class="text"><input class="text" id="include_tax_money" name="include_tax_money" type="text"   value=""  maxB="100" Require="true" onBlur="namecheck()">
    <span class="biTian">*</span></td>
    
      <td nowrap class="text">是否含税：</td>
   <td nowrap class="text"><select class="text" Require="true" name="if_tax"><script>w(mSetOpt(" ","|是|否"));</script></select>
     <span class="biTian">*</span></td>
     <td nowrap class="text">单价：</td>
	<td nowrap class="text"><input class="text" id="unit_price" name="unit_price" type="text"   value="" maxB="15"></td>
   
</tr> 
<tr>
	  <td nowrap class="text">发票类型：</td>
   <td nowrap class="text"><select class="text" Require="invoice_type" id="invoice_type" name="invoice_type"><script>w(mSetOpt(" ","|增值税普通发票|增值税专用发票"));</script></select>
   <span class="biTian">*</span></td>
	  <td nowrap class="text">是否erp数据：</td>
   <td nowrap class="text"><select class="text" Require="true" name="if_erp"><script>w(mSetOpt(" ","|是|否"));</script></select>
     <span class="biTian">*</span></td>
   
</tr>    
<tr>
   <td nowrap class="text">创建人：</td>
	<td nowrap class="text"><input class="text" id="creator" name="creator" type="text"   value="<%=creator%>"  maxB="100" Require="true" onBlur="namecheck()">
             <span class="biTian">*</span></td>
   <td nowrap class="text">创建时间：</td>
	<td nowrap class="text"><input class="text" id="create_date" name="create_date" type="text" readonly Require="true" value="<%=date%>">
	<img onClick="openCalendar(create_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
	<span class="biTian">*</span></td>
</tr> 
</table>
</div>
<script type="text/javascript">

function checkinfo(obj){   

	 var invoicetype=document.getElementById("invoice_type").value;
	 if(invoicetype=='增值税专用发票'){
	  var taxpayerno=document.getElementById("tax_payer_no");
	   taxpayerno.setAttribute("Require", true);

	   var address=document.getElementById("address");
	   address.setAttribute("Require", true);

	   var phone=document.getElementById("phone");
	   phone.setAttribute("Require", true);
	   var bankname=document.getElementById("bank_name");
	   bankname.setAttribute("Require", true);

	   var accountnumber=document.getElementById("account_number");
	   accountnumber.setAttribute("Require", true);
	 }
	
	 return Validator.Validate(obj,3);


	}
	
		
		
</script>
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
<%if(null != db){db.close();}%>