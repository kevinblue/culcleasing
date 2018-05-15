<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="java.util.regex.Pattern"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common_simple.jsp"%>

<%
//还款计划上传保存
int flag = 0;
String drawings_id = getStr( request.getParameter("drawings_id") );
String sqlstr = ""; 
//先删除之前保存的数据
sqlstr="delete from financing_amortize where drawings_id='"+drawings_id+"'";
db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "保存摊销明细前，删除原摊销明细："+sqlstr);
//保存新数据
sqlstr = "Insert into financing_amortize ";
sqlstr +=" (drawings_id,amortize_date,amortize_money,Non_amortization_balance,amortize_method,creator,create_date,amortize_list,amortize_type) ";
sqlstr +=" select ";
sqlstr +=" drawings_id,amortize_date,amortize_money,Non_amortization_balance,amortize_method,creator,create_date,amortize_list,amortize_type ";
sqlstr +=" from financing_amortize_temp ";
sqlstr +=" where drawings_id='"+drawings_id+"'";
flag=db.executeUpdate(sqlstr);
String sqlLog = LogWriter.getSqlIntoDB(request, "分摊明细保存", "数据保存", "分摊明细保存", sqlstr);
db.close();
if(flag>0){
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("分摊明细保存成功！");
	window.opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
	window.close();
	window.opener.alert("分摊明细保存失败，无数据可供保存！");
	window.opener.location.reload();
</script>
<%
}%>