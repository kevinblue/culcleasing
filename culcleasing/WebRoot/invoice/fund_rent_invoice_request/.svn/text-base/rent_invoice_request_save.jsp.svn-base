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
	String contract_id_list = getStr(request.getParameter("contract_id_list"));
	String invoice_type_list = getStr(request.getParameter("invoice_type_list"));
	String tax_type_list = getStr(request.getParameter("tax_type_list"));
	String tax_type_invoice_list = getStr(request.getParameter("tax_type_invoice_list"));
	String tax_rate_list = getStr(request.getParameter("tax_rate_list"));
	String rent_list = getStr(request.getParameter("rent_list"));
	String interest_list = getStr(request.getParameter("interest_list")); 
	String corpus_list = getStr(request.getParameter("corpus_list")); 
	String rent_num_list = getStr(request.getParameter("rent_num_list")); 
	String invoice_statues_list = getStr(request.getParameter("invoice_statues_list")); 
	
	
	//ResultSet rs;
	String [] id_arr =id_list.split("#");
	String [] begin_arr =begin_id_list.split("#");
	String [] contract_arr = contract_id_list.split("#");
	String [] invoice_type_arr =invoice_type_list.split("#");
	String [] tax_type_arr = tax_type_list.split("#");	
	String [] tax_type_invoice_arr = tax_type_invoice_list.split("#");
	String [] tax_rate_arr = tax_rate_list.split("#");
	String [] rent_arr =rent_list.split("#");
	String [] interest_arr = interest_list.split("#");
	String [] corpus_arr = corpus_list.split("#");
	String [] rent_num_arr = rent_num_list.split("#");
	String [] invoice_statues_arr = invoice_statues_list.split("#");
	String confirm_user = getStr(request.getParameter("confirm_user")); 
		
	System.out.println("confirm_user:"+confirm_user);
	System.out.println(id_arr.length+"---"+begin_arr.length);
	System.out.println(contract_arr.length+"---"+invoice_type_arr.length);
	System.out.println(tax_type_arr.length+"---"+tax_type_invoice_arr.length);
	System.out.println(tax_rate_arr.length+"---"+rent_arr.length);
	System.out.println(interest_arr.length+"---"+corpus_arr.length);
	System.out.println(rent_num_arr.length+"---"+invoice_statues_arr.length);
	
	
	String message = "本次开票"+id_arr.length+"条;";
	String   invoice_type_name1="先开，租金总额发票";
	String   invoice_type_name2="后开，租金总额发票";
	String   invoice_type_name3="先开，本金收据，利息发票";
	String   invoice_type_name4="后开，本金收据，利息发票";
	String   invoice_type_name5="先开，本利分开";
	String   invoice_type_name6="后开，本利分开";
	String   invoice_type_name7="先开，本金收据，利息发票，另加总额收据";
	String   invoice_type_name8="后开，本金收据，利息发票，另加总额收据";
	String   invoice_type_name9="全额收据";
	String   invoice_type_name10="全额收据，本利分开";
	
	for(int i=0;i<id_arr.length;i++){
	if( (invoice_type_arr[i]).equals("") ){
		message="发票开具方式为空,开票不";
    break;
	}
	if( (tax_type_invoice_arr[i]).equals("") ){
		message="发票类型为空,开票不";
    break;
	}
		String  remarkname=getStr(request.getParameter("invoice_remark_"+id_arr[i]));
		String	 sql="";
		String billtype="";
		if("收据".equals(tax_type_invoice_arr[i])){
			billtype="receipt";
		}else{
			billtype="invoice";
		}
		if("未申请".equals(invoice_statues_arr[i])){
			if(invoice_type_name1.equals(invoice_type_arr[i])||invoice_type_name2.equals(invoice_type_arr[i])){
				
				sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
							 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
							 "confirm_user,creator,create_date,modificator,modify_date) "+
							 " values(";
					   sql+="'"+begin_arr[i] +"',";
					   sql+="'"+id_arr[i]		+"',";
					   sql+="'"+contract_arr[i]		+"',";
					   sql+="'"+tax_type_arr[i] +"',";
					   sql+="'"+tax_type_invoice_arr[i] +"',";
					   sql+="'"+rent_num_arr[i] +"',";
					   sql+="'"+"2"				+"',";
					   sql+="'"+"invoice"		+"',";
					   sql+="'"+"租金"			+"',";
					   sql+="'"+rent_arr[i]		+"',";	
					   sql+="'"+remarkname		+"',";	
					   sql+="'"+confirm_user	+"',";	
					   sql+="'"+czyid			+"',";
					   sql+="'"+datestr			+"',";
					   sql+="'"+"null"			+"',";
					   sql+="null";
					   sql+=")";
			}else if(invoice_type_name3.equals(invoice_type_arr[i])||invoice_type_name4.equals(invoice_type_arr[i])){
				sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
							 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
							 "confirm_user,creator,create_date,modificator,modify_date) "+
							 " values(";
					   sql+="'"+begin_arr[i] +"',";
					   sql+="'"+id_arr[i]		+"',";
					   sql+="'"+contract_arr[i]		+"',";
					   sql+="'"+tax_type_arr[i] +"',";
					   sql+="'"+tax_type_invoice_arr[i] +"',";
					   sql+="'"+rent_num_arr[i] +"',";
					   sql+="'"+"2"				+"',";
					   sql+="'"+"receipt"		+"',";
					   sql+="'"+"本金"			+"',";
					   sql+="'"+corpus_arr[i]		+"',";	
					   sql+="'"+remarkname		+"',";	
					   sql+="'"+confirm_user	+"',";						   
					   sql+="'"+czyid			+"',";
					   sql+="'"+datestr			+"',";
					   sql+="'"+"null"			+"',";
					   sql+="null";
					   sql+=")";
					   
				sql += " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
							 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
							 "confirm_user,creator,create_date,modificator,modify_date) "+
							 " values(";
					   sql+="'"+begin_arr[i] +"',";
					   sql+="'"+id_arr[i]		+"',";
					   sql+="'"+contract_arr[i]		+"',";
					   sql+="'"+tax_type_arr[i] +"',";
					   sql+="'"+tax_type_invoice_arr[i] +"',";
					   sql+="'"+rent_num_arr[i] +"',";
					   sql+="'"+"2"				+"',";
					   sql+="'"+"invoice"		+"',";
					   sql+="'"+"利息"			+"',";
					   sql+="'"+interest_arr[i]		+"',";
					   sql+="'"+remarkname		+"',";	
					   sql+="'"+confirm_user	+"',";						   
					   sql+="'"+czyid			+"',";
					   sql+="'"+datestr			+"',";
					   sql+="'"+"null"			+"',";
					   sql+="null";
					   sql+=")";
				
			}else if(invoice_type_name5.equals(invoice_type_arr[i])||invoice_type_name6.equals(invoice_type_arr[i])){
				sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
							 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
							 "confirm_user,creator,create_date,modificator,modify_date) "+
							 " values(";
					   sql+="'"+begin_arr[i] +"',";
					   sql+="'"+id_arr[i]		+"',";
					   sql+="'"+contract_arr[i]		+"',";
					   sql+="'"+tax_type_arr[i] +"',";
					   sql+="'"+tax_type_invoice_arr[i] +"',";
					   sql+="'"+rent_num_arr[i] +"',";
					   sql+="'"+"2"				+"',";
					   sql+="'"+"invoice"		+"',";
					   sql+="'"+"本金"			+"',";
					   sql+="'"+corpus_arr[i]		+"',";	
					   sql+="'"+remarkname		+"',";	
					   sql+="'"+confirm_user	+"',";						   
					   sql+="'"+czyid			+"',";
					   sql+="'"+datestr			+"',";
					   sql+="'"+"null"			+"',";
					   sql+="null";
					   sql+=")";
					   
				sql += " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
							 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
							 "confirm_user,creator,create_date,modificator,modify_date) "+
							 " values(";
					   sql+="'"+begin_arr[i] +"',";
					   sql+="'"+id_arr[i]		+"',";
					   sql+="'"+contract_arr[i]		+"',";
					   sql+="'"+tax_type_arr[i] +"',";
					   sql+="'"+tax_type_invoice_arr[i] +"',";
					   sql+="'"+rent_num_arr[i] +"',";
					   sql+="'"+"2"				+"',";
					   sql+="'"+"invoice"		+"',";
					   sql+="'"+"利息"			+"',";
					   sql+="'"+interest_arr[i]		+"',";
					   sql+="'"+remarkname		+"',";	
					   sql+="'"+confirm_user	+"',";						   
					   sql+="'"+czyid			+"',";
					   sql+="'"+datestr			+"',";
					   sql+="'"+"null"			+"',";
					   sql+="null";
					   sql+=")";
				
			}else	if(invoice_type_name7.equals(invoice_type_arr[i])||invoice_type_name8.equals(invoice_type_arr[i])){
				sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
							 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
							 "confirm_user,creator,create_date,modificator,modify_date) "+
							 " values(";
					   sql+="'"+begin_arr[i] +"',";
					   sql+="'"+id_arr[i]		+"',";
					   sql+="'"+contract_arr[i]		+"',";
					   sql+="'"+tax_type_arr[i] +"',";
					   sql+="'"+tax_type_invoice_arr[i] +"',";
					   sql+="'"+rent_num_arr[i] +"',";
					   sql+="'"+"2"				+"',";
					   sql+="'"+"receipt"		+"',";
					   sql+="'"+"本金"			+"',";
					   sql+="'"+corpus_arr[i]		+"',";	
					   sql+="'"+remarkname		+"',";	
					   sql+="'"+confirm_user	+"',";						   
					   sql+="'"+czyid			+"',";
					   sql+="'"+datestr			+"',";
					   sql+="'"+"null"			+"',";
					   sql+="null";
					   sql+=")";
					   
				sql += " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
							 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
							 "confirm_user,creator,create_date,modificator,modify_date) "+
							 " values(";
					   sql+="'"+begin_arr[i] +"',";
					   sql+="'"+id_arr[i]		+"',";
					   sql+="'"+contract_arr[i]		+"',";
					   sql+="'"+tax_type_arr[i] +"',";
					   sql+="'"+tax_type_invoice_arr[i] +"',";
					   sql+="'"+rent_num_arr[i] +"',";
					   sql+="'"+"2"				+"',";
					   sql+="'"+"invoice"		+"',";
					   sql+="'"+"利息"			+"',";
					   sql+="'"+interest_arr[i]		+"',";	
					   sql+="'"+remarkname		+"',";	
					   sql+="'"+confirm_user	+"',";						   
					   sql+="'"+czyid			+"',";
					   sql+="'"+datestr			+"',";
					   sql+="'"+"null"			+"',";
					   sql+="null";
					   sql+=")";
				
				sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
							 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
							 "confirm_user,creator,create_date,modificator,modify_date) "+
							 " values(";
					   sql+="'"+begin_arr[i] +"',";
					   sql+="'"+id_arr[i]		+"',";
					   sql+="'"+contract_arr[i]		+"',";
					   sql+="'"+tax_type_arr[i] +"',";
					   sql+="'"+tax_type_invoice_arr[i] +"',";
					   sql+="'"+rent_num_arr[i] +"',";
					   sql+="'"+"2"				+"',";
					   sql+="'"+"receipt"		+"',";
					   sql+="'"+"租金"			+"',";
					   sql+="'"+rent_arr[i]		+"',";	
					   sql+="'"+remarkname		+"',";	
					   sql+="'"+confirm_user	+"',";						   
					   sql+="'"+czyid			+"',";
					   sql+="'"+datestr			+"',";
					   sql+="'"+"null"			+"',";
					   sql+="null";
					   sql+=")";
			}else if(invoice_type_name9.equals(invoice_type_arr[i])){
			sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
						 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
						 "confirm_user,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+id_arr[i]		+"',";
				   sql+="'"+contract_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+rent_num_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"receipt"		+"',";
				   sql+="'"+"租金"			+"',";
				   sql+="'"+rent_arr[i]		+"',";	
				   sql+="'"+remarkname		+"',";	
				   sql+="'"+confirm_user	+"',";					   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
			}else if(invoice_type_name10.equals(invoice_type_arr[i])){
			sql = " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,contract_id,tax_type,"+
						 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
						 "confirm_user,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+id_arr[i]		+"',";
				   sql+="'"+contract_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+rent_num_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"receipt"		+"',";
				   sql+="'"+"本金"			+"',";
				   sql+="'"+corpus_arr[i]		+"',";	
				   sql+="'"+remarkname		+"',";	
				   sql+="'"+confirm_user	+"',";					   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
				   
			sql += " insert  into  [dbo].[rent_invoice_info](begin_id,contract_fund_rent_plan,tax_type,contract_id,"+
						 " tax_type_invoice,rent_list,invoice_status,bill_type,rent_type,invoice_money,invoice_remark,"+
						 "confirm_user,creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+begin_arr[i] +"',";
				   sql+="'"+id_arr[i]		+"',";
				   sql+="'"+contract_arr[i]		+"',";
				   sql+="'"+tax_type_arr[i] +"',";
				   sql+="'"+tax_type_invoice_arr[i] +"',";
				   sql+="'"+rent_num_arr[i] +"',";
				   sql+="'"+"2"				+"',";
				   sql+="'"+"receipt"		+"',";
				   sql+="'"+"利息"			+"',";
				   sql+="'"+interest_arr[i]		+"',";	
				   sql+="'"+remarkname		+"',";	
				   sql+="'"+confirm_user	+"',";					   
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
			
			}else{
				sql="";
			}
		}else{
			if(invoice_type_name1.equals(invoice_type_arr[i])||invoice_type_name2.equals(invoice_type_arr[i])){					   
					sql = "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+rent_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='invoice'";
					sql+=" and rent_type='租金'";
			}else if(invoice_type_name3.equals(invoice_type_arr[i])||invoice_type_name4.equals(invoice_type_arr[i])){
					sql = "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+corpus_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='receipt'";
					sql+=" and rent_type='本金'";
					   
					sql+= "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+interest_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='invoice'";
					sql+=" and rent_type='利息'";
				
			}else if(invoice_type_name5.equals(invoice_type_arr[i])||invoice_type_name6.equals(invoice_type_arr[i])){					 
					sql = "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+corpus_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='invoice'";
					sql+=" and rent_type='本金'";			   
					
					sql+= "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+interest_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='invoice'";
					sql+=" and rent_type='利息'";
				
			}else	if(invoice_type_name7.equals(invoice_type_arr[i])||invoice_type_name8.equals(invoice_type_arr[i])){   
					sql= "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+corpus_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='receipt'";
					sql+=" and rent_type='本金'";
					
					sql+= "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+interest_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='invoice'";
					sql+=" and rent_type='利息'";
					  
					sql+= "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+rent_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='receipt'";
					sql+=" and rent_type='租金'";
				
			}else if(invoice_type_name9.equals(invoice_type_arr[i])){		
				   	sql= "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+rent_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='receipt'";
					sql+=" and rent_type='租金'";
			}else if(invoice_type_name10.equals(invoice_type_arr[i])){
				   	sql= "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+corpus_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='receipt'";
					sql+=" and rent_type='本金'";
					
				    sql+= "update [dbo].[rent_invoice_info]  set ";
					sql+="tax_type='"+tax_type_arr[i] +"',";
					sql+="tax_type_invoice='"+tax_type_invoice_arr[i] +"',";
					sql+="invoice_status='"+"2" +"',";
					sql+="invoice_money='"+interest_arr[i] +"',";					
					sql+="invoice_remark='"+remarkname +"',";
					sql+="confirm_user='"+confirm_user +"',";
					sql+="modificator='"+czyid +"',";
					sql+="modify_date='"+datestr +"'";				
					sql+=" where  contract_fund_rent_plan='"+id_arr[i]+"' and contract_id='"+contract_arr[i] +"'";
					sql+=" and begin_id='"+begin_arr[i]+"'";
					sql+=" and bill_type='receipt'";
					sql+=" and rent_type='利息'";		
			}else{
				sql="";
			}
		
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
		//window.opener.location.reload();
		//window.opener=null;
		//window.open("","_self");
	//	setTimeout("self.close()",100);
		
		opener.location.reload();
	
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();
		
		} 
	 else{history.back()}
		
		
	</script>
