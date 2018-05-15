<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

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

//��ȡ����
String proj_id;
String raiser;
String dutier;
String raiser_date;
String operation_dept;
String flow;
String idea;
String plan_date;
String check_man;
//request.setChara
proj_id = getStr( request.getParameter("proj_id") );
raiser = getStr( request.getParameter("raiser") );
dutier=getStr( request.getParameter("dutier") );
//System.out.println("aaaaaaaaaaaaaaaaaa"+dutier);
raiser_date = getStr( request.getParameter("raiser_date") );
operation_dept = getStr( request.getParameter("operation_dept") );
flow = getStr( request.getParameter("flow") );
idea = getStr( request.getParameter("idea") );
System.out.println("aaaaaaaaaaaaaaaaaa"+idea);
plan_date = getStr( request.getParameter("plan_date") );
check_man=getStr( request.getParameter("check_man") );
String sqlstr;
String datestr = getSystemDate(0); //��ȡϵͳʱ��
int flag = 0;
String msg = "";
if ( stype.equals("add") ){        //���Ӳ���
	//insert
	sqlstr = "insert into opinion_execution(proj_id,raiser,dutier,raiser_date,idea,check_man,operation_dept,flow,status,creator,create_date,modificator,modify_date,plan_date)";
	sqlstr += " values('"+proj_id+"','"+raiser+"','"+dutier+"','"+raiser_date+"','"+idea+"','"+check_man+"','"+operation_dept+"','"+flow+"',0,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"','"+plan_date+"')";
	System.out.println("����===="+sqlstr);
	flag = db.executeUpdate(sqlstr);
	
	//String sqlLog = LogWriter.getSqlIntoDB(request, "��������", "���ִ�м��", "������Ŀ��"+proj_id+" ���������ˣ�"+raiser, sqlstr);
	//db.executeUpdate(sqlLog);
	db.close();
	
	msg = "������Ŀִ�����";
}else if("del".equals(stype)){//ɾ�����
	String item_id = getStr( request.getParameter("item_id") );

	sqlstr = "delete from opinion_execution where id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	
	//String sqlLog = LogWriter.getSqlIntoDB(request, "��������", "���ִ�м��", "ɾ����Ŀ�����id��Ϊ��"+item_id, sqlstr);
	//db.executeUpdate(sqlLog);
	db.close();
	
	msg = "ɾ����Ŀִ�����";
}else if ("mod".equals(stype)){//�޸�
	String kid =  getStr( request.getParameter("kid") );
	
	sqlstr = "update opinion_execution set raiser='"+raiser+"',dutier='"+dutier+"',raiser_date='"+raiser_date+"',operation_dept='"+operation_dept+"',flow='"+flow+"',idea='"+idea+"',modificator='"+dqczy+"',modify_date='"+datestr+"',plan_date='"+plan_date+"' where id='"+kid+"'";
	flag = db.executeUpdate(sqlstr);
	
	//String sqlLog = LogWriter.getSqlIntoDB(request, "��������", "���ִ�м��", "�޸���Ŀ�����id��Ϊ��"+kid, sqlstr);
	//db.executeUpdate(sqlLog);
	db.close();
	
	msg = "�޸���Ŀִ�����";
}else if ("sucPre".equals(stype)){//ִ��
	String kid =  getStr( request.getParameter("kid") );
	String result =  getStr( request.getParameter("result") );
	String end_time =  getStr( request.getParameter("end_time") );
	String remark =  getStr( request.getParameter("remark") );
	
	sqlstr = "update opinion_execution set status=2,result='"+result+"',end_time='"+end_time+"',remark='"+remark+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+kid+"'";
	flag = db.executeUpdate(sqlstr);
	
	//String sqlLog = LogWriter.getSqlIntoDB(request, "��������", "���ִ�м��", "��Ŀ�����ɣ�id��Ϊ��"+kid, sqlstr);
	//db.executeUpdate(sqlLog);
	db.close();
	
	msg = "��Ŀ�Ѿ�ִ�У��ȴ�ȷ��";
}else if ("suc".equals(stype)){//���
	String kid =  getStr( request.getParameter("kid") );
	//String result =  getStr( request.getParameter("result") );
	//String end_time =  getStr( request.getParameter("end_time") );
	//String remark =  getStr( request.getParameter("remark") );
	
	sqlstr = "update opinion_execution set status=1,modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+kid+"'";
	flag = db.executeUpdate(sqlstr);
	
	//String sqlLog = LogWriter.getSqlIntoDB(request, "��������", "���ִ�м��", "��Ŀ�����ɣ�id��Ϊ��"+kid, sqlstr);
	//db.executeUpdate(sqlLog);
	db.close();
	
	msg = "ȷ�������Ŀִ�����";
}

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