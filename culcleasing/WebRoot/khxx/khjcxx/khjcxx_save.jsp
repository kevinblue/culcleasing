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
String czid= getStr( request.getParameter("czid") );
String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String short_name = getStr( request.getParameter("short_name") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //��ȡϵͳʱ��
if ( stype.equals("add") ){        //��Ӳ���
	
		sqlstr = "insert into inter_cust_info (cust_id, cust_name, short_name) values ('" + cust_id + "','" + cust_name + "','" + short_name + "')";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 

%>
		<script>
			window.close();
			opener.alert("��ӳɹ�!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("mod") ){      //�޸Ĳ���
	//String czid = getStr( request.getParameter("id") );
	
		sqlstr = "update inter_cust_info set cust_id='" + cust_id + "',cust_name='" + cust_name + "',short_name='" + short_name + "' where cust_id='" + czid + "'";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("�޸ĳɹ�!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("del") ){         //ɾ������
	
	//String czid = getStr( request.getParameter("id") );
	sqlstr = "delete from inter_cust_info where cust_id='" + cust_id + "'";
	db.executeUpdate(sqlstr); 
%>
	<script>
		window.close();
		opener.alert("ɾ���ɹ�!");
		opener.location.reload();
	</script>
<%			
}
db.close();
%>


</BODY>
</HTML>

