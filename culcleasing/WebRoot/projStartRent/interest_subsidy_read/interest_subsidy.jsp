<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ����</title>
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
		var interest_money = document.getElementById("interest_money").value;//������Ϣ 
		var interest_num = document.getElementById("interest_num").value;//�����ڴ�
		var leftInterestSubsidy = document.getElementById("validLM").value;//ʣ����Ϣ 
		if(leftInterestSubsidy-interest_money<0){
			alert("������Ϣ�������ܴ���ʣ����Ϣ����������");
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
		if(save_type=="mod"){
			var input = document.getElementsByName("pre_money");
			var money_str="";
			for(var i=0;i<input.length;i++){
				money_str=money_str+document.getElementsByName("pre_money")[i].value+"#";
			}
			money_str=money_str.substring(0,money_str.length-1);
			alert(money_str);
			document.getElementById("money_str").value=money_str;
			alert(money_str);
		}
		document.forms(0).submit();
		//return false;
	}
	
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��������	
String user_id = (String)session.getAttribute("czyid");//ȡ�õ�¼�˵�ID ����ȡ�õ�¼�˵�name
//��ȡ����
String contract_id = getStr(request.getParameter("contract_id"));
String begin_id = getStr(request.getParameter("begin_id"));
String doc_id = getStr(request.getParameter("doc_id"));
String flow_date = getStr(request.getParameter("flow_date"));//����ʱ��

%>

<body onload="public_onload(0);">
<form name="dataNav" action="oper_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
 <legend style="color:#E46344;font-size: 16px;font-weight: bold">&nbsp;��Ϣ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>

<table border="0" width="100%" cellspacing="5" cellpadding="0">
    <tr height="40" style="font-weight: bold;width:100%;">
		<%
			String totalInterestSubsidy ="0.00";
			String usedInterestSubsidy = "0.00";
			
		//	sqlstr = "select isnull(sum(subsidy_money),0) use_subsidy_money,cc.rate_subsidy from  begin_info bi left join begin_interest_info bii on  ";
		//	sqlstr+="bii.begin_id=bi.begin_id left join contract_condition cc on bi.contract_id=cc.contract_id ";
		//	sqlstr+=" where bi.contract_id='"+contract_id+"' and bi.begin_id='"+begin_id+"' group by bi.contract_id,rate_subsidy ";
			
			sqlstr = "select rate_subsidy,(select isnull(sum(subsidy_money),0) use_subsidy_money from begin_interest_info  bii ";
			sqlstr +="left join begin_info bi on bi.begin_id=bi.begin_id where bi.contract_id=cc.contract_id and convert(varchar(19),bii.flow_date,21)<convert(varchar(19),'"+flow_date+"',21) ) use_subsidy_money";
			sqlstr +=" from contract_condition cc where cc.contract_id='"+contract_id+"' ";
			
			System.out.println("ʣ����Ϣ����============="+sqlstr);
			rs = db.executeQuery(sqlstr);
			if(rs.next()){
				totalInterestSubsidy = getDBStr(rs.getString("rate_subsidy"));
				usedInterestSubsidy = getDBStr(rs.getString("use_subsidy_money"));
			}
			rs.close();
			//����ѽ��й����㣬���β�������Ϣ
			String old_money="";
			String old_term="";
			sqlstr="select * from begin_interest_info where begin_id='"+begin_id+"'";
			rs = db.executeQuery(sqlstr);
			if(rs.next()){
				old_money = getDBStr(rs.getString("subsidy_money"));
				old_term = getDBStr(rs.getString("subsidy_term"));
			}
			rs.close();
			String leftInterestSubsidy = MathExtend.subtract(totalInterestSubsidy, usedInterestSubsidy);
		%>
		<td style="font-size: 16px;">��ͬ��Ϣ������<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(totalInterestSubsidy) %></b></td>
		<td style="font-size: 16px;">��ʹ����Ϣ������<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(usedInterestSubsidy) %></b></td>
		<td style="font-size: 16px;">ʣ����Ϣ������<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(leftInterestSubsidy) %></b>
		<input type="hidden" id="validLM" value="<%=leftInterestSubsidy %>">
		<input type="hidden" name="contract_id" value="<%=contract_id %>">
		<input type="hidden" name="begin_id" value="<%=begin_id %>">
		<input type="hidden" name="savetype" id="savetype" value="add">
		<input type="hidden" id="old_money" value="<%=old_money %>">
		<input type="hidden" id="old_term" value="<%=old_term %>">
		<input type="hidden" id="temp">
		<input type="hidden" id="money_str" name="money_str">
		</td>
	</tr>
</table>
</fieldset>
</div>


<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="90%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			  <td>������Ϣ������� <%=CurrencyUtil.convertFinance(old_money) %>&nbsp;&nbsp;&nbsp;&nbsp;
			  ������Ϣ�������� <%=CurrencyUtil.convertFinance(old_term) %>
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
      <tr  width="100%">
	  <!-- $$$$$$$$$$$$$$- ��Ϣ���� -$$$$$$$$$$$$$$ -->
	  <td valign="top">
		  <table border="0" style="border-collapse:collapse;overflow: auto;" align="left" cellpadding="2" 
		  	cellspacing="1" width="100%" 
		  	class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>�ڴ�</th>
					<th>��Ϣ����</th>
				  </tr>
				  <tbody id="data">
				  <%
					//���γ�����ϸ��ѯ
					sqlstr = "select * from begin_interest_subsidy where begin_id='"+begin_id+"' ";
					LogWriter.logDebug(request, "��Ϣ������֡�����== "+sqlstr);
					rs = db.executeQuery(sqlstr);
					while(rs.next()) {
				  %>
				  <tr>
					<td align="center"><%=getDBStr(rs.getString("subsidy_list")) %></td> 
					<td align="center"><%=CurrencyUtil.convertFinance(getDBStr(rs.getString("subsidy_money")) )%></td> 
				  </tr>
				  <%}
				  	rs.close();
				  	db.close();
				  %>
				  </tbody>
			  </table>
		  </td>
      </tr>
    </table></div>
</form>
</body>
</html>