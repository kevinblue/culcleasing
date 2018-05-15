<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@ include file="../../func/common_simple.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>商务条件 - 商务条件变更</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //合同号、起租编号、doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	
	//模拟赋值
	if(contract_id==null || "".equals(contract_id)){
		contract_id = "11CULC010614L26";
		begin_id = "11CULC010614L2639";
		doc_id = "JS999999900_HT11_445555";
	}
	
	//初始化起租信息
	ConditionService.flowInitBeginCondData(contract_id, begin_id, doc_id);
	//初始化起租信息
	ConditionService1.flowInitBeginCondData(contract_id, begin_id, doc_id);
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		起租信息&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
		<iframe frameborder="0" name="con" width="100%" height="330" 
			src="proj_cond_set.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>">
		</iframe>
    </div>
   
</div>
</body>
</html>
