<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��Ϣ - ��Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
<%
	String contract_id = "007";//getStr(request.getParameter("contract_id"));
	String doc_id = "";//getStr(request.getParameter("doc_id"));

%>
</script>
</head>
<body style="overflow:auto;">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			��Ϣ - ��Ϣ
		</td>
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	<div id="tablenode"> 
	  	<div id="tabletit" class="tabtitexp" onClick="expThis()">
	    	<div class="icon"></div>
	    	��Ϣǰ�������ƻ�
	    </div> 
	    <div id="tablesub">
			<iframe frameborder="0" name="oldhl" width="100%" height="400" 
				src="tx_zjhl.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&flag=2">
			</iframe>
		</div>
	</div>
	<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp" onClick="expThis()">
    		<div class="icon"></div>
    		��������Ϣ
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="qs" width="100%" height="180" src="tx_fc.jsp"></iframe>
		</div>
	</div>
	
		<iframe frameborder="0" name="save" width="100%" height="0" src="tx_save.jsp"></iframe>
		
	<div id="tablenode"> 
   		<div id="tabletit" class="tabtitexp" onClick="expThis()">
   			<div class="icon"></div>
   			��Ϣ���������ƻ�
   		</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="hl" width="100%" height="400" src="tx_zjhl.jsp"></iframe>
		</div>
	</div>
</div>
</body>
</html>
