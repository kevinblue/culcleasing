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
String cust_id = getStr( request.getParameter("cust_id") );
String rank = getStr( request.getParameter("rank") );
String change_date = getStr( request.getParameter("change_date") );
String memo = getStr( request.getParameter("memo") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //��ȡϵͳʱ��
if ( stype.equals("add") ){        //��Ӳ���
	
		sqlstr = "insert into cust_rank (cust_id, rank, change_date, memo,creator ,create_date ) values ('" + cust_id + "','" + rank + "','" + change_date + "','" + memo + "','"+ dqczy + "'," + datestr +  ")";
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
	
		sqlstr = "update cust_rank set rank='" + rank + "',change_date='" + change_date + "',memo='" + memo + "',modificator='" + dqczy  + "',modify_date=" + datestr + " where id='" + czid + "'";
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
	sqlstr = "delete from cust_rank where id='" + czid + "'";
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

