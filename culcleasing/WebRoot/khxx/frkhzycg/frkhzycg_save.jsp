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
String rank = getStr( request.getParameter("rank") );
String reg_number = getStr( request.getParameter("reg_number") );
String stake = getStr( request.getParameter("stake") );
String biz_scope_primary = getStr( request.getParameter("biz_scope_primary") );
String asset_size = getStr( request.getParameter("asset_size") );
String asset_liability = getStr( request.getParameter("asset_liability") );
String profit_year = getStr( request.getParameter("profit_year") );
String memo = getStr( request.getParameter("memo") );
String creator = getStr( request.getParameter("creator") );
String create_date = getStr( request.getParameter("create_date") );
String modificator = getStr( request.getParameter("modificator") );
String modify_date = getStr( request.getParameter("modify_date") );
String stype = getStr( request.getParameter("savetype") );
	String systemDate = getSystemDate(0);

String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){        //添加操作
	
		sqlstr = "insert into cust_share_company (cust_id, rank, reg_number,stake,biz_scope_primary,asset_size,asset_liability,profit_year,memo,creator,create_date,modificator ,modify_date) values ('" + cust_id + "','" + rank + "','" + reg_number + "','" + stake + "','"+ biz_scope_primary + "','" + asset_size + "','" + asset_liability + "','" + profit_year + "','" + memo + "','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"')";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		%>
		//<script>
		////alert(<%=sqlstr%>);
		//</script>
<%
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
	//String czid = getStr( request.getParameter("id") );
	
		sqlstr = "update cust_share_company set rank='" + rank + "',reg_number='" + reg_number +"',stake='" + stake +"',biz_scope_primary='" + biz_scope_primary + "',asset_size='"+asset_size+"',asset_liability='"+asset_liability+"',profit_year='"+profit_year+"',memo='"+memo+"',modificator='" + dqczy  + "',modify_date='" + systemDate + "' where id='" + czid + "'";
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
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	
	//String czid = getStr( request.getParameter("id") );
	sqlstr = "delete from cust_share_company where id='" + czid + "'";
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

