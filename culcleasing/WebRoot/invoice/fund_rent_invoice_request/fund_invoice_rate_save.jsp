<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->
<!-- 2010-08-05�޸�Ϊ��com.rent.calc.tx.TransRateNew ��ǰ��ֵΪ��com.rent.calc.TransRate -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<BODY>
<%
	
	String czyid =(String) session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	
	String id_list = getStr(request.getParameter("id_list"));
	String contract_id_list = getStr(request.getParameter("contract_id_list"));
	String tax_rate = getStr(request.getParameter("tax_rate"));
	String statues_list = getStr(request.getParameter("statues_list")); 
	
	//ResultSet rs;
	String [] id_arr = id_list.split("#");
	String [] contract_arr = contract_id_list.split("#");
	String [] statues_arr = statues_list.split("#");
	
	String message = "����ά��"+id_arr.length+"��;";
	
	for(int i=0;i<id_arr.length;i++){
		int  num=0;
		String	 sql="";
		if("δά��".equals(statues_arr[i])){
			sql = " insert  into  [dbo].[fund_invoice_rate_info](contract_id,tax_rate,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+contract_arr[i] +"',";
				   sql+="'"+tax_rate 	+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
		}else{
				sql = " update  [dbo].[fund_invoice_rate_info]  set tax_rate='"+tax_rate+"',modificator='"+czyid+"',modify_date='"+datestr+"'";					 
				sql+=" where  contract_id='"+contract_arr[i] +"'";
			
		}
			System.out.println("sql="+sql);
			//rs.close();
			num = db.executeUpdate(sql);
			if(num==0){
				message +="��ͬ�ţ�"+contract_arr[i]+"��Ϣά��ʧ��;";
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
