<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ - ִ�е�Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<BODY>
<%
	
	 
	List list_contr = new ArrayList();
	list_contr.add("033-ZL-JX-2010001");
	//************************************************************************************************
	//                                            �ֽ���
	//************************************************************************************************
	//���ú�̨�������е�Ϣʱ��������	
	System.out.println("join2^^^^^^^^^^==>join2");
	int flag = cashFlow.addCashFlow(list_contr, "43");
	System.out.println("��Ϣflag��ֵΪ==> :"+flag);

	
	//************************************************************************************************	
		
%>
	</BODY>
	</html>	    