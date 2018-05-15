<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;




String contract_id = getStr( request.getParameter("contract_id") );
String asset_ownership = getStr( request.getParameter("asset_ownership") );
String back_buyer = getStr( request.getParameter("back_buyer") );
String appoint_date = getStr( request.getParameter("appoint_date") );
String default_standard = getStr( request.getParameter("default_standard") );
String default_rate = getStr( request.getParameter("default_rate") );
String reason = getStr( request.getParameter("reason") );
String memo = getStr( request.getParameter("memo") );
String process_mode = getStr( request.getParameter("process_mode") );

String flag="";
String message="保存成功!";
sqlstr="select * from contract_abnormal_end where contract_id='"+contract_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	flag="1";
}rs.close();

if(flag.equals("")){
	sqlstr="insert into contract_abnormal_end(contract_id,process_mode,asset_ownership,back_buyer,appoint_date,default_standard,default_rate,reason,memo,creator,create_date) values('"+contract_id+"','"+process_mode+"','"+asset_ownership+"','"+back_buyer+"','"+appoint_date+"','"+default_standard+"',"+default_rate+",'"+reason+"','"+memo+"','"+dqczy+"','"+curr_date+"')";
	db.executeUpdate(sqlstr);
}else{
	sqlstr="update contract_abnormal_end set process_mode='"+process_mode+"',asset_ownership='"+asset_ownership+"',back_buyer='"+back_buyer+"',appoint_date='"+appoint_date+"',default_standard='"+default_standard+"',default_rate="+default_rate+",obligation_total=0,reason='"+reason+"',memo='"+memo+"',modificator='"+dqczy+"',modify_date='"+curr_date+"' where contract_id='"+contract_id+"'";
	db.executeUpdate(sqlstr);
}



db.close();
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>