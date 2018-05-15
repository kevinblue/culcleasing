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
String systemDate = getSystemDate(0);

int flag=0;
String sqlstr="";
String message="";

	//获取参数
	String sqlIds = getStr( request.getParameter("sqlIds") );//选择项
	String[] priIdS=sqlIds.split(",");
	//删除detail表
	for(int i = 0; i < priIdS.length; i++) {
	 sqlstr = "Delete from manual_open_invoice_info where out_no="+priIdS[i]+"";
		flag += db.executeUpdate(sqlstr);
	}
	
	
	
	message="删除发票";

%>
<%
if(flag!=0){
%>
<script>
	opener.alert("<%=message%>成功!");
	opener.location.reload();
	
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%
}else{
%>
<script>
	opener.alert("<%=message%>失败!");
	opener.location.reload();
	
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%}
db.close();%>
</body>
</html>