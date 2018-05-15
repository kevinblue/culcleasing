<%@ page contentType="text/html; charset=gbk" language="java"%>

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
//内部行业相关信息的增删改查

String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );

String code = getStr( request.getParameter("code") );
String trade = getStr( request.getParameter("trade") );
String id = getStr( request.getParameter("id") );

String sqlstr;
ResultSet rs;
String datestr = getSystemDate(0); //获取系统时间

if ( stype.equals("add") ){        //添加操作
		sqlstr = "select code from base_trade where code='" + code + "'";
		rs = db.executeQuery(sqlstr); 
		if ( rs.next() ) {
		%>
			<script type="text/javascript">
			window.history.back();
			alert("所填内部行业代码与现有代码重复");
			</script>
		<%
		} else {
			sqlstr = "insert into base_trade(code,trade,gxrq ,czy ) values ('" + code + "','" + trade  + "','" + datestr  + "','" + dqczy + "')";
			db.executeUpdate(sqlstr); 
			%>
			<script type="text/javascript">
				window.close();
				opener.alert("添加成功!");
				opener.location.reload();
			</script>
			<%
		}
}else if ( stype.equals("mod") ){      //修改操作
	String kid = getStr( request.getParameter("kid") );
	sqlstr = "update base_trade set code='"+code+"',trade='" + trade  + "',gxrq='" + datestr + "',czy='" + dqczy + "' where id='" + kid + "'";
	db.executeUpdate(sqlstr);
	%>
	<script type="text/javascript">
		window.close();
		opener.alert("修改成功!");
		opener.location.reload();
	</script>
	<%
}else if ( stype.equals("del") ){         //删除操作
	sqlstr = "delete from base_trade where id='" + id + "'";
	db.executeUpdate(sqlstr);
%>
	<script type="text/javascript">
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
