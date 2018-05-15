<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>其他功能 - 租金还款延后</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function changeOne(){
	var theArrBox=document.getElementsByName("itemselect");
	var conStr="";
	var beginStr="";
	for(i=0;i<theArrBox.length;i++){
		if(theArrBox[i].checked) { 
			conStr=theArrBox[i].value; 
			beginStr=theArrBox[i].attributes["begin_id"].nodeValue;
			break; 
		}
	}
	if(conStr==""){
		alert("请选择要延迟的项目！");
		return false;
	}
	document.getElementById("contract_id").value=conStr;
	document.getElementById("begin_id").value=beginStr;
	document.dataNav.action="delay_change.jsp";
	document.dataNav.target="_blank";
	document.dataNav.submit();
	document.dataNav.action="delay_list.jsp";
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
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">其他功能&gt; 租金还款延后</td>
  </tr>
</table>
<!--标题结束-->

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and cust_name like '%" + proj_manage_name + "%'";
}

countSql = "select count(contract_id) as amount from vi_begin_info where 1=1 "+wherestr;

%>

<form action="delay_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>承租人:&nbsp;<input name="proj_manage_name"  type="text" size="15" value="<%=proj_manage_name %>"></td>
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
		           <BUTTON class="btn_2" name="btnHire" value="延后"  type="button" onclick="return changeOne()">
        			<img src="../../images/fdmo_36.gif" align="absmiddle" alt="转移(Alt+Y)" border="0">
        			&nbsp;延后
        			</button>
        			<input type="hidden" name="contract_id" id="contract_id">
        			<input type="hidden" name="begin_id" id="begin_id">
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
        <th width="1%"></th>
	    <th>合同编号</th>
	    <th>起租编号</th>
	    <th>项目名称</th>
	    <th>承租人</th>
	    <th>租赁本金</th>
	    <th>还租次数</th>
	    <th>租赁期限</th>
	    <th>起租日</th>
      </tr>
      <tbody id="data">
<%
String col_str=" vbi.contract_id,begin_id,equip_amt,lease_money,income_number,lease_term,period_type,rent_start_date,ci.project_name,vca.cust_name   ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_begin_info vbi left join contract_info ci on vbi.contract_id=ci.contract_id left join vi_cust_all_info vca on ci.cust_id=vca.cust_id where vbi.contract_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" contract_id from vi_begin_info where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr +=" order by proj_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("contract_id") )%>"  begin_id="<%=getDBStr( rs.getString("begin_id") )%>"></td>
        <td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("lease_money"))%></td>
        <td align="left"><%=getDBStr(rs.getString("income_number"))%></td>
        <td align="left"><%=getDBStr(rs.getString("lease_term"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("rent_start_date"))%></td>
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
