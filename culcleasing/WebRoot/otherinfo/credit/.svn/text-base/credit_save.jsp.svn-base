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

String cust_id = getStr( request.getParameter("kid") );

String credit = getStr( request.getParameter("credit") );
String start_date = getStr( request.getParameter("start_date") );
String end_date = getStr( request.getParameter("end_date") );

String sqlstr;
ResultSet rs = null;
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;

if ( stype.equals("mod") ){        //添加操作
	//先判断数据库里是否存在
	sqlstr = "update cust_credit_info set credit='"+credit+"',start_date='"+start_date+"',end_date='"+end_date+"',";
	sqlstr+= "modificator='"+dqczy+"',modify_date='"+datestr+"' where cust_id='"+cust_id+"'";

	flag = db.executeUpdate(sqlstr);
	//不存在则insert
	if(flag<=0){
		sqlstr = "insert into cust_credit_info(cust_id,credit,start_date,end_date,creator,create_date,modificator,modify_date)";
		sqlstr += " values('"+cust_id+"','"+credit+"','"+start_date+"','"+end_date+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
		System.out.println(sqlstr);
		flag = db.executeUpdate(sqlstr);
	}
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "系统信息维护", "授信额度维护", "修改承租客户："+cust_id+" 授信额度改为："+credit, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
}
db.close();

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("客户授信额度修改成功!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("客户授信额度修改失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
