<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@ page import="com.tenwa.log.LogWriter"%>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%


//��ȡ��������
String title = getStr( request.getParameter("title") );
String exchange_rate= getStr( request.getParameter("exchange_rate") );


int flag = 0;
String msg = "";
//1.��ɾ��
sqlstr="delete from base_currency where currency_name='"+title+"'";
flag=db.executeUpdate(sqlstr);
//2.�����
String sqlStr1="insert into base_currency(currency_name,exchange_rate) values('"+title+"','"+exchange_rate+"')";
flag+=db.executeUpdate(sqlStr1);
	
	msg = "�����޸�";


//3�����ж�
if(flag>0){%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>�ɹ�!");
		window.opener.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>ʧ��!");
		window.opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>