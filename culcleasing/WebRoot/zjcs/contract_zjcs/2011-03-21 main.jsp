<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- �����㹫���� -->
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<!-- ��ͬ--������ģ����ҳ -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ͬ���׽ṹ - ������</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
    //��ͬ���׽ṹ�� contract_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//��Ŀ���   "001";//
	String model = getStr(request.getParameter("model"));// "";//
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����   measure_id
	String contract_id = getStr(request.getParameter("contract_id"));//��ͬ���  
	//���ó�ʼ�������ݷ���
	model = condition.Oper_Contract_Condition_Temp(proj_id,doc_id,contract_id);
	System.out.println("model======>   :"+model);
	//��ѯ���׽ṹ���ж��Ƿ�Ϊ�ֹ��������
	String query_sql = "select * from  contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'";
	ResultSet rs; 
	rs = db.executeQuery(query_sql);
	System.out.println("query_sql======>   :"+query_sql);
	rs.last();
	int count_data = rs.getRow();
	rs.beforeFirst();
	String measure_type = "";//�����㷽��
	String plan_irr = "";//����IRR
	String market_irr = "";//�г�IRR
	while(rs.next()){
		measure_type = getStr(rs.getString("measure_type"));//�ֹ�����Ϊ3
		plan_irr = getDBStr(rs.getString("plan_irr"));
		market_irr = getDBStr(rs.getString("market_irr"));
	}
	//������
	//measure_type = "3";
	System.out.println("measure_type=====>"+measure_type);
	//��ʼ����ͬ��𳥻��ƻ�����
	int flag = condition.init_fund_rent_plan_temp(contract_id,doc_id,proj_id);
 %>
 
<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	    <div>
	    	<!-- Ƕ��iframe��ҳ��zjcs_businessAdd.jsp����չʾ������֮ǰ��Ҫ��д����Ϣ���磺���׽ṹ��Ϣ proj_idΪ��Ŀ��� modelΪ�ж�����ɾ���޸Ĳ���  -->
			<iframe frameborder="0" name="con" width="100%" height=390" 
				src="zjcs_contractAdd.jsp?proj_id=<%=proj_id%>&model=<%=model%>&doc_id=<%=doc_id%>&contract_id=<%=contract_id%>">
			</iframe>
		</div>
<% 
	if(!measure_type.equals("3")){//�����Ϊ�ֹ�����
%>	
    	<div id="tabletit" class="tabtitexp"> 
    		��ͬ��𳥻��ƻ� 
    	</div> 
    	<div id="tablesub"><!-- zjcs_div_list.jsp  rentplan_frame.jsp -->
			<iframe frameborder="0" name="rentplan" width="100%" height="1000" 
			src="zjcs_div_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&contract_id=<%=contract_id%>&plan_irr=<%=plan_irr%>&market_irr=<%=market_irr%>">
			</iframe>
		</div>
<% 
	}else{//���Ϊ�ֹ���������ת���ֹ�������MIS��ҳ
%>		
    	<div id="tabletit" class="tabtitexp">&nbsp; 
    		��ͬ��𳥻��ƻ��ֹ�����
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="rentplan1" width="100%" height="700" 
				src="../zjcs_sg/zjcs_sg_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&contract_id=<%=contract_id%>&temp=contract_zjcs">
			</iframe>
		</div>
<% 
	}
%>		
</div>
</body>
</html>
