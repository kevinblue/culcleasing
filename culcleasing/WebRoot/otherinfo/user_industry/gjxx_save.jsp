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
String code =getStr(request.getParameter("code"));
String name =getStr(request.getParameter("name"));
String respon_provice_title =getStr(request.getParameter("credit_group_name"));
String respon_provice_id =getStr(request.getParameter("credit_group_id"));


int flag=0;
String sqlstr;
ResultSet rs;

String datestr = getSystemDate(0); //��ȡϵͳʱ��


//���ж����ݿ����Ƿ����
String Sid="";
String sql = "select id from base_trade_respons where trade_code='"+code+"'";
rs = db.executeQuery(sql);
if(rs.next()){
	Sid =getDBStr(rs.getString("id"));
}
LogWriter.logDebug(request,"����Ҫ��Sid:"+Sid);
rs.close();

if(Sid!=""){
	sqlstr = "update base_trade_respons set respon_provice_id='"+respon_provice_id+"',respon_provice_title='"+respon_provice_title+"',";
	sqlstr+= "modificator='"+dqczy+ "',modify_date='"+datestr+"' where trade_code='"+code+"'";
	LogWriter.logDebug(request,"11111111111111111����Ҫ��up-sqlstr:"+sqlstr);
	flag = db.executeUpdate(sqlstr);
}else{
	sqlstr ="insert into base_trade_respons (trade_code,trade_name,respon_provice_id,respon_provice_title,creator,create_date,modificator,modify_date)";
	sqlstr +=" values('"+code+"','"+name+"','"+respon_provice_id+"','"+respon_provice_title+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
	flag=db.executeUpdate(sqlstr);
	LogWriter.logDebug(request,"22222222222222222����Ҫ��in-sqlstr:"+sqlstr);
}
db.close();
%>
<script type="text/javascript">
	window.close();
	opener.alert("�޸ĳɹ�!");
	opener.location.reload();
</script>
</BODY>
</HTML>
