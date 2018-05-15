<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金计划 - 偿还计划修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String dqczy=(String) session.getAttribute("czyid");

%>


<body onload="public_onload(0);">
<form action="chjhxg_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				租金计划 &gt; 偿还计划修改</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%

String curr_date = getSystemDate(0);

String sqlstr;
ResultSet rs;
String wherestr = " where 1=1";

String contract_id=getStr( request.getParameter("contract_id") );
sqlstr="select fund_rent_income.*,ifelc_conf_dictionary.title as balance_mode_name from fund_rent_income left join ifelc_conf_dictionary on fund_rent_income.balance_mode=ifelc_conf_dictionary.name where fund_rent_income.contract_id='"+contract_id+"'";
//sqlstr="select fund_rent_income.* from fund_rent_income";

%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		
		
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
		<th>合同编号</th>
        <th>网银编号</th>
        <th>计划期项</th>
        <th>回笼期项</th>
        <th>回笼类型</th>
        <th>结算方式</th>
        <th>回笼日期</th>
        <th>单据号</th>
        <th>回笼租金</th>
        <th>回笼本金</th>
        <th>回笼租息</th>
        <th>回笼罚息</th>
        <th>租金调整</th>
        <th>本金调整</th>
        <th>租息调整</th>
        <th>罚息调整</th>
        <th>付款来源</th>
        <th>付款人</th>
        <th>回笼到位银行</th>
        <th>回笼银行账户</th>
        <th>回笼银行帐号</th>
        <th>会计处理日</th>
        <th>备注</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
		<td><%= getDBStr( rs.getString("contract_id") ) %></td> 
		<td><%= getDBStr( rs.getString("ebank_number") ) %></td> 
		<td><%= getDBStr( rs.getString("plan_list") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_list") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_type") ) %></td> 
		<td><%= getDBStr( rs.getString("balance_mode_name") ) %></td>
		<td><%= getDBDateStr( rs.getString("hire_date") ) %></td> 
		<td><%= getDBStr( rs.getString("invoice_no") ) %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("corpus") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("interest") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("penalty") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("rent_adjust") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("corpus_adjust") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("interest_adjust") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("penalty_adjust") ),"#,##0.00") %></td> 
		<td><%= getDBStr( rs.getString("hire_source") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_object") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_bank") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_account") ) %></td>
		<td><%= getDBStr( rs.getString("hire_number") ) %></td> 
		<td><%= getDBDateStr( rs.getString("accounting_date") ) %></td> 
		<td><%= getDBStr( rs.getString("memo") ) %></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
		
    </table>
</div>

<!--报表结束-->
</form>
</body>
</html>
