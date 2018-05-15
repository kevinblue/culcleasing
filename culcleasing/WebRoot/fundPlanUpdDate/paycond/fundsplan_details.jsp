<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.service.RentCashService"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>资金计划上报详情</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<style type="text/css">

.buttonly {
	background: red url(overlay.png) repeat-x;
	display: inline-block;
	padding: 5px 10px 6px;
	color: #fff;
	text-decoration: none;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	-moz-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	text-shadow: 0 -1px 1px rgba(0,0,0,0.25);
	border-bottom: 1px solid rgba(0,0,0,0.25);
	position: relative;
	cursor: pointer
}
</style>
<script type="text/javascript" >
	
	function clostpl(){
		if(confirm("是否关闭")){
			window.close();
		}else{
			return false;
		}
	}
</script>
</head>
<%
    //合同号、doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	
	%>

<body style="overflow:auto;"> 
<button class="buttonly" onclick="clostpl();">关闭</button> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		合同基本信息&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div>
   <div>
   	<!-- 合同基本信息 -->
	<iframe frameborder="0" name="contract_info" width="100%" height="220" 
		src="contract_basicinfo.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>">		
	</iframe>
   </div>
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		资金收支一览&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div>
   	<div>
   	<!-- 资金收支一栏 -->
	<iframe frameborder="0" name="con" width="100%" height="350" 
		src="funds_income.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>">
	</iframe>
   </div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		资金计划上报(修改收支时间)&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
   		<!-- 租金偿还计划 --> 
		<iframe frameborder="0" name="rentplan" width="100%" height="600" 
		src="fundsplan_add.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
</div>
</body>
</html>
