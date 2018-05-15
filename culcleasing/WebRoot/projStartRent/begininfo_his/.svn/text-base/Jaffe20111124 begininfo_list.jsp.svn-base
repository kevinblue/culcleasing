<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>历史起租信息</title>
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
<%
//合同号
String contract_id = getStr( request.getParameter("contract_id") );
String flow_date = getStr( request.getParameter("flow_date") );

//模拟赋值
if(contract_id==null || "".equals(contract_id)){
	contract_id = "CULC_0022_T001";
}

%>
<body onload="public_onload(0);">

<form action="wyhx_loadlist.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		历史起租信息</td>
	</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	</td>
	<td align="right" width="60%"><!--翻页控制开始-->
	</td>		 	
 </tr>
</table>


<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>合同编号</th>
	    <th>起租编号</th>
	    <th>租赁本金</th>
	    <th>货币类型</th>
	    <th>还租次数</th>
	    <th>付租方式</th>
	    <th>租赁期限</th>
	    <th>付租类型</th>
	    <th>租金计算方法</th>
	    <th>租赁年利率</th>
	    <th>起租日</th>
	    <th>租金偿还日</th>
	    <th>逾期宽限日</th>
	    <th>批量调息</th>
	    <th></th>
      </tr>
      <tbody id="data">
<%
sqlstr = "select * from vi_begin_info where contract_id='"+contract_id+"' and convert(varchar(10),create_date,21)<convert(varchar(10),'"+flow_date+"',21) order by id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="center"><%= getDBStr( rs.getString("contract_id")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("begin_id")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("lease_money")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("currency_title")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("income_number")) %></td>
		<td align="center">
			<select style="width: 100px;" disabled="disabled">
				<script type="text/javascript">
					w(mSetOpt("<%= getDBStr(rs.getString("income_number_year"))%>","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
				</script>
			</select>
		</td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("lease_term")) %></td>	
		<td align="center">
			<select style="width: 60px;" disabled="disabled">
	        <script type="text/javascript">
		        w(mSetOpt('<%=getDBStr(rs.getString("period_type")) %>',"期初|期末","1|0"));
	        </script>
		</td>	
		<td align="center"><%= getDBStr( rs.getString("settle_method_title")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("year_rate")) %></td>	
		<td align="center"><%= getDBDateStr( rs.getString("start_date")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("income_day")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("free_defa_inter_day")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("into_batch")) %></td>	
		<td align="center">
			<a href="main.jsp?begin_id=<%=getDBStr( rs.getString("begin_id")) %>&contract_id=<%=getDBStr( rs.getString("contract_id")) %>" target="_blank">
			查看租金
			</a>
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
