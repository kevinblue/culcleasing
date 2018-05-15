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

//获取基础参数contract_id
String seal_date= getStr( request.getParameter("seal_date") );
String[] ids = request.getParameterValues("list");
//String recycle_id = dqczy;	废弃人

int flag = 0;//计数器
int length =0;//数组长度
if(ids == null){
	length = 0;
}else{
	length = ids.length;
}
for(int i = 0; i < length; i++) {
	if(seal_date != null && !"".equals(seal_date)){
		sqlstr = "update contract_list_info " 
				+ " set seal_date = '"+seal_date+"'";
		sqlstr+= " where id='"+ids[i]+"'";
		flag += db.executeUpdate(sqlstr); 
	} 
}
db.close();
	String msg = length + "份合同盖章时间修改为"+seal_date; 

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
