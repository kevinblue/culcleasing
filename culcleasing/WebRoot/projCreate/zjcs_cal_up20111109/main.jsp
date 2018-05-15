<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ include file="../../func/common_simple.jsp"%>

<!-- 商务条件+租金测算模块首页 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>商务条件 - 拟商务条件制定</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //项目交易结构临时表 proj_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//合同编号   "001";//
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	//测试数据Id
	if(proj_id==null || "".equals(proj_id)){
		proj_id = "CULCTest022";
		doc_id = "JS999999900";
	}
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		商务条件&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
   	<!-- 商务条件制定，直接生成租金+现金流 -->
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="proj_cond_set.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
	</iframe>
   </div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		租金偿还计划&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div id="tablesub"> 
   		<!-- 展示租金计划数据 --> 
		<iframe frameborder="0" name="rentplan" width="100%" height="600" 
		src="rent_show.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
</div>
</body>
</html>
