<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金展期 - 租金展期</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
<%String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
%>
</script>
</head>

<body style="overflow:auto;">

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				租金展期 &gt; 租金展期</td>
			</tr>
</table>


	

	

<!-- end cwCellTop -->



<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>展期前回笼计划</div> 
    <div id="tablesub">
		<iframe frameborder="0" width="100%" height="400" src="zjzq_zjhl.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&flag=1"></iframe>
	</div>
	</div>
	
  <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>展期信息</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="qs" width="100%" height="230" src="zjzq_fc.jsp"></iframe>
	</div>
	</div>

	<iframe frameborder="0" name="save" width="100%" height="0" src="zjzq_save.jsp"></iframe>

  <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>展期后租金回笼计划</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="hl" width="100%" height="200" src="zjzq_zjhl.jsp"></iframe>
		</div>
	</div>
	<div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>展期后现金流量情况</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="xj" width="100%" height="200" src="zjzq_zj.jsp"></iframe>
		</div>
	</div>

<!-- end cwDataNav -->
</div>





<!-- end cwMain -->
</body>
</html>
