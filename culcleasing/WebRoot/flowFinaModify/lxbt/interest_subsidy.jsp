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
		
		if(interest_money<0){
			alert("������Ϣ��������С��0");
		}
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
		var interest_money = document.getElementById("interest_money").value;//������Ϣ 
		var leftInterestSubsidy = document.getElementById("validLM").value;//ʣ����Ϣ
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
			alert("���������߲���������д��ʽ����");
			return false;
		}else if(interest_money<0){
			alert("������Ϣ��������С��0");
			return false;
		}else if(leftInterestSubsidy-interest_money<0){
			alert("������Ϣ�������ܴ���ʣ����Ϣ����������");
			return false;
		}else if(temp_money>interest_money){
			alert("������Ϣ�������ܴ���ʣ����Ϣ����������");
			return false;
		}
		else{
			document.forms(0).submit();
		}
		//return false;
	}
	
	function checkSum(){
		var tM = 0;
		$(":input[name='pre_money']").each(function(i){
			var m = $(this).attr("value");
			//alert("ֵ��"+m);
			tM = tM*1.00 + m*1.00;
		});
		//alert("ss   "+tM);
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

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="90%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			
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
      <tr  width="100%">
	  <!-- $$$$$$$$$$$$$$- ��Ϣ���� -$$$$$$$$$$$$$$ -->
	  <td valign="top">
		  <table border="0" style="border-collapse:collapse;overflow: auto;" align="left" cellpadding="2" 
		  	cellspacing="1" width="100%" 
		  	class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>�ڴ�</th>
					<th>����</th>
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
					<td><%=getDBStr(rs.getString("subsidy_list")) %></td> 
					<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
					<td><input type="text" name="pre_money"  onfocus="mak_value(this.value,'1');" onblur="mak_value(this.value,'2');" value="<%=getDBStr(rs.getString("subsidy_money")) %>"></td> 
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
<script type="text/javascript">
	function updData(){
		window.open("interest_upload.jsp?begin_id=<%=begin_id %>&contract_id=<%=contract_id %>&flow_date=<%=flow_date %>");
	}
</script>
</body>
</html>
