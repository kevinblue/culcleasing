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
String id = getStr( request.getParameter("czid") );
String liaison_date = getStr( request.getParameter("liaison_date") );
String liaison_way = getStr( request.getParameter("liaison_way") );
String cust_id = getStr( request.getParameter("cust_id") );
String liaison_info = getStr( request.getParameter("liaison_info") );
String pay_date = getStr( request.getParameter("pay_date") );
String pay_money = getStr( request.getParameter("pay_money") );
String nextliaison_date = getStr( request.getParameter("nextliaison_date") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
if ( stype.equals("add") ){        //添加操作
	
		sqlstr = "insert into dunning_record (cust_id, liaison_date, liaison_way,liaison_info, pay_date,pay_money,nextliaison_date,liaisoner) values ('" + cust_id + "','" + liaison_date + "','" + liaison_way + "','" + liaison_info   + "','" + pay_date  + "','" + pay_money  + "','" + nextliaison_date  + "','" + dqczy  +"')";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 

%>
		<script>
			window.close();
			opener.alert("添加成功!");
			opener.parent.location.reload();
		</script>
<%
	
}
if ( stype.equals("mod") ){      //修改操作
	String czid = getStr( request.getParameter("czid") );
	
		sqlstr = "update dunning_record set liaison_date='" + liaison_date+ "', liaison_way='"+liaison_way+ "', liaison_info='"+liaison_info+ "', pay_date='"+pay_date+ "', pay_money='"+pay_money+ "', nextliaison_date='"+nextliaison_date+"' where dunningrecord_id='" + id + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			window.parent
			opener.alert("修改成功!");
			opener.parent.location.reload();
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	
	String czid = getStr( request.getParameter("czid") );
	sqlstr = "delete from dunning_record where dunningrecord_id='" + czid + "'";
	db.executeUpdate(sqlstr); 
%>
	<script>
		window.close();
		opener.alert("删除成功!");
		opener.parent.location.reload();
	</script>
<%			
}
db.close();
%>


</BODY>
</HTML>
