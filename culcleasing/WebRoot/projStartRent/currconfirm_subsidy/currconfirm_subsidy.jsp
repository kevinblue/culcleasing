<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���ڷִ�ȷ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script src="../../js/validator.js"></script>
<script type="text/javascript">
	function check_interest(){
		var old_money=document.getElementById("old_money").value;//�ɵĽ��
		var old_term=document.getElementById("old_term").value;//�ɵ��ڴ�
		var interest_money = document.getElementById("interest_money").value;//���α�֤�� 
		var interest_num = document.getElementById("interest_num").value;//�����ڴ�
		var leftInterestSubsidy = document.getElementById("validLM").value;//ʣ�ౣ֤�� 
		if(leftInterestSubsidy-interest_money<0){
			alert("����ȷ�Ͻ��ܴ���ʣ��ȷ�Ͻ�����");
		}else if(old_money>leftInterestSubsidy){
			alert("����ȷ�Ͻ���С��ʣ��ȷ�Ͻ�����");
		}
		if(interest_money<0){
			alert("����ȷ�϶�Ȳ���С��0");
		}
		
		if(old_money!=""&&(old_money!=interest_money)){
			document.getElementById("tj_sumbit").value="����";
		}
		if(old_term!=""&&(old_term!=interest_num)){
			document.getElementById("tj_sumbit").value="����";
		}
		
	}
	
	function mak_value(tmp,flag){
		if(flag==1){
		document.getElementById("temp").value=tmp;		
		}else if(flag==2){
		var old_tmp = document.getElementById("temp").value;
		if((tmp-old_tmp)!=0){
			document.getElementById("tj_sumbit").value="����";
			document.getElementById("savetype").value="mod";
			}
		}

	}
	
	function check_sub(){
		var save_type=document.getElementById("savetype").value;
		var interest_money = document.getElementById("interest_money").value;//���α�֤�� 
		var leftInterestSubsidy = document.getElementById("validLM").value;//ʣ�ౣ֤��
		var temp_money=0; 
		if(save_type=="mod"){
			var input = document.getElementsByName("pre_money");
			var money_str="";
			for(var i=0;i<input.length;i++){
				money_str=money_str+document.getElementsByName("pre_money")[i].value+"#";
				temp_money=temp_money+parseFloat(document.getElementsByName("pre_money")[i].value);
			}
			money_str=money_str.substring(0,money_str.length-1);
			document.getElementById("money_str").value=money_str;
			//alert(money_str);
		}
		//�жϲ�������벹�������Ϸ���
		if(isNaN($("#interest_money").val()) || isNaN($("#interest_num").val())){
			alert("ȷ�Ͻ����߲���������д��ʽ����");
			return false;
		}else if(interest_money<0){
			alert("����ȷ�϶�Ȳ���С��0");
			return false;
		}
		else if(leftInterestSubsidy-interest_money<0){
			alert("����ȷ�Ͻ��ܴ���ʣ��ȷ�Ͻ���");
			return false;
		}else if(temp_money>interest_money){
			alert("����ȷ�Ͻ��ܴ���ʣ��ȷ�Ͻ�");
			return false;
		}		
		else{
			document.forms(0).submit();
		}
		//return false;
	}
	
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����
String contract_id = getStr(request.getParameter("contract_id"));
String begin_id = getStr(request.getParameter("begin_id"));
String flow_date = getStr(request.getParameter("flow_date"));//����ʱ��
String doc_id = getStr(request.getParameter("doc_id"));

if("".equals(begin_id)){
	begin_id="12CULC010864L3983";
	contract_id="12CULC010864L39";
	flow_date="2012-5-1";
}

//��ȡ����ѡ������(����������)���ϼ���ض�ȡ���ʹ�ö��
String totalInterestSubsidy ="0.00";
String usedInterestSubsidy = "0.00";
sqlstr = "select (isnull(cc.management_fee,0)+isnull(cc.handling_charge,0)) as caution_money,(select isnull(sum(currConfirm_money),0) use_subsidy_money from begin_currconfirm_info  bii ";
sqlstr +="left join begin_info bi on bi.begin_id=bii.begin_id where bi.contract_id=cc.contract_id  and convert(varchar(19),bii.flow_date,21)<convert(varchar(19),'"+flow_date+"',21) ) use_subsidy_money";
sqlstr +=" from contract_condition cc where cc.contract_id='"+contract_id+"' ";
System.out.println("�������============="+sqlstr);
rs = db.executeQuery(sqlstr);
if(rs.next()){
	totalInterestSubsidy = getDBStr(rs.getString("caution_money"));
	usedInterestSubsidy = getDBStr(rs.getString("use_subsidy_money"));
}
rs.close();

//����ѽ��й����㣬���β�������Ϣ
String old_money="";
String old_term="";
String conf_type = "";

