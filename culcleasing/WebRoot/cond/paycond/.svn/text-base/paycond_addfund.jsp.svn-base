<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划 - 新增</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script  src="../../js/sys_test_time.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">


<script type="text/javascript">
//选择款项方式
function changePayWay(){
	var payWayVal = $(":input[name='pay_way']").val();
	var feeTypeVal = $(":input[name='fee_type']").val();
	if(payWayVal=='收款'){
		$(":input[name='pay_obj']").val($(":input[name='cust_name']").val());
		//判断款项内容是否正确
		if(feeTypeVal=='24' || feeTypeVal=='21' || feeTypeVal=='18' || feeTypeVal=='26'){
			alert("选择款项内容为付款款项，请重新选择款项！");
			$(":input[name='fee_type']").val('');
		}
	}else{
		$(":input[name='pay_obj']").val("");
		//判断款项内容是否正确
		if( feeTypeVal!='' && feeTypeVal!='24' && feeTypeVal!='21' && feeTypeVal!='18' && feeTypeVal!='26'){
			alert("选择款项内容为收款款项，请重新选择款项！");
			$(":input[name='fee_type']").val('');
		}
	}
}
//选择款项内容
function checkVal(){
	var feeTypeVal = $(":input[name='fee_type']").val();
	var payWayVal = $(":input[name='pay_way']").val();
	//alert(feeTypeVal);
	if(feeTypeVal=='24' || feeTypeVal=='21' || feeTypeVal=='18' || feeTypeVal=='26'){
		if(payWayVal=='收款'){
			alert("该款项内容非收款款项，请重新选择款项！");
			$(":input[name='fee_type']").val('');
		}
	}
}
//校验计划金额是否正确
function checkMoney(){
	var planMoneyVal = $(":input[name='plan_money']").val();
	var reg = /^[0-9]+(\.[0-9]+)?$/;  
	if(planMoneyVal!=''){
		if(!reg.test(planMoneyVal)){  
	        alert('计划金额填写格式有误！');  
	        $(":input[name='plan_money']").val('');
	        $(":input[name='plan_money']").focus();  
	    }  
	}
}

</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%
//提取参数proj_id,doc_id,cust_id
String proj_id = getStr( request.getParameter("proj_id") );
String proj_name = getStr( request.getParameter("proj_name") );
String doc_id = getStr( request.getParameter("doc_id") );
String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );

%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">资金计划&gt; 新增条目</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="paycond_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="cust_id" value="<%=cust_id %>">
<input type="hidden" name="cust_name" value="<%=cust_name %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">项目名称</td>
    <td scope="row"><%=proj_name %></td>
   	<td scope="row">承租人</td>
    <td scope="row"><%=cust_name %></td>
  </tr>

  <tr>
    <td scope="row">款项方式</td>
    <td scope="row">
     <select style="width:150px;" name="pay_way" onchange="changePayWay()" Require="ture">
        <script type="text/javascript">
	        	w(mSetOpt('',"|收款|付款","|收款|付款"));
        </script>
     </select>
     <span class="biTian">*</span>
    </td>
    
     <td scope="row">款项内容</td>
    <td scope="row">
     <select style="width:150px;" name="fee_type" onchange="checkVal()" Require="ture">
        <script type="text/javascript">
	        	w(mSetOpt('',"<%=feetype_name_str %>","<%=feetype_name_val %>"));
        </script>
     </select>
     <span class="biTian">*</span>
    </td>
  </tr>
     
  <tr>
    <td scope="row">收/付款人</td>
    <td scope="row">
    <input style="width:150px;" name="pay_obj_name" type="text">
    <input name="pay_obj" type="hidden">

	<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="popUpWindow('pay_obj.jsp',250,350)">
		
    </td>

    <td scope="row">收/付款人账号</td>
    <td scope="row">
    <input style="width:150px;" name="pay_bank_no" type="text">
    </td>
  </tr>
     
  <tr>
    <td scope="row">收/支时间</td>
    <td scope="row">
    <input name="plan_date" type="text" style="width:150px;" readonly dataType="Date" Require="ture" onpropertychange="validDate(document.form1.plan_date.value,'<%=getSystemDate(0) %>')">
    <img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
    
    <td scope="row">币种</td>
    <td scope="row">
    <select style="width:150px;" name="currency" id="currency" Require="true"></select>
	<script language="javascript" class="text">
	dict_list("currency","currency_type","currency_type1","name");
	</script>
    </td>
  </tr>
  
  <tr>
   <td scope="row">收/付款金额</td>
    <td scope="row">
    <input name="plan_money" style="width:150px;" type="text" dataType="Money" Require="ture" onblur="checkMoney()"><span class="biTian">*</span>
    </td>
    
    <td scope="row">结算方式</td>
    <td scope="row">
	    <select style="width:150px;" name="pay_type" Require="ture">
	        <script type="text/javascript">
		        	w(mSetOpt('',"<%=paytype_name_str %>","<%=paytype_name_val %>"));
	        </script>
	     </select>
	     <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
  <td scope="row">备注</td>
    <td scope="row" colspan="3">
    	<textarea rows="6" cols="4" name="fpnote"></textarea>
    </td>
  </tr>
</table>

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
</div>
<!-- end cwMain -->
</body>
</html>

<%if(null != db){db.close();}%>