<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="../../public/pageError.jsp"%>
<%@page import="com.webService.service.GlobalReceiveService;"%>

<%
	int flag =GlobalReceiveService.dataSync();
if(flag>0){
%>
<script type="text/javascript">
		alert("�����տ����ӿ�����ͬ����ɣ�");
		window.close();
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		alert("��ǰû��[�����տ]������Ҫͬ����");
		window.close();
		opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
		alert("�����տ����ӿ�����ͬ��ʧ�ܣ�");
		window.close();
		opener.location.reload();
</script>
<%	
}
%>
