<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ include file="../../func/common_simple.jsp"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.service.RentCashService"%>

<!-- ��������+������ģ����ҳ -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�������� - �����������ƶ�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //��ͬ�š������š�doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� "001";// measure_id
	String flow_date = getStr(request.getParameter("flow_date"));//����ʱ��
	
	//ģ�⸳ֵ
	if(contract_id==null || "".equals(contract_id)){
		contract_id = "CULC_0022_T001";
		begin_id = "CULC_0022_T001_002";
		doc_id = "JS999999900_HT11_44";
		flow_date = "2011-11-01";
	}
	
//1.������������
	ConditionService.flowInitBeginCondData(contract_id, begin_id, doc_id);
	ConditionService1.flowInitBeginCondData(contract_id, begin_id, doc_id);
	//2.���ƻ�����
	RentPlanService.flowInitBeginRentData(contract_id, begin_id, doc_id);
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		������Ϣ&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div>
		<iframe frameborder="0" name="con" width="100%" height="330" 
			src="proj_cond_set.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>">
		</iframe>
    </div>
   
</div>
</body>
</html>
