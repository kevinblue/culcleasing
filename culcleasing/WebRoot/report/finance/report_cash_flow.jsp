<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 合同现金流量表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 
<script Language="Javascript" src="../../js/jquery-1.3.2.min.js"></script>
<script type="text/javascript">
//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		var form1 = document.getElementById("dataNav1");
		dataNav1.action="report_cash_flow_export.jsp";
  		form1.submit();
		dataNav1.action="report_cash_flow.jsp";
	}
    
	return false;
}
</script>
</head>

<%
	String dqczy=(String) session.getAttribute("czyid");

	String dept_name = getStr( request.getParameter("dept_name") );
	String begin_date = getStr( request.getParameter("begin_date") );
	String end_date = getStr( request.getParameter("end_date") );
	
	ResultSet rs = null;
	String wherestr = " where 1=1 ";
	
	if(dept_name!=null && !"".equals(dept_name)){
		wherestr+=" and dept_name like '%"+dept_name+"%'";
	}

	if(begin_date!=null && !"".equals(begin_date)){
		wherestr+=" and convert(varchar(10),start_date,21)>='"+begin_date+"' ";
	}
	if(end_date!=null && !"".equals(end_date)){
		wherestr+=" and convert(varchar(10),start_date,21)<='"+end_date+"' ";
	}
	
	String  sqlstr="select contract_id,bank_rate,handling_charge,caution_money,tfe,lease_term,start_date from vi_report_zc_cashflow"+wherestr+" order by contract_id";
	String sql = "select distinct convert(varchar(7),plan_date,120) as diff_date from fund_rent_plan  group by plan_date";

	System.out.println("合同现金流报表#####"+sqlstr);
%>


<body onload="public_onload(0);" style="border:1px solid #8DB2E3;overflow:auto">
<form name="dataNav1" action="report_cash_flow.jsp" method="post">		
<input type="hidden" name="query_sql" id="query_sql" value="<%=sqlstr%>"/>
<input type="hidden" name="query_sql2" id="query_sql2" value="<%=sql%>"/>
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
<tr class="tree_title_txt">
  <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
  报表 &gt;合同现金流量表</td>
</tr>
</table>
<!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>部门&nbsp;<input name="dept_name" type="text" size="13" value="<%=dept_name %>"></td>

<td>起租日期:&nbsp;<input name="begin_date" type="text" size="10" readonly dataType="Date" value="<%=begin_date %>"><img  onClick="openCalendar(begin_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
至
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>"><img onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="dataNav1.submit();">
</td>
</tr>
</table>
</fieldset>
</div><!-- 查询条件结束 -->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
<tr class="maintab">
  <td align="left" width="1%"><!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >
		<tr class="maintab"><td>
				<a href="#" accesskey="n" onClick="isExport()">
					<img   src="../../images/Excel.png" alt="导出" align="absmiddle">
				</a>
			</td>
		</tr>
	</table>
	<!--操作按钮结束--></td>

   <td align="right" width="90%"><!--翻页控制开始-->
    <% 
	int intPageSize = 20;   //一页显示的记录数
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

	System.out.println("%%%%===================================%%"+sqlstr);
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
		var nf = document.dataNav1;
	</script>
            <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页
              <%if(intPage>1){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0">
              <% } %>
              第 <font color="red"><%=intPage%></font> 页
              <%if(intPage<intPageCount){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0">
              <% } %></td>
            <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
            <td nowrap>转到
              <input name="page" type="text" size="2" value="1">
              页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
          </tr>
        </table></td>
    </tr>
  </table>
  <!--翻页控制结束-->



  <!--报表开始-->
  <div style="vertical-align:top;width:100%;height:430;overflow:auto;position: relative;"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title"> 
	    <th>合同号</th>
		<th>租赁期限</th>
	    <th>同期银行贷款利率</th>
	    <th>投放额</th>
		<th>手续费</th>
		<th>保证金</th>

		<%
		List xlmcList = new ArrayList(0);
		//查询日期
		ResultSet rs2 = null;

		String sqlstr2 = "select distinct convert(varchar(7),plan_date,120) as diff_date from fund_rent_plan group by plan_date";
		rs2 = db2.executeQuery(sqlstr2);
		while(rs2.next()){
			xlmcList.add(rs2.getString("diff_date"));//添加系列名称
		%>
		<th><%=getDBStr(rs2.getString("diff_date")) %></th>
		<%} %>
      </tr>
<%	  
String contract_id = "";
String partSql = "";
String xlmc = "";
if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
	contract_id=getDBStr(rs.getString("contract_id"));
%>

      <tr>
        <td align="center" nowrap><%=getDBStr(rs.getString("contract_id")) %></td>
		<td align="center" nowrap><%=getDBStr(rs.getString("lease_term")) %></td>
		<td align="center" nowrap><%=formatNumberStr(rs.getString("bank_rate"),"#,##0.00") %></td>
		<td align="center" nowrap><%=CurrencyUtil.convertFinance(rs.getDouble("tfe")) %></td>
		<td align="center" nowrap><%=CurrencyUtil.convertFinance(rs.getDouble("handling_charge")) %></td>
		<td align="center" nowrap><%=CurrencyUtil.convertFinance(rs.getDouble("caution_money")) %></td>
		
		<%
	    //循环系列查询该代理商该系列的数量
	    for(int j=0;j<xlmcList.size();j++){
	    	xlmc = xlmcList.get(j)+"";
			
	    	partSql = "select net_follow from fund_contract_plan where contract_id='"+contract_id+"' and convert(varchar(7),plan_date,120)='"+xlmc+"'";
	    	rs2 = db2.executeQuery(partSql);
	    	if(rs2.next()){ 
				%>
			<td align="center" nowrap><%=CurrencyUtil.convertFinance(rs2.getString("net_follow")) %></td>
				<%
			}else{
				%>
			<td align="center" nowrap></td>
				<%
				}
	    }
	    %>

      </tr>
<%
		rs.next();
		i++;
	}
}
}

rs.close(); 
rs2.close();
db.close();
db2.close();
%>
</table>
</div>
</form>
<!--报表结束-->
</body>
</html>
