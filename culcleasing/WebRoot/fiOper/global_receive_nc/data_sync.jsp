<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="../../public/pageError.jsp"%>
<%@page import="com.webService.service.GlobalReceiveService;"%>

<%
	int flag =GlobalReceiveService.dataSync();
if(flag>0){
%>
<script type="text/javascript">
		alert("国内收款单财务接口数据同步完成！");
		window.close();
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		alert("当前没有[国内收款单]数据需要同步！");
		window.close();
		opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
		alert("国内收款单财务接口数据同步失败！");
		window.close();
		opener.location.reload();
</script>
<%	
}
%>
