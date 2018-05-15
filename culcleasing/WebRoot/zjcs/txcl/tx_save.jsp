<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );

String base_rate = getStr( request.getParameter("base_rate") );
String base_adjust_rate = getStr( request.getParameter("base_adjust_rate") );
String base_date = getStr( request.getParameter("base_date") );
String start_date = getStr( request.getParameter("start_date") );
String rate_limit = getStr( request.getParameter("rate_limit") );
String adjust_flag = getStr( request.getParameter("adjust_flag") );

String yh_adjust_rate = getStr( request.getParameter("yh_adjust_rate") );
String nx = getStr( request.getParameter("nx") );

String sqlstr;
ResultSet rs;
//-----------------�ж��ظ�--------------
String repeat_flag="";
if(stype.equals("add")){
	sqlstr="select * from base_adjust_interest where start_date='"+start_date+"' or adjust_flag='��'";//or adjust_flag='��'
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="10";
	}rs.close();
}else if(stype.equals("mod")){
//	sqlstr="select * from base_adjust_interest where (start_date='"+start_date+"' and id<>'"+czid+"') or adjust_flag='��'";
//	rs=db.executeQuery(sqlstr);
//	if(rs.next()){
//		repeat_flag="2";
//	}rs.close();
	if(repeat_flag.equals("")){
		sqlstr="select * from adjust_interest_proj where adjust_id='"+czid+"' and adjust_flag='��'";
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			repeat_flag="3";
		}rs.close();
	}
}else{
	sqlstr="select * from adjust_interest_proj where adjust_id='"+czid+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="4";
	}rs.close();
}
if(repeat_flag.equals("1")){
%>
<script>
	alert("�ܱ�Ǹ�������,ϵͳ�л���û�д�����ĵ�Ϣ������ӵĵ�Ϣʱ��ϵͳ���Ѿ�����!");
	window.history.back(-1);
</script>
<%
	return;
}else if(repeat_flag.equals("2")){
%>
<script>
	alert("�ܱ�Ǹ�����޸ģ���������Ϣ��¼�Ѿ������ꡱ �� ��ϵͳ���Ѵ�������Ҫ�޸ĵ�Ϣʱ�䡱!");
	window.history.back(-1);
</script>
<%
	return;
}else if(repeat_flag.equals("3")){
%>
<script>
	alert("������Ϣ��¼������δ��Ϣ����Ŀ�������޸�!");
	window.history.back(-1);
</script>
<%
	return;
}else if(repeat_flag.equals("4")){
%>
<script>
	alert("������Ϣ��¼�Ѿ�������Ŀ����ɾ��!");
	window.history.back(-1);
</script>
<%
	return;
}

String message="";
if(stype.equals("add")){
	sqlstr="insert into base_adjust_interest(base_rate,base_adjust_rate,base_date,start_date,rate_limit,adjust_flag,creator,create_date,yh_adjust_rate,nx) select "+base_rate+","+base_adjust_rate+",'"+base_date+"','"+start_date+"',"+rate_limit+",'��','"+dqczy+"','"+curr_date+"','"+yh_adjust_rate+"','"+nx+"'";
	db.executeUpdate(sqlstr);
	message="���";
}
if ( stype.equals("mod") ){ 
	sqlstr="update base_adjust_interest set base_rate="+base_rate+",base_adjust_rate="+base_adjust_rate+",base_date='"+base_date+"',start_date='"+start_date+"',rate_limit="+rate_limit+",adjust_flag='"+adjust_flag+"',modificator='"+dqczy+"',modify_date='"+curr_date+"',yh_adjust_rate='"+yh_adjust_rate+"',nx='"+nx+"' where id='"+czid+"'";
	db.executeUpdate(sqlstr);
	message="�޸�";
}
if ( stype.equals("del") ){ 
	sqlstr="delete from base_adjust_interest where  id='"+czid+"'";
	db.executeUpdate(sqlstr);
	message="ɾ��";
}
db.close();
%>
<script>
	window.close();
	opener.alert("<%=message%>�ɹ�!");
	opener.location.reload();
</script>
		