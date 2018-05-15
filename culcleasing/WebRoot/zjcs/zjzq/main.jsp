<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 租金测算模块首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 租金测算</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>

</script>
</head>
<%
    //合同交易结构表 contract_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//合同编号
	String model = getStr(request.getParameter("model"));
 %>
<body style="overflow:auto;"> 
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> 
		<br>租金测算 &gt; 租金测算</td>
	</tr>
</table>

<!-- end cwCellTop -->  

<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	<div id="tablenode"> 
		<div id="tabletit" class="tabtitexp">
    		<div class="icon"> </div>
    		拟商务条件
    	</div> 	    
	    <div id="tablesub">
	    	<!-- 嵌入iframe到页面zjcs_businessAdd.jsp用于展示租金测算之前需要填写的信息例如：交易结构信息 proj_id为合同编号 model为判断增加删除修改操作  -->
			<iframe frameborder="0" name="con" width="100%" height="450" 
				src="zjcs_businessAdd.jsp?proj_id=<%=proj_id%>&model=add"><!-- 暂时是修改操作 -->
			</iframe>
		</div>
	</div>
	
	<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp">
    		<div class="icon"> </div>
    		租金偿还计划
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="rentplan" width="100%" height="600" src="rentplan_frame.jsp?proj_id=<%= proj_id%>"></iframe>
		</div>
	</div>
<!-- end cwDataNav -->
</div>





<!-- end cwMain -->
</body>
</html>
