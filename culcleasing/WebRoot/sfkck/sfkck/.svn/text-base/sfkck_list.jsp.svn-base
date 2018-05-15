<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("advance-sfkck-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>首付款提醒表 - 首付款提醒表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String context = request.getContextPath();
String searchKeyDate = getStr( request.getParameter("searchKeyDate") );
if(searchKeyDate.equals("")){
	searchKeyDate=getSystemDate(0);
}
ResultSet rs;
String sqlstr = "select DISTINCT * from (select con.contract_id,equip_sn,cust_name,dbo.fk_getname(proj_dept) as sale_name,begin_payment,isnull((select sum(fact_money) from fund_fund_charge_lsm where contract_id=info.contract_id and (fee_type=11 or fee_type=15 or fee_type=13 )),0) as fact_money, dateadd(dd,isnull(special_date_number,0),out_time) as pay_date,isnull(datediff(dd,dateadd(dd,isnull(special_date_number,0),out_time),'"+searchKeyDate+"'),0) as out_day from contract_condition as con left join contract_info as info  on info.contract_id=con.contract_id left join contract_equip as equip on info.contract_id=equip.contract_id left join vi_cust_all_info as cust on info.cust_id=cust.cust_id left join fund_fund_charge_lsm as sm on info.contract_id=sm.contract_id left join fund_rent_advance as adv on info.contract_id=adv.contract_id ) as f where (f.begin_payment-f.fact_money)>0 and f.out_day>=0  order by out_day desc";
%>
<body>
<form action="sfkck_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr><td colspan="2">
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left">
        按截止日期:
        <input name="searchKeyDate" accesskey="s" type="text" size="15" value="<%= searchKeyDate %>">
        <img  onClick="openCalendar(searchKeyDate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
        </td>
    </tr>
  </table>
</td>
</tr>
      <tr class="maintab">
        <td align="left" width="20%"><!--操作按钮开始-->
          <table border="0" cellspacing="0" cellpadding="0" >
            <tr class="maintab">
              <td ><a href="sfkck_out.jsp?end_date=<%=searchKeyDate%>"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="导出首付款催款信息" >导出首付款催款信息</a></td>
            </tr>
          </table>
          <!--操作按钮结束--></td>
<td align="right" width="90%">
<%
int intPageSize = 15;   //一页显示的记录数
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
rs=db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //记算总1页数
	if(intPage>intPageCount) intPage = intPageCount;            //调整待显示的页码
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //将记录指针定位到待显示页的第一条记录上
	int i = 0; %>

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
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0"></td>
 </tr>
</table>

<!-- end cwCellTop -->
</td>
</tr>
</table>

<div style="vertical-align:top;height:480px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		<th>合同号</th>
		<th>机编号</th>
		<th>客户</th>
		<th>分公司</th>
		<th>初期首付总额</th>
		<th>实收金额</th>
		<th>应收日期</th>
        <th>截止日期</th>
        <th>已逾期天数</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
        <td></td>
		<td><%=getDBStr( rs.getString("contract_id") ) %></td>
		<td><%=getDBStr( rs.getString("equip_sn") ) %></td>
        <td><%=getDBStr( rs.getString("cust_name") ) %></td>
        <td><%=getDBStr( rs.getString("sale_name") ) %></td>
        <td><%=getDBStr( rs.getString("begin_payment") ) %></td>
        <td><%=getDBStr( rs.getString("fact_money") ) %></td>
        <td><%=getDBDateStr( rs.getString("pay_date") ) %></td>
        <td><%= searchKeyDate %></td>
        <td><%=getDBStr( rs.getString("out_day") ) %></td>
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


<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->


</form>
<!-- end cwMain -->
</body>
</html>
