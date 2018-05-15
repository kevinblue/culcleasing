<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.util.CRMOperationUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>

<BODY>
<%
String erpCode =getStr(request.getParameter("erpCode"));
LogWriter.logDebug(request,"我需要的erpCode:"+erpCode);
String sCode =getStr(request.getParameter("sCode"));
LogWriter.logDebug(request,"我需要的sCode:"+sCode);
String sName =getStr(request.getParameter("sName"));
String subsidiary = getStr(request.getParameter("subsidiary"));


int flag=0;
flag +=CRMOperationUtil.inser(erpCode,sCode,sName,subsidiary);
if(flag>0){


sqlstr ="update base_user set register_status=1 where id='"+erpCode+"' and name ='"+sName+"'";
flag += db.executeUpdate(sqlstr);
}
LogWriter.logDebug(request,"22222222222222222我需要的flag:"+flag);
if(flag>0){
	%>
	<script type="text/javascript">
		window.close();
		alert("同步成功!");
		window.location.href="synchronism_list.jsp"
	</script>
	<%
	}
	 %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>