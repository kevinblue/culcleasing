<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.service.ProjInfoWriteService"%>

<%
//��ҳ��Ϊ����ҳ��
String contract_id = request.getParameter("contract_id");
String factDate = request.getParameter("fact_date");
String planDate = request.getParameter("plan_date");

int flag = 0;
LogWriter.logDebug("ִ�п�ʼ,��ͬ��ţ�"+contract_id);
//1�����һ��ǩԼ����
//if(order_index!=null && "1".equals(order_index)){
//	flag = ProjInfoWriteService.dataSync(contract_id);
//}else{
//	flag = ProjInfoWriteService.dataSyncT2(contract_id);
//}
flag = ProjInfoWriteService.dataSync5(contract_id,factDate,planDate);

LogWriter.logDebug("ִ�н���,��ͬ��ţ�"+contract_id);

//flagΪ0��ʾʧ�ܣ���0��ʾ�ɹ�
out.print("Result:"+flag);
%>
