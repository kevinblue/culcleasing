<%@ page contentType="text/html; charset=gbk" language="java"%>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
	//0.基础参数
	String user_id = (String)session.getAttribute("czyid");//当前登陆人
    String datestr = getSystemDate(0); //获取系统时间
	//1.1==获取参数
	String doc_id = getStr(request.getParameter("doc_id")); //文档编号 measure_id
    String contract_id = getStr(request.getParameter("contract_id")); //合同编号
    String begin_id = getStr(request.getParameter("begin_id")); //起租编号
	
    String sqlstr = "";
    ResultSet rs = null;
    int flag = 0;

    sqlstr = " Exec dbo.Flow_QZOffFirstRent_Oper '"+contract_id+"','"+begin_id+"','"+doc_id+"','"+user_id+"'";
    flag = db.executeUpdate(sqlstr);
	
	LogWriter.logDebug(request, "起租资金冲抵第一期租金核销操作！");
		
if(flag>0){
%>
    <script type="text/javascript">
		alert("第一期租金冲抵核销成功!");
		opener.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("第一期租金冲抵核销失败!");
		opener.location.reload();
		this.close();
	</script>
<%	
}
%>
<%if(null != db){db.close();}%>