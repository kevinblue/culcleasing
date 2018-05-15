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
	String cfpi_id_list = getStr(request.getParameter("cfpi_id_list"));
	String contract_id_list = getStr(request.getParameter("contract_id_list"));
	String tax_type_list = getStr(request.getParameter("tax_type_list"));
	String tax_type_invoice_list = getStr(request.getParameter("tax_type_invoice_list"));
	String money_list = getStr(request.getParameter("money_list")); 
	String fee_name_list = getStr(request.getParameter("fee_name_list")); 
	String fee_num_list = getStr(request.getParameter("fee_num_list")); 
	String invoice_statues_list = getStr(request.getParameter("invoice_statues_list")); 
	
	String confirm_user = getStr(request.getParameter("confirm_user")); 
	
	
	//ResultSet rs;
	String [] id_arr =  id_list.split("#");
	String [] cfpi_arr =  cfpi_id_list.split("#");
	String [] contract_arr = contract_id_list.split("#");
	String [] tax_type_arr = tax_type_list.split("#");
	String [] tax_type_invoice_arr = tax_type_invoice_list.split("#");
	String [] money_arr = money_list.split("#");
	String [] fee_name_arr = fee_name_list.split("#");
	String [] fee_num_arr = fee_num_list.split("#");
	String [] invoice_statues_arr = invoice_statues_list.split("#");
	
	String message = "本次开票"+id_arr.length+"条;";
	for(int i=0;i<id_arr.length;i++){
		String  remarkname=getStr(request.getParameter("invoice_remark_"+id_arr[i]));
		String billtype="";
		if("收据".equals(tax_type_invoice_arr[i])){
			billtype="receipt";
		}else{
			billtype="invoice";
		}		
		int  num=0;
		String	 sql ="";
		if(invoice_statues_arr[i].equals("未申请")){
			sql = " insert  into  [dbo].[fund_invoice_info](contract_id,contract_fund_plan,tax_type,tax_type_invoice,"+
						 " invoice_status,bill_type,invoice_money,invoice_remark,confirm_user,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+contract_arr[i] +"',";
				   sql+="'"+cfpi_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
					sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+billtype		+"',";
				   sql+="'"+money_arr[i]	+"',";
				   sql+="'"+remarkname		+"',";
				   sql+="'"+confirm_user	+"',";			   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
		}
		if(invoice_statues_arr[i].equals("已退回")){
			
					sql = "update [dbo].[fund_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="bill_type='"+billtype +"',";
					sql+="invoice_money='"+money_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_plan='"+cfpi_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
		}
			 
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
