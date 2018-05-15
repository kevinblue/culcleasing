<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- 租金测算模块首页 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>合同调息 - 调息前后对比</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script type="text/javascript">
	//调息回滚
	function tiaoxi_hg(){
		if(confirm("是否进行调息回滚操作?")){
			var sql_where = document.getElementById('sql_where').value;
			var contract_id = document.getElementById('contract_id').value;
			form1.action = "tx_back.jsp?sql_where="+sql_where+"&contract_id="+contract_id;
			form1.target = "_blank";
			form1.submit();
		}
	}
</script>
<script>
</script>
</head>
<%
    //通过该主键在表fund_adjust_interest_contract中查询对应的measure_id
	String custId = getStr(request.getParameter("custId")); 
	String start_date = getStr(request.getParameter("start_date")); //调息开始日期
	String contract_id = getStr(request.getParameter("contract_id")); 
	String adjust_flag = getStr(request.getParameter("adjust_flag")); //是否调息完成
	System.out.println("adjust_flag=====>"+adjust_flag);
	ResultSet rs;
	StringBuffer sql_first = new StringBuffer();//调息前列表SQL
	StringBuffer sql_last = new StringBuffer();//调息后
	
	//2010-12-10 代码新增 查询新旧利率
	String query_rate = " select before_rate,after_rate,isHG,hgCreateDate,hgCreator from fund_adjust_interest_contract where contract_id = '"+contract_id+"' and adjust_id = '"+custId+"'  ";
	ResultSet rs_r = null;
	String before_rate = ""; //旧
	String after_rate = "";//先
	String isHG = "";//是否回滚
	String hgCreateDate = "";//回滚时间
	String hgCreator = "";//回滚人
	rs_r = db.executeQuery(query_rate);
 	while(rs_r.next()){
 		before_rate = getDBStr(rs_r.getString("before_rate"));
 		after_rate = getDBStr(rs_r.getString("after_rate"));
 		isHG = getDBStr(rs_r.getString("isHG"));
 		hgCreateDate = getDBDateStr(rs_r.getString("hgCreateDate"));
 		hgCreator = getDBStr(rs_r.getString("hgCreator"));
 	}
 	if(isHG.equals("") || isHG == null){
 		isHG = "否";
 	}
 	//查询登录人 根据登录ID
 	String query_userName = " select * from base_user  where id = '"+hgCreator+"'";
 	rs_r = db.executeQuery(query_userName);
 	String  name = "";
 	while(rs_r.next()){
 		name = getDBStr(rs_r.getString("name"));
 	}
 	rs_r.close();
 	
	StringBuffer query_TXsql = new StringBuffer();//查询 调息开始期项
	query_TXsql.append(" select min(rent_list) as rent_list from fund_rent_plan ")
				.append(" where contract_id = '"+contract_id+"' ")
	            .append("  and plan_date > '"+start_date+"' ")//plan_date > 调息开始日期 
	            .append(" and plan_status = '未回笼' ");
	System.out.println("query_TXsql===>>  "+query_TXsql.toString());
 	rs = db.executeQuery(query_TXsql.toString());
 	String rent_num = "";//调息开始期项
 	while(rs.next()){
 		rent_num = getDBStr(rs.getString("rent_list"));
 	}
 	//计算利息差 调息后减去调息前
 	String end_interest = "";
 	StringBuffer sql =  new StringBuffer();
 	sql.append(" select (sum(case status when '后' then interest end) ")
 	   .append(" - ")
 	   .append(" sum(case status when '前' then interest end) )as end_interest ")
 	   .append(" from fund_rent_plan_his  ")
 	   .append(" where  mod_reason = '调息' ")
 	   .append(" and measure_id = '"+custId+"' ")
	   .append(" and  contract_id = '"+contract_id+"' ");
	ResultSet rs_one = db.executeQuery(sql.toString());
	while(rs_one.next()){
		end_interest = getDBStr(rs_one.getString("end_interest"));
	}
	rs_one.close();
	//查询交易结构
	String query_jyjg = " select  case   isnull(ajdustStyle,0)   when '0' then '次日' when '1' then '次月' when '2' then '次期' when '3' then '次年'  end   as ajdustStyle,case measure_type when '1' then '等额租金' end as measure_type from  contract_condition where contract_id = '"+contract_id+"'  and measure_type <> '0'";
	ResultSet  rs_cc = db.executeQuery(query_jyjg);
	String measure_type = "";//字段计算方法
	String ajdustStyle = "";//调息方式
	while(rs_cc.next()){
		measure_type = getDBStr(rs_cc.getString("measure_type"));
		ajdustStyle = getDBStr(rs_cc.getString("ajdustStyle"));
	}
	rs_cc.close();
 %>
