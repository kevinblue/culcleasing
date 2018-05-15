<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ include file="../../func/common_simple.jsp"%>

<!-- 或有租金修订 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>或有租金修订</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

</head>
<%
    //或有租金修订 proj_condition_temp
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号   "001";//
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	//测试数据Id
	if(contract_id==null || "".equals(contract_id)){
		contract_id = "CULCTest02233";
		doc_id = "JS99999990004";
	}
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		或有租金&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>

	<iframe frameborder="0" id="con" name="con" width="100%" height="500" 
		src="rent_hy_set.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id%>">
	</iframe>
   </div>
</div>
</body>
</html>
