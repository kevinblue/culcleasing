<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<%@ page import="java.sql.*"%>
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
String dqczy = (String) session.getAttribute("czyid");//��½��
String stype = getStr( request.getParameter("savetype") );//��������
System.out.println("��������"+stype);

//��ȡ����
String start_date=getStr( request.getParameter("start_date"));//��ʼ����
String end_date=getStr( request.getParameter("end_date"));//��������
String cash_money=getStr( request.getParameter("cash_money"));//������
String remark=getStr( request.getParameter("remark") );//��ע

String sqlstr;
String datestr = getSystemDate(0); //��ȡϵͳʱ��
int flag = 0;
String msg = "";
if ( stype.equals("add") ){        //��Ӳ���
	//insert
	sqlstr = "insert into dbo.financing_cash_flow(start_date,end_date,cash_money,remark,cash_flow_way,creator,create_date,modificator,modify_date)";
	sqlstr += " values('"+start_date+"','"+end_date+"','"+cash_money+"','"+remark+"','��������','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
	//System.out.println(sqlstr);
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "��������", "���������ƶ�", "������¼����Ա��"+dqczy, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "������������";
}else if("del".equals(stype)){//ɾ��
	String id = getStr( request.getParameter("id") );
	System.out.println("����id"+id);
	sqlstr = "delete from dbo.financing_cash_flow where id='"+id+"'";
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "��������", "���������ƶ�", "ɾ����id��Ϊ��"+id, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "ɾ��";
}else if ("mod".equals(stype)){//�޸�
	String id =  getStr( request.getParameter("id") );
	
	sqlstr = "update dbo.financing_cash_flow set start_date='"+start_date+"',end_date='"+end_date+"',cash_money='"+cash_money+"',remark='"+remark+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+id+"'";
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "��������", "���������ƶ�", "�޸ģ�id��Ϊ��"+id, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "�޸�";
}

if(flag>0){
%>
<script type="text/javascript">
	opener.alert("<%=msg%>�ɹ�!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
		<%
			} else {
		%>
		<script type="text/javascript">
		opener.alert("<%=msg%>ʧ��!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
		<%
			}
		%>
	</BODY>
</HTML>
