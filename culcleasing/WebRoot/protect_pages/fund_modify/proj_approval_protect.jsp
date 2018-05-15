<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目信息维护</title>
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

<form action="proj_approval_protect.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		项目信息维护&gt; </td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";
String wh_userid=(String) session.getAttribute("czyid");
 if(wh_userid.equals("ADMN-8GRBW4")){
   wherestr += "or 1=1";
}
//本页查询参数
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and pi.project_name like '%" + project_name + "%'";
}

countSql = "select count(pi.id) as amount from proj_info pi where 1=1 ";
countSql +="and pi.proj_dept in  (select department from base_user where id='"+wh_userid+"')"+wherestr;

//剩余金额>0
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
	    <th>编号</th>
	    <th>项目编号</th>
		<th>项目名称</th>
		<th>项目经理</th>
		<th>大区</th>	
        <th>部门</th>		
        <th>是否执行 </th>        
        <th>项目日期</th>        
        <th>创建日期</th>
        <th>维护人</th>
        <th>维护日期</th>
		<th>同步状态</th>
		<th>操作</th>
        <th>同步</th>
      </tr>
      <tbody id="data">
	 
<%

String col_str="pi.id,pi.proj_id,pi.project_name,bd.dept_name, bd.parent_deptname,pi.wh_status,case "
+" when  pi.is_exec='1A' then '执行'when  pi.is_exec='2A' then '不执行'  when  pi.is_exec='3A' then '不确定' "
+"    else'' end is_exec,pi.proj_pg_date,bu.name as projmanage,pi.create_date,pi.wh_modificator,pi.wh_modify_date";
int i=1;
sqlstr = "select top "+ intPageSize +" "+col_str+" from proj_info pi left join v_select_base_department  bd  on bd.id= pi.proj_dept ";
sqlstr += "left join base_user bu on bu.id=pi.proj_manage ";
sqlstr += "where 1=1 and pi.proj_dept in  (select department from base_user where id='"+wh_userid+"')  "+wherestr+" and pi.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" pi.id from proj_info pi left join v_select_base_department  bd  on bd.id= pi.proj_dept ";
sqlstr += "left join base_user bu on bu.id=pi.proj_manage ";
sqlstr += "where 1=1 and pi.proj_dept in  (select department from base_user where id='"+wh_userid+"') "+wherestr+" order by proj_id ) " ;
sqlstr += " order by pi.proj_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><%=i %></td>
        <td align="left"><%=getDBStr( rs.getString("proj_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("projmanage")) %></td>			
		<td align="left"><%=getDBStr( rs.getString("dept_name")) %></td>
		<td align="left"><%=getDBStr( rs.getString("parent_deptname")) %></td>
		<td align="center"><%=getDBStr( rs.getString("is_exec")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("proj_pg_date")) %></td>		

		
		<td align="center"><%=getDBDateStr( rs.getString("create_date")) %></td>	
		
		<td align="center"><%=getDBStr( rs.getString("wh_modificator")) %></td>	
		
		<td align="center"><%=getDBDateStr( rs.getString("wh_modify_date")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("wh_status")) %></td>	
		<td align="center">
     	<a href='proj_approval_protect_mod.jsp?id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>     	
     	</td>
        <td align="center">		
        <a href='proj_info_add.jsp?proj_id=<%=getDBStr(rs.getString("proj_id"))%>&id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/sbtn_quick_up.gif" align="bottom" border="0">单个执行同步</a> 
	  </td>
	  </tr>
<%
i++;
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
