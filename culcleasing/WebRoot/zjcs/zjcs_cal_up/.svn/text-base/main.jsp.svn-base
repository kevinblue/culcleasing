<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@ page import="com.rent.calc.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />

<!-- 租金测算模块首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 项目租金测算</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
    //项目交易结构临时表 proj_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//合同编号   "001";//
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   <div>
   	<!-- 嵌入iframe到页面zjcs_businessAdd.jsp用于展示租金测算之前需要填写的信息例如：交易结构信息 proj_id为合同编号 model为判断增加删除修改操作  -->
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="zjcs_proj_add.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
	</iframe>
   </div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		租金偿还计划不规则
   	</div> 
   	<div id="tablesub">  
		<iframe frameborder="0" name="rentplan" width="100%" height="600" 
			src="zjcs_div_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
</div>
</body>
</html>
