<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ�ƻ� - �޸�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function choi_Fee(){
	var contractId = $(":input[name='contract_id']").val();
	var docId = $(":input[name='doc_id']").val();
		popUpWindow('fee_name.jsp?doc_id='+docId+'&contract_id='+contractId,250,350);
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<%
//��ȡ����item_id
//ResultSet rs1="";
String item_id = getStr( request.getParameter("item_id") ); 
String doc_id = getStr( request.getParameter("doc_id") ); 
String contract_id = getStr( request.getParameter("contract_id") ); 
sqlstr = "select *,[dbo].[GetFundZKName_T](payment_id,doc_id) as zk_fee_name from vi_contract_fund_fund_charge_plan_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'  and payment_id='"+item_id+"'";

rs = db.executeQuery(sqlstr);
String pay_type_name = "";
String fee_type_name = "";
String fee_num = "";
String fee_name = "";
String zk_fee_name = "";

if(rs.next()){
	pay_type_name = getDBStr(rs.getString("pay_type_name"));
	fee_type_name = getDBStr(rs.getString("fee_type_name"));
	fee_num = getDBStr(rs.getString("fee_num"));
	fee_name = getDBStr(rs.getString("fee_name"));
	zk_fee_name = getDBStr(rs.getString("zk_fee_name"));
}
rs.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">�ʽ�ƻ��ϱ�&gt; ���ۿ���</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="zk_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="item_id" value="<%=item_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">��ͬ���</td>
    <td scope="row">
    <input type="text" name="fee_name" style="width:150px;" readonly="readonly" value="<%=contract_id %>"  readonly>
    </td>
    
    <td scope="row">��������</td>
     <td scope="row">
    <input type="text" name="fee_name" style="width:150px;" readonly="readonly" value="<%=fee_type_name %>"  readonly>
    </td>
  </tr>
     
  <tr>
   <td scope="row">���</td>
     <td scope="row">
    <input type="text" name="fee_name" style="width:150px;" readonly="readonly" value="<%=fee_num %>"  readonly>
    </td>

	<td scope="row">��������</td>
	<td>
		<input type="text" name="fee_name" style="width:150px;" readonly="readonly" value="<%=fee_name %>"  dreadonly>
	 	<span class="biTian">*</span>
	</td>
  </tr>
   <tr>
   <td scope="row">֧����ʽ</td>
     <td scope="row">
    <input type="text" name="fee_name" style="width:150px;" readonly="readonly" value="<%=pay_type_name %>"  readonly>
    </td>

	<td scope="row">���ۿ���</td>
	<td scope="row">
    <input style="width:150px;" name="zk_fee_name" type="text" readonly="readonly" value="<%=zk_fee_name %>">
	 <input style="width:150px;" name="zk_fee_name_val" type="hidden">
    
    <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="choi_Fee();"> 
    </td>
	 	<span class="biTian">*</span>
  </tr>
  
  


</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="����" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close();" class="btn3_mouseout">
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