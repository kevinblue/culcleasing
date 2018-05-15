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
String datestr = getSystemDate(0); //获取系统时间

String code = getStr( request.getParameter("code") );
String refund_name = getStr( request.getParameter("refund_name") );
String refund_code = getStr( request.getParameter("refund_code") );
String refund_detail_name = getStr( request.getParameter("refund_detail_name") );
String priId = getStr( request.getParameter("priId") );

String sqlstr = "";
ResultSet rs = null;
int flag = 0;
String msg = "";

if ( stype.equals("add") ){        //添加操作
	sqlstr = "select id from financing_config_refundtype_detail where code='" + code + "'";
	rs = db.executeQuery(sqlstr); 
	if ( rs.next() ) {
		flag = -2;
	} else {
		sqlstr = "Insert into financing_config_refundtype_detail(code,refund_detail_name,refund_code,creator,create_date,modifactor,modify_date ) "+
				 "select top 1  '" + code + "','" + refund_detail_name  + "','"+refund_code+"','" + dqczy + "','" + datestr  + "','" + dqczy + "','" + datestr  + "'"+ 
				 "from financing_config_refundtype where refund_name='"+refund_name+"'";
		System.out.print(sqlstr);
		flag = db.executeUpdate(sqlstr); 
		msg = "添加还款类型明细";
	}
}else if ( stype.equals("mod") ){      //修改操作
	sqlstr = "Update financing_config_refundtype_detail set code='"+code+"',refund_detail_name='"+refund_detail_name+ "',modifactor='"+dqczy+"',modify_date='"+datestr+"' where id='"+priId+"'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "更新还款款类型";
}else if ( stype.equals("del") ){         //删除操作
	sqlstr = "Delete from financing_config_refundtype_detail where id='" + priId + "'";
	flag = db.executeUpdate(sqlstr);
	
	msg = "删除还款类型";
}
db.close();

if(flag == -2){
%>
	<script type="text/javascript">
		window.history.back();
		alert("所填[还款类型编号]与现有编号重复");
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
