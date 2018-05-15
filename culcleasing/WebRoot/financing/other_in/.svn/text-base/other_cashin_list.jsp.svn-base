<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>其他流入制定</title>
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
	window.open("other_cashin_add.jsp");
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
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">其他操作&gt; 其他流入制定</td>
  </tr>
</table>
<!--标题结束-->

<%
wherestr = "";

String start_date = getStr( request.getParameter("start_date") );
String end_date = getStr( request.getParameter("end_date") );

if ( start_date!=null && !start_date.equals("") ) {
	wherestr += " and start_date>'" + start_date+"'";
}
if ( end_date!=null && !end_date.equals("") ) {
	wherestr += " and end_date<'" + end_date+"'";
}
countSql = "select count(id) as amount from dbo.financing_cash_flow where 1=1 "+wherestr+"and cash_flow_way='其他流入'";
System.out.println("countSql---------------------"+countSql);
%>

<form action="other_cashin_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>起始日期:&nbsp;<input id="start_date" name="start_date" type="text" readonly Require="ture" value="<%=start_date %>">
	<img onClick="openCalendar(start_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle"></td>
<td>结束日期:&nbsp;
 <input id="end_date" name="end_date" type="text" readonly Require="ture" value="<%=end_date %>">
	<img onClick="openCalendar(end_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
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
		           <BUTTON class="btn_2" name="btnHire" value="新增"  type="button" onclick="return addNew()">
        			<img src="../../images/sbtn_new.gif" align="absmiddle" alt="移交(Alt+Y)" border="0">
        			&nbsp;新增
        			</button>
        			<input type="hidden" id="add_proj_id" name="add_proj_id">
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
	    
	    <th>序号</th>
	    <th>起始日期</th>
	    <th>结束日期</th>
		<th>流入金额</th>
		<th>备注</th>
		<th>录入人员</th>
		<th>录入时间</th>
		<th>最后更新人员</th>
		<th>录最后更新时间</th>
		<th colspan="2">操作</th>
      </tr>
      <tbody id="data">
<%
int i=0;
String col_str="cash.id as id,start_date,end_date,cash_money,remark,bu1.name as creator,create_date,bu.name as modificator,modify_date";

sqlstr = "select top "+ intPageSize +" "+col_str+" from financing_cash_flow cash left join base_user bu on bu.id=modificator "+
"left join base_user bu1 on bu1.id=creator where cash.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" cash.id from financing_cash_flow where 1=1 "+wherestr+" and cash_flow_way='其他流入' order by cash.id ) and cash_flow_way='其他流入'"+wherestr;
sqlstr +=" order by cash.id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
i++;
%>
      <tr>
        <td align="center"><%= i %></td>
		<td align="center"><%= getDBDateStr( rs.getString("start_date") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("end_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("cash_money") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("remark") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("creator") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("create_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("modificator") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("modify_date") ) %></td>
		<td align="center">
		<script type="text/javascript">
			function delItem(texVal){
				if(confirm("确认要删除该记录吗？")){
					window.open('other_cashin_save.jsp?savetype=del&id='+texVal);
				}
			}
		</script>
	    <a href='Javascript: delItem(<%=getDBStr(rs.getString("id"))%>)'>
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">删除</a>
        </td>
        <td>
		<a href="other_cashin_mod.jsp?id=<%=getDBStr( rs.getString("id"))%>" target="_blank">
		<img src="../../images/sbtn_mod.bak.gif" align="bottom" border="0">修改</a>
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
