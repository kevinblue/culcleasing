<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ include file="../../func/common_simple.jsp"%>
<%@page import="com.tenwa.log.LogWriter"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>或有租金修订</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
	String contract_id=getStr(request.getParameter("contract_id"));
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id =getStr(request.getParameter("doc_id"));
	//模拟赋值
	if("".equals(contract_id)){
		contract_id="12CULC040814L79";
		begin_id ="12CULC040814L7971";
		doc_id ="E91720FCC03ACD25482579A4001CF669";
	}
	
 %>
<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		租金&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div style="overflow:auto ">
	<iframe frameborder="0" name="con" width="100%" height="300" scrolling="auto"
		src="rent_plan.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&begin_id=<%=begin_id %>">
	</iframe>
   </div>
   
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		管理服务费&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300" scrolling="auto"
		src="managefee_plan.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&begin_id=<%=begin_id %>">
		</iframe>
	</div>
	
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		其他金额&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
		<iframe frameborder="0" name="rentplan" width="100%" height="300"  scrolling="auto"
		src="otherfee_plan.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&begin_id=<%=begin_id %>">
		</iframe>
	</div>
</div>
</body>
</html>
