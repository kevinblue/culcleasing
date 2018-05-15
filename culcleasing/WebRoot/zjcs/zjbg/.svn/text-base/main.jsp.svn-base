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
</head>
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
	String measure_type = "";//租金计算方法 等额租金|等额本金|不规则|手工调整","1|2|0|3"
	if (rs_t.next()) {
		measure_type = getDBStr(rs_t.getString("measure_type"));
	}
	rs_t.close();
	//查询正式表 正式表 判断租金正式表是否存在数据 没有数据择不能进行变更
	String query_sql = " select * from  fund_rent_plan where contract_id = '"+contract_id+"'";
	ResultSet rs_o = db.executeQuery(query_sql);
	rs_o.last();
	int count_data = rs_o.getRow();
	rs_o.beforeFirst();	
	//将正式表偿还计划数据插入到临时表中
	int flag = condition.init_fund_rent_plan_temp(contract_id,doc_id,proj_id);
	//初始化现金流
	flag = condition.init_fcptemp(doc_id,contract_id);
%>  
  <body style="overflow:auto;">
 <% 
 	if("0".equals(measure_type)){
 %> 
 	<center>
  	<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
		暂不支持租金计算方式为不规则的租金变更!
	</div> 	
	</center>
 <% 
 	}else{
 %> 
  	<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	    <div id="tabletit" class="tabtitexp" >
			租金变更--当前偿还计划
	    </div> 
	    <div id="tablesub">
			<iframe frameborder="0" name="old_plan" width="100%" height="400"
			 src="zq_oldrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>">
			</iframe>
		</div>
		<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp">
    		租金变更--进行调整
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="ets_info" width="100%" height="100" 
			src="zq_ets.jsp?contract_id=<%=contract_id%>&proj_id=<%=proj_id%>&doc_id=<%=doc_id %>">
			</iframe>
		</div>
		<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp">
    		租金变更--变更后偿还计划
    	</div> 
    	<div id="tablesub"> 
			<iframe frameborder="0" name="new_plan" width="100%" height="700" 
			src="zibg_div_list.jsp?contract_id=<%=contract_id%>&proj_id=<%=proj_id %>&doc_id=<%=doc_id %>">
			</iframe>
		</div>
	</div>
	</div>
  	</div>
<%
	}
 %>
  </body>
</html>
<%if(null != db){db.close();}%>