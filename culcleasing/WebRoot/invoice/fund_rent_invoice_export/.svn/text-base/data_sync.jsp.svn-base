<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>  
<%@ include file="../../func/common_simple.jsp"%>
<%@page import="com.invoiceSync.service.InvoiceInfoExportService;"%>

<%
	String sqlIds = getStr( request.getParameter("sqlIds") );//选择项
	System.out.println("dddddddd"+sqlIds);	
	String  flag="ERP";
	int  amount = InvoiceInfoExportService.dataSync(sqlIds,flag);
	
	
if(amount>0){
%>
<script type="text/javascript">     
		window.close();
		opener.alert("发票接口同步完成！");
		opener.location.reload();
</script>
<%	
}else if(amount==0){
%>
<script type="text/javascript">
		window.close();
		opener.alert("当前没有数据需要同步！");
		opener.location.reload();
</script>
<%
}else{
	%>
	<script type="text/javascript">
			window.close();
			opener.alert("数据同步失败！");
			opener.location.reload();
	</script>
	<%
}
%>
