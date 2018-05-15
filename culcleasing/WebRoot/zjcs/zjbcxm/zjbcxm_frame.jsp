<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>项目租金测算 - 项目租金测算</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>

</script>
</head>
<%String lease_money = getStr(request.getParameter("lease_money"));
String project_id = getStr(request.getParameter("project_id"));
String fund_id = getStr(request.getParameter("fund_id"));
String volume = getStr(request.getParameter("volume"));
String jg = getStr(request.getParameter("jg"));
String zq = getStr(request.getParameter("zq"))!=null?getStr(request.getParameter("zq")):"";
 %>
<body style="overflow:auto;">



	

	

<!-- end cwCellTop -->



<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>租金期次</div> 
    <div id="tablesub">
		<iframe frameborder="0" width="100%" height="550" src="zjbcxm_list.jsp?lease_money=<%=lease_money %>&project_id=<%=project_id %>&fund_id=<%=fund_id %>&volume=<%=volume %>&zq=<%=zq %>&jg=<%=jg %>"></iframe>
	</div>
	</div>
	
  <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>租金期次</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="qs" width="100%" height="180" src="zjbcxm_fc.jsp"></iframe>
	</div>
	</div>

  <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>租金回笼计划</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="hl" width="100%" height="200" src="zjbcxm_zjhl.jsp"></iframe>
		</div>
	</div>
	<div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>现金流量计划</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="xj" width="100%" height="200" src="zjbcxm_zj.jsp"></iframe>
		</div>
	</div>

<!-- end cwDataNav -->
</div>
<!-- end cwMain -->
</body>
</html>
