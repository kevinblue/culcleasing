<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.CRMOperationUtil"%>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>续保统计报表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<%
wherestr = "";
String searchKey = getStr(request.getParameter("cust_name"));
String searchKey1 = getStr(request.getParameter("project_name"));
if ( searchKey!=null && !"".equals(searchKey))
{
   
   wherestr += " and cust_name like '%"+searchKey+"%' "; 
   LogWriter.logDebug(request, "######"+sqlstr);
}

countSql = "select count(contract_id) as amount from vi_insur_unxb where 1=1 "+wherestr;

%>



<body onLoad="public_onload(0)">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<form action="insur_unxb.jsp" name="dataNav" onSubmit="return goPage()">
<!-- end cwTop -->
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;查询条件
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
	</legend>
		<table border="0" width="100%" cellspacing="5" cellpadding="0">
			<tr>
				<td>客户名称:&nbsp;<input name="cust_name"  type="text" size="15" value="<%=searchKey %>"></td>
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


<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    <td width="1%">
	&nbsp;&nbsp;&nbsp;
     </td>	
		<!-- 翻页控制 -->
		
		<td align="right" width="100%">
		<%@ include file="../../public/pageSplit.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
  		<tr class="maintab_content_table_title">
			<th>序号</th>
			<th>客户名称</th>
			<th>项目名称</th>
			<th>项目经理</th>
			<th>保费支付</th>
			<th>上期投保额</th>
			<th>上期承保期限</th>
			<th>上期保费 </th>
			<th>续保年限(月)</th>
		</tr>
   <tbody id="data">
<%	  
String col_str="id,cust_name,project_name,proj_manage_name,insur_type,insur_money,insur_start_date,insur_end_date,insur_charge_money,xbmonth_amount";
sqlstr="select top "+ intPageSize +" "+col_str+"  from vi_insur_unxb where 1=1"+wherestr+" and xbmonth_amount>0 and insur_end_date<=dateadd(dd,30,getdate()) order by id";
LogWriter.logDebug(request, "@@@@@@@"+sqlstr);
int index = 1;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
 		<td align="center"><%=index++ %></td>
	 	<td align="center"><%=getDBStr(rs.getString("cust_name")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("project_name")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("proj_manage_name")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("insur_type")) %></td>
	 	<td align="center"><%=CurrencyUtil.convertFinance(rs.getString("insur_money")) %></td>
	 	<td align="center"><%=getDBDateStr(rs.getString("insur_start_date")) %>至<%=getDBDateStr(rs.getString("insur_end_date")) %></td>
	 	<td align="center"><%=CurrencyUtil.convertFinance(rs.getString("insur_charge_money")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("xbmonth_amount")) %></td>
    </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>

</form>
</body>
</html>
