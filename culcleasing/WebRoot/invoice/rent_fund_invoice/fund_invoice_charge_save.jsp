<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- 2010-08-05�޸�Ϊ��com.rent.calc.tx.TransRateNew ��ǰ��ֵΪ��com.rent.calc.TransRate -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ʊ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<BODY>
<%
	System.out.println("��Ʊ����ʵ�����룺aaaaaaaaaaaaaaaaa");
	String czyid = (String) session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	
	String id_list = getStr(request.getParameter("id_list"));
	String cfci_id_list = getStr(request.getParameter("cfci_id_list"));
	String contract_id_list = getStr(request.getParameter("contract_id_list"));
	String tax_type_list = getStr(request.getParameter("tax_type_list"));
	String money_list = getStr(request.getParameter("money_list")); 
	String fee_num_list = getStr(request.getParameter("fee_num_list")); 
	//ResultSet rs;
	String [] cfci_arr =  cfci_id_list.split("#");
	String [] contract_arr = contract_id_list.split("#");
	String [] tax_type_arr = tax_type_list.split("#");
	String [] money_arr = money_list.split("#");
	String [] fee_num_arr = fee_num_list.split("#");
	String message = "���ο�Ʊ"+cfci_arr.length+"��;";
	for(int i=0;i<cfci_arr.length;i++){
	String billtype="";
	if("�վ�".equals(tax_type_arr[i])){
		billtype="receipt";
	}else{
		billtype="invoice";
	}	
	int  num=0;
	String	 sql = " insert  into  [dbo].[fund_invoice_info](contract_id,contract_fund_charge,tax_type,"+
					 " invoice_status,bill_type,invoice_money,creator,create_date,modificator,modify_date) "+
					 " values(";
			   sql+="'"+contract_arr[i] +"',";
			   sql+="'"+cfci_arr[i]		+"',";
			   sql+="'"+tax_type_arr[i] +"',";
			   sql+="'"+"2"				+"',";
			   sql+="'"+billtype		+"',";
			   sql+="'"+money_arr[i]	+"',";
			   sql+="'"+czyid			+"',";
			   sql+="'"+datestr			+"',";
			   sql+="'"+"null"			+"',";
			   sql+="null";
			   sql+=")";
		System.out.println("sql="+sql);
		//rs.close();
		num = db.executeUpdate(sql);
		if(num==0){
			message +="��ͬ�ţ�"+contract_arr[i]+fee_num_arr[i]+"����Ʊ����ʧ��;";
		}
	}
	db.close();
%>
	<script>		
		window.alert("<%=message%>�ɹ�!");
		window.opener.location.reload();
		window.opener=null;
		window.open("","_self");
		setTimeout("self.close()",100);
		
		
		
	</script>
