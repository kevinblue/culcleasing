<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%@ include file="../../func/sms_common.jsp"%>
<%

String czid = getStr( request.getParameter("czid") );
String mobile_phone = getStr( request.getParameter("mobile_phone") );
String add_time = getStr( request.getParameter("add_time") );
String sms_message = smsReplace(getStr( request.getParameter("sms_message") ));
String type = getStr( request.getParameter("type") );
String savetype = getStr( request.getParameter("savetype") );
if(savetype.equals("add")){
String sqlstr = "";
sqlstr="insert into sms_info (mobile_phone,sms_message,perform_time,perform_flag,actual_time,type,add_time,delete_flag) values (";
sqlstr+="'"+mobile_phone+"'";
sqlstr+=",'"+sms_message+"'";
sqlstr+=",null";
sqlstr+=",0";
sqlstr+=",null";
sqlstr+=",'"+type+"'";
sqlstr+=",'"+add_time+"'";
sqlstr+=",'0'";
sqlstr+=")";
System.out.println(sqlstr);
db.executeUpdate(sqlstr);
}
db.close();
%>
<script>
	window.close();
	opener.alert("短信记录添加成功!");
	opener.location.reload();
</script>