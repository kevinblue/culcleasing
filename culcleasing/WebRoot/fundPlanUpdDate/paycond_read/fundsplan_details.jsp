<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@page import="com.tenwa.culc.service.RentPlanService"%>
<%@page import="com.tenwa.culc.service.RentCashService"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ʽ�ƻ��ϱ�����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<style type="text/css">

.buttonly {
	background: red url(overlay.png) repeat-x;
	display: inline-block;
	padding: 5px 10px 6px;
	color: #fff;
	text-decoration: none;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	-moz-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.6);
	text-shadow: 0 -1px 1px rgba(0,0,0,0.25);
	border-bottom: 1px solid rgba(0,0,0,0.25);
	position: relative;
	cursor: pointer
}
</style>
<script type="text/javascript" >
	
	function clostpl(){
		if(confirm("�Ƿ�ر�")){
			window.close();
		}else{
			return false;
		}
	}
</script>
</head>
<%
    //��ͬ�š�doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� "001";// measure_id
	
	%>

<body style="overflow:auto;"> 
<button class="buttonly" onclick="clostpl();">�ر�</button> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		��ͬ������Ϣ&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div>
   <div>
   	<!-- ��ͬ������Ϣ -->
	<iframe frameborder="0" name="contract_info" width="100%" height="220" 
		src="contract_basicinfo.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>">		
	</iframe>
   </div>
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		�ʽ���֧һ��&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div>
   	<div>
   	<!-- �ʽ���֧һ�� -->
	<iframe frameborder="0" name="con" width="100%" height="350" 
		src="funds_income.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>">
	</iframe>
   </div>
	<div id="tabletit" class="tabtitexp">&nbsp; 
   		�ʽ�ƻ��ϱ�(�޸���֧ʱ��)&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div id="tablesub"> 
   		<!-- ��𳥻��ƻ� --> 
		<iframe frameborder="0" name="rentplan" width="100%" height="600" 
		src="fundsplan_add.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
</div>
</body>
</html>
