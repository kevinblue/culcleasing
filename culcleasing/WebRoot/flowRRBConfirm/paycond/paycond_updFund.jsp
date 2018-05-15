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

<script type="text/javascript">
//ѡ����ʽ
function changePayWay(){
	var payWayVal = $(":input[name='pay_way']").val();
	var feeTypeVal = $(":input[name='fee_type']").val();
	if(payWayVal=='�տ�'){
		$(":input[name='pay_obj']").val($(":input[name='cust_name']").val());
		//�жϿ��������Ƿ���ȷ
		if(feeTypeVal=='24' || feeTypeVal=='21' || feeTypeVal=='18' || feeTypeVal=='26'){
			alert("ѡ���������Ϊ������������ѡ����");
			$(":input[name='fee_type']").val('');
		}
	}else{
		$(":input[name='pay_obj']").val("");
		//�жϿ��������Ƿ���ȷ
		if( feeTypeVal!='' && feeTypeVal!='24' && feeTypeVal!='21' && feeTypeVal!='18' && feeTypeVal!='26'){
			alert("ѡ���������Ϊ�տ���������ѡ����");
			$(":input[name='fee_type']").val('');
		}
	}
}
//ѡ���������
function checkVal(){
	var feeTypeVal = $(":input[name='fee_type']").val();
	var payWayVal = $(":input[name='pay_way']").val();
	//alert(feeTypeVal);
	if(feeTypeVal=='24' || feeTypeVal=='21' || feeTypeVal=='18' || feeTypeVal=='26'){
		if(payWayVal=='�տ�'){
			alert("�ÿ������ݷ��տ���������ѡ����");
			$(":input[name='fee_type']").val('');
		}
	}
}
//У��ƻ�����Ƿ���ȷ
function checkMoney(){
	var planMoneyVal = $(":input[name='plan_money']").val();
	var reg = /^[0-9]+(\.[0-9]+)?$/;


	if(planMoneyVal!=''){
		if(!reg.test(planMoneyVal)){  
	        alert('�ƻ������д��ʽ����');  
	        $(":input[name='plan_money']").val('');
	        $(":input[name='plan_money']").focus();  
	    }  
	}
	if()
}

//ѡ���ո������˺���Ϣ
function choi_custBank(){
	//�ж��Ƿ���ѡ�п���
	var custId = $(":input[name='pay_obj']").val();
	if(custId==""){
		alert( "����ѡ��"+$("#bj_1").text());
	}else{
		popUpWindow('pay_bank_info.jsp?cust_id='+custId,250,350);
	}
}

//��������
function showFeeName(){
	var fee_type = $("select[name='fee_type']:selected").val();
	//alert(fee_type);
}

