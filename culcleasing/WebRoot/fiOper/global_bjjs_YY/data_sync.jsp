<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<%@page import="com.webService.service.GlobalBjjsYYService;"%>
<%
	String sqlIds = getStr( request.getParameter("sqlIds") );//ѡ����
	System.out.println("dddddddd"+sqlIds);	
	//int flag=0;
	Map<String,Integer> amount = GlobalBjjsYYService.dataSync(sqlIds);
	if(amount.size()>0){				
	Integer  a= amount.get("success");
	Integer  b= amount.get("fail");
	
	
if(a>0){
%>
<script type="text/javascript">     
		window.close();
		opener.alert("�����˰��(Ӫҵ˰)����ӿ�����ͬ����ɣ��ɹ�"+<%=a%>+"��,ʧ��"+<%=b%>+"��");
		opener.location.reload();
</script>
<%	
}else if(a==0 && b==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("��ǰû��[�����˰����Ӫҵ˰��]������Ҫͬ����");
		opener.location.reload();
</script>
<%
}else if (a==0 && b>0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("�����˰��(Ӫҵ˰)����ӿ�����ͬ����ɣ��ɹ�"+<%=a%>+"��,ʧ��"+<%=b%>+"��");
		opener.location.reload();
</script>
<%	
}
}else{
	%>
	<script type="text/javascript">
			window.close();
			opener.alert("�����˰����Ӫҵ˰������ӿ�����ͬ��ʧ�ܣ�");
			opener.location.reload();
	</script>
	<%
}
%>