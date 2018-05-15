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
String contract_status= getStr( request.getParameter("contract_status") );
String recycle_date = getStr(request.getParameter("change_date"));
String[] ids = request.getParameterValues("list");
String recycle_id = dqczy;

int flag = 0;
int length =0;
if(ids == null){
	length = 0;
}else{
	length = ids.length;
}
for(int i = 0; i < length; i++) {
	 sqlstr = "update contract_fund_fund_charge_condition " 
			+ " set status = '"+contract_status+"'";
			
	if("已收".equals(contract_status)){
		sqlstr+= " ,recycle_person = '" + recycle_id + "'";
		if(recycle_date != null && !"".equals(recycle_date)){
			sqlstr += " ,recycle_date = '" + recycle_date + "'";
		} 
	} else if("未收".equals(contract_status)){
		sqlstr+= " ,recycle_person = null ";
		sqlstr += " ,recycle_date = null ";
	}
	sqlstr+= " where id='"+ids[i]+"'";
	flag += db.executeUpdate(sqlstr); 
}

db.close();
	String msg = length + "份付款材料交接状态修改"; 

//3返回判断
if(flag == length){%>
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
<%} 

%>
</BODY>
</HTML>
