<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��Ϣ���� - ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //��ͬ�š������š�doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� "001";// measure_id
	
	//ģ�⸳ֵ
	if(contract_id==null || "".equals(contract_id)){
		contract_id = "11CULC 010280L12";
		begin_id = "11CULC 010280L1284";
		doc_id = "JS999999900_HT11_44";
	}
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;height:100%;overflow:auto;position: relative; left: 0px; top: 0px">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		��Ϣ����&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div style="width:100%;height:98%">
   	<!-- ���������ƶ���ֱ���������+�ֽ��� -->
	<iframe frameborder="0" name="con" width="100%" height="100%"
		src="interest_subsidy.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>">
	</iframe>
   </div>
</div>
</body>
</html>
