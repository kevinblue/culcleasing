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
<!-- ������ֻ����ҳ -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������ - ��Ŀ��������ϸ��Ϣ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
    //��ͬ���׽ṹ�� contract_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//��ͬ���   "001";//
	String model = getStr(request.getParameter("model"));// "mod";// "";//
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� "001";// measure_id
//System.out.println("proj_id-->"+proj_id+"<--doc_id-->"+doc_id);
	//���ú�̨����
	model = condition.oper_proj_condition_temp(proj_id,doc_id);
	//��ѯ���׽ṹ���ж��Ƿ�Ϊ�ֹ��������
	String query_sql = "select * from  proj_condition_temp where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ";
	ResultSet rs; 
	rs = db.executeQuery(query_sql);
	rs.last();
	int count_data = rs.getRow();
	rs.beforeFirst();
	String measure_type = "";//�����㷽��
	String plan_irr = "";
	String market_irr = "";
	while(rs.next()){
		measure_type = getStr(rs.getString("measure_type"));//�ֹ�����Ϊ3
		plan_irr = getDBStr(rs.getString("plan_irr"));
		market_irr = getDBStr(rs.getString("market_irr"));
	}
	rs.close();
	db.close();
	//��ʼ����Ŀ�ֽ���
	int flag = condition.init_fund_rent_plan_proj_temp(proj_id,doc_id);
 %>
<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	    <div>
	    	<!-- Ƕ��iframe��ҳ��zjcs_businessAdd.jsp����չʾ������֮ǰ��Ҫ��д����Ϣ���磺���׽ṹ��Ϣ proj_idΪ��ͬ��� modelΪ�ж�����ɾ���޸Ĳ���  -->
			<iframe frameborder="0" name="con" width="100%" height="430" 
				src="show_projList.jsp?proj_id=<%=proj_id%>&model=<%=model%>&doc_id=<%=doc_id%>">
			</iframe>
		</div>
    	<div id="tabletit" class="tabtitexp">
    		��𳥻��ƻ�
    	</div> 
    	<div id="tablesub"><!-- show_proj_div_list.jsp   show_projrentplan.jsp -->
			<iframe frameborder="0" name="rentplan" width="100%" height="600" 
			src="show_proj_div_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&temp_type=zhiduPage&plan_irr=<%=plan_irr%>&market_irr=<%=market_irr%>&measure_type=<%=measure_type %>">
			</iframe>
		</div>
</div>
</body>
</html>
