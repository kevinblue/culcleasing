<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.webService.service.GlobalStartRentService;"%>

<%
	int flag = GlobalStartRentService.dataSync();
if(flag>0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("起租财务接口数据同步完成！");
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("当前没有[起租]数据需要同步！");
		opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("起租财务接口数据同步失败！");
		opener.location.reload();
</script>
<%	
}
%>
