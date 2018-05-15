<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 项目收付款明细</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script src="../../js/delitem.js"></script>
<script type="text/javascript">

		
	//查询条件变更为空时后面的输入框值清空
	function init_searchKey(){
		var searchFld  = document.dataNav1.searchFld.value;
		//alert(searchFld);
		if(searchFld == null || searchFld == ""){
			document.dataNav1.searchKey.value = "";
			document.dataNav1.searchKey.disabled = true;
		}else{
			document.dataNav1.searchKey.value = "";
			document.dataNav1.searchKey.disabled = false;
		}
	}
</script>

<%
	String dqczy=(String) session.getAttribute("czyid");
	//System.out.println("dqczy="+dqczy);

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String start_date = getStr( request.getParameter("start_date") );
String end_date = getStr( request.getParameter("end_date") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("项目名称") ) {
	searchFld_tmp = "contract_info.project_name";
}else if( searchFld.equals("部门") ) {
	searchFld_tmp = "contract_info.industry_type";
}else if(searchFld.equals("项目经理") ) {
	searchFld_tmp = "dbo.GETUSERNAME(dbo.contract_info.proj_manage)";
}else if(searchFld.equals("是否逾期")){
      searchFld_tmp="(CASE WHEN ((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) > 0 THEN '是' ELSE '否' END)";
}else if(searchFld.equals("是否已收罚息")){
      searchFld_tmp="(CASE WHEN (((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) > 0 THEN '是' ELSE '否' END)";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
//if(create_start_date!=null&&!create_start_date.equals("")){
	//wherestr+=" and convert(varchar(10),create_date,21)>='"+create_start_date+"' ";
//}
//if(create_end_date!=null&&!create_end_date.equals("")){
	//wherestr+=" and convert(varchar(10),create_date,21)<='"+create_end_date+"' ";
//}
//String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_info_main" + wherestr +" order by create_date desc"; 
String sqlstr="SELECT distinct dbo.contract_info.project_name, dbo.contract_info.contract_id, dbo.contract_info.industry_type, dbo.GETUSERNAME(dbo.contract_info.proj_manage) AS proj_manage, dbo.contract_info.sign_date, ((CASE WHEN ffp.rent IS NULL THEN 0 ELSE ffp.rent END) + case when ffcp.plan_money is null then 0 else ffcp.plan_money end) AS proj_total, CAST(ff.fact_money AS numeric(10, 2)) AS fact_money, CAST((CASE WHEN ff2.fee IS NULL THEN 0 ELSE ff2.fee END) AS numeric(10, 2)) AS fee_t, CAST((CASE WHEN income2.penalty IS NULL THEN 0 ELSE income2.penalty END) AS numeric(10, 2)) AS penalty_received, frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) AS rent_due, CASE WHEN fundrp_1.rent2 IS NULL THEN 0 ELSE fundrp_1.rent2 END + CASE WHEN f2.first_pay2 IS NULL THEN 0 ELSE f2.first_pay2 END AS rent_out, CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) AS rent_received, (CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) AS yuqi_e, (CASE WHEN ((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2)) > 0 THEN '是' ELSE '否' END) AS yes_faxi, CONVERT(decimal(10, 2), (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) / (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END))) * 1 AS late_p1, CONVERT(decimal(10, 2),(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END)) / (frpd.rent_t + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) * 1.0) AS received_p1,(CASE WHEN (((CASE WHEN frpd.rent_t IS NULL THEN 0 ELSE frpd.rent_t END) + (CASE WHEN f1.first_pay1 IS NULL THEN 0 ELSE f1.first_pay1 END)) - CAST(CASE WHEN income1.rent IS NULL THEN 0 ELSE income1.rent END + (CASE WHEN ff3.yishou IS NULL THEN 0 ELSE ff3.yishou END) AS numeric(10, 2))) > 0 THEN '是' ELSE '否' END) AS yes_yuqi FROM dbo.contract_info LEFT OUTER JOIN dbo.proj_info ON dbo.proj_info.proj_id = dbo.contract_info.proj_id LEFT OUTER JOIN(SELECT contract_id, SUM(fact_money) AS fact_money FROM dbo.fund_fund_charge WHERE (item_method = '付款')and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id) AS ff ON dbo.contract_info.contract_id = ff.contract_id LEFT OUTER JOIN(SELECT contract_id, SUM(fact_money) AS fee FROM dbo.fund_fund_charge AS fund_fund_charge_1 WHERE (fee_type = '14') and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id) AS ff2 ON dbo.contract_info.contract_id = ff2.contract_id LEFT OUTER JOIN(SELECT contract_id, plan_date, SUM(plan_money) AS first_pay1 FROM dbo.fund_fund_charge_plan WHERE (fee_type = '11') AND (plan_date <= GETDATE() and plan_date>='"+start_date+"' and plan_date<='"+end_date+"') GROUP BY contract_id, plan_date) AS f1 ON f1.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN(SELECT contract_id, fact_date, SUM(fact_money) AS yishou FROM dbo.fund_fund_charge AS fund_fund_charge_2 WHERE (fee_type = '11') and fact_date>='"+start_date+"' and fact_date<='"+end_date+"' GROUP BY contract_id, fact_date) AS ff3 ON ff3.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(plan_money) AS first_pay2 FROM  dbo.fund_fund_charge_plan AS fund_fund_charge_plan_2 WHERE  (fee_type = '11') AND (plan_date > GETDATE()) and plan_date>='"+start_date+"' and plan_date<='"+end_date+"' GROUP BY contract_id) AS f2 ON f2.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN(SELECT contract_id, SUM(rent) AS rent FROM  dbo.fund_rent_income where hire_date>='"+start_date+"' and hire_date<='"+end_date+"' GROUP BY contract_id) AS income1 ON income1.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, hire_date, SUM(penalty) AS penalty FROM  dbo.fund_rent_income AS fund_rent_income_1 where hire_date>='"+start_date+"' and hire_date<='"+end_date+"' GROUP BY contract_id, hire_date) AS income2 ON income2.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(plan_money) AS plan_money FROM dbo.fund_fund_charge_plan AS fund_fund_charge_plan_1 WHERE (fee_type = '11') GROUP BY contract_id) AS ffcp ON ffcp.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(rent) AS rent FROM dbo.fund_rent_plan AS fund_rent_plan_1 GROUP BY contract_id) AS ffp ON ffp.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, plan_date, SUM(rent) AS rent_t FROM dbo.fund_rent_plan WHERE (plan_date <= GETDATE() and plan_date>='"+start_date+"' and plan_date<='"+end_date+"') GROUP BY contract_id, plan_date) AS frpd ON frpd.contract_id = dbo.contract_info.contract_id LEFT OUTER JOIN (SELECT contract_id, SUM(rent) AS rent2 FROM dbo.fund_rent_plan AS fund_rent_plan_2 WHERE plan_date > GETDATE() and plan_date>='"+start_date+"' and plan_date<='"+end_date+"' GROUP BY contract_id) AS fundrp_1 ON fundrp_1.contract_id = dbo.contract_info.contract_id "+wherestr ;
System.out.println("###"+sqlstr);
	
%>
<script type="text/javascript">
//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		var form1 = document.getElementById("dataNav1");
		dataNav1.action="texport_save.jsp";
  		form1.submit();
		dataNav1.action="t.jsp";
	}
    
	return false;
}
</script>
</head>
<body onLoad="public_onload(0);" style="border:1px solid #8DB2E3;overflow:auto">
	 <form name="dataNav1" action="contract_pays.jsp" method="post">		
	 <input type="hidden" name="query_sql" id="query_sql" value="<%=sqlstr%>"/>
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      报表 &gt;项目收付款明细</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	<tr class="maintab">
				<td align="left" colspan="2">               
					&nbsp;按&nbsp;
						<select name="searchFld" onchange="init_searchKey()">
							<script type="text/javascript" >
								w(mSetOpt("<%= searchFld %>","|项目名称|部门|项目经理|是否逾期|是否已收罚息"));
							</script>
				        </select>
					&nbsp;查询&nbsp;
					<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
	添加日期<input name="start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=start_date %>"> <img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=end_date %>"> <img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr class="maintab">
				<td>
					<a href="#" accesskey="n" 
						onClick="isExport()">
						<img   src="../../images/sbtn_new.gif" alt="导出" align="absmiddle">
					</a>
				</td>
		    </tr>
        </table>
        <!--操作按钮结束--></td>
      <td align="right" width="90%"><!--翻页控制开始-->
        <% 
	int intPageSize = 10;   //一页显示的记录数
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


