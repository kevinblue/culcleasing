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
	String begin_id_list = getStr(request.getParameter("begin_id_list"));
	String plid_list = getStr(request.getParameter("plid_list"));
	String rent_type_list = getStr(request.getParameter("rent_type_list"));
	String rent_list_list = getStr(request.getParameter("rent_list_list")); 
	
	//ResultSet rs;
	
	String [] id_arr =  id_list.split("#");
	String [] begin_id_arr = begin_id_list.split("#");
	String [] plid_arr = plid_list.split("#");
    String [] rent_type_arr = rent_type_list.split("#");
	String [] rent_list_arr = rent_list_list.split("#");
	
	String message = "����"+invoice_statues+id_arr.length+"��;";
	for(int i=0;i<id_arr.length;i++){
	String	 sql="";
	int  num=0;
	if(invoice_statues.equals("����")){
		sql = "update [dbo].[rent_invoice_info]  set ";
			sql+="invoice_status='"+"3" +"',";
			sql+="modificator='"+czyid +"',";
			sql+="modify_date='"+datestr +"'";				
			sql+=" where  id='"+id_arr[i]+"'";
	}
	
	if(invoice_statues.equals("�˻�")){
			sql = "update [dbo].[rent_invoice_info]  set ";
			sql+="invoice_status='"+"1" +"',";
			sql+="modificator='"+czyid +"',";
			sql+="modify_date='"+datestr +"'";				
			sql+=" where  contract_fund_rent_plan='"+plid_arr[i]+"'";
	
	}
			  		   
		System.out.println("sql="+sql);
		
		//rs.close();
		num = db.executeUpdate(sql);
		if(num==0){
			message +="�����ţ�"+begin_id_arr[i]+"��"+rent_list_arr[i]+"��"+rent_type_arr[i]+"����վ�"+invoice_statues+"ʧ��;";
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
