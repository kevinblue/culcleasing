<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>明细 - 租赁公司收款</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
</head>



<body onload="fun_winMax();" style="overflow:auto;">
<iframe frameborder="0" name="list" width="100%" height="65%" src="leasing_list_search.jsp" style="overflow:auto;" >
</iframe>
<hr style="border:gray 1px solid;">
<iframe frameborder="0" name="deltail" width="100%" height="600px" src="leasing.jsp" style="overflow:auto;" >
</iframe>
</body>
</html>
