<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.service.RentCashService"%>
<%@ include file="../../func/common_simple.jsp"%>

<!-- 商务条件+租金测算模块首页 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>商务条件变更</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //合同号、项目id、doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	String proj_money = getStr(request.getParameter("proj_money"));//项目金额
	//模拟赋值
	if("".equals(contract_id)){
		contract_id = "CULC_0022_T001";
		proj_money = "9999999";
		doc_id = "JS999999900_HT11";
	}
	
	//初始化项目交易结构数据
	ConditionService.flowInitContractData(contract_id, doc_id);
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
    <div id="tabletit" class="tabtitexp">&nbsp; 
   		商务条件&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	
   	<div>
	   	<!-- 商务条件制定，直接生成租金+现金流 -->
		<iframe frameborder="0" name="con" width="100%" height="430" 
			src="proj_cond_set.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&proj_money=<%=proj_money %>">
		</iframe>
	</div>
</div>
</body>
</html>
