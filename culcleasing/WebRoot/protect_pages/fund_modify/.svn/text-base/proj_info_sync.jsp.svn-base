<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.service.YYProjInfoService"%>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*"%>
<%@ page import="com.tenwa.culc.util.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<%
String proj_id = request.getParameter("proj_id");
String id = request.getParameter("id");
String sqlstr="";
int flag = YYProjInfoService.dataSync(proj_id);
if(flag>0){
	sqlstr = "update proj_info set wh_status='已同步' where id='" + id + "'";
	db.executeUpdate(sqlstr);
	db.close();
%>
<script type="text/javascript">
		window.close();
		opener.alert("数据同步完成！");
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("当前没有[项目基本信息]数据需要同步！");
		opener.location.reload();
</script>
<%	
}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("数据同步失败！");
		opener.location.reload();
</script>
<%	
}
%>
