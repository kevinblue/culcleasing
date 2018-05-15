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
String sql_ids = getStr( request.getParameter("sql_ids") );

int flag=0;
String sqlstr="";
String message="";
String stype =  getStr( request.getParameter("savetype") );
if ( stype.equals("del") ){ 
	
	sqlstr="delete invoice_draw_info where glide_id='"+sql_ids+"'";
	flag += db.executeUpdate(sqlstr);

	sqlstr="delete invoice_draw_detail where apply_id='"+sql_ids+"'";
	flag += db.executeUpdate(sqlstr);
	
	//日志操作
	String sqlLog = LogWriter.getSqlIntoDB(request, "发票领取", "批量发票领取", dqczy+"删除发票编号,"+sql_ids, sqlstr);
	db.executeUpdate(sqlLog);
	
	message="删除发票领取";
} else if ( stype.equals("sub") ){ 
	sqlstr="Update invoice_draw_info set is_sub='已提交',status='流程中' where glide_id in ('"+sql_ids+"') ";
	flag += db.executeUpdate(sqlstr);
	message="提交发票领取";
}
if(flag!=0){
%>
<script>
<% if (stype.equals("sub") ){%>
//测试环境
window.open("http://test.eleasing.com.cn/ELeasing/ProjectWF/ProjectEHire.nsf/OSNewWorkFlowFromFPLQ?openagent&priId=<%=sql_ids %>");
//北京正式环境
//window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/ProjectEHire.nsf/OSNewWorkFlowFromFPLQ?openagent&priId=<%=sql_ids %>");
//天津正式环境
//window.open("http://culctj.eleasing.com.cn/ELeasing/ProjectWF/ProjectEHire.nsf/OSNewWorkFlowFromFPLQ?openagent&priId=<%=sql_ids %>");
<% }%>	
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