<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>

<%@ include file="../../func/common_simple.jsp"%>

<!-- 租金测算模块只读首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 项目租金测算</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
    //获取参数 proj_id,doc_id
	String proj_id = getStr(request.getParameter("proj_id"));//合同编号   "001";//
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	//测试proj_id,doc_id
	//proj_id = "00007-03-02-2010-00162-00000";
	//doc_id = "F54FA93C6C6E0F0B4825780300334D18";
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <div>
  	 <div id="tabletit" class="tabtitexp">&nbsp; 
   		租金偿还计划不规则&nbsp;
  		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
  		style="cursor:hand" title="显示/隐藏内容">		
   	</div> 
   	<div id="tablesub"> 
   	<!-- 嵌入iframe到页面zjcs_businessAdd.jsp用于展示租金测算之前需要填写的信息例如：交易结构信息 proj_id为合同编号 model为判断增加删除修改操作  -->
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="zjcs_proj_read.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
	</iframe>
	</div>
   </div>
   
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		租金偿还计划 &nbsp;
 		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
 		style="cursor:hand" title="显示/隐藏内容">		
   	</div> 
   	
   	<div id="tablesub">  
		<iframe frameborder="0" name="rentplan" width="100%" height="600" 
			src="zjcs_div_list_read.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
</div>
</body>
</html>
