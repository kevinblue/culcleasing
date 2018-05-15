<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>其他功能 - 意见执行监控</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function addNew(){
	var theArrBox=document.getElementsByName("itemselect");
	var tempStr="";
	for(i=0;i<theArrBox.length;i++){
		if(theArrBox[i].checked) { 
			tempStr=theArrBox[i].value; 
			break; 
		}
	}
	if(tempStr==""){
		alert("请选择要录入意见的项目！");
		return false;
	}
	document.getElementById("add_proj_id").value=tempStr;
	document.dataNav.action="opinion_add.jsp";
	document.dataNav.target="_blank";
	document.dataNav.submit();
	document.dataNav.action="opinion_monitor_list.jsp";
	document.dataNav.target="_self";
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">其他功能&gt; 意见执行监控</td>
  </tr>
</table>
<!--标题结束-->

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String has_opinion = getStr( request.getParameter("has_opinion") );

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( has_opinion!=null && !has_opinion.equals("") && has_opinion.equals("1")) {
	wherestr += " and isnull(opinion_amount,0)>0";
}
if ( has_opinion!=null && !has_opinion.equals("") && has_opinion.equals("0")) {
	wherestr += " and isnull(opinion_amount,0)=0";
}

countSql = "select count(proj_id) as amount from vi_proj_opinion_state where 1=1 "+wherestr;

%>

<form action="opinion_monitor_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="proj_name"  type="text" size="13" value="<%=proj_name %>"></td>
<td>是否有意见:&nbsp;
 <select name="has_opinion">
    <script type="text/javascript">
     	w(mSetOpt('<%=has_opinion %>',"|是|否","|1|0"));
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
	    <th>意见数量</th>
		<th>未完成意见数量</th>
		<th>已完成意见数量</th>
		
      </tr>
      <tbody id="data">
<%
String col_str="proj_id,project_name,opinion_amount,opinion_wc_amount,opinion_wwc_amount";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_proj_opinion_state where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from vi_proj_opinion_state where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by proj_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td><a href="opinion_details.jsp?proj_id=<%=getDBStr( rs.getString("proj_id"))%>" target="_blank">
        <%=getDBStr( rs.getString("proj_id") ) %></a></td>
		<td><%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%=CurrencyUtil.convertIntAmount( rs.getString("opinion_amount") ) %></td>
		<td align="center"><%=CurrencyUtil.convertIntAmount( rs.getString("opinion_wwc_amount") ) %></td>
		<td align="center"><%=CurrencyUtil.convertIntAmount( rs.getString("opinion_wc_amount") ) %></td>
		
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
