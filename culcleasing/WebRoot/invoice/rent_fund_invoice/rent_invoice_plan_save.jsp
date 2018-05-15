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
	System.out.println("租金发票数据提前申请：aaaaaaaaaaaaaaaaa");
	String czyid = (String) session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	
	String id_list = getStr(request.getParameter("id_list"));
	String begin_id_list = getStr(request.getParameter("begin_id_list"));
	String cfrp_id_list = getStr(request.getParameter("cfrp_id_list"));
	String invoice_type_list = getStr(request.getParameter("invoice_type_list"));
	String tax_type_list = getStr(request.getParameter("tax_type_list"));
	String tax_type_invoice_list = getStr(request.getParameter("tax_type_invoice_list"));
	String rent_list = getStr(request.getParameter("rent_list"));
	String interest_list = getStr(request.getParameter("interest_list")); 
	String corpus_list = getStr(request.getParameter("corpus_list")); 
	String rent_num_list = getStr(request.getParameter("rent_num_list")); 
	
	//ResultSet rs;
	String [] id_arr =id_list.split("#");
	String [] begin_arr =begin_id_list.split("#");
	String [] cfrp_arr = cfrp_id_list.split("#");
	String [] invoice_type_arr =invoice_type_list.split("#");
	String [] tax_type_arr = tax_type_list.split("#");	
	String [] tax_type_invoice_arr = tax_type_invoice_list.split("#");
	String [] rent_arr =rent_list.split("#");
	String [] interest_arr = interest_list.split("#");
	String [] corpus_arr = corpus_list.split("#");
	String [] rent_num_arr = rent_num_list.split("#");
	
	
	String message = "本次开票"+id_arr.length+"条;";
	for(int i=0;i<id_arr.length;i++){
		String	 sql="";
		String billtype="";
		if("收据".equals(tax_type_arr[i])){
			billtype="receipt";
		}else{
			billtype="invoice";
		}
		if("先开，租金总额发票".equals(invoice_type_arr[i])){
			sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,"+
						 " tax_type_invoice,invoice_status,bill_type,rent_type,invoice_money,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+cfrp_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"invoice"		+"',";
				   sql+="'"+"租金"			+"',";
				   sql+="'"+rent_arr[i]		+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
		}else if("先开，本金收据，利息发票".equals(invoice_type_arr[i])){
			sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,"+
						 " tax_type_invoice,invoice_status,bill_type,rent_type,invoice_money,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+cfrp_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"receipt"		+"',";
				   sql+="'"+"本金"			+"',";
				   sql+="'"+corpus_arr[i]		+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
				   
			sql += " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,"+
						 " tax_type_invoice,invoice_status,bill_type,rent_type,invoice_money,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+cfrp_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"invoice"		+"',";
				   sql+="'"+"利息"			+"',";
				   sql+="'"+interest_arr[i]		+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
			
		}else if("先开，本利分开".equals(invoice_type_arr[i])){
			sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,"+
						 " tax_type_invoice,invoice_status,bill_type,rent_type,invoice_money,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+cfrp_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"invoice"		+"',";
				   sql+="'"+"本金"			+"',";
				   sql+="'"+corpus_arr[i]		+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
				   
			sql += " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,"+
						 " tax_type_invoice,invoice_status,bill_type,rent_type,invoice_money,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+cfrp_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"invoice"		+"',";
				   sql+="'"+"利息"			+"',";
				   sql+="'"+interest_arr[i]		+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
			
		}else	if("先开，本金收据，利息发票，另加总额收据".equals(invoice_type_arr[i])){
			sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,"+
						 " tax_type_invoice,invoice_status,bill_type,rent_type,invoice_money,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+cfrp_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"receipt"		+"',";
				   sql+="'"+"本金"			+"',";
				   sql+="'"+corpus_arr[i]		+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
				   
			sql += " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,"+
						 " tax_type_invoice,invoice_status,bill_type,rent_type,invoice_money,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+cfrp_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"invoice"		+"',";
				   sql+="'"+"利息"			+"',";
				   sql+="'"+interest_arr[i]		+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
			
			sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,"+
						 " tax_type_invoice,invoice_status,bill_type,rent_type,invoice_money,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+cfrp_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"receipt"		+"',";
				   sql+="'"+"租金"			+"',";
				   sql+="'"+rent_arr[i]		+"',";				   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
		}else{
			sql="";
		}
		int  num=0;
			num = db.executeUpdate(sql);
			if(num==0){
				message +="合同号："+begin_arr[i]+rent_num_arr[i]+"条发票申请失败;";
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
