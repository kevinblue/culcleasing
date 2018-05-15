<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
String cust_name = getStr( request.getParameter("cust_name") );
String credit_rank = getStr( request.getParameter("credit_rank") );
System.out.println("credit_rank="+credit_rank);
String change_date = getStr( request.getParameter("change_date") );
String memo = getStr( request.getParameter("memo") );
String modificator = getStr( request.getParameter("modificator") );



String stype = getStr( request.getParameter("savetype") );
			String systemDate = getSystemDate(0);
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){        //添加操作
	
		sqlstr = "insert into cust_credit_rank (cust_id, credit_rank, change_date, memo,creator ,create_date,modificator,modify_date) values ('" + cust_id+"','"+credit_rank + "','" + systemDate + "','" + memo + "','"+ dqczy + "','" + systemDate + "','"+dqczy+"','"+systemDate+"')";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 

%>
		<script>
			window.close();
			opener.alert("添加成功!");
			opener.location.reload();
		</script>
<%
	
}else if ( stype.equals("mod") ){      //修改操作
	//String czid = getStr( request.getParameter("id") );
	
		sqlstr = "update cust_credit_rank set credit_rank='" + credit_rank + "',change_date='" + systemDate + "',memo='" + memo + "',modificator='" + dqczy  + "',modify_date='" + systemDate + "' where id='" + czid + "'";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
<%
	
}else if ( stype.equals("del") ){         //删除操作
	
	//String czid = getStr( request.getParameter("id") );
	sqlstr = "delete from cust_credit_rank where id='" + czid + "'";
	db.executeUpdate(sqlstr); 
%>
<script>
		window.close();
		opener.alert("删除成功!");
		opener.location.reload();
	</script>
    <% }
	db.close();%>
</BODY>
</HTML>

