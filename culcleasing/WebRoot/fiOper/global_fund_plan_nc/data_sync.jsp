<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.webService.service.GlobalFundPlanService;"%>

<%
	int flag = GlobalFundPlanService.dataSync();
if(flag>0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("�ʽ��ո��ƻ������ӿ�����ͬ����ɣ�");
		opener.location.reload();
</script>
<%	
}else if(flag==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("��ǰû��[�ʽ��ո��ƻ���]������Ҫͬ����");
		opener.location.reload();
</script>
<%
}else{
%>
<script type="text/javascript">
		window.close();
		opener.alert("�ʽ��ո��ƻ������ӿ�����ͬ��ʧ�ܣ�");
		opener.location.reload();
</script>
<%	
}
%>
