<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@ page import="com.tenwa.log.LogWriter"%>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//项目资料状态修改
//===========================================

//获取基础参数
String contract_id = getStr( request.getParameter("contract_id") );
String bank= getStr( request.getParameter("bank") );


int flag = 0;
String msg = "";
 //1.先删除
sqlstr="delete from sys_contract_p_bank where contract_id='"+contract_id+"'";
flag=db.executeUpdate(sqlstr);
//2.后添加
String sqlStr1="insert into sys_contract_p_bank(contract_id,bank_str) select '"+contract_id+"','"+bank+"'";
flag=db.executeUpdate(sqlStr1);
	
	msg = "银行修改";


//3返回判断
if(flag>0){%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>成功!");
		window.opener.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>失败!");
		window.opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>