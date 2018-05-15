<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>网银资金收款明细</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>
	<script src="../../js/calend.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<body  onload="public_onload(0);">
<form action="leasing_list_detail_search.jsp" name="dataNav" onSubmit="return goPage()">
<%
wherestr="";

String project_name = getStr( request.getParameter("project_name") );
String cust_name = getStr( request.getParameter("cust_name") );

String date_start = getStr( request.getParameter("date_start") );
String date_end = getStr( request.getParameter("date_end") );
	
if ( !project_name.equals("") ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if ( !cust_name.equals("") ) {
	wherestr += " and cust_name  like '%" + cust_name + "%'";
}

if(date_start!=null&&!date_start.equals("")){
	wherestr +=" and convert(varchar(10),plan_date,21)>='"+date_start+"' ";
}
if(date_end!=null&&!date_end.equals("")){
	wherestr +=" and convert(varchar(10),plan_date,21)<='"+date_end+"' ";
}

countSql = "select count(id) as amount from vi_fund_fund_charge_SK where pay_type_name='网银' "+wherestr;

%>		
			
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
   <tr>
	<td>项目名称: <input name="project_name" type="text" size="10" value="<%=project_name %>" /></td>
	<td>承租客户:<input name="cust_name" type="text" size="10" value="<%=cust_name %>"></td>
	<td>计划日期:
	<input name="date_start" type="text"  size="10"   value="<%=date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="date_end" type="text"  size="10"   value="<%=date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	 </td>
	 
	 <td>
	 <input type="button" value="查询" onclick="dataNav.submit();"> 
	&nbsp;
	 <input type="button" value="清空" onclick="clearQuery();">
	 </td>
   </tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
	<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		网银资金收款明细
	</td>
	</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
			<!--操作按钮开始-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr class="maintab">
				</tr>
			</table>
			<!--操作按钮结束-->
		</td>
		<td align="right" width="90%">
		<!-- 翻页开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:100%" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
class="maintab_content_table">
	<tr class="maintab_content_table_title">							
      	 <th>项目名称</th>
		 <th>合同编号</th>
		 <th>承租客户</th>
		 
	     <th>款项内容</th>
	     <th>序号</th>
	     <th>付款人</th>
	     <th>付款人账号</th>
	     <th>计划收款日期</th>
	     <th>实际收款日期</th>
	     <th>计划收款金额</th>
	     <th>实际收款金额</th>
	     
	     <th>计划收款开户银行</th>
	     <th>计划收款银行账号</th>
	     <th>实际收款开户银行</th>
	     <th>实际收款银行账号</th>
	     
	     <th>网银编号</th>
	</tr>
<tbody id="data">
<%	  
//===变量定义==
sqlstr = "select * from vi_fund_fund_charge_SK where pay_type_name='网银' "+wherestr;

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
	<tr>
    <td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
	<td align="center"><%=getDBStr(rs.getString("contract_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("cust_name")) %></td>

   	<td align="center"><%=getDBStr(rs.getString("feetype_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("charge_list")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("fact_obj")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("client_accnumber")) %></td>
   	
   	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
   	<td align="center"><%=getDBDateStr(rs.getString("fact_date")) %></td>
   	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
   	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("fact_money")) %></td>
   	
   	<td align="center"><%=getDBStr(rs.getString("plan_bank_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("plan_bank_no")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("account_bank")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("acc_number")) %></td>
   	
   	<td align="center">
	   	<a href="../ebank_data/ebank_data_detail.jsp?czid=<%=getDBStr(rs.getString("ebank_number")) %>" target="_blank">
	  	 	<b style="color:#E46344;"><%=getDBStr(rs.getString("ebank_number")) %></b>
	   	</a>
   	</td>
	</tr>
<% }
rs.close(); 
db.close();
%>
	</tbody>	
</table>
</div>
<!--报表结束-->
</form>		
</body>
</html>

