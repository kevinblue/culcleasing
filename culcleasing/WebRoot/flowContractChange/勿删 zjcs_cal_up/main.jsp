<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.service.RentCashService"%>
<%@ include file="../../func/common_simple.jsp"%>

<!-- ��������+������ģ����ҳ -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����������</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //��ͬ�š���Ŀid��doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� "001";// measure_id
	String proj_money = getStr(request.getParameter("proj_money"));//��Ŀ���
	//ģ�⸳ֵ
	if("".equals(contract_id)){
		contract_id = "CULC_0022_T001";
		proj_money = "9999999";
		doc_id = "JS999999900_HT11";
	}
	
	//��ʼ����Ŀ���׽ṹ����
	ConditionService.flowInitContractData(contract_id, doc_id);
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
    <div id="tabletit" class="tabtitexp">&nbsp; 
   		��������&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	
   	<div>
	   	<!-- ���������ƶ���ֱ���������+�ֽ��� -->
		<iframe frameborder="0" name="con" width="100%" height="430" 
			src="proj_cond_set.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&proj_money=<%=proj_money %>">
		</iframe>
	</div>
</div>
</body>
</html>
