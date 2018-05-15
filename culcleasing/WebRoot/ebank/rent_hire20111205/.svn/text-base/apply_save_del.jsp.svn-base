<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="com.tenwa.log.LogWriter"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//新增人
String sql_bh_ids = getStr( request.getParameter("sql_bh_ids") );

int flag=0;
String sqlstr="";
String message="";
String stype =  getStr( request.getParameter("savetype") );

if ( stype.equals("del") ){ 
	//修改资金计划表flag字段值为0
	sqlstr = " Update fund_rent_plan set state=0 where id in( select plan_id from apply_info_detail where apply_id ="+sql_bh_ids+")";
	sqlstr+= " Update fund_penalty_plan set state=0 where uuid in( select plan_id from apply_info_detail where apply_id ="+sql_bh_ids+")";
	LogWriter.logDebug(request, "sss"+sqlstr);
	flag += db.executeUpdate(sqlstr);
	
	sqlstr="delete apply_info where glide_id="+sql_bh_ids;
	flag += db.executeUpdate(sqlstr);

	sqlstr="delete apply_info_detail where apply_id="+sql_bh_ids;
	flag += db.executeUpdate(sqlstr);
	
	//日志操作
	String sqlLog = LogWriter.getSqlIntoDB(request, "租金投放管理", "网银租金收款", dqczy+"删除网银收款编号,"+sql_bh_ids, sqlstr);
	db.executeUpdate(sqlLog);
	
	message="删除网银租金收款";
} else if ( stype.equals("sub") ){ 
	sqlstr="Update apply_info set is_sub='已提交',status='未核销' where glide_id in ("+sql_bh_ids+") ";

	flag += db.executeUpdate(sqlstr);
	message="提交网银租金收款";
}
if(flag!=0){
%>
<script>
	window.close();
	opener.alert("<%=message%>成功!");
	opener.location.reload();
</script>
<%
}else{
%>
<script>
	window.close();
	opener.alert("<%=message%>失败!");
	opener.location.reload();
</script>
<%}
db.close();%>
</body>
</html>