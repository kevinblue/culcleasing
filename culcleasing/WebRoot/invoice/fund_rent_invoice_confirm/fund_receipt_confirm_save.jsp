<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- 2010-08-05修改为：com.rent.calc.tx.TransRateNew 以前的值为：com.rent.calc.TransRate -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>发票申请</title>
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
	String message = "本次"+invoice_statues+id_arr.length+"条;";
	for(int i=0;i<id_arr.length;i++){
	String	 sql="";
	int  num=0;
	if(invoice_statues.equals("导出")){
		sql = "update [dbo].[fund_invoice_info]  set ";
			sql+="invoice_status='"+"3" +"',";
			sql+="modificator='"+czyid +"',";
			sql+="modify_date='"+datestr +"'";				
			sql+=" where  id='"+id_arr[i]+"'";
	}
	
	if(invoice_statues.equals("退回")){
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
			message +="合同号："+contract_arr[i]+"款项名称"+fee_name_arr[i]+"第"+fee_num_arr[i]+"期资金收据"+invoice_statues+"失败;";
		}
	}
	db.close();
%>
	<script>		
		window.alert("<%=message%>成功!");
		window.opener.location.reload();
		window.opener=null;
		window.open("","_self");
		setTimeout("self.close()",100);
		
		
		
	</script>
