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


	

	

<!-- end cwCellTop -->



<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	<div id="tablenode"> 
	    <div id="tabletit" class="tabtitexp" onClick="expThis()">
	    	<div class="icon">
	    	</div>
			租金期次
	    </div> 
	    <div id="tablesub">
			<iframe frameborder="0" name="con" width="100%" height="740" src="zjcsbg_cdt.jsp">
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
			<iframe frameborder="0" name="rentplan" width="100%" height="400" src="zjcsbg_rent.jsp"></iframe>
		</div>
	</div>
<!-- end cwDataNav -->
</div>





<!-- end cwMain -->
</body>
</html>
