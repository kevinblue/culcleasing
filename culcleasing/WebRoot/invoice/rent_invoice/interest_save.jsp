<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
	
//��ȡ��������
String id = getStr( request.getParameter("item_id") );//id���
String interest=getStr( request.getParameter("interest"));




//��������
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//��ǰ��½��
String datestr = getSystemDate(0); //��ȡϵͳʱ��

int flag = 0;
	sqlstr = "update report_month_plan_accrued_temp set interest='"+interest+"' where id='"+id+"'";
	System.out.print("sql"+sqlstr);
	flag = db.executeUpdate(sqlstr);
db.close();

//3�����ж�

if(flag>0){%>
	<script type="text/javascript">
		window.close();
		opener.alert("�޸���Ϣ�ɹ�!");
		opener.location.reload();
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("�޸���Ϣʧ��!");
		opener.location.reload()
	</script>
<%} %>
</BODY>
</HTML>
