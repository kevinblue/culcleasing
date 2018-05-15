<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

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

String stockholder_name = getStr( request.getParameter("stockholder_name") );
String actual_invest = getStr( request.getParameter("actual_invest") );
String capital_ratio = getStr( request.getParameter("capital_ratio") );
String primary_ratio = getStr( request.getParameter("primary_ratio") );
String memo = getStr( request.getParameter("memo") );
String creator = getStr( request.getParameter("creator") );
String create_date = getStr( request.getParameter("create_date") );

String stype = getStr( request.getParameter("savetype") );
	String systemDate = getSystemDate(0);
//String modificator = getStr( request.getParameter("modificator") );
//String modify_date = getStr( request.getParameter("modify_date") );

String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){        //添加操作
	
		sqlstr = "insert into cust_stockholder (cust_id, stockholder_name, actual_invest,capital_ratio,primary_ratio,memo,creator,create_date,modificator ,modify_date) values ('" + cust_id + "','" + stockholder_name + "','" + actual_invest + "','" + capital_ratio + "','"+ primary_ratio + "','" + memo + "','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		%>
		//<script>
	////	alert(<%=sqlstr%>);
	///	</script>
<%
		db.executeUpdate(sqlstr); 

%>
		<script>
			window.close();
			opener.alert("添加成功!");
		
			opener.location.reload();
			//window.close();
			//opener.alert("添加成功!");
			//opener.location.reload();
			//opener.window.location.href = "frkhzygd_list.jsp";
		//alert("添加成功!");
		//this.close();
		</script>
<%
	
}
if ( stype.equals("mod") ){      //修改操作
	//String czid = getStr( request.getParameter("id") );
	
		sqlstr = "update cust_stockholder set stockholder_name='" + stockholder_name + "',actual_invest='" + actual_invest +"',capital_ratio='" + capital_ratio +"',primary_ratio='" + primary_ratio + "',memo='"+memo+"',modificator='" + dqczy  + "',modify_date='" + systemDate + "' where id='" + czid + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		%>
		//<script>
		//alert(<%=sqlstr%>);
		//</script>
<%
		db.executeUpdate(sqlstr);
%>
		<script>
		
				window.close();
			opener.alert("修改成功!");
		
			opener.location.reload();
			//opener.window.location.href = "frkhzygd_list.jsp";
			//opener.window.location();
	//	alert("修改成功!");
		
		//this.close();
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	
	//String czid = getStr( request.getParameter("id") );
	sqlstr = "delete from cust_stockholder where id='" + czid + "'";
	db.executeUpdate(sqlstr); 
%>
	<script>
		window.close();
		opener.alert("删除成功!");
		opener.location.reload();
		//opener.window.location.href = "frkhzygd_list.jsp";
		//alert("删除成功!");
		//this.close();
	</script>
<%			
}
db.close();
%>


</BODY>
</HTML>

