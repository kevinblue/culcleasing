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
String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );

String rate = getStr( request.getParameter("rate") );

String sqlstr = "";
String datestr = getSystemDate(0); //��ȡϵͳʱ��
int flag = 0;

if ( stype.equals("mod") ){        //��Ӳ���
	//���ж����ݿ����Ƿ����
	sqlstr = "update financing_config_rate set rate='"+rate+"',";
	sqlstr+= "modificator='"+dqczy+"',modify_date='"+datestr+"'";

	flag = db.executeUpdate(sqlstr);
	//��������insert
	if(flag<=0){
		sqlstr = "insert into financing_config_rate(rate,creator,create_date,modificator,modify_date)";
		sqlstr += " values('"+rate+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
		flag = db.executeUpdate(sqlstr);
	}
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "ϵͳ��Ϣά��", "����ά��", "�޸�����Ϊ��"+rate+" �޸��û�Id��"+dqczy, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
}
db.close();

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("���µ�ǰ���ʳɹ�!");
		opener.location.reload();
		//window.opener="";
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("���µ�ǰ����ʧ��!");
		opener.location.reload();
//		window.opener="";
	</script>
<%} %>
</BODY>
</HTML>
