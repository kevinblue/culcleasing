<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>利息费用 表</title>
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

<form action="financing_drawings_interest.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		利息费用表
		</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = " ";

//本页查询参数
/* String drawings_date_start = getStr( request.getParameter("drawings_date_start") ); */
String drawings_date_end = getStr( request.getParameter("drawings_date_end") );
if(drawings_date_end!=null && !"".equals(drawings_date_end)){
	wherestr +=" and drawings_date <='"+drawings_date_end+"'";
}
/* if(drawings_date_start!=null && !"".equals(drawings_date_start) && drawings_date_end!=null && !"".equals(drawings_date_end)){
	wherestr +=" and drawings_date >= '"+drawings_date_start+"' and drawings_date<='"+drawings_date_end+"'";
}
if(drawings_date_start!=null && !"".equals(drawings_date_start) && "".equals(drawings_date_end)){
	wherestr +=" and drawings_date >= '"+drawings_date_start+"'";
}
if("".equals(drawings_date_start) && drawings_date_end!=null && !"".equals(drawings_date_end)){
	wherestr +=" and drawings_date <='"+drawings_date_end+"'";
} */

countSql = "select count(id) as amount from vi_financing_drawings_detail where 1=1 "+wherestr;
String expsqlstr = "select drawings_id as '提款编号',crediter as '授信单位',drawings_type as '贷款类型',drawings_money as '提款金额（原币）',currency as '币种',drawings_date as '提款日起',drawings_end_date as '贷款到期日',drawings_time_limit as '贷款期限',factorage_money as '手续费（总和）',drawings_rate_para1 as '合同利率浮动',drawings_rate_float as '合同利率浮动',isnull(current_foreign_rate,0) as '原始利率',isnull(drawings_fact_rate,0) as '当前利率',refund_way as '本金偿还方式',rebated_type as '利息支付方式',drawings_rate_float_type as '调息方式',loan_category as '贷款类别',pawn_condition as '质押情况',assurer_condition as '担保情况',abroad_domestic as '境内外分类',withholding_tax as '代扣税费情况',withholding_tax_rate as '代扣税费税率',table_type as '表内外情况',drawings_rate_type as '利率类型',drawings_time_type as '期限类型',financing_method as '融资方式' from vi_financing_drawings_detail where 1=1 "+wherestr+" order by crediter,id ";
%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td scope="row">查询时间：
<%-- 晚于<input type="text" id="drawings_date_start" name="drawings_date_start"
	 readonly="readonly" 
	 value="<%=drawings_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> --%>
 <input type="text" id="drawings_date_end" name="drawings_date_end"
	 readonly="readonly" 
	value="<%=drawings_date_end %>"
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
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="financing_drawings_interest">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','financing_drawings_interest.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	    <!--操作按钮结束-->
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
      	<th>查询时间</th>
	    <th>提款编号</th>
		<th>授信单位</th>
		<!-- <th>贷款类型</th> -->
		<th>提款金额（原币）</th>
        <th>币种</th>
        
        <th>提款日期</th>
        <th>货款到期日</th>
        <!-- <th>货款期限</th>
        <th>手续费（总和）</th>   
        <th>合同利率基准</th>
        
        <th>合同浮动利率</th>
        <th>原始利率</th>
        <th>当前利率</th>
        <th>本金偿还方式</th>   
        <th>利息支付方式</th>
        
        <th>调息方式</th> -->
        <!-- <th>已还本金（原币）</th>
        <th>剩余本金（原币）</th> -->
        <!-- th>货款类型</th>   
        <th>质押情况</th>
        
        <th>担保情况</th> -->
        <th>境内外分类</th>
        <th>代扣税费情况</th>
        <th>代扣税费税率</th>   
        <!-- <th>表内外情况</th>
        
        <th>利率类型</th>
        <th>期限类型</th>   
        <th>融资方式</th> -->
         
      </tr>
      <tbody id="data">
<%
String col_str=" * ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_financing_drawings_detail where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_financing_drawings_detail where 1=1 "+wherestr+" order by crediter,id ) "+wherestr ;
sqlstr += " order by crediter,id ";

rs = db.executeQuery(sqlstr);

while ( rs.next() ) {
%>
      <tr>
      	<td align="center"><%=drawings_date_end %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("crediter")) %></td>
		<%-- <td align="center"><%=getDBStr( rs.getString("drawings_type")) %></td> --%>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("drawings_money" )) %></td>
		<td align="center"><%=getDBStr( rs.getString("currency")) %></td>
		
		<td align="center"><%=getDBDateStr( rs.getString("drawings_date")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("drawings_end_date")) %></td>
		<%-- <td align="center"><%=getDBStr( rs.getString("drawings_time_limit")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("factorage_money" )) %></td>	
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_para1")) %></td>
        
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_float")) %></td>
		<td align="center"><%=getDBStr( rs.getString("current_foreign_rate")) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_fact_rate")) %></td>	
        <td align="center"><%=getDBStr( rs.getString("refund_way")) %></td>
        <td align="center"><%=getDBStr( rs.getString("rebated_type")) %></td>
        
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_float_type")) %></td> --%>
		<%-- <td align="center"><%=getDBStr( rs.getString("drawings_refund_corpus")) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_left_corpus")) %></td> --%>	
        <%-- <td align="center"><%=getDBStr( rs.getString("loan_category")) %></td>
        <td align="center"><%=getDBStr( rs.getString("pawn_condition")) %></td>
        
        <td align="center"><%=getDBStr( rs.getString("assurer_condition")) %></td> --%>
		<td align="center"><%=getDBStr( rs.getString("Abroad_domestic")) %></td>
		<td align="center"><%=getDBStr( rs.getString("Withholding_tax")) %></td>	
        <td align="center"><%=getDBStr( rs.getString("Withholding_tax_rate")) %></td>
        <%-- <td align="center"><%=getDBStr( rs.getString("Table_type")) %></td>
        
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_type")) %></td>	
        <td align="center"><%=getDBStr( rs.getString("drawings_time_type")) %></td>
        <td align="center"><%=getDBStr( rs.getString("Financing_Method")) %></td> --%>
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
