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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 偿还计划变更</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>

</script>
</head>
<body style="overflow:auto;">
<%
	String proj_id = getStr(request.getParameter("proj_id")); //项目编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号  "FA6FFC6AC326B1CF4825772E0027A83E";//
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号 "2010-00002-002-175";//
	//调用后台方法
	String model = condition.Oper_Contract_Condition_Temp(proj_id,doc_id,contract_id);
	//手工调整的话则直接进入另外的页面 加判断
	//首先要判断 该编号下的租金计划是手工调整还是其余的调整方式
	//从合同租金临时表中查询
	String sql = " select * from contract_condition_temp where contract_id = '"
			+ contract_id + "' and measure_id = '" + doc_id + "'";
	ResultSet rs_t = db.executeQuery(sql);
	System.out.println("查询contract_condition_temp表: "+sql);
	String measure_type = "";//租金计算方法 等额租金|等额本金|不规则|手工调整","1|2|0|3"
	String income_number = "";
	String income_day = "";
	String plan_irr = "";//财务IRR
	String market_irr = "";//市场IRR
	String delay = "";//延迟期
	String grace = "";//宽限期
	if (rs_t.next()) {
		income_number = getDBStr(rs_t.getString("income_number"));
		income_day = getDBStr(rs_t.getString("income_day"));
		measure_type = getDBStr(rs_t.getString("measure_type"));
		plan_irr = getDBStr(rs_t.getString("plan_irr"));
		market_irr = getDBStr(rs_t.getString("market_irr"));
		delay = getZeroStr(rs_t.getString("delay"));
		grace = getZeroStr(rs_t.getString("grace"));
	}
	rs_t.close();
	//查询正式表 正式表 判断租金正式表是否存在数据 没有数据择不能进行变更
	String query_sql = " select * from  fund_rent_plan where contract_id = '"+contract_id+"'";
	ResultSet rs_o = db.executeQuery(query_sql);
	rs_o.last();
	int count_data = rs_o.getRow();
	rs_o.beforeFirst();	
	rs_o.close();
	//2011-03-28 增加修改：将正式表偿还计划数据插入到临时表前先删除临时表的数据
	String d_sql = " delete from fund_rent_plan_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'  ";
	db.executeUpdate(d_sql);
	//将正式表偿还计划数据插入到临时表中
	int flag = condition.init_fund_rent_plan_temp(contract_id,doc_id,doc_id);
	String query_1 = " select isnull(COUNT(*),0) as sum1 from fund_contract_plan_temp where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"' ";
	ResultSet rs_1 = db.executeQuery(query_1);
	String sum1 = "0";
	if(rs_1.next()){
		sum1 = getDBStr(rs_1.getString("sum1"));
	}
	rs_1.close();
	if(Integer.parseInt(sum1) <= 0){
		//初始化现金流
		flag = condition.init_fund_contract_plan_temp(doc_id,contract_id);
	}
	
	String query_2 = " select isnull(COUNT(*),0) as sum2 from fund_contract_plan_mark_temp where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"' ";
	ResultSet rs_2 = db.executeQuery(query_2);
	String sum2 = "0";
	if(rs_2.next()){
		sum2 = getDBStr(rs_2.getString("sum2"));
	}
	rs_2.close();
	if(Integer.parseInt(sum2) <= 0){
		//初始化现金流
		flag = condition.init_fund_contract_plan_mark_temp(doc_id,contract_id);
	}

%>

<!-- end cwCellTop -->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
<%
	//存在数据并且租金计算方式不为不规则调整时才进行租金变更操作
	if(count_data > 0 && !measure_type.equals("0")){
%>	
	<div id="tablenode">  
	    <div id="tabletit" class="tabtitexp" >
			租金变更--当前偿还计划
	    </div> 
	    <div id="tablesub">
			<iframe frameborder="0" name="old_plan" width="100%" height="400"
			 src="zq_oldrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>">
			</iframe>
		</div>
	</div>
	<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp">
    		租金变更--进行调整
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="ets_info" width="100%" height="100" 
			src="zq_ets.jsp?contract_id=<%=contract_id%>&proj_id=<%=proj_id%>&doc_id=<%=doc_id %>&income_number=<%=income_number%>&income_day=<%=income_day%>&delay=<%=delay%>&grace=<%=grace%>">
			</iframe>
		</div>
	</div>
	<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp">
    		租金变更--变更后偿还计划
    	</div> 
    	<div id="tablesub"><!-- showBG_div_list.jsp   zibg_div_list.jsp -->
			<iframe frameborder="0" name="new_plan" width="100%" height="500" 
			src="zibg_div_list.jsp?contract_id=<%=contract_id%>&proj_id=<%=proj_id %>&doc_id=<%=doc_id %>&plan_irr=<%=plan_irr%>&market_irr=<%=market_irr %>">
			</iframe>
		</div>
	</div>
<% 
	}
    else if(count_data <= 0){
%>
	<div id="tablenode"> 
	    <div id="tabletit" class="tabtitexp" >
	    	<div class="icon">
	    	</div>
			租金变更--当前偿还计划
	    </div> 
	    <div id="tablesub">
		    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
		      <tr class="maintab_content_table_title">
				<th>计划日期</th>
				<th>期数</th>
				<th>租金</th>
				<th>本金</th>
				<th>利率(%)</th>
				<th>利息</th>
				<th>剩余本金</th>
				<th>回笼状态</th>
		      </tr>
		      <tr align="center">
		      	<td align="center" colspan="8">当前偿还计划没有数据无法进行租金调整!</td>
		      </tr>
		</div>
	</div>
<% 
	}else{
%>
	<div id="tablenode"> 
		跳转到手工调整页面，该功能暂时为实现!
	</div>
<% 
	}
%>
<!-- end cwDataNav -->
</div>
<!-- end cwMain -->
</body>
</html>
<%if(null != db){db.close();}%>