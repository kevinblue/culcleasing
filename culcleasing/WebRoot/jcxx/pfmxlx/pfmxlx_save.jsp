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
String evaluation_type = getStr( request.getParameter("evaluation_type") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
boolean flag = true;
if ( stype.equals("add") ){        //添加操作
		sqlstr = "select count(*) from base_evaluation_type where evaluation_type='"+evaluation_type+"'";
		rs = db.executeQuery(sqlstr);
		if(rs.next()){
			if(rs.getInt(1)>0){
				flag = false;
			}
		}
		if(flag){
		sqlstr = "insert into base_evaluation_type (evaluation_type,creator ,create_date ) values ('" + evaluation_type + "','"+ dqczy + "'," + datestr +  ")";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 
		

%>
		<script>
			window.close();
			opener.alert("添加成功!");
			opener.location.reload();
		</script>
<%
		}else{
		%>
		<script>
			window.close();
			opener.alert("评分类型已存在，添加失败!");
			opener.location.reload();
		</script>
<%
		}
}
if ( stype.equals("mod") ){      //修改操作
	//String czid = getStr( request.getParameter("id") );
		sqlstr = "select count(*) from base_evaluation_type where evaluation_type='"+evaluation_type+"' and id<>"+czid;
		rs = db.executeQuery(sqlstr);
		if(rs.next()){
			if(rs.getInt(1)>0){
				flag = false;
			}
		}
		if(flag){
		sqlstr = "update base_evaluation_type set evaluation_type='" + evaluation_type + "',modificator='" + dqczy  + "',modify_date=" + datestr + " where id='" + czid + "'";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
<%
		}else{
		%>
		<script>
			window.close();
			opener.alert("评分类型已存在，修改失败!");
			opener.location.reload();
		</script>
<%
		}
}
if ( stype.equals("del") ){         //删除操作
	
	//String czid = getStr( request.getParameter("id") );
	sqlstr = "delete from base_evaluation_type where id='" + czid + "'";
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

