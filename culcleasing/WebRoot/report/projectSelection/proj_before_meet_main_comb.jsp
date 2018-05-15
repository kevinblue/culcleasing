<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>非标会前客户信息统计表 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">


</head>
<%
   
	String cust_id = getStr(request.getParameter("cust_id"));//
	
 %>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    	<div id="tablesub">
			<iframe frameborder="0" name="rentplan" width="100%" height="200" 
			src="proj_before_meet_list_detail1_comb.jsp?cust_id=<%=cust_id%>">
			</iframe>
		</div>
	    <div>
	    	
			<iframe frameborder="0" name="con" width="100%" height="570" 
				src="proj_before_meet_list_detail2_comb.jsp?cust_id=<%=cust_id%>">
			</iframe>
		</div>

</div>
</body>
</html>
<%if(null != db){db.close();}%>