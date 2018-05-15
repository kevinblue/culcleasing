<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.sql.*" %> 
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
String id =getStr(request.getParameter("dept_id"));
String name =getStr(request.getParameter("dept_name"));
String respon_provice_title =getStr(request.getParameter("credit_group_name"));
String respon_provice_id =getStr(request.getParameter("credit_group_id"));


int flag=0;
String sqlstr;
ResultSet rs;

String datestr = getSystemDate(0); //获取系统时间


//先判断数据库里是否存在
String Sid="";
String sql = "select id from base_department_respons where dept_id='"+id+"'";
rs = db.executeQuery(sql);
if(rs.next()){
	Sid =getDBStr(rs.getString("id"));
}
LogWriter.logDebug(request,"我需要的Sid:"+Sid);
rs.close();

if(Sid!=""){
	sqlstr = "update base_department_respons set respon_provice_id='"+respon_provice_id+"',respon_provice_title='"+respon_provice_title+"',";
	sqlstr+= "modificator='"+dqczy+ "',modify_date='"+datestr+"' where dept_id='"+id+"'";
	LogWriter.logDebug(request,"11111111111111111我需要的up-sqlstr:"+sqlstr);
	flag = db.executeUpdate(sqlstr);
}else{
	sqlstr ="insert into base_department_respons (dept_name,dept_id,respon_provice_id,respon_provice_title,creator,create_date,modificator,modify_date)";
	sqlstr +=" values('"+name+"','"+id+"','"+respon_provice_id+"','"+respon_provice_title+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
	flag=db.executeUpdate(sqlstr);
	LogWriter.logDebug(request,"22222222222222222我需要的in-sqlstr:"+sqlstr);
}
db.close();
%>
<script type="text/javascript">
	window.close();
	opener.alert("修改成功!");
	opener.location.reload();
</script>
</BODY>
</HTML>
