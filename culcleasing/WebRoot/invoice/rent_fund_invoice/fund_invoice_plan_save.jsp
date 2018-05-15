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
	System.out.println("发票数据提前申请：aaaaaaaaaaaaaaaaa");
	String czyid = (String) session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	
	String id_list = getStr(request.getParameter("id_list"));
	System.out.println("id_list="+id_list);
	String cfpi_id_list = getStr(request.getParameter("cfpi_id_list"));
	System.out.println("cfpi_id_list="+cfpi_id_list);
	String contract_id_list = getStr(request.getParameter("contract_id_list"));
	System.out.println("contract_id_list="+contract_id_list);
	String tax_type_list = getStr(request.getParameter("tax_type_list"));
	System.out.println("tax_type_list="+tax_type_list);	
	String money_list = getStr(request.getParameter("money_list")); 
	System.out.println("money_list="+money_list);
	String fee_num_list = getStr(request.getParameter("fee_num_list")); 
	System.out.println("fee_num_list="+fee_num_list);
	//ResultSet rs;
	String [] cfpi_arr =  cfpi_id_list.split("#");
	String [] contract_arr = contract_id_list.split("#");
	String [] tax_type_arr = tax_type_list.split("#");
	String [] money_arr = money_list.split("#");
	String [] fee_num_arr = fee_num_list.split("#");
	String message = "本次开票"+cfpi_arr.length+"条;";
	for(int i=0;i<cfpi_arr.length;i++){
	String billtype="";
	if("收据".equals(tax_type_arr[i])){
		billtype="receipt";
	}else{
		billtype="invoice";
	}		
	int  num=0;
	String	 sql = " insert  into  [dbo].[fund_invoice_info](contract_id,contract_fund_plan,tax_type,"+
					 " invoice_status,bill_type,invoice_money,creator,create_date,modificator,modify_date) "+
					 " values(";
			   sql+="'"+contract_arr[i] +"',";
			   sql+="'"+cfpi_arr[i]		+"',";
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
			message +="合同号："+contract_arr[i]+fee_num_arr[i]+"条发票申请失败;";
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
