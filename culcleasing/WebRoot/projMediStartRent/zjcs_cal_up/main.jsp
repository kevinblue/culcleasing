<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionMediService"%>
<%@page import="com.tenwa.culc.service.BeginMediService"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�������� - ������Ϣ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
    //��ͬ�š������š�doc_id
	String contract_id = getStr( request.getParameter("contract_id") );
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� "001";// measure_id
	String flow_date = getStr(request.getParameter("flow_date"));//����ʱ��
	
	//ģ�⸳ֵ
	if(contract_id==null || "".equals(contract_id)){
		contract_id = "12CULC040877L49";
		begin_id = "11CULC010631L8667G";
		doc_id = "JS999999900_HT11_44";
		flow_date = "2011-11-01";
	}
	//�ж��Ƿ�������
	boolean flag = ConditionMediService.judgeBeginType(contract_id);
	int begin_order_index=0;//�������к�
	if( flag ){//�������
		//������⣬ֻҪͨ�����ޱ�����п���
		begin_order_index = BeginMediService.getBeginOrderIndex(contract_id);
		//1.������������
		ConditionMediService.flowInitBeginTempData(contract_id, begin_id, doc_id);
	}else{
		//��ǩԼ�������ݽ��п���
		//1.������������
		ConditionMediService.flowInitBeginTempData(contract_id, begin_id, doc_id);
		
		begin_order_index = 1;
	}
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		������Ϣ&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="��ʾ/��������">				 
   	</div> 
   	<div>
   	<!-- ���������ƶ���ֱ���������+�ֽ��� -->
	<iframe id="qz" frameborder="0" name="con" width="100%" height="400" 
		src="proj_cond_set.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>&flow_date=<%=flow_date %>&begin_order_index=<%=begin_order_index %>">
	</iframe>
   </div>

</div>
</body>
</html>
