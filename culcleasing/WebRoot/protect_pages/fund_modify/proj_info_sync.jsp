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
	sqlstr = "update proj_info set wh_status='��ͬ��' where id='" + id + "'";
	db.executeUpdate(sqlstr);
	db.close();
%>
<script type="text/javascript">
		window.close();
		opener.alert("����ͬ����ɣ�");
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("��ǰû��[��Ŀ������Ϣ]������Ҫͬ����");
		opener.location.reload();
</script>
<%	
}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("����ͬ��ʧ�ܣ�");
		opener.location.reload();
</script>
<%	
}
%>