<body style="overflow:auto;"> 
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">合同调息前后对比</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<form name="form1" method="post"  onSubmit="return false;">
<input type="hidden" id="adjust_flag" name="adjust_flag" value="<%=adjust_flag %>"/>  
<input type="hidden" id="custId" name="custId" value="<%=custId %>"/>  
<input type="hidden" id="contract_id" name="contract_id" value="<%=contract_id %>"/>  
<input type="hidden" id="sql_where" name="sql_where" value="<%="and mod_reason = '调息'  and status = '前' and measure_id = '"+custId+"'  and  contract_id = '"+contract_id+"'"%>"/>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="maintab_content_table">  
<% if(!"是".equals(adjust_flag) && !isHG.equals("是")){
%>	
	<tr scope="row" align="left">
		<td	colspan=2">
			<a href="#" onclick="tiaoxi_hg();">
            	<img src="../../images/sbtn_yijiao.gif" alt="调息回滚" border="0" align="absmiddle" >
            </a>
		</td>
	</tr>
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">调息日期：<%=getDBDateStr(start_date) %>&nbsp;&nbsp;&nbsp;调息开始期项：<%=rent_num %>&nbsp;&nbsp;调息是否完成:<%=adjust_flag %></td>
		<td>调息前后利息差为(调息后减调息前)：<%=end_interest%></td>
	</tr>
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">调息前利率：<%=before_rate%></td>
		<td>调息后利率：<%=after_rate%></td>
	</tr>
<%}else{ %>
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">调息日期：<%=getDBDateStr(start_date) %>&nbsp;&nbsp;&nbsp;调息开始期项：<%=rent_num %>&nbsp;&nbsp;调息是否完成:<%=adjust_flag %></td>
		<td>调息前后利息差为(调息后减调息前)：0</td>
	</tr>
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">调息前利率：<%=before_rate%></td>
		<td>调息后利率：<%=after_rate%></td>
	</tr>
<%} %>	
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">租金计算方法：<%=measure_type%></td>
		<td>调息方式：<%=ajdustStyle%></td>
	</tr>
	<tr scope="row" align="left">
		<td width="" class="cwDLRow">回滚状态：<%=isHG%></td>
		<td>回滚人：<%=name%>&nbsp;&nbsp;回滚时间：<%=getDBDateStr(hgCreateDate)%></td>
	</tr>
	
	<tr scope="row" align="center">
		<td>调息前偿还计划</td>
		<td>调息后偿还计划</td>
	</tr>

	<tr>
<%
		String query_sum = "  select SUM(rent) as sum_rent,SUM(corpus_market) as sum_corpus,SUM(interest_market) as sum_interest from fund_rent_plan_his  where 1=1   ";
		query_sum = query_sum + " and mod_reason = '调息'  and status = '前' and measure_id = '"+custId+"'  and  contract_id = '"+contract_id+"'  ";
		ResultSet rs_sum = db.executeQuery(query_sum);
		String sum_rent_b = "";
		String sum_corpus_b = "";
		String sum_interest_b = "";
		while(rs_sum.next()){
			sum_rent_b = getDBStr(rs_sum.getString("sum_rent"));
			sum_corpus_b = getDBStr(rs_sum.getString("sum_corpus"));
			sum_interest_b = getDBStr(rs_sum.getString("sum_interest"));
		}
		rs_sum.close();
		//调息前偿还计划列表
		sql_first.append(" select * from fund_rent_plan_his ")
			   .append(" where 1=1 ")
			   .append(" and mod_reason = '调息' ")
			   .append(" and status = '前' ")
			   .append(" and measure_id = '"+custId+"' ")
			   .append(" and  contract_id = '"+contract_id+"' ")
			   .append(" order by rent_list ");
	    System.out.println("sql_first.toString()==>>"+sql_first.toString());
 		rs = db.executeQuery(sql_first.toString());
 		rs.last();
 		int count_last = rs.getRow();
 		rs.beforeFirst();
 		if(count_last > 0){
%>

	  <td>
  	  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="0" cellspacing="0" width="100%" 
 class="maintab_content_table">
   				<tr class="maintab_content_table_title1">
					<th nowrap="nowrap">期项</th>
					<th nowrap="nowrap">计划状态</th>
					<th nowrap>承付日期</th>
					<th nowrap>租金</th>
					<th nowrap>本金</th>
					<th nowrap>租息</th>
					<th nowrap>本金余额</th>
				  </tr>
<%
	while(rs.next()){
%>
				<tr class="cwDLRow" >
					<td align="center" nowrap><%=getDBStr(rs.getString("rent_list"))%></td>
					<td align="center" nowrap><%=getDBStr(rs.getString("plan_status"))%></td>
					<td align="center" nowrap><%=getDBDateStr(rs.getString("plan_date"))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("rent")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("corpus_market")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("interest_market")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("corpus_overage_market")))%></td>
				  </tr>
<%	
	}
