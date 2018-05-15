<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 保费修定</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="insur_bfxd.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		保险管理&gt; 保费修订</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = " ";
String wherestr1=" contract_id ";
//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
String start_date=getStr( request.getParameter("start_date") );
String cd=getStr( request.getParameter("CD") );
if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if(!cd.equals("") || cd!=null){
	if(cd.equals("升序")){
	wherestr1="cd_date asc";
	}else if (cd.equals("降序")){
	wherestr1="cd_date desc";
	}
}

if(!start_date.equals("") || start_date!=null){
	if(start_date.equals("升序")){
	wherestr1="insur_start_date asc";
	}else if (start_date.equals("降序")){
	wherestr1="insur_start_date desc";
	}
}
//暂不区分投保租赁物件数量

countSql = "select count(id) as amount from vi_insur_bfxd where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>
<td>CD交接排序方式
<select name="CD" style="width: 120px;" >
	<script type="text/javascript">
		w(mSetOpt("<%=cd %>","|升序|降序","|升序|降序")); 
	</script>
</select>
</td>
<td>投保起始日期排序
<select name="start_date" style="width: 120px;" >
	<script type="text/javascript">
		w(mSetOpt("<%=start_date %>","|升序|降序","|升序|降序")); 
	</script>
</select>
</td>
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
		<th>项目名称</th>
		<th>项目编号</th>
		<th>合同编号</th>
		<th>承租人</th>
		<th>项目经理</th>
		<th>投保方式</th>
		<th>保费收取方式</th>
		<th>项目金额</th>
		<th>租赁期限(月)</th>
		<th>CD交接时间</th>
		<th>投保起始日期</th>
        <th>操作</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_insur_bfxd where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_insur_bfxd where 1=1 "+wherestr+" order by  "+wherestr1+") "+wherestr+" order by "+wherestr1 ;
System.out.println("aaa"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("proj_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_type")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insure_pay_type")) %></td>	

		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("equip_amt" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("lease_term" )) %></td>	
		<td align="center"><%= getDBDateStr( rs.getString("cd_date" )) %></td>	
		<td align="center"><%= getDBDateStr( rs.getString("insur_start_date" )) %></td>	
      	<td align="center">
			<a href="bfxd_list.jsp?contract_id=<%=getDBStr( rs.getString("contract_id")) %>&insur_type=<%=getDBStr( rs.getString("insur_type")) %>&insur_start_date=<%= getDBDateStr( rs.getString("insur_start_date" )) %>&insur_end_date=<%= getDBDateStr( rs.getString("insur_end_date" )) %>"  target="_blank">查看保费资金计划</a>
		</td>
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
