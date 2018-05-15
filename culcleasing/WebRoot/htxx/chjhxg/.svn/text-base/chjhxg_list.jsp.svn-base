<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 偿还计划修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">
<form action="chjhxg_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				合同信息 &gt; 偿还计划修改</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%

String sqlstr;
ResultSet rs;
String curr_date = getSystemDate(0);
String wherestr = " where 1=1";
String doc_id = getStr( request.getParameter("doc_id") );
String contract_id = getStr( request.getParameter("contract_id") );

if(doc_id.equals("")){
	wherestr=" where 1=0";
}else{
	wherestr+=" and fund_rent_plan_temp.measure_id='"+doc_id+"'";
}
//判断temp表中有没有数据
String data_flag="0";
sqlstr="select * from fund_rent_plan_temp where measure_id='"+doc_id+"'";
System.out.println("sqlstr0=================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	data_flag="1";
}rs.close();
if(data_flag.equals("0")){
	sqlstr="insert into fund_rent_plan_temp( measure_id,measure_date, contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate, interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type, creator,create_date,modificator,modify_date ) select '"+doc_id+"','"+curr_date+"', contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate, interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type, creator,create_date,modificator,modify_date from fund_rent_plan where contract_id='"+contract_id+"'";
	System.out.println("sqlstr1=================="+sqlstr);
	db.executeUpdate(sqlstr);
}
//处理交易结构
data_flag="0";
sqlstr="select * from contract_condition_temp where measure_id='"+doc_id+"'";
System.out.println("sqlstr2=================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	data_flag="1";
}rs.close();
if(data_flag.equals("0")){
	sqlstr="insert into contract_condition_temp (contract_id, equip_amt, lease_money, lease_term, income_number_year, income_number, year_rate, rate_float_type, period_type, settle_method, income_day, start_date, accounting_start_date, first_date, second_date, first_payment_ratio, first_payment, first_payment_in_ratio, first_payment_in, caution_money_ratio, caution_money, lessee_caution_ratio, lessee_caution_money, vndr_caution_ratio, vndr_caution_money, sale_caution_ratio, sale_caution_money, caution_deduction_ratio, caution_deduction_money, handling_charge_ratio, handling_charge, return_ratio, return_amt, supervision_fee_ratio, supervision_fee, consulting_fee, other_fee, nominalprice, insurance_method, insurance_lessor, insurance_lessee, redressalk, pena_rate, total_amt, actual_fund, rough_earn, year_earn, irr, plan_irr, agree_penalty_days, measure_id, creator, create_date, modificator, modify_date) select contract_id, equip_amt, lease_money, lease_term, income_number_year, income_number, year_rate, rate_float_type, period_type, settle_method, income_day, start_date, accounting_start_date, first_date, second_date, first_payment_ratio, first_payment, first_payment_in_ratio, first_payment_in, caution_money_ratio, caution_money, lessee_caution_ratio, lessee_caution_money, vndr_caution_ratio, vndr_caution_money, sale_caution_ratio, sale_caution_money, caution_deduction_ratio, caution_deduction_money, handling_charge_ratio, handling_charge, return_ratio, return_amt, supervision_fee_ratio, supervision_fee, consulting_fee, other_fee, nominalprice, insurance_method, insurance_lessor, insurance_lessee, redressalk, pena_rate, total_amt, actual_fund, rough_earn, year_earn, irr, plan_irr, agree_penalty_days, '"+doc_id+"', creator, create_date, modificator, modify_date from contract_condition where contract_id='"+contract_id+"'";
	System.out.println("sqlstr3=================="+sqlstr);
	db.executeUpdate(sqlstr);
}

sqlstr = "select fund_rent_plan_temp.id,fund_rent_plan_temp.measure_id,fund_rent_plan_temp.measure_date,fund_rent_plan_temp.contract_id,fund_rent_plan_temp.rent_list,fund_rent_plan_temp.plan_status,fund_rent_plan_temp.plan_date,fund_rent_plan_temp.eptd_rent,fund_rent_plan_temp.rent,fund_rent_plan_temp.corpus,fund_rent_plan_temp.year_rate,fund_rent_plan_temp.interest,fund_rent_plan_temp.rent_overage,fund_rent_plan_temp.corpus_overage,fund_rent_plan_temp.interest_overage,fund_rent_plan_temp.penalty_overage,fund_rent_plan_temp.penalty,fund_rent_plan_temp.rent_type,fund_rent_plan_temp. creator,fund_rent_plan_temp.create_date,fund_rent_plan_temp.modificator,fund_rent_plan_temp.modify_date from fund_rent_plan_temp" + wherestr; 
sqlstr +=" order by fund_rent_plan_temp.rent_list";
System.out.println("sqlstr2=================="+sqlstr);
%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	
		<td><a href="#" accesskey="n" onclick="dataHander('add','chjhxg_add.jsp?doc_id=<%=doc_id %>&contract_id=<%=contract_id %>',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td>
		<td><a href="#" accesskey="m" onclick="dataHander('mod','chjhxg_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onclick="dataHander('del','chjhxg_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td>
    </tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 200;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>


<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>

<!--翻页控制结束-->






<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th>合同编号</th>
        <th>期项</th>
        <th>状态</th>
        <th>承付日期</th>
        <th>租金</th>
        <th>本金</th>
        <th>年利率</th>
        <th>利息</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("id") ) %>"></td>
        <td><a href="chjhxg.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank"><%= getDBStr(rs.getString("contract_id") ) %></a></td>
		<td><%= getDBStr( rs.getString("rent_list") ) %></td> 
		<td><%= getDBStr( rs.getString("plan_status") ) %></td> 
		<td><%= getDBDateStr( rs.getString("plan_date") ) %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("corpus") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("year_rate") ),"#,##0.0000") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("interest") ),"#,##0.00") %></td> 
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
		<tr>
			<td></td>
			<td colspan="8"><a href="../ysss/tmp_blj_tzq_list.jsp?doc_id=<%= doc_id %>" target="_blank">日程表</a></td>
	      </tr>
    </table>
</div>

<!--报表结束-->
</form>
</body>
</html>
