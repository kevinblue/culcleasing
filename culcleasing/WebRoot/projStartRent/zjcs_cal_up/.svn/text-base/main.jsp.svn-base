<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.service.RentCashService"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>商务条件 - 起租信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //合同号、起租编号、doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	String flow_date = getStr(request.getParameter("flow_date"));//流程时间
	
	//模拟赋值
	if(contract_id==null || "".equals(contract_id)){
		contract_id = "CULC_0022_T001";
		begin_id = "11Test0001_01_01";
		doc_id = "JS999999900_HT11_244";
		flow_date = "2011-11-01";
	}
	//判断是否多次起租
	boolean flag = ConditionService.judgeBeginType(contract_id);
	int begin_order_index=0;//起租序列号
	if( flag ){//多次起租
		//多次起租，只要通过租赁本金进行控制
		begin_order_index = BeginService.getBeginOrderIndex(contract_id);
		//2011-12-26 杨舒提出每次起租都带入默认值
		//1.商务条件拷贝
		ConditionService.flowInitBeginTempData(contract_id, begin_id, doc_id);
		//1.商务条件拷贝tax_type
		ConditionService1.flowInitBeginTempData(contract_id, begin_id, doc_id);
		//2.租金计划拷贝
		RentPlanService.flowInitBeginTempData(contract_id, begin_id, doc_id);
	}else{
		//将签约审批数据进行拷贝
		//1.商务条件拷贝
		ConditionService.flowInitBeginTempData(contract_id, begin_id, doc_id);
		//1.商务条件拷贝tax_type
		ConditionService1.flowInitBeginTempData(contract_id, begin_id, doc_id);
		//2.租金计划拷贝
		RentPlanService.flowInitBeginTempData(contract_id, begin_id, doc_id);
		
		begin_order_index = 1;
	}
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		起租信息&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
   	<!-- 商务条件制定，直接生成租金+现金流 -->
	<iframe id="qz" frameborder="0" name="con" width="100%" height="340" 
		src="proj_cond_set.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>&flow_date=<%=flow_date %>&begin_order_index=<%=begin_order_index %>">
	</iframe>
   </div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		租金偿还计划&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
   		<!-- 展示租金计划数据 --> 
		<iframe frameborder="0" name="rentplan" width="100%" height="600" 
		src="rent_show.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
</div>
</body>
</html>
