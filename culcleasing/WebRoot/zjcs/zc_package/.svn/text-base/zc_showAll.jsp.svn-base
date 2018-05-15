<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />

<!-- 租金测算模块首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>资产包管理 - 资产包详细信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
	String Zc_num = getStr(request.getParameter("Zc_num"));// 
	String UserName = getStr(request.getParameter("UserName"));// 
	String status = getStr(request.getParameter("status"));// 
	//System.out.println("doc_id==>"+doc_id);
 %>
<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    	<div id="tabletit" class="tabtitexp">&nbsp; 
    		资产包对应资产详细信息
    		<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
								<img src="../../images/hg.gif" align="absmiddle" border="0">关闭</button>
    	</div> 
	    <div>
			<iframe frameborder="0" name="con" width="100%" height="300" 
				src="zc_yDB_List.jsp?Zc_num=<%=Zc_num%>&UserName=<%=UserName%>&status=<%=status %>">
			</iframe>
		</div>
    	<div id="tabletit" class="tabtitexp">&nbsp; 
    		资产包对应发票信息
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="rentplan" width="100%" height="300" 
			src="fp_showYKP_List.jsp?Zc_num=<%=Zc_num%>&Fp_tt=<%=UserName%>">
			</iframe>
		</div>
%>		
</div>
</body>
</html>
