<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>  
<%@ include file="../../func/common_simple.jsp"%>
<%@page import="com.webService.service.GlobalBjjsService;"%>

<%
	String sqlIds = getStr( request.getParameter("sqlIds") );//ѡ����
	System.out.println("dddddddd"+sqlIds);	
	//int flag=0;
	Map<String,Integer> amount = GlobalBjjsService.dataSync(sqlIds);
	if(amount.size()>0){				
	Integer  a= amount.get("success");
	Integer  b= amount.get("fail");
	
	
if(a>0){
%>
<script type="text/javascript">     
		window.close();
		opener.alert("�����˰�����ӿ�����ͬ����ɣ��ɹ�"+<%=a%>+"��,ʧ��"+<%=b%>+"��");
		opener.location.reload();
</script>
<%	
}else if(a==0 && b==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("��ǰû��[�����˰��]������Ҫͬ����");
		opener.location.reload();
</script>
<%
}else if(a==0 && b>0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("�����˰�����ӿ�����ͬ����ɣ��ɹ�"+<%=a%>+"��,ʧ��"+<%=b%>+"��");
		opener.location.reload();
</script>
<%	
}
}else{
	%>
	<script type="text/javascript">
			window.close();
			opener.alert("�����˰�����ӿ�����ͬ��ʧ�ܣ�");
			opener.location.reload();
	</script>
	<%
}
%>