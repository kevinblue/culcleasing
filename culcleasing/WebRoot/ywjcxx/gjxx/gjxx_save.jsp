<%@ page contentType="text/html; charset=gbk" language="java"%>
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


String gjmc = getStr( request.getParameter("gjmc") );
String id = getStr( request.getParameter("id") );

String stype = getStr( request.getParameter("savetype") );

String sqlstr;
ResultSet rs;
String datestr = getSystemDate(0); //��ȡϵͳʱ��

if ( stype.equals("add") ){        //��Ӳ���
		sqlstr = "select * from jb_gjxx where id='" + id + "'";
		rs = db.executeQuery(sqlstr); 
		if ( rs.next() ) {
		%>
			<script>
			window.history.back();
			alert("������Ҵ��������д����ظ�");
			</script>
		<%
		} else {
			sqlstr = "insert into jb_gjxx ( id ,gjmc ,gxrq ,czy ) values ('" + id + "','" + gjmc  + "','" + datestr  + "','" + dqczy + "')";
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
}
if ( stype.equals("mod") ){      //�޸Ĳ���
	String kid = getStr( request.getParameter("kid") );
	if ( kid.equals(id) ) {
		sqlstr = "update jb_gjxx set gjmc='" + gjmc  + "',gxrq='" + datestr + "',czy='" + dqczy + "' where id='" + id + "'";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
		%>
		<script>
			window.close();
			opener.alert("�޸ĳɹ�!");
			opener.location.reload();
		</script>
		<%
	} else {
		sqlstr = "select * from jb_gjxx where id='" + id + "'";
		rs = db.executeQuery(sqlstr); 
		if ( rs.next() ) {
		%>
			<script>
			window.history.back();
			alert("������Ҵ��������д����ظ�");
			</script>
		<%
		} else {
			sqlstr = "update jb_gjxx set id='" + id  + "',gjmc='" + gjmc  + "',gxrq='" + datestr + "',czy='" + dqczy + "' where id='" + kid + "'";
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
	}
}
if ( stype.equals("del") ){         //ɾ������
	sqlstr = "delete from jb_gjxx where id='" + id + "'";
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
