<%@ page contentType="text/html; charset=gbk" language="java"%>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
	//0.��������
	String user_id = (String)session.getAttribute("czyid");//��ǰ��½��
    String datestr = getSystemDate(0); //��ȡϵͳʱ��
	//1.1==��ȡ����
	String doc_id = getStr(request.getParameter("doc_id")); //�ĵ���� measure_id
    String contract_id = getStr(request.getParameter("contract_id")); //��ͬ���
    String begin_id = getStr(request.getParameter("begin_id")); //������
    String hire_date = getStr(request.getParameter("hireDate")); //��������
	
    String sqlstr = "";
    ResultSet rs = null;
    int flag = 0;

    sqlstr = " Exec dbo.Flow_QZOffFirstRent_Oper '"+contract_id+"','"+begin_id+"','"+doc_id+"','"+hire_date+"','"+user_id+"'";
    flag = db.executeUpdate(sqlstr);
	
	LogWriter.logDebug(request, "�����ʽ��ֵ�һ��������������");
		
	db.close();
if(flag>0){
%>
    <script type="text/javascript">
		alert("��һ������ֺ����ɹ�!");
		opener.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("��һ������ֺ���ʧ��!");
		opener.location.reload();
		this.close();
	</script>
<%	
}
%>
