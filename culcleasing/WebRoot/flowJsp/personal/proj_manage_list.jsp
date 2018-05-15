<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目助理</title>
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

<form action="proj_manage_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		项目助理</td>
	</tr>
</table>
<!--标题结束-->

<%
//项目经理数据
String proj_manage = (String)session.getAttribute("czyid");

String sqlstr1="select dept_name from v_base_user bu where bu.id='"+proj_manage+"'";
rs=db.executeQuery(sqlstr1);
String dept="000";
if(rs.next()){
	dept=rs.getString("dept_name");
}
wherestr = " and parent_deptname='"+dept+"'";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
//提前15天显示续保保单号
countSql = "select count(id) as amount from vi_personal_proj where 1=1 "+ wherestr;

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
		<th>项目编号</th>
		<th>合同编号</th>
		<th>项目名称</th>
		<th>行业</th>
		<th>承租人</th>
		<th>部门名称</th>
		<th>项目经理</th>
		<th>项目助理</th>
		<th>项目类型</th>
		<th>租赁类型</th>
		<th>租赁形式</th>
		<th>立项日期</th>
		<th>合同状态</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_personal_proj where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_personal_proj where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr += " order by contract_id ";
System.out.println("======================="+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left">
		<a href="http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/OSShowProjectInfo?openagent&proj_id=<%=getDBStr( rs.getString("proj_id")) %>" target="_blank">
		<%=getDBStr( rs.getString("proj_id")) %></a></td>	
		<td align="left"><%=getDBStr( rs.getString("contract_id")) %></td>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("industry_type_name")) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("dept_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("proj_assistant_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("proj_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("leas_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("leas_form")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("proj_date")) %></td>
		<td align="center"><%=getDBStr( rs.getString("status_name")) %></td>	
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
