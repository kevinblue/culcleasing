<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>非标会前客户信息统计表-明细 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">


</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="proj_before_meet_list_detail2_comb.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<%
String cust_idnew  = getStr( request.getParameter("cust_id") );

%>
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="cust_id" value="<%=cust_idnew%>">
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		租金明细</td>
	</tr>
</table> 
<%
wherestr = "";
String cust_id = getStr( request.getParameter("cust_id") );
String project_name = getStr( request.getParameter("project_name") );
if ( project_name!=null && !project_name.equals("") ) {
	wherestr += " and ci.project_name like '%" + project_name + "%'";
}
//2013-08-02新增查询条件
countSql = "select count(proj_id) as amount from vi_fund_rent_plan_comb frp left join vi_contract_info_comb ci on ci.contract_id=frp.contract_id where ci.cust_id='"+cust_id+"'" +wherestr;
%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="30" value="<%=project_name %>"></td>

<td>
<input type="button" value="查询" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="清空" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--操作按钮开始-->
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%"><!--翻页控制开始-->
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	  <th align="center"></th> 
	    <th>项目编号</th>
	    <th>项目名称</th>
	    <th>起租编号</th>
	 	<th>租金期次</th>
	 	<th>计划日期</th>
		<th>实收日期</th>
	 	<th>租金</th>
		<th>剩余租金</th>
		<th>剩余租金</th>
	 	<th>本金</th>
	 	<th>利息</th>
	 	<th>状态</th>
      </tr>
   <tbody id="data">
<%

String col_str="*";

sqlstr = "select top "+ intPageSize +" ci.proj_id,ci.project_name,frp.begin_id,frp.rent_list,frp.plan_date,frp.rent,frp.curr_rent,frp.plan_status,(select MAX(hire_date) from (select * from fund_rent_income union select * from CulcLeasingTJ.dbo.fund_rent_income) fri where fri.match_id=frp.id)"; 
sqlstr +="hire_date,";
sqlstr +="isnull(frp.rent_diff,0) rent_diff,frp.corpus,frp.interest from vi_fund_rent_plan_comb frp left join vi_contract_info_comb ci on ci.contract_id=frp.contract_id ";
sqlstr +="where frp.id not in( select top "+ (intPage-1)*intPageSize +" frp.id from vi_fund_rent_plan_comb  frp left join vi_contract_info_comb ci on ci.contract_id=frp.contract_id where ci.cust_id='"+cust_id+"' "+wherestr+" order by ci.proj_id,frp.begin_id,rent_list ) and  " ;
sqlstr +=" ci.cust_id='"+cust_id+"' "+wherestr+" order by ci.proj_id,frp.begin_id,rent_list";


rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>  


     <tr class="materTr_<%=index_no %>">
		<td></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        
		<td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
	    <td align="left"><%=getDBDateStr(rs.getString("hire_date"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("curr_rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("rent_diff"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("corpus"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("interest"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		
      </tr>
<%}
			System.out.println("test=========="+index_no);
rs.close();
db.close();
%>   
     </tbody>
</table>
</div>
</form>

</body>
</html>
