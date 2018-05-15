<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@ page import="com.rent.calc.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />

<!-- 租金测算模块首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金测算 - 项目租金测算</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
</script>
</head>
<%
    //项目交易结构临时表 proj_condition_temp
	String proj_id = getStr(request.getParameter("proj_id"));//合同编号   "001";//
	String model = getStr(request.getParameter("model"));// "mod";// "";//
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号 "001";// measure_id
	//System.out.println("doc_id==>"+doc_id);
	LogWriter.logDebug(request, "商务条件JSP：输出proj_id:"+proj_id+" model:"+model+" doc_id:"+doc_id);
	//×××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××
	//××××××××××××××××××××××××××	初始化交易结构数据信息 ××××××××××××××××××××××××××××××
	//××××××××××××××××××××××××××						 ××××××××××××××××××××××××××××××
	//×××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××
	//model返回的值为add/mod 判断是否在temp有数据
	model = condition.oper_proj_condition_temp(proj_id,doc_id);
	
	//查询交易结构表判断是否为手工调整租金
	ResultSet rs = null; 
	String query_sql = "select measure_type,plan_irr,market_irr from  proj_condition_temp where proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ";
	rs = db.executeQuery(query_sql);
	
	String measure_type = "";//租金计算方法
	String plan_irr = "";
	String market_irr = "";
	while(rs.next()){
		measure_type = getStr(rs.getString("measure_type"));//不规则调整为0
		plan_irr = getDBStr(rs.getString("plan_irr"));
		market_irr = getDBStr(rs.getString("market_irr"));
	}
	rs.close();
	db.close();
	//测试用
	//measure_type = "3";
	
	//初始化项目现金流 -- 租金计划的copy
	int flag = condition.init_fund_rent_plan_proj_temp(proj_id,doc_id);
	//LogWriter.logDebug(request, "main页面的flag"+flag);
%>

<body style="overflow:auto;"> 
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <div>
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		商务条件&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
   	<!-- 嵌入iframe到页面zjcs_businessAdd.jsp用于展示租金测算之前需要填写的信息例如：交易结构信息 proj_id为合同编号 model为判断增加删除修改操作  -->
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="zjcs_proj_add.jsp?proj_id=<%=proj_id%>&model=<%=model%>&doc_id=<%=doc_id%>">
	</iframe>
	</div>
   </div>
<% 
	if(measure_type.equals("0")){//如果不为手工调整
%>		
		<div id="tabletit" class="tabtitexp">&nbsp; 
    		租金偿还计划不规则&nbsp;
   			<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   			style="cursor:hand" title="显示/隐藏内容">		
    	</div> 
    	<div id="tablesub">  
			<iframe frameborder="0" name="rentplan" width="100%" height="600" 
				src="bgz_zjcs_div_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&temp=proj_zjcs">
			</iframe>
		</div>
<% 
	}else{//如果为不规则调整则跳转到不规则调整的MIS首页
%>		
    	<div id="tabletit" class="tabtitexp">&nbsp; 
    		租金偿还计划 &nbsp;
   			<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   			style="cursor:hand" title="显示/隐藏内容">		
    	</div>
    	<div id="tablesub" >
			<iframe frameborder="0" name="rentplan" width="100%" height="1000" 
			src="zics_div_list.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>&market_irr=<%=market_irr %>&plan_irr=<%=plan_irr%>&measure_type=<%=measure_type %>">
			</iframe>
		</div>
<% 
	}
%>		
</div>
</body>
</html>