//�жϵ�ǰѡ���������ϵͳ��ǰ��������1����
function validDate(){
	var now = '<%=getSystemDate(0) %>';
	var choiDate = $(":input[name='plan_date']").val();
	var difDays = DateDiff(now, choiDate);
	
	//alert("��ǰ���ڣ�"+now+"__"+choiDate+"���"+difDays);
	if( choiDate < now ){
		alert("�ƻ����ڲ�ҪС�ڵ�ǰ���ڣ�");
		//$(":input[name='plan_date']").val("");
	}else if( difDays>300 ){
		alert("��ѡ����Ч�ļƻ���/�������ڣ�");
		//$(":input[name='plan_date']").val("");
	}
}
//����������
function DateDiff(beginDate, endDate)   //���������ĺ���
{    
    //beginDate��endDate����2007-8-10��ʽ
    var arrbeginDate, Date1,Date2,arrendDate,iDays 
    arrbeginDate= beginDate.split("-") 
    Date1= new Date(arrbeginDate[1]+'-'+arrbeginDate[2]+'-'+arrbeginDate[0])    //ת��Ϊ8-10-2007��ʽ
    arrendDate= endDate.split("-") 
    Date2= new Date(arrendDate[1]+'-'+arrendDate[2]+'-'+arrendDate[0]) 
    iDays = parseInt(Math.abs(Date1- Date2)/1000/60/60/24)        //ת��Ϊ���� 
    return iDays 
    

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
String item_id = getStr( request.getParameter("item_id") ); 

sqlstr = "select pffcpt.*,pay_objname=dbo.getCustName(pffcpt.pay_obj),(select top 1 account from vi_cust_account where acc_number=pay_bank_no ) account,(select top 1 acc_status from vi_cust_account where acc_number=pay_bank_no ) acc_status from contract_fund_fund_charge_plan_temp pffcpt where id='"+item_id+"'";
rs = db.executeQuery(sqlstr);

String contract_id = "";
String id="";
String doc_id = "";
String pay_way = "";
String fee_type = "";
String fee_name = "";
String pay_obj = "";
String pay_obj_name = "";
String pay_bank_name = "";
String pay_bank_no = "";
String plan_bank_name = "";
String plan_bank_no = "";
String plan_date = "";
String currency_type = "";
String plan_money = "";
String pay_type = "";
String fpnote = "";

if(rs.next()){
	contract_id = getDBStr(rs.getString("contract_id"));
	id=getDBStr(rs.getString("make_contract_id"));
	doc_id = getDBStr(rs.getString("doc_id"));
	pay_way = getDBStr(rs.getString("pay_way"));
	fee_type = getDBStr(rs.getString("fee_type"));
	fee_name = getDBStr(rs.getString("fee_name"));
	pay_obj = getDBStr(rs.getString("pay_obj"));
	pay_obj_name = getDBStr(rs.getString("pay_objname"));
	pay_bank_name = getDBStr(rs.getString("pay_bank_name"));
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
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="item_id" value="<%=item_id %>">
<input type="hidden" name="fee_type" value="<%=fee_type %>">
<input type="hidden" name="pay_way" value="<%=pay_way %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
<tr>
<td scope="row">��ͬ���</td>
<td scope="row">
      <input name="make_contract_id" style="width:150px;" type="text" value="<%=id %>">
    </td>
</tr>
  <tr>
    <td scope="row">���ʽ</td>
    <td scope="row">
     <select style="width:150px;" name="pay_way" onchange="changePayWay()" Require="ture" disabled="disabled">
        <script type="text/javascript">
	        	w(mSetOpt('<%=pay_way %>',"|�տ�|����","|�տ�|����"));
        </script>
     </select>

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
    <td scope="row"><%="�տ�".equals(pay_way)?"������":"�տ���" %></td>
    <td scope="row">
    <input style="width:150px;" name="pay_obj_name" type="text" value="<%=pay_obj_name %>" Require="ture"   readonly="true">
    <input name="pay_obj" type="hidden" value="<%=pay_obj %>">
	
    </td>

	<td>��������</td>
	<td>
		<input type="text" name="fee_name" style="width:150px;" Require="ture" value="<%=fee_name %>"   readonly="true">
	</td>
  </tr>
  
  <tr>
	<td scope="row"><%="�տ�".equals(pay_way)?"�����˿�������":"�տ��˿�������" %></td>
    <td scope="row">
    <input style="width:150px;" name="pay_bank_name" type="text" value="<%=pay_bank_name %>"   readonly="readonly">
    </td>
    
	<td scope="row"><%="�տ�".equals(pay_way)?"�����������ʺ�":"�տ��������ʺ�" %></td>
    <td scope="row">
    <input style="width:150px;" name="pay_bank_no" type="text" value="<%=pay_bank_no %>"   readonly="readonly">
     
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
    <input style="width:150px;" name="plan_bank_no" type="text"   readonly="readonly" value="<%=plan_bank_no %>">
    
    
    </td>
  </tr>
     
  <tr>
    <td scope="row"><%="�տ�".equals(pay_way)?"�տ�ʱ��":"����ʱ��" %></td>
    <td scope="row">
    <input name="plan_date" type="text" style="width:150px;" readonly dataType="Date" Require="ture" value="<%=plan_date %>"  onpropertychange="validDate()">
    <img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
    
    <td scope="row">����</td>
    <td scope="row">
    <!--  <select style="width:150px;" name="currency" id="currency" Require="true"   ></select>
	<script language="javascript" class="text">
	dict_list("currency","currency_type","<%=currency_type %>","name");
	</script>
	-->
	<input style="width:150px;" name="currency" id="currency" type="hidden"  Require="true"  readonly="readonly"  value="<%=currency_type %>">
	<input style="width:150px;" type="text"  Require="true"  readonly="readonly"  value="�����">
    </td>
  </tr>
  
  <tr>
   <td scope="row"><%="�տ�".equals(pay_way)?"�տ���":"������" %></td>
    <td scope="row">
    <input name="plan_money" style="width:150px;" type="text" dataType="Money" Require="ture" onblur="checkMoney()" value="<%=plan_money %>">
    <span class="biTian">*</span>
    </td>
    
    <td scope="row">���㷽ʽ</td>
    <td scope="row">
	    <select style="width:150px;" name="pay_type" Require="true" >
	        <script type="text/javascript">
		        	w(mSetOpt('<%=pay_type %>',"<%=paytype_name_str %>","<%=paytype_name_val %>"));
	        </script>
	     </select>
	      <span class="biTian">*</span>
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

<%if(null != db){db.close();}%>