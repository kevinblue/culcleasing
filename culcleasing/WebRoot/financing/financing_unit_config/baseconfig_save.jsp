<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

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
//授信单位相关信息的增删改查
String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );

String unit_code = getStr( request.getParameter("unit_code") );
String unit_name = getStr( request.getParameter("unit_name") );
String unit_property = getStr( request.getParameter("unit_property") );
String priId = getStr( request.getParameter("priId") );

String sqlstr = "";
ResultSet rs = null;
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;
String msg = "";

if ( stype.equals("add") ){        //添加操作
	sqlstr = "select id from financing_config_unit where unit_code='" + unit_code + "'";
	rs = db.executeQuery(sqlstr); 
	if ( rs.next() ) {
		flag = -2;
	} else {
		sqlstr = "Insert into financing_config_unit(unit_code,unit_name,unit_property,creator,create_date ) values ('" + unit_code + "','" + unit_name  + "','"+unit_property+"','" + dqczy + "','" + datestr  + "')";
		flag = db.executeUpdate(sqlstr); 
		msg = "添加授信单位";
	}
}else if ( stype.equals("mod") ){      //修改操作
	sqlstr = "Update financing_config_unit set unit_code='"+unit_code+"',unit_name='"+unit_name+ "',unit_property='"+unit_property+ "',modifactor='"+dqczy+"',modify_date='"+datestr+"' where id='"+priId+"'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "更新授信单位";
}else if ( stype.equals("del") ){         //删除操作
	sqlstr = "Delete from financing_config_unit where id='" + priId + "'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "删除授信单位";
}
db.close();

if(flag == -2){
%>
	<script type="text/javascript">
		window.history.back();
		alert("所填[授信单位英文简称]与现有代码重复");
	</script>
<%	
}else if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>成功!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
