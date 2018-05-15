<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.log.LogWriter"%> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//��������
String dqczy = (String) session.getAttribute("czyid");
String datestr = getSystemDate(0); //��ȡϵͳʱ��
String stype = getStr( request.getParameter("savetype") );

String sqlstr = "";
ResultSet rs = null;
int flag = 0;
String msg = "";

if ( stype.equals("addRefund") ){//��ӻ���ƻ�
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
	
	//��������
	sqlstr = "Insert into financing_refund_plan_temp(doc_id,drawings_id,refund_list,refund_plan_date,";
	sqlstr+= " refund_rate,refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,";
	sqlstr+= "refund_subtotal,remark)";
	sqlstr+= " Select '"+doc_id+"','"+drawings_id+"','"+refund_list+"','"+refund_plan_date+"','"+drawings_fact_rate+"','"+refund_corpus+"', ";
	sqlstr+= " '"+refund_interest+"','"+refund_money+"','"+refund_otherfee_money+"','"+refund_otherfee_type+"','"+refund_subtotal+"','"+remark+"' ";
	
	LogWriter.logDebug(request, "��������ƻ����ݣ�"+sqlstr);
	flag = db.executeUpdate(sqlstr); 
	msg = "��ӻ���ƻ�";
}else if ( stype.equals("delRefund") ){//ɾ������ƻ�
	String doc_id = getStr( request.getParameter("doc_id") );
	String item_id = getStr( request.getParameter("item_id") );
	sqlstr = "Delete from financing_refund_plan_temp where refund_plan_id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "ɾ������ƻ�";
}else if ( stype.equals("updRefund") ){//�޸Ļ���ƻ�
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
	msg = "�޸Ļ���ƻ�";
}
db.close();

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>�ɹ�!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>ʧ��!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
