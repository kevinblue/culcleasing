<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.service.ProjInfoWriteService"%>

<%
String contract_id = request.getParameter("contract_id");

int flag = 0;
LogWriter.logDebug("执行开始,合同编号："+contract_id);
//1如果第一次签约审批
//if(order_index!=null && "1".equals(order_index)){
//	flag = ProjInfoWriteService.dataSync(contract_id);
//}else{
//	flag = ProjInfoWriteService.dataSyncT2(contract_id);
//}
flag = ProjInfoWriteService.dataSyncFinal(contract_id);

LogWriter.logDebug("执行结束,合同编号："+contract_id);

//flag为0表示失败，非0表示成功
out.print("Result:"+flag);
%>
