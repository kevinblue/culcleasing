<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>利息补贴 - 起租</title>
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
		contract_id = "11CULC 010280L12";
		begin_id = "11CULC 010280L1284";
		doc_id = "JS999999900_HT11_44";
	}
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;height:100%;overflow:auto;position: relative; left: 0px; top: 0px">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		利息补贴&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div style="width:100%;height:98%">
   	<!-- 商务条件制定，直接生成租金+现金流 -->
	<iframe frameborder="0" name="con" width="100%" height="100%"
		src="interest_subsidy.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>">
	</iframe>
   </div>
</div>
</body>
</html>
