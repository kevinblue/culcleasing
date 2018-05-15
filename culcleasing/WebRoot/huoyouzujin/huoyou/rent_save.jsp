<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.tenwa.culc.util.CommonTool"%> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//基础参数
String sysDate = getSystemDate(0);						   //当前时间
String user_id = (String)session.getAttribute("czyid");    //当前登陆人
//获取传递的参数
String contract_id =getStr(request.getParameter("contract_id"));
String doc_id= getStr(request.getParameter("doc_id"));
String flag= getStr(request.getParameter("flag"));

String rent_list =getStr(request.getParameter("rent_list"));
String equip_operation_revenue =getStr(request.getParameter("equip_operation_revenue"));
String proj_cost =getStr(request.getParameter("proj_cost"));
String leas_rent_start_date =getStr(request.getParameter("leas_rent_start_date"));
String leas_rent_end_date =getStr(request.getParameter("leas_rent_end_date"));
String income_hire_date =getStr(request.getParameter("income_hire_date"));
String plan_date =getStr(request.getParameter("plan_date"));

//--医院分成
String medi_base_income =getStr(request.getParameter("medi_base_income"));
String medi_other_outcome =getStr(request.getParameter("medi_other_outcome"));
String medi_other_income =getStr(request.getParameter("medi_other_income"));
String medi_fact_income =getStr(request.getParameter("medi_fact_income"));

//--管理公司分成
String mana_base_income =getStr(request.getParameter("mana_base_income"));
String mana_supp_culc_rent =getStr(request.getParameter("mana_supp_culc_rent"));
String mana_out_divide_income =getStr(request.getParameter("mana_out_divide_income"));
String mana_other_outcome =getStr(request.getParameter("mana_other_outcome"));
String mana_other_income =getStr(request.getParameter("mana_other_income"));
String mana_fact_income =getStr(request.getParameter("mana_fact_income"));

//--环球分成
String culc_base_income =getStr(request.getParameter("culc_base_income"));
String culc_floor_rent_income =getStr(request.getParameter("culc_floor_rent_income"));
String culc_out_divide_income =getStr(request.getParameter("culc_out_divide_income"));
String culc_other_outcome =getStr(request.getParameter("culc_other_outcome"));
String culc_other_income =getStr(request.getParameter("culc_other_income"));
String culc_fact_income =getStr(request.getParameter("culc_fact_income"));

String plan_bank_name =getStr(request.getParameter("plan_bank_name"));
String plan_bank_no =getStr(request.getParameter("plan_bank_no"));

//判断是否插入
int cFlag = 0;
String msg = "";
//1.0修改数据
String sqlstr = "";
if("1".equals(flag)){
	sqlstr = "Update fund_rent_plan_hy_medi_temp set equip_operation_revenue='"+equip_operation_revenue+"',leas_rent_start_date='"+leas_rent_start_date+"',leas_rent_end_date='"+leas_rent_end_date+"',";
	sqlstr +=" proj_cost='"+proj_cost+"',income_hire_date='"+income_hire_date+"',plan_date='"+plan_date+"',medi_base_income='"+medi_base_income+"',medi_other_outcome='"+medi_other_outcome+"',medi_other_income='"+medi_other_income+"',";
	sqlstr +=" medi_fact_income='"+medi_fact_income+"',mana_base_income='"+mana_base_income+"',mana_supp_culc_rent='"+mana_supp_culc_rent+"',mana_out_divide_income='"+mana_out_divide_income+"',mana_other_outcome='"+mana_other_outcome+"',";
	sqlstr +=" mana_other_income='"+mana_other_income+"',mana_fact_income='"+mana_fact_income+"',culc_base_income='"+culc_base_income+"',culc_floor_rent_income='"+culc_floor_rent_income+"',culc_out_divide_income='"+culc_out_divide_income+"',";
	sqlstr +=" culc_other_outcome='"+culc_other_outcome+"',culc_other_income='"+culc_other_income+"',culc_fact_income='"+culc_fact_income+"',";
	sqlstr +=" plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"',modificator='"+user_id+"',modify_date='"+sysDate+"' ";
	sqlstr +=" where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
	
	msg = "修改或有租金";
}else{
//2.0新增数据
	sqlstr = "Insert into fund_rent_plan_hy_medi_temp(uuid,doc_id,contract_id,rent_list,equip_operation_revenue,proj_cost,leas_rent_start_date,leas_rent_end_date,";
	sqlstr +=" income_hire_date,plan_date,medi_base_income,medi_other_outcome,medi_other_income,";
	sqlstr +=" medi_fact_income,mana_base_income,mana_supp_culc_rent,mana_out_divide_income,mana_other_outcome,mana_other_income,";
	sqlstr +=" mana_fact_income,culc_base_income,culc_floor_rent_income,culc_out_divide_income,culc_other_outcome,culc_other_income,";
	sqlstr +=" culc_fact_income,plan_status,plan_bank_name,plan_bank_no,creator,create_date,modificator,modify_date)";
	sqlstr +=" values('"+CommonTool.getUUID()+"','"+doc_id+"','"+contract_id+"','"+rent_list+"','"+equip_operation_revenue+"','"+proj_cost+"','"+leas_rent_start_date+"','"+leas_rent_end_date+"',";
	sqlstr +=" '"+income_hire_date+"','"+plan_date+"','"+medi_base_income+"','"+medi_other_outcome+"','"+medi_other_income+"',";
	sqlstr +=" '"+medi_fact_income+"','"+mana_base_income+"','"+mana_supp_culc_rent+"','"+mana_out_divide_income+"','"+mana_other_outcome+"','"+mana_other_income+"',";
	sqlstr +=" '"+mana_fact_income+"','"+culc_base_income+"','"+culc_floor_rent_income+"','"+culc_out_divide_income+"','"+culc_other_outcome+"','"+culc_other_income+"',";
	sqlstr +=" '"+culc_fact_income+"','未核销','"+plan_bank_name+"','"+plan_bank_no+"','"+user_id+"','"+sysDate+"','"+user_id+"','"+sysDate+"')";
	
	msg = "新增或有租金";
}

cFlag = db.executeUpdate(sqlstr);
	
db.close();
if(cFlag>0){
%>
    <script type="text/javascript">
		alert("<%=msg %>成功!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("<%=msg %>失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
}
%>
</BODY>
</HTML>
