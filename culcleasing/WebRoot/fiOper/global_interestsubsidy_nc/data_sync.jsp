<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.webService.service.GlobalInterestSubsidyService;"%>

<%
	int flag = GlobalInterestSubsidyService.dataSync();
if(flag>0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("ȷ����Ϣ�����ӿ�����ͬ����ɣ�");
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("��ǰû��[ȷ����Ϣ����]������Ҫͬ����");
		opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("ȷ����Ϣ�����ӿ�����ͬ��ʧ�ܣ�");
		opener.location.reload();
</script>
<%	
}
%>
