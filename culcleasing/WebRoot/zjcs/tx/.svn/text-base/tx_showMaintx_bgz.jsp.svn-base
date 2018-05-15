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
<title>调息 - 调息首页</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
    //央行利率基准表中的主键,通过该主键在表fund_adjust_interest_contract中查询对应的contract_id
	String txid = getStr(request.getParameter("czid"));//央行利率调息ID  
	String start_date = getStr(request.getParameter("start_date"));//调息开始日期  
	String adjust_method = getStr(request.getParameter("adjust_method"));//调息方式
	String adjust_flag = getStr(request.getParameter("adjust_flag"));//调息方式
	//ResultSet rs;
 	//rs = db.executeQuery(sql.toString());
	//rs.close();
 %>
<body style="overflow-y:auto;"> 
<div style="position: relative; left: 0px; top: 0px"  id="mydiv";>
    	<div id="tablesub">
			<iframe frameborder="0" name="rentplan" width="100%" height="400" 
			src="tx_showAll_ytx_bgz.jsp?txId=<%=txid%>&adjust_method=<%= adjust_method %>&adjust_flag=<%= adjust_flag %>&start_date=<%=start_date%>">
			</iframe>
		</div>
	    <div>
	    	<!-- 嵌入iframe到页面tx_showAll_wtx_bgz.jsp 所有未调息的列表的页面传入主键 -->
			<iframe frameborder="0" name="con" width="100%" height="400" 
				src="tx_showAll_wtx_bgz.jsp?txId=<%=txid%>&adjust_method=<%= adjust_method %>&adjust_flag=<%= adjust_flag %>&start_date=<%=start_date%>">
			</iframe>
		</div>

</div>
</body>
</html>
<%if(null != db){db.close();}%>