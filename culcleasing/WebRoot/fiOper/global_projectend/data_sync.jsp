<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="../../public/pageError.jsp"%>
<%@page import="com.webService.service.GlobalProjectEndService;"%>

<%
	int flag = GlobalProjectEndService.dataSync();
if(flag>0){
%>
<script type="text/javascript">
		alert("合同结清接口数据同步完成！");
		window.close();
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		alert("当前没有[合同结清]数据需要同步！");
		window.close();
		opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
		alert("合同结清接口数据同步失败！");
		window.close();
		opener.location.reload();
</script>
<%	
}
%>
