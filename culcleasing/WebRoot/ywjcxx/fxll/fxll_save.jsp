<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");


String contract_id = getStr( request.getParameter("contract_id") );
String pena_rate_type = getStr( request.getParameter("pena_rate_type") );
String pena_rate = getStr( request.getParameter("pena_rate") );
String ratestartdate = getStr( request.getParameter("ratestartdate") );
String rateenddate = getStr( request.getParameter("rateenddate") );

String stype = getStr( request.getParameter("savetype") );

String sqlstr;
ResultSet rs;
String id;
String datestr = getSystemDate(0); //获取系统时间
if ( stype.equals("add") ){        //添加操作
		sqlstr = "insert into contract_overdue_interest ( contract_id ,pena_rate_type ,pena_rate ,ratestartdate ,rateenddate ,creator ,create_date ,modificator ,modify_date ) values ('" + contract_id + "','" + pena_rate_type  + "'," + pena_rate  + ",'" + ratestartdate  + "','" + rateenddate + "','" + dqczy + "','" + datestr + "','" + dqczy + "','" + datestr + "')";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 
%>
		<script>
			window.close();
			opener.alert("添加成功!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("mod") ){      //修改操作
	id = getStr( request.getParameter("id") );

	sqlstr = "update contract_overdue_interest set contract_id='" + contract_id + "',pena_rate_type='" + pena_rate_type  + "',pena_rate=" + pena_rate  + ",ratestartdate='" + ratestartdate  + "',rateenddate='" + rateenddate + "',modificator='" + dqczy + "',modify_date='" + datestr + "' where id='" + id + "'";
	//System.out.println("sqlstrsqlstr=="+sqlstr);
	db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	
	id = getStr( request.getParameter("id") );
	sqlstr = "delete from contract_overdue_interest where id='" + id + "'";
	db.executeUpdate(sqlstr);
%>
	<script>
		window.close();
		opener.alert("删除成功!");
		opener.location.reload();
	</script>
<%			
}
db.close();
%>


</BODY>
</HTML>
