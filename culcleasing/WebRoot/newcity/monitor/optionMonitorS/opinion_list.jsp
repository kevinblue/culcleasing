<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>个人落实意见列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
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
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">个人待落实意见列表</td>
  </tr>
</table>
<!--标题结束-->

<%
//查询当期人的姓名
String loginName = "";
sqlstr = "Select name from base_user where id='"+dqczy+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	loginName = rs.getString("name");
}
rs.close();

//只能查询自己落实的项目意见
wherestr = " and dutier = '"+ loginName +"' ";

String proj_name = getStr( request.getParameter("proj_name") );
String raiser = getStr( request.getParameter("raiser") );
String status = getStr( request.getParameter("has_opinion") );

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( raiser!=null && !raiser.equals("") ) {
	wherestr += " and raiser like '%" + raiser + "%'";
}
if ( status!=null && !status.equals("") ) {
	wherestr += " and status = '" + status + "'";
}

countSql = "select count(id) as amount from vi_opinion_list where 1=1 "+wherestr;

%>

<form action="opinion_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="proj_name"  type="text" size="13" value="<%=proj_name %>"></td>
<td>提出人:&nbsp;<input name="raiser"  type="text" size="13" value="<%=raiser %>"></td>
<td>是否完成:&nbsp;
 <select name="has_opinion">
    <script type="text/javascript">
     	w(mSetOpt('<%=status %>',"|是|否","|1|0"));
    </script>
 </select>
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
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  
		class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th>项目编号</th>
	    <th>项目名称</th>
	    <th>提出人</th>
     	<th>提出时间</th>
 		<th>意见</th>
		<th>责任落实人</th>
		<th>执行部门</th>
	 	<th>落实阶段</th>
	 	<th>意见核实人员</th>

	 	<th>是否完成</th>
	    <th>执行结果</th>
	    <th>结果意见</th>
	    <th>完成时间</th>
	    <th>登记人</th>
	    <th>登记时间</th>
		
		<th></th>
      </tr>
      <tbody id="data">
<%
String col_str=" *,cjz=dbo.GETUSERNAME(creator) ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_opinion_list where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_opinion_list where 1=1 "+wherestr+" order by proj_id,id ) "+wherestr ;
sqlstr +=" order by proj_id,id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left">
		<a href="http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/OSShowProjectInfo?openagent&proj_id=<%=getDBStr( rs.getString("proj_id")) %>" target="_blank">
		<%=getDBStr( rs.getString("proj_id")) %></a>
		</td>	
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("raiser"))%></td>
		<td align="center"><%=getDBDateStr(rs.getString("raiser_date")) %></td>
		<td align="left"><%=getDBStr(rs.getString("idea")) %></td>
  
		<td><%=getDBStr(rs.getString("dutier")) %></td>
		<td><%=getDBStr(rs.getString("operation_dept")) %></td>
		<td><%=getDBStr(rs.getString("flow")) %></td>
    	<td><%=getDBStr(rs.getString("check_man")) %></td>

		<td align="center"><%=rs.getInt("status")==0?"否":"是" %></td>
		
		<td><%=getDBStr(rs.getString("result")) %></td>
		<td><%=getDBStr(rs.getString("remark")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("end_time")) %></td>
		<td><%=getDBStr(rs.getString("cjz")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("create_date")) %></td>
	

		<td align="center">
		<% if( rs.getInt("status")==0 ) { %>

		<a href="opinion_suc.jsp?item_id=<%=getDBStr( rs.getString("id"))%>" target="_blank">意见完成</a>
		<% } else {%>
		无操作
		<% } %>
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
