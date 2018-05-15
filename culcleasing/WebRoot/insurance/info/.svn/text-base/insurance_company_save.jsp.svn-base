<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="java.text.*" %> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//授信单位相关信息的增删改查
String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );
String datestr = getSystemDate(0); //获取系统时间

String cust_name = getStr( request.getParameter("cust_name") );
String cust_ename = getStr( request.getParameter("cust_ename") );
String finance_code = getStr( request.getParameter("finance_code") );
String cust_type = "5";
String cust_id ="";
java.util.Date d = new java.util.Date();
DateFormat df = new SimpleDateFormat("yyMMdd");

cust_id = df.format(d)+ String.format("%04d", new Random().nextInt(1000));

String sqlstr = "";
ResultSet rs = null;
int flag = 0;
String msg = "";

if ( stype.equals("add") ){        //添加操作
	sqlstr = "select id from cust_info where cust_name like '%保险%' and ( cust_name='" + cust_name + "' or finance_code = '" + finance_code + "' or cust_id = '" + cust_id + "' )";
	rs = db.executeQuery(sqlstr); 
	if ( rs.next() ) {
		flag = -2;
	} else {
		sqlstr = "Insert into cust_info(cust_id,cust_name,cust_ename,cust_type,finance_code,creator,create_date,modificator,modify_date ) values ('" + cust_id + "','" + cust_name  + "','" + cust_ename  + "','" + cust_type + "','" + finance_code  + "','" + dqczy + "','" + datestr  + "','" + dqczy + "','" + datestr  + "')";
		System.out.println(sqlstr);
		flag = db.executeUpdate(sqlstr); 
		msg = "添加保险公司";
	}
}
db.close();

if(flag == -2){
%>
	<script type="text/javascript">
		window.history.back();
		alert("所填[保险公司名称]或者[南北财务编码]与现有信息重复");
	</script>
<%	
}else if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>成功!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
