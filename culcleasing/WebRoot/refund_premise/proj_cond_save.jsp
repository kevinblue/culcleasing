<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//项目资料状态修改
//===========================================

//获取基础参数
String type = getStr( request.getParameter("type") );

//基本变量
String sqlstr = "";
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
String msg = "";
 
if("updStatus".equals(type)){
	//修改状态
	String items = request.getParameter("itemStr");
	System.out.println("---"+items);
	String[] item = items.split("\\|");
	
	String text_status = "";
	String itemId = "";
	
	for(int i=0;i<item.length;i++){
		if(item[i]==null || "".equals(item[i]) || "|".equals(item[i])){
			continue;
		}
		
		LogWriter.logDebug(request, "sqlstr:"+item.length+"----------dogcat-----"+item[i]);
		text_status = getStr(request.getParameter("text_status_"+item[i]));
		itemId = getStr(request.getParameter("item_"+item[i]));
		String receive_date="";
		if("已收".equals(text_status)){
			receive_date=",receive_date=getdate() ";
		}
		//upd
		sqlstr = "update contract_fund_fund_charge_condition set status='"+text_status+"'"+receive_date+" where id='"+itemId+"' ";
		flag += db.executeUpdate(sqlstr);
	}

	LogWriter.logDebug(request, "付款，付款前提确认");
	
	//日志操作
	String sqlLog = LogWriter.getSqlIntoDB(request, "付款", "付款前提", "付款前提确认:"+items, sqlstr);
	db.executeUpdate(sqlLog);
	
	msg = "付款前提确认";
}else if("del".equals(type)){//删除某项目资料

}

//3返回判断
if(flag>0){%>
	<script type="text/javascript">
		//window.close();
		window.opener.alert("<%=msg %>成功!");
		window.opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
<%}else{
%>
	<script type="text/javascript">
		//window.close();
		window.opener.alert("<%=msg %>失败!");
		window.opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}	
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>