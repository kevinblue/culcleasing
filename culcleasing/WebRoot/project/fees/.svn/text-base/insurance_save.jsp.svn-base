<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
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
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );
String insurer1 = getStr( request.getParameter("insurer1") );
String insurer = getStr( request.getParameter("insurer") );
String fees_way = getStr( request.getParameter("fees_way") );
String insurance_type = getStr( request.getParameter("insurance_type") );
String note = getStr( request.getParameter("note") );

String sqlstr;
ResultSet rs;
int flag=0;
String message="";
if ( stype.equals("add") ){ 
sqlstr = "select * from insurance_fees where insurer = '"+insurer+"'";
System.out.println(sqlstr);
rs = db.executeQuery(sqlstr); 
message = "同一保险公司不可重复添加";
if ( rs.next() == false) {
	sqlstr="insert into insurance_fees (insurer,fees_way,note,updatetime,insurance_type) values('"+insurer+"','"+fees_way+"','"+note+"','"+curr_date+"','"+insurance_type+"')";
    System.out.println("sqlstr======================"+sqlstr);
    flag = db.executeUpdate(sqlstr);
    message="添加保险费用维护";
}
}
if ( stype.equals("mod") ){ 
sqlstr="update insurance_fees set insurer='"+insurer+"',fees_way='"+fees_way+"',note='"+note+"',updatetime='"+curr_date+"',insurance_type='"+insurance_type+"' where insurance_fees='"+czid+"'";
//System.out.println("sqlstr======================"+sqlstr);
flag = db.executeUpdate(sqlstr);
message="修改保险费用维护";
}
if ( stype.equals("del") ){ 
sqlstr="delete from insurance_fees where  insurance_fees='"+czid+"'";
flag = db.executeUpdate(sqlstr);
message="删除保险费用维护";
}
if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>失败!");
			opener.location.reload();
		</script>
<%}
		db.close();%>