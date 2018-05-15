<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- 租金测算公用类 -->
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<!-- 租金测算只读首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 项目租金测算详细信息</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
    //合同交易结构表 contract_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//合同编号   "001";//
	String model = getStr(request.getParameter("model"));// "mod";// "";//
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
//System.out.println("proj_id-->"+proj_id+"<--doc_id-->"+doc_id);
	//调用后台方法
	model = condition.oper_proj_condition_temp(proj_id,doc_id);
	//查询交易结构表判断是否为手工调整租金
	String query_sql = "select * from  proj_condition_temp where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ";
	ResultSet rs; 
	rs = db.executeQuery(query_sql);
	rs.last();
	int count_data = rs.getRow();
	rs.beforeFirst();
	String measure_type = "";//租金计算方法
	String plan_irr = "";
	String market_irr = "";
	while(rs.next()){
		measure_type = getStr(rs.getString("measure_type"));//手工调整为3
		plan_irr = getDBStr(rs.getString("plan_irr"));
		market_irr = getDBStr(rs.getString("market_irr"));
	}
	rs.close();
	db.close();
	//初始化项目现金流
	int flag = condition.init_fund_rent_plan_proj_temp(proj_id,doc_id);
 %>
<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	    <div>
	    	<!-- 嵌入iframe到页面zjcs_businessAdd.jsp用于展示租金测算之前需要填写的信息例如：交易结构信息 proj_id为合同编号 model为判断增加删除修改操作  -->
			<iframe frameborder="0" name="con" width="100%" height="430" 
				src="show_projList.jsp?proj_id=<%=proj_id%>&model=<%=model%>&doc_id=<%=doc_id%>">
			</iframe>
		</div>
    	<div id="tabletit" class="tabtitexp">
    		租金偿还计划
    	</div> 
    	<div id="tablesub"><!-- show_proj_div_list.jsp   show_projrentplan.jsp -->
			<iframe frameborder="0" name="rentplan" width="100%" height="600" 
			src="show_proj_div_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&temp_type=zhiduPage&plan_irr=<%=plan_irr%>&market_irr=<%=market_irr%>&measure_type=<%=measure_type %>">
			</iframe>
		</div>
</div>
</body>
</html>
