<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

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
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<%
//��ȡ����item_id
String item_id = getStr( request.getParameter("item_id") ); 

sqlstr = "select pffcpt.*,pay_objname=dbo.getCustName(pffcpt.pay_obj),(select top 1 account from vi_cust_account where acc_number=pay_bank_no ) account,(select top 1 acc_status from vi_cust_account where acc_number=pay_bank_no ) acc_status from contract_fund_fund_charge_plan_temp pffcpt where id='"+item_id+"'";
rs = db.executeQuery(sqlstr);

String pay_way = "";
String fee_type = "";
String pay_obj = "";
String pay_obj_name = "";
String pay_bank_no = "";
String plan_bank_name = "";
String plan_bank_no = "";
String plan_date = "";
String currency_type = "";
String plan_money = "";
String pay_type = "";
String fpnote = "";

if(rs.next()){
	pay_way = getDBStr(rs.getString("pay_way"));
	fee_type = getDBStr(rs.getString("fee_type"));
	pay_obj = getDBStr(rs.getString("pay_obj"));
	pay_obj_name = getDBStr(rs.getString("pay_objname"));
	pay_bank_no = getDBStr(rs.getString("pay_bank_no"));
	plan_bank_name = getDBStr(rs.getString("plan_bank_name"));
	plan_bank_no = getDBStr(rs.getString("plan_bank_no"));
	plan_date = getDBDateStr(rs.getString("plan_date"));
	currency_type = getDBStr(rs.getString("currency"));
	plan_money = getDBStr(rs.getString("plan_money"));
	pay_type = getDBStr(rs.getString("pay_type"));
	fpnote = getDBStr(rs.getString("fpnote"));
}
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">�ʽ�ƻ�&gt; �޸���Ŀ</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="paycond_upsave.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="item_id" value="<%=item_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">���ʽ</td>
    <td scope="row">
     <select style="width:150px;" name="pay_way" onchange="changePayWay()" Require="ture" disabled="disabled">
        <script type="text/javascript">
	        	w(mSetOpt('<%=pay_way %>',"|�տ�|����","|�տ�|����"));
        </script>
     </select>
     <span class="biTian">*</span>
    </td>
    
    <td scope="row">��������</td>
    <td scope="row">
     <select style="width:150px;" name="fee_type" onchange="checkVal()" Require="ture" disabled="disabled">
        <script type="text/javascript">
	        	w(mSetOpt('<%=fee_type %>',"<%=feetype_name_str %>","<%=feetype_name_val %>"));
        </script>
     </select>
     <span class="biTian">*</span>
    </td>
  </tr>
     
  <tr>
    <td scope="row"><%="�տ�".equals(pay_way)?"������":"������" %></td>
    <td scope="row">
    <input style="width:150px;" name="pay_obj_name" type="text" value="<%=pay_obj_name %>" readonly="readonly">
    <input name="pay_obj" type="hidden" value="<%=pay_obj %>">
    </td>

    <td scope="row"><%="�տ�".equals(pay_way)?"�������˺�":"�տ����˺�" %></td>
    <td scope="row">
    <input style="width:150px;" name="pay_bank_no" type="text" value="<%=pay_bank_no %>">
    </td>
  </tr>
  
   <!-- �������򷽼ƻ��տ�\�����˺� -->
  <tr>
    <td scope="row" id="bj_3"><%="�տ�".equals(pay_way)?"�ƻ��տ������":"�ƻ����������" %></td>
    <td scope="row">
    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly" value="<%=plan_bank_name %>">
    </td>

    <td scope="row" id="bj_4"><%="�տ�".equals(pay_way)?"�ƻ��տ������˺�":"�ƻ����������˺�" %></td>
    <td scope="row">
    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly" value="<%=plan_bank_no %>">
    </td>
  </tr>
     
  <tr>
    <td scope="row"><%="�տ�".equals(pay_way)?"�տ�ʱ��":"����ʱ��" %></td>
    <td scope="row">
    <input name="plan_date" type="text" style="width:150px;" readonly dataType="Date" Require="ture" value="<%=plan_date %>">
    <img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
    
    <td scope="row">����</td>
    <td scope="row">
    <select style="width:150px;" name="currency" id="currency" disabled="disabled"></select>
	<script language="javascript" class="text">
	dict_list("currency","currency_type","<%=currency_type %>","name");
	</script>
    </td>
  </tr>
  
  <tr>
   <td scope="row"><%="�տ�".equals(pay_way)?"�տ���":"������" %></td>
    <td scope="row">
    <input name="plan_money" style="width:150px;" type="text" dataType="Money" value="<%=plan_money %>" readonly="readonly">
    </td>
    
    <td scope="row">���㷽ʽ</td>
    <td scope="row">
	    <select style="width:150px;" name="pay_type" disabled="disabled">
	        <script type="text/javascript">
		        	w(mSetOpt('<%=pay_type %>',"<%=paytype_name_str %>","<%=paytype_name_val %>"));
	        </script>
	     </select>
    </td>
  </tr>
  <tr>
  <td scope="row">��ע</td>
    <td scope="row" colspan="3">
    	<textarea rows="6" cols="4" name="fpnote"><%=fpnote %></textarea>
    </td>
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
