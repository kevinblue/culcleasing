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
<title>������ - �����ͬ���׽ṹ��ϸ��Ϣ </title>
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
//System.out.println("proj_id-->"+proj_id+"<--doc_id-->"+doc_id);
	//���ó�ʼ�������ݷ���
	model = condition.Oper_Contract_Condition_Temp(proj_id,doc_id,contract_id);
//System.out.println("mainҳ�����յ���������ֵΪ^^^^proj_idΪ:^"+proj_id+"^^^^modelΪ:^^^"+model+"^^^^^doc_idΪ:"+doc_id);
	
	String query_sql = "select * from  contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'";
	ResultSet rs; 
	rs = db.executeQuery(query_sql);
	System.out.println("query_sql======>   :"+query_sql);
	String plan_irr = "";//����IRR
	String market_irr = "";//�г�IRR
	//String measure_type = "";//�����㷽��
	while(rs.next()){
	//	measure_type = getStr(rs.getString("measure_type"));//�ֹ�����Ϊ3
		plan_irr = getDBStr(rs.getString("plan_irr"));
		market_irr = getDBStr(rs.getString("market_irr"));
	}
	
	//��ʼ����ͬ��𳥻��ƻ�����
	int flag = condition.init_fund_rent_plan_temp(contract_id,doc_id,proj_id);
	
	
 %>
 
<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	    <div>
			<iframe frameborder="0" name="con" width="100%" height=450" 
				src="show_qz_contractList.jsp?proj_id=<%=proj_id%>&model=<%=model%>&doc_id=<%=doc_id%>&contract_id=<%=contract_id%>">
			</iframe>
		</div>
    	<div id="tabletit" class="tabtitexp"> 
    		��ͬ��𳥻��ƻ� 
    	</div> 
    	<div id="tablesub"><!-- zjcs_div_qz_list.jsp show_qz_contractRentplan.jsp  -->
			<iframe frameborder="0" name="rentplan" width="100%" height="800" 
			src="zjcs_div_qz_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&contract_id=<%=contract_id%>&temp_type=zhiduPage&plan_irr=<%=plan_irr%>&market_irr=<%=market_irr%>">
			</iframe>
		</div>
</div>
</body>
</html>
<%if(null != db){db.close();}%>