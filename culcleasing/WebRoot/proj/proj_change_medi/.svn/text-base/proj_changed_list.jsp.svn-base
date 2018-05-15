<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>其他功能 - 项目转移列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
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
<form action="proj_changed_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">其他功能&gt; 项目转移列表</td>
  </tr>
</table>
<!--标题结束-->

<%
wherestr = " and industry_type='CULC_06'";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),transfer_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),transfer_date,21)<='"+end_date+"' ";
}

countSql = "select count(proj_id) as amount from vi_proj_transfer_list where 1=1 "+wherestr;

%>


<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>项目经理:&nbsp;<input name="proj_manage_name"  type="text" size="15" value="<%=proj_manage_name %>"></td>
<td>移交时间:&nbsp;
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
        <td align="left" width="1%"><!--操作按钮开始-->
	        <table border="0" cellspacing="0" cellpadding="0" >
	        	<tr class="maintab">
		         <td align="left">
		          </td>
		         </tr>
	        </table>
        </td>
        <!--操作按钮结束-->
        
        <td align="right" width="95%"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>

  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>项目编号</th>
	    <th>项目名称</th>
	    <th>原项目经理</th>
	    <th>新项目经理</th>
	    <th>原项目助理</th>
	    <th>新项目助理</th>

 		<th>移交时间</th>
		<th>备注</th>
	 	<th>创建人</th>
      </tr>
      <tbody id="data">
<%
String col_str="proj_id,project_name,old_manager,now_manager,old_manage_assisant,new_manage_assisant,transfer_date,ctmemo,creator_name";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_proj_transfer_list where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_proj_transfer_list where 1=1 "+wherestr+" order by id,proj_Id ) "+wherestr ;
sqlstr +=" order by id,proj_Id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("old_manager"))%></td>
        <td align="left"><%=getDBStr(rs.getString("now_manager"))%></td>
        <td align="left"><%=getDBStr(rs.getString("old_manage_assisant"))%></td>
        <td align="left"><%=getDBStr(rs.getString("new_manage_assisant"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("transfer_date"))%></td>
        <td align="left"><%=getDBStr(rs.getString("ctmemo"))%></td>
        <td align="left"><%=getDBStr(rs.getString("creator_name"))%></td>
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
