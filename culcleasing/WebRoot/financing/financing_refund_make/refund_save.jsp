<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.financing.util.FinancingCalcUtil"%>
<%@page import="com.tenwa.culc.financing.util.FinancingRefundPlan"%> 
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
String dqczy = (String) session.getAttribute("czyid");
String datestr = getSystemDate(0); //获取系统时间
String stype = getStr( request.getParameter("savetype") );

String sqlstr = "";
ResultSet rs = null;
int flag = 0;
String msg = "";

if ( stype.equals("addRefund") ){//添加还款计划
	String drawings_id = getStr( request.getParameter("drawings_id") );
	String doc_id = getStr( request.getParameter("doc_id") );
	String drawings_fact_rate = getStr( request.getParameter("drawings_fact_rate") );
	String refund_list = getStr( request.getParameter("refund_list") );
	String refund_plan_date = getStr( request.getParameter("refund_plan_date") );
	String refund_corpus = getStr( request.getParameter("refund_corpus") );
	String refund_interest = getStr( request.getParameter("refund_interest") );
	String refund_money = getStr( request.getParameter("refund_money") );
	String refund_otherfee_money = getStr( request.getParameter("refund_otherfee_money") );
	String refund_otherfee_type = getStr( request.getParameter("refund_otherfee_type") );
	String refund_subtotal = getStr( request.getParameter("refund_subtotal") );
	String remark = getStr( request.getParameter("remark") );
	
	//插入数据
	sqlstr = "Insert into financing_refund_plan_temp(doc_id,drawings_id,refund_list,refund_plan_date,";
	sqlstr+= " refund_rate,refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,";
	sqlstr+= "refund_subtotal,refund_status,remark)";
	sqlstr+= " Select '"+doc_id+"','"+drawings_id+"','"+refund_list+"','"+refund_plan_date+"','"+drawings_fact_rate+"','"+refund_corpus+"', ";
	sqlstr+= " '"+refund_interest+"','"+refund_money+"','"+refund_otherfee_money+"','"+refund_otherfee_type+"','"+refund_subtotal+"','未还款','"+remark+"' ";
	
	LogWriter.logDebug(request, "新增还款计划数据："+sqlstr);
	flag = db.executeUpdate(sqlstr); 
	msg = "添加还款计划";
}else if ( stype.equals("delRefund") ){//删除还款计划
	String doc_id = getStr( request.getParameter("doc_id") );
	String item_id = getStr( request.getParameter("item_id") );
	sqlstr = "Delete from financing_refund_plan_temp where refund_plan_id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "删除还款计划";
}else if ( stype.equals("updRefund") ){//修改还款计划
	String item_id = getStr( request.getParameter("item_id") );
	String refund_plan_date = getStr( request.getParameter("refund_plan_date") );
	String refund_corpus = getStr( request.getParameter("refund_corpus") );
	String refund_interest = getStr( request.getParameter("refund_interest") );
	String refund_money = getStr( request.getParameter("refund_money") );
	String refund_otherfee_money = getStr( request.getParameter("refund_otherfee_money") );
	String refund_otherfee_type = getStr( request.getParameter("refund_otherfee_type") );
	String refund_subtotal = getStr( request.getParameter("refund_subtotal") );
	String remark = getStr( request.getParameter("remark") );
	
	sqlstr = "Update financing_refund_plan_temp set refund_plan_date='"+refund_plan_date+"',refund_corpus='"+refund_corpus+"',";
	sqlstr+= " refund_interest='"+refund_interest+"',refund_money='"+refund_money+"',refund_otherfee_money='"+refund_otherfee_money+"',";
	sqlstr+= " refund_otherfee_type='"+refund_otherfee_type+"',refund_subtotal='"+refund_subtotal+"',remark='"+remark+"' ";
	sqlstr+= " Where refund_plan_id='"+item_id+"'";
	
	flag = db.executeUpdate(sqlstr);
	msg = "修改还款计划";
}else if( "autoMake".equals(stype) ){
	//获取自动计算参数
	String drawings_id = getStr( request.getParameter("drawings_id") );
	String doc_id = getStr( request.getParameter("doc_id") );
	
	String lease_money = getStr( request.getParameter("lease_money") );
	String start_date = getStr( request.getParameter("start_date") );
	String rate = getStr( request.getParameter("rate") );
	String leasTerm = getStr( request.getParameter("leasTerm") );
	String income_number_year = getStr( request.getParameter("income_number_year") );
	//CLear Data Before Insert
	sqlstr = "Delete from financing_refund_plan_temp where drawings_id='"+drawings_id+"'";
	flag = db.executeUpdate(sqlstr);

	//开始测算	
	FinancingCalcUtil financCU = new FinancingCalcUtil();
	List<FinancingRefundPlan> financList = financCU.calcPlan(drawings_id, doc_id, lease_money,leasTerm, income_number_year,rate,"0", start_date);
	
	//保存FinancList
	msg = "测算还款计划";
	sqlstr = "";
	FinancingRefundPlan financPlan = null;
	for(int i=0;i<financList.size();i++){
		//插入数据
		financPlan = financList.get(i);
		
		sqlstr = "Insert into financing_refund_plan_temp(doc_id,drawings_id,refund_list,refund_plan_date,";
		sqlstr+= " refund_rate,refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,";
		sqlstr+= "refund_subtotal,refund_status,remark)";
		sqlstr+= " Select '"+doc_id+"','"+drawings_id+"','"+financPlan.getRefund_list()+"','"+financPlan.getRefund_plan_date()+"',";
		sqlstr+= " '"+financPlan.getRefund_rate()+"','"+financPlan.getRefund_corpus()+"','"+financPlan.getRefund_interest()+"',";
		sqlstr+= " '"+financPlan.getRefund_money()+"','"+financPlan.getRefund_otherfee_money()+"','"+financPlan.getRefund_otherfee_type()+"',";
		sqlstr+= " '"+financPlan.getRefund_subtotal()+"','"+financPlan.getRefund_status()+"','"+financPlan.getRemark()+"'";

		LogWriter.logDebug(request, "新增还款计划数据："+sqlstr);
		flag += db.executeUpdate(sqlstr); 
	}

}
db.close();

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>成功!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
