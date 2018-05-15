<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.webService.service.GlobalInterestService;"%>

<%
	int flag = GlobalInterestService.dataSync();
if(flag>0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("利息计算表财务接口数据同步完成！");
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("当前没有[利息计算表]数据需要同步！");
		opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("利息计算表财务接口数据同步失败！");
		opener.location.reload();
</script>
<%	
}
%>
