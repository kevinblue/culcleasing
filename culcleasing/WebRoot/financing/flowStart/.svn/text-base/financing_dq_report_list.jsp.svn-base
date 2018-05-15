<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>掉期总表</title>
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

<!-- 公共变量 -->
<%@ include file="../../public/selectDataFina.jsp"%>
<!-- 公共变量 -->


<%
String swap_bank = getStr( request.getParameter("swap_bank") );
String drawings_start_date = getStr( request.getParameter("drawings_start_date") );
String drawings_end_date = getStr( request.getParameter("drawings_end_date") );
String drawings_id = getStr( request.getParameter("drawings_id") );
String swap_nominal_money = getStr( request.getParameter("swap_nominal_money") );
String drawings_money = getStr( request.getParameter("drawings_money") );

if ( swap_bank!=null && !"".equals(swap_bank) ) {
	wherestr += " and fc.swap_bank like '%" + swap_bank + "%'";
}
if ( drawings_id!=null && !"".equals(drawings_id) ) {
	wherestr += " and fc.drawings_id like '%" + drawings_id + "%'";
}
if ( drawings_start_date!=null && !drawings_start_date.equals("") ) {
	wherestr += " and convert(varchar(10),fd.drawings_date,21)>='" + drawings_start_date+"'";
}
if ( drawings_end_date!=null && !drawings_end_date.equals("") ) {
	wherestr += " and convert(varchar(10),fd.drawings_date,21)<='" + drawings_end_date+"'";
}
if ( swap_nominal_money!=null && !"".equals(swap_nominal_money) ) {
	wherestr += " and swap_nominal_money = '" + swap_nominal_money + "'";
}
if ( drawings_money!=null && !"".equals(drawings_money) ) {
	wherestr += " and fd.drawings_money = '" + drawings_money + "'";
}

countSql = "select count(fc.id) as amount from financing_change fc left join financing_drawings fd on fd.drawings_id = fc.drawings_id where 1=1 "+wherestr;

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<form action="financing_dq_report_list.jsp" name="dataNav" onSubmit="return goPage()">
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>提款标号:&nbsp;<input name="drawings_id"  type="text" size="15" value="<%=drawings_id %>"></td>
<td colspan="2">提款日期:&nbsp;<input id="drawings_start_date" name="drawings_start_date" type="text" readonly Require="ture" value="<%=drawings_start_date %>" size="11">
	<img onClick="openCalendar(drawings_start_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
到:&nbsp;
 <input id="drawings_end_date" name="drawings_end_date" type="text" readonly Require="ture" value="<%=drawings_end_date %>" size="11">
	<img onClick="openCalendar(drawings_end_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
提款金额:&nbsp;<input name="drawings_money"  type="text" size="15" value="<%=drawings_money %>">
<td>
</tr>

<tr>
<td>掉期银行:&nbsp;<input name="swap_bank"  type="text" size="15" value="<%=swap_bank %>"></td>
<td>掉期名义金额:&nbsp;<input name="swap_nominal_money"  type="text" size="15" value="<%=swap_nominal_money %>">
</td>
<td>
<input type="button" value="查询" onclick="dataNav.submit();">&nbsp;&nbsp;&nbsp;
<input type="button" value="清空" onclick="clearQuery();" >
</td>
</tr>

</table>
</fieldset>
</div>
<div style="margin-top: 0px;">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    <td align="left" width="80%">
	<!--操作按钮开始-->
	
	<!--操作按钮结束-->
	</td>
		<!-- 翻页控制 -->
		<td align="right">
		<%@ include file="../../public/pageSplit.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>提款标号</th>
     <th>提款日期</th>
     <th>提款金额</th>
     <th>提款银行</th>
     <th>掉期日期</th>
     <th>掉期银行</th>
     <th>掉期币种</th>
     <th>掉期名义金额</th>
     <th>掉期利率</th>
     <th>操作</th>
   </tr>
   <tbody id="data">
<%
String col_str="fc.id,fd.drawings_id,fc.doc_id,fd.drawings_date,fd.drawings_money,fc.swap_start_date,fcu.unit_name swap_bank,fc.swap_nominal_money,fc.swap_rate,fc.swap_currency,fcr.crediter ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from financing_change fc left join financing_drawings fd on fd.drawings_id = fc.drawings_id "
		+" left join financing_credit fcr on fd.credit_id=fcr.credit_id "
		+"left join financing_config_unit fcu on fc.swap_bank=fcu.unit_code where fc.id not in" +
		"(select top "+ (intPage-1)*intPageSize +" fc.id from financing_change fc where 1=1 "+wherestr+" order by fc.id)"+wherestr+" order by fc.id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("drawings_id")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("drawings_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("drawings_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("crediter")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("swap_start_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("swap_bank")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("swap_currency")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("swap_nominal_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("swap_rate")) %></td>
     	
     	<td align="center">
     	<a href='financing_dqAccount_list.jsp?drawings_id=<%=getDBStr(rs.getString("drawings_id"))%>&doc_id=<%=getDBStr(rs.getString("doc_id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">查看台账</a>
     	
     	</td>
     </tr>
<%
}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
</form>
</body>
</html>
<%if(null != db){db.close();}%>