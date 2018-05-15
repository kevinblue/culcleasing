<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 合同租金测算</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>

</script>
</head>
<%String lease_money = "";
String contract_id = getStr(request.getParameter("contract_id"));
String fund_id = getStr(request.getParameter("fund_id"));
String doc_id = getStr(request.getParameter("doc_id"));
String volume = getStr(request.getParameter("volume"));
String zq = getStr(request.getParameter("zq"))!=null?getStr(request.getParameter("zq")):"";
String sql = "";
if(fund_id!=null&&!fund_id.equals("")){
	sql = "select sum(corpus) as sum_corpus from fund_rent_plan where contract_id='"+contract_id+"' and id>="+fund_id;
	System.out.println(sql);
	ResultSet rssum = db.executeQuery(sql);
	if(rssum.next()){
		lease_money = getDBStr(rssum.getString("sum_corpus"));
	}
}
 %>
<body style="overflow:auto;">



	

	

<!-- end cwCellTop -->



<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>租金期次</div> 
    <div id="tablesub">
		<iframe frameborder="0" width="100%" height="550" src="zjbcht_list.jsp?lease_money=<%=lease_money %>&contract_id=<%=contract_id %>&fund_id=<%=fund_id %>&volume=<%=volume %>&zq=<%=zq %>&doc_id=<%=doc_id %>"></iframe>
	</div>
	</div>
	
  <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>租金期次</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="qs" width="100%" height="180" src="zjbcht_fc.jsp?lease_money=<%=lease_money %>&contract_id=<%=contract_id %>&fund_id=<%=fund_id %>&volume=<%=volume %>&zq=1"></iframe>
	</div>
	</div>

  <div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>租金回笼计划</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="hl" width="100%" height="200" src="zjbcht_zjhl.jsp"></iframe>
		</div>
	</div>
<div id="tablenode"> 
    <div id="tabletit" class="tabtitexp" onClick="expThis()"><div class="icon"></div>现金流量计划</div> 
    <div id="tablesub">
		<iframe frameborder="0" name="xj" width="100%" height="200" src="zjbcht_zj.jsp"></iframe>
		</div>
	</div>
<!-- end cwDataNav -->
</div>
<div>
<input type="button" name="关闭" onclick="window.close();opener.location.reload();">
<div>



<!-- end cwMain -->
</body>
</html>
<%db.close();%>