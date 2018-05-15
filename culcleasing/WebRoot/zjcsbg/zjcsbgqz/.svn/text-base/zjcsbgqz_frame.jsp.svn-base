<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 租金测算</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>

</script>
</head>
<body style="overflow:auto;">

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				租金测算 &gt; 租金测算</td>
			</tr>
</table>

<%
String contract_id = getStr(request.getParameter("contract_id"));
String doc_id = getStr(request.getParameter("doc_id"));
String proj_id = getStr(request.getParameter("proj_id"));
String readonly = getStr(request.getParameter("readonly"));
 %>
	

	

<!-- end cwCellTop -->



<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	<div id="tablenode"> 
	    <div id="tabletit" class="tabtitexp" onClick="expThis()">
	    	<div class="icon">
	    	</div>
			租金期次
	    </div> 
	    <div id="tablesub">
			<iframe frameborder="0" name="con" width="100%" height="720" src="<%if(readonly!=null&&readonly.equals("1")){%>zjcsbgqz_cdtview.jsp<%}else{ %>zjcsbgqz_cdt.jsp<%} %>?cs=1&contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&proj_id=<%=proj_id %>&readonly=<%=readonly %>">
			</iframe>
		</div>
	</div>
	<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp" onClick="expThis()">
    		<div class="icon">
    		</div>
    		租金回笼计划
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="rentplan" width="100%" height="440" src="zjcsbgqz_rent.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&readonly=<%=readonly %>"></iframe>
		</div>
	</div>
<!-- end cwDataNav -->
</div>





<!-- end cwMain -->
</body>
</html>