<div
				style="vertical-align:top;width:100%;overflow:auto;position: relative;"
				id="mydiv";>

					

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	     <th width='80'>项目名称</th>
        <th width='80'>项目编号</th>
        <th>项目经理</th>
        <th>部门</th>
		<th>合同额</th>
        <th>签约日</th>
        <th>已付款</th>
        <th>已收手续费</th>
	<th>应收到期租金</th>
        <th>应收未到期租金</th>
        <th>已收租金</th>
        <th>已收罚息</th>
        <th>已收占比</th>
        <th>逾期额</th>
        <th>逾期占比</th>
      </tr>

<%	  

if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
         <td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="center"><%=getDBStr(rs.getString("proj_manage"))%></td>
        <td align="center"><%=getDBStr(rs.getString("industry_type")) %></td>
        <td align="center"><%=getDBStr(rs.getString("proj_total")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("sign_date"))%></td>
		<td align="center"><%=getDBStr(rs.getString("fact_money"))%></td>
        <td align="center"><%=getDBStr(rs.getString("fee_t")) %></td>
        <td align="center"><%=getDBStr(rs.getString("rent_due")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("rent_out")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("rent_received")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("penalty_received")) %></td>
		<td align="center"><%=getDBStr(rs.getString("received_p1")) %>%</td>
		<td align="center"><%=formatNumberDoubleTwo(rs.getString("yuqi_e")) %></td>
		<td align="center"><%=getDBStr(rs.getString("late_p1")) %>%</td>
      </tr>
<%
		rs.next();
		i++;
	}
}
}
rs.close(); 
db.close();
%>
    </table>
  </div>
    </form>
  <!--报表结束-->

</body>
</html>
