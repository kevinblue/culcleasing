<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>提款费用摊销表明细</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="financing_amortize_group.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		提款费用摊销表明细
		</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = " ";
String wherestrid = "";
//本页查询参数
String drawings_id = getStr( request.getParameter("drawings_id") );
wherestrid = " and vf.drawings_id = '"+drawings_id+"'";
String amortize_date_start = getStr( request.getParameter("amortize_date_start") );
String amortize_date_end = getStr( request.getParameter("amortize_date_end") );
if(amortize_date_start!=null && !"".equals(amortize_date_start) && amortize_date_end!=null && !"".equals(amortize_date_end)){
	wherestr +=" and amortize_date >= '"+amortize_date_start+"' and amortize_date<='"+amortize_date_end+"'";
}
if(amortize_date_start!=null && !"".equals(amortize_date_start) && "".equals(amortize_date_end)){
	wherestr +=" and amortize_date >= '"+amortize_date_start+"'";
}
if("".equals(amortize_date_start) && amortize_date_end!=null && !"".equals(amortize_date_end)){
	wherestr +=" and amortize_date <='"+amortize_date_end+"'";
}

countSql = " select count(vf.id) as amount from vi_financing_drawings_detail vf , (select drawings_id from financing_amortize where 1=1 "+wherestr;
countSql+= " group by drawings_id,amortize_list,amortize_type) fa where vf.drawings_id = fa.drawings_id ";
countSql+= wherestrid;

String expsqlstr = "select  '"+amortize_date_start+"' as '摊销时间晚于','"+amortize_date_end+"' as '摊销时间晚于',vf.drawings_id as '提款编号',vf.crediter as '授信单位',vf.drawings_type as '贷款类型',vf.drawings_money as '提款金额（原币）',vf.factorage_money as '手续费（总和）',fa.sum_amortize_money as '摊销费用金额',fa.min_amortize_date as '摊销开始日',fa.max_amortize_date as '摊销结束日',dbo.Financ_getAmortizeMethod(vf.drawings_id) as '摊销方法',fa.amortize_money_already as '已摊销金额', CASE '"+amortize_date_start+"' WHEN '' THEN fa.Non_amortization_balance ELSE '0' END as '未摊销金额',fa.amortize_list as '序号',fa.amortize_type as '摊销类别' from vi_financing_drawings_detail vf, (select drawings_id,MIN(amortize_date) as min_amortize_date,MAX(amortize_date) as max_amortize_date,SUM(amortize_money) as sum_amortize_money,SUM(Non_amortization_balance) as Non_amortization_balance,(SUM(amortize_money)-SUM(Non_amortization_balance)) as  amortize_money_already,amortize_list,amortize_type from financing_amortize where 1=1 "+wherestr+" group by drawings_id,amortize_list,amortize_type) fa where vf.drawings_id = fa.drawings_id "+wherestrid ;
expsqlstr += " order by vf.drawings_id,fa.amortize_list,fa.amortize_type,vf.id ";
%>

<!--可折叠查询开始-->
<input type="hidden" id="drawings_id" name="drawings_id" value="<%=drawings_id %>" />
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td scope="row">摊销日期：
 晚于<input type="text" id="amortize_date_start" name="amortize_date_start"
	 readonly="readonly" 
	 value="<%=amortize_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 早于<input type="text" id="amortize_date_end" name="amortize_date_end"
	 readonly="readonly" 
	value="<%=amortize_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
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
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="financing_amortize_group">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','financing_amortize_group.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
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
      	<th>摊销时间晚于</th>
		<th>摊销时间早于</th>
	    <th>提款编号</th>
		<th>授信单位</th>
		<th>贷款类型</th>
		<th>提款金额（原币）</th>
        <th>手续费（总和）</th>
        <th>摊销费用金额</th>
        <th>摊销开始日</th>
        <th>摊销结束日</th>
        <th>摊销方法</th>   
        <th>已摊销金额</th>
        <th>未摊销金额</th>
        <th>序号</th>
        <th>摊销类别</th>
      </tr>
      <tbody id="data">
<%
String col_str=" vf.id,vf.drawings_id,vf.crediter,vf.drawings_type,vf.drawings_money,vf.factorage_money,fa.min_amortize_date,fa.max_amortize_date,fa.sum_amortize_money,fa.Non_amortization_balance,fa.amortize_money_already,fa.amortize_list,fa.amortize_type,dbo.Financ_getAmortizeMethod(vf.drawings_id) as amortize_method ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_financing_drawings_detail vf, (select drawings_id,MIN(amortize_date) as min_amortize_date,MAX(amortize_date) as max_amortize_date,SUM(amortize_money) as sum_amortize_money,SUM(Non_amortization_balance) as Non_amortization_balance,(SUM(amortize_money)-SUM(Non_amortization_balance)) as  amortize_money_already,amortize_list,amortize_type from financing_amortize where 1=1 "+wherestr+" group by drawings_id,amortize_list,amortize_type) fa where vf.drawings_id = fa.drawings_id and vf.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" vf1.id from vi_financing_drawings_detail vf1, (select drawings_id from financing_amortize  where 1=1 "+wherestr+" group by drawings_id,amortize_list,amortize_type) fa1  where vf1.drawings_id = fa1.drawings_id ) "+wherestrid ;
sqlstr += " order by vf.drawings_id,fa.amortize_list,fa.amortize_type,vf.id ";

rs = db.executeQuery(sqlstr);

while ( rs.next() ) {
%>
      <tr>
     	 <td align="center"><%=getDBDateStr(amortize_date_start) %></td>	
		<td align="center"><%=getDBDateStr( amortize_date_end) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("crediter")) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_type")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("drawings_money" )) %></td>
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("factorage_money" )) %></td>
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("sum_amortize_money" )) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("min_amortize_date")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("max_amortize_date")) %></td>
		<td align="center"><%=getDBStr( rs.getString("amortize_method")) %></td>
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("amortize_money_already" )) %></td>
		<td align="center">
		<%
		if(amortize_date_start!=null && !"".equals(amortize_date_start)){
			%>-----<%
		}else{
			%><%= CurrencyUtil.convertFinance( rs.getString("Non_amortization_balance" )) %><%
		}
		%>
		</td>
		<td align="center"><%=getDBStr( rs.getString("amortize_list")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("amortize_type")) %></td>
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
