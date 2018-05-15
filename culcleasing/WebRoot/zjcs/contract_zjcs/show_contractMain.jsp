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
<!-- 合同--租金测算模块首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 合同交易结构详细信息 </title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
    //合同交易结构表 contract_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//项目编号   "001";//
	String model = getStr(request.getParameter("model"));// "";//
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号   measure_id
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号  
//System.out.println("proj_id-->"+proj_id+"<--doc_id-->"+doc_id);
	//调用初始化表数据方法
	model = condition.Oper_Contract_Condition_Temp(proj_id,doc_id,contract_id);
	
	String query_sql = "select * from  contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'";
	ResultSet rs; 
	rs = db.executeQuery(query_sql);
	System.out.println("query_sql======>   :"+query_sql);
	rs.last();
	int count_data = rs.getRow();
	rs.beforeFirst();
	String measure_type = "";//租金计算方法
	String plan_irr = "";//财务IRR
	String market_irr = "";//市场IRR
	while(rs.next()){
		measure_type = getStr(rs.getString("measure_type"));//手工调整为3
		plan_irr = getDBStr(rs.getString("plan_irr"));
		market_irr = getDBStr(rs.getString("market_irr"));
	}
	
//System.out.println("main页面最终的三个参数值为^^^^proj_id为:^"+proj_id+"^^^^model为:^^^"+model+"^^^^^doc_id为:"+doc_id);
 %>
 
<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	    <div>
	    	<!-- 嵌入iframe到页面zjcs_businessAdd.jsp用于展示租金测算之前需要填写的信息例如：交易结构信息 proj_id为项目编号 model为判断增加删除修改操作  -->
			<iframe frameborder="0" name="con" width="100%" height=400" 
				src="show_contractList.jsp?proj_id=<%=proj_id%>&model=<%=model%>&doc_id=<%=doc_id%>&contract_id=<%=contract_id%>">
			</iframe>
		</div>
    	<div id="tabletit" class="tabtitexp"> 
    		合同租金偿还计划 
    	</div> 
    	<div id="tablesub"><!-- zjcs_div_zhidu_list.jsp   show_contractRentplan.jsp -->
			<iframe frameborder="0" name="rentplan" width="100%" height="800" 
			src="zjcs_div_zhidu_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&contract_id=<%=contract_id%>&temp_type=zhiduPage&plan_irr=<%=plan_irr%>&market_irr=<%=market_irr%>">
			</iframe>
		</div>
</div>
</body>
</html>
<%if(null != db){db.close();}%>