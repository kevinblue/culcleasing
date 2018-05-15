<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金变更 - 通知书</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function rentInform(obj){
	window.open("http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/CreateRentChangeNotice?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="rent_modify_dept.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		租金变更 &gt; 通知书
		</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";//调息变更的项目

//传递参数，出单部门
String deptId = getStr(request.getParameter("deptId"));

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));


if ( deptId!=null && !"".equals(deptId) ) {
	wherestr += " and proj_dept = '" + deptId + "'";
}else{
	//不显示
	wherestr += " and 1=2";
}

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),start_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),start_date,21)<='"+end_date+"' ";
}

countSql = "select count(id) as amount from vi_fund_adjust_ytx_inform_doc where 1=1 "+wherestr;

%>
<input type="hidden" value="<%=deptId %>" name="deptId"/>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="20" value="<%=project_name %>"></td>

<td>调息日期:&nbsp;
<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
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
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td></td>
	    </tr>
	</table>
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
        <th>起租编号</th>
        <th>项目经理</th>
        <th>部门</th>
        
        <th>调息方式</th>
        <th>调息前利率</th>
        <th>调息后利率</th>
        
        <th>调息日期</th>
        <th>利息差额</th>
        <th>操作</th>
      </tr>
      <tbody id="data">
<%
String col_str=" id,project_name,proj_dept,proj_manage_name,start_date,contract_id,begin_id,adjust_id,dept_name,adjust_type,";
col_str += "before_rate,after_rate,implicite_rate,rent_list_start,left_corpus,left_interest,interest_diff ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_fund_adjust_ytx_inform_doc where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_fund_adjust_ytx_inform_doc where 1=1 "+wherestr+" order by begin_id ) "+wherestr ;
sqlstr += " order by begin_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("begin_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("dept_name")) %></td>	

		<td align="center"><%=getDBStr( rs.getString("adjust_type")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("before_rate" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("after_rate" )) %></td>	
		
		<td align="left"><%= getDBDateStr( rs.getString("start_date")) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("interest_diff" )) %></td>	
		
		<td>
			<a onclick="Javascript:rentInform('<%=getDBStr( rs.getString("id")) %>')" target="_blank" title="点击下载通知书">
			<b style="color:#E46344;">《下载租金变更通知书》</b></a>
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
