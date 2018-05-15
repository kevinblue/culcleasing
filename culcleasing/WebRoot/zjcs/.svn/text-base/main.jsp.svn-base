<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- 租金测算模块首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 租金测算</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>

</script>
</head>
<%
    //合同交易结构表 contract_condition_temp
	String doc_id = getStr(request.getParameter("doc_id"));
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	String model = getStr(request.getParameter("model"));
 %>
<body style="overflow:auto;"> 
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> 
		<br>租金测算 &gt; 租金测算</td>
	</tr>
</table>

<!-- end cwCellTop -->  

<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	<div id="tablenode"> 	    
	    <div id="tablesub">
	    	<!-- 嵌入iframe到页面condition_frame.jsp用于展示租金测算之前需要填写的信息  -->
			<iframe frameborder="0" name="con" width="100%" height="400" 
				src="condition_frame.jsp?doc_id=<%= doc_id%>&contract_id=<%= contract_id%>&model=<%= model%>">
			</iframe>
		</div>
	</div>
	
	<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp">
    		<div class="icon"> </div>
    		租金偿还计划
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="rentplan" width="100%" height="600" src="rentplan_frame.jsp?doc_id=<%= doc_id%>&contract_id=<%= contract_id%>"></iframe>
		</div>
	</div>
<!-- end cwDataNav -->
</div>





<!-- end cwMain -->
</body>
</html>