sqlstr="select * from begin_currconfirm_info where begin_id='"+begin_id+"' ";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	old_money = getDBStr(rs.getString("currConfirm_money"));
	old_term = getDBStr(rs.getString("currConfirm_term"));
	conf_type = getDBStr(rs.getString("confirm_type"));
}
rs.close();

String leftInterestSubsidy = MathExtend.subtract(totalInterestSubsidy, usedInterestSubsidy);
%>

<% if(!"".equals(conf_type)) { %>
<script type="text/javascript">
$(document).ready(function() {
	$(":radio[name='feeType']").removeAttr("checked");
	$("input[name='feeType'][value='<%=conf_type %>']").attr("checked","checked");
 });
</script>
<%} %>

<body onload="public_onload(0);">
<form name="dataNav" action="oper_save.jsp" target="_blank" onSubmit="return Validator.Validate(this,3);">
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
 <legend style="color:#E46344;font-size: 16px;font-weight: bold">&nbsp;���ڷִ�ȷ��
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>

<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr style="font-weight: bold;">
		<td>
		ѡ��������ͣ�
			<input type="radio" name="feeType" checked="checked" value="�����" style="border: none;">�����
			<input type="radio" name="feeType" value="�����" style="border: none;">�����
			<input type="radio" name="feeType" value="�ϼ�"   style="border: none;">�ϼ�
		</td>
	</tr>
    <tr height="40" style="font-weight: bold;width:100%;">
		<td style="font-size: 16px;">��ȣ�<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(totalInterestSubsidy) %></b></td>
		<td style="font-size: 16px;">��ʹ�ö�ȣ�<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(usedInterestSubsidy) %></b></td>
		<td style="font-size: 16px;">ʣ���ȣ�<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(leftInterestSubsidy) %></b></td>
	</tr>
</table>

<input type="hidden" id="validLM" value="<%=leftInterestSubsidy %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="begin_id" value="<%=begin_id %>">
<input type="hidden" name="savetype" id="savetype" value="add">
<input type="hidden" name="flow_date" value="<%=flow_date %>">
<input type="hidden" id="old_money" value="<%=old_money %>">
<input type="hidden" id="old_term" value="<%=old_term %>">
<input type="hidden" id="confirm_type" value="<%=conf_type %>">
<input type="hidden" id="temp">
<input type="hidden" id="money_str" name="money_str">
		
</fieldset>
</div>




<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="90%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			<td>
			  ����ȷ�϶��<input type="text" name="interest_money" id="interest_money" dataType="Number" 
			  	Require="true"  onblur="check_interest();" value="<%=old_money %>"><span class="biTian">*</span>
			  ȷ������<input type="text" name="interest_num" id="interest_num" dataType="Number"  
			  	Require="true" onblur="check_interest();" value="<%=old_term %>"><span class="biTian">*</span>
				<input type="button" id="tj_sumbit" value="����" onclick="check_sub();">
			</td>
			
			<td>
				<BUTTON class="btn_2" type="button" onclick="updData();">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="�ϴ�(Alt+N)">&nbsp;�ϴ�Excel</button>
			</td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="10%"><!--��ҳ���ƿ�ʼ-->
	</td>		 	
 </tr>
</table>


<div style="vertical-align:top;width:100% ;overflow:auto;position: relative;margin-top: 10px;"  id="mydiv">
	<table align="center" width="100%">		
      <tr width="100%">
	  <td valign="top">
		  <table border="0" style="border-collapse:collapse;overflow: auto;" align="left" cellpadding="2" 
		  	cellspacing="1" width="100%" 
		  	class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>ȷ���ڴ�</th>
					<th>����</th>
					<th>ȷ�϶��</th>
				  </tr>
				  <tbody id="data">
				  <%
					//���γ�����ϸ��ѯ
					sqlstr = "select * from begin_currconfirm_subsidy where begin_id='"+begin_id+"' ";
					rs = db.executeQuery(sqlstr);
					while(rs.next()) {
				  %>
				  <tr>
					<td><%=getDBStr(rs.getString("currconfirm_list")) %></td> 
					<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
					<td>
						<input type="text" name="pre_money"  onfocus="mak_value(this.value,'1');" 
						onblur="mak_value(this.value,'2');" value="<%=getDBStr(rs.getString("currconfirm_money")) %>"></td> 
				  </tr>
				  <%}
				  	rs.close();
				  	db.close();
				  %>
			  </tbody>
		  </table>
	  </td>
      </tr>
    </table>
</div>
</form>
<script type="text/javascript">
	function updData(){
		var ty = $(":radio[name='feeType']").val();
		window.open("confirm_upload.jsp?begin_id=<%=begin_id %>&contract_id=<%=contract_id %>&flow_date=<%=flow_date %>&type="+ty);
	}
</script>
</body>
</html>
