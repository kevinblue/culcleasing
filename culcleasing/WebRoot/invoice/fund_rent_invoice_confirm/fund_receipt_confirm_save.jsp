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
	String czyid = (String) session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	
	String id_list = getStr(request.getParameter("id_list"));
	String invoice_statues = getStr(request.getParameter("invoice_statues")); 
	String contract_id_list = getStr(request.getParameter("contract_id_list"));
	String fee_name_list = getStr(request.getParameter("fee_name_list"));
	String fee_num_list = getStr(request.getParameter("fee_num_list")); 
	
	//ResultSet rs;
	
	String [] id_arr =  id_list.split("#");
	String [] contract_arr = contract_id_list.split("#");
    String [] fee_name_arr = fee_name_list.split("#");
	String [] fee_num_arr = fee_num_list.split("#");
	String message = "����"+invoice_statues+id_arr.length+"��;";
	for(int i=0;i<id_arr.length;i++){
	String	 sql="";
	int  num=0;
	if(invoice_statues.equals("����")){
		sql = "update [dbo].[fund_invoice_info]  set ";
			sql+="invoice_status='"+"3" +"',";
			sql+="modificator='"+czyid +"',";
			sql+="modify_date='"+datestr +"'";				
			sql+=" where  id='"+id_arr[i]+"'";
	}
	
	if(invoice_statues.equals("�˻�")){
			sql = "update [dbo].[fund_invoice_info]  set ";
			sql+="invoice_status='"+"1" +"',";
			sql+="modificator='"+czyid +"',";
			sql+="modify_date='"+datestr +"'";				
			sql+=" where  id='"+id_arr[i]+"'";
	
	}
			  		   
		System.out.println("sql="+sql);
		
		//rs.close();
		num = db.executeUpdate(sql);
		if(num==0){
			message +="��ͬ�ţ�"+contract_arr[i]+"��������"+fee_name_arr[i]+"��"+fee_num_arr[i]+"���ʽ��վ�"+invoice_statues+"ʧ��;";
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
