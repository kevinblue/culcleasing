<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<%@page import="com.webService.service.GlobalBjjsYYService;"%>
<%
	String sqlIds = getStr( request.getParameter("sqlIds") );//选择项
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
		opener.alert("本金计税表(营业税)财务接口数据同步完成！成功"+<%=a%>+"条,失败"+<%=b%>+"条");
		opener.location.reload();
</script>
<%	
}else if(a==0 && b==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("当前没有[本金计税表（营业税）]数据需要同步！");
		opener.location.reload();
</script>
<%
}else if (a==0 && b>0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("本金计税表(营业税)财务接口数据同步完成！成功"+<%=a%>+"条,失败"+<%=b%>+"条");
		opener.location.reload();
</script>
<%	
}
}else{
	%>
	<script type="text/javascript">
			window.close();
			opener.alert("本金计税表（营业税）财务接口数据同步失败！");
			opener.location.reload();
	</script>
	<%
}
%>