%>	
				<tr class="cwDLRow" >
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>合计:<%=formatNumberDoubleTwo(sum_rent_b)%></td>
					<td align="center" nowrap>合计:<%=formatNumberDoubleTwo(sum_corpus_b)%></td>
					<td align="center" nowrap>合计:<%=formatNumberDoubleTwo(sum_interest_b)%></td>
					<td align="center" nowrap>&nbsp;</td>
				  </tr>
<%	
}else{
%>	
				<tr class="cwDLRow" >
					<td align="center" nowrap>调息前偿还计划不存在!</td>
				</tr>			  
<%} %>				  
				  
			  </table>
		  </td>
<%
		//2011-01-04日修改 表名从fund_rent_plan_his 修改为 fund_rent_plan
		query_sum = "";
		query_sum = "  select SUM(rent) as sum_rent,SUM(corpus_market) as sum_corpus,SUM(interest_market) as sum_interest from fund_rent_plan_his  where 1=1   ";
		query_sum = query_sum + " and mod_reason = '调息'  and status = '后' and measure_id = '"+custId+"'  and  contract_id = '"+contract_id+"'  ";
		query_sum = query_sum + "   and  contract_id = '"+contract_id+"'  ";
		ResultSet rs_sum_a = db.executeQuery(query_sum);
		String sum_rent_a = "";
		String sum_corpus_a = "";
		String sum_interest_a = "";
		while(rs_sum_a.next()){
			sum_rent_a = getDBStr(rs_sum_a.getString("sum_rent"));
			sum_corpus_a = getDBStr(rs_sum_a.getString("sum_corpus"));
			sum_interest_a = getDBStr(rs_sum_a.getString("sum_interest"));
		}
		rs_sum_a.close();
		//调息后偿还计划列表
		//2011-01-06 需求调整  判断回滚状态 非是 就 查询状态为 后的  否则查询 前的   
		if(!"是".equals(isHG)){
			sql_last.append(" select * from fund_rent_plan_his ")
				   .append(" where 1=1 ")
				   .append(" and mod_reason = '调息' ")
				   .append(" and status = '后' ")
				   .append(" and measure_id = '"+custId+"' ")
				   .append("  and contract_id = '"+contract_id+"' ")
			  	 	.append(" order by rent_list ");
		}else{
			sql_last.append(" select * from fund_rent_plan_his ")
				    .append(" where 1=1 ")
				    .append(" and mod_reason = '调息' ")
				    .append(" and status = '前' ")
				    .append(" and measure_id = '"+custId+"' ")
				    .append(" and  contract_id = '"+contract_id+"' ")
			   		.append(" order by rent_list ");
		}
		//之前从	 fund_rent_plan 中查询
		//sql_last.append(" select * from fund_rent_plan ")
		//	   .append(" where 1=1 ")
		//	   .append("  and contract_id = '"+contract_id+"' ");
		System.out.println("sql_last.toString()==>>"+sql_last.toString());
 		rs = db.executeQuery(sql_last.toString());
 		rs.last();
 		int count_first = rs.getRow();
 		rs.beforeFirst();
%>
		  <td>
		  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="0" cellspacing="0" 
 width="100%" class="maintab_content_table" >
<%
	if(count_first > 0){
%>
   				<tr class="maintab_content_table_title1">
					<th nowrap>期项</th>
					<th nowrap>计划状态</th>
					<th nowrap>承付日期</th>
					<th nowrap>租金</th>
					<th nowrap>本金</th>
					<th nowrap>租息</th>					
					<th nowrap>本金余额</th>
				  </tr>
<%
	while(rs.next()){
%>
				<tr class="cwDLRow" >
					<td align="center" nowrap><%=getDBStr(rs.getString("rent_list"))%></td>
					<td align="center" nowrap><%=getDBStr(rs.getString("plan_status"))%></td>
					<td align="center" nowrap><%=getDBDateStr(rs.getString("plan_date"))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("rent")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("corpus_market")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("interest_market")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("corpus_overage_market")))%></td>
				  </tr>
<%	
	}
	%>	
				<tr class="cwDLRow" >
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>合计:<%=formatNumberDoubleTwo(sum_rent_a)%></td>
					<td align="center" nowrap>合计:<%=formatNumberDoubleTwo(sum_corpus_a)%></td>
					<td align="center" nowrap>合计:<%=formatNumberDoubleTwo(sum_interest_a)%></td>
					<td align="center" nowrap>&nbsp;</td>
				  </tr>
<%	
}else{
%>
	<tr class="cwDLRow" >
		<td align="center" rowspan="" nowrap>调息后偿还计划不存在!</td>
	</tr>
<%	
}
	rs.close();
	db.close();
%>	
			  </table>
		  </td>
      </tr>
    </table>
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td width=8 width="12">
<input name="btnClose" value="关闭" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
   </form>
</body>
</html>
