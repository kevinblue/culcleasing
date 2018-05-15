<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目租金列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<body  onload="public_onload(0);" style='overflow:scroll;overflow-y:hidden;'>
<form action="rentplan_list_read1.jsp" name="dataNav" onSubmit="return goPage()">
<%
String cust_id = request.getParameter("cust_id");
wherestr=" and cust_id="+cust_id;


 System.out.println("qqqqqq=="+countSql);
//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
countSql = "select count(id) as amount from vi_fund_rent_plan where 1=1 "+wherestr;
%>
<input name="cust_id"  type="hidden" " value="<%=cust_id %>">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>
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
	<td align="right"><!--翻页控制开始-->
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">

<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2"  cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>项目名称</th>
		<th>租金期次</th>
		<th>租金</th> 
		<th>剩余租金</th>
		<th>本金</th> 
		<th>剩余本金</th>
		<th>利息</th> 
		<th>剩余利息</th>
		<th>计划日期</th>
		<th>实收日期</th>
		<th>年利率</th>
		
		<th>状态</th>
      </tr>
	  <%
	 sqlstr = "select top "+ intPageSize +" *  from vi_fund_rent_plan frp left join fund_rent_income fri on fri.match_id=frp.id where frp.id not in(select top "+ (intPage-1)*intPageSize +" id from vi_fund_rent_plan where 1=1 "+wherestr+" order by project_name,rent_list ) "+wherestr+" order by project_name,rent_list ";
	 System.out.println("qqqqqq=="+sqlstr);
	 rs = db.executeQuery(sqlstr);
	while(rs.next()){
	 %>
 
	<tr class="maintab_content_table_title" > 
		<td colspan=""><%=rs.getString("project_name")%></td>
		<td colspan=""><%=rs.getString("rent_list")%></td>
		<td colspan=""><%=rs.getString("rent")%></td>
		<td colspan=""><%=rs.getString("curr_rent")%></td>
		<td colspan=""><%=rs.getString("corpus")%></td>
		<td colspan=""><%=rs.getString("curr_corpus")%></td>
		<td colspan=""><%=rs.getString("interest")%></td>
		<td colspan=""><%=rs.getString("curr_interest")%></td>
		<td colspan=""><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td colspan=""><%=getDBDateStr(rs.getString("hire_date"))%></td>
		<td colspan=""><%=rs.getString("year_rate")%></td>
		<td colspan=""><%=rs.getString("plan_status")%></td>
		
	</tr>
	<%
	 }
	rs.close();%>
   </table>
</div>
</div>
</form>
</body>


</html>
