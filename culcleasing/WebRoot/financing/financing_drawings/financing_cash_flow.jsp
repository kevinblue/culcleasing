<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@ page import="com.tenwa.culc.financing.util.FinancingCashFlowUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>现金流报表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function cashFlowSumbit(){
	var refund_date_start = document.getElementById("refund_date_start").value;
	var refund_date_end = document.getElementById("refund_date_end").value;
	if('' == refund_date_start || null == refund_date_start || '' == refund_date_end || null == refund_date_end ){
		alert("开始时间和 结束时间不能为空！");
		return false;
	}
	var start=new Date(refund_date_start.replace("-", "/"));  
	var end=new Date(refund_date_end.replace("-", "/"));  
	if(end<start){
		alert("开始时间不可以大于结束时间！");
		return false;  
	}  
	var srartFive = new Date(start.getFullYear()+5,start.getMonth(),start.getDate());
	if(end>srartFive){
		alert("结束时间 大于开始时间，不可以超过5年！");
		return false;  
	} 
	dataNav.submit();
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="financing_cash_flow.jsp"  name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		现金流报表
		</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = " ";
//本页查询参数
String cycle = getStr( request.getParameter("cycle") );
if("".equals(cycle) || null== cycle ){
	cycle= "year";
}
String refund_date_start = getStr( request.getParameter("refund_date_start") );
String refund_date_end = getStr( request.getParameter("refund_date_end") );
List<String> list ;

if(refund_date_start!=null && !"".equals(refund_date_start) && refund_date_end!=null && !"".equals(refund_date_end)){
	Map<String,String> timeArea = FinancingCashFlowUtil.checkTimeArea(refund_date_start,refund_date_end);
	refund_date_start =timeArea.get("start");
	refund_date_end =timeArea.get("end");
	list=FinancingCashFlowUtil.getTableExtHead( cycle,refund_date_start,refund_date_end);
}else{
	list = new ArrayList<String>();
}

countSql = "select count(id) as amount from vi_financing_drawings_detail where 1=1 "+wherestr;
String expsqlstr = "select  '"+refund_date_start+"' as '偿还日期晚于','"+refund_date_end+"' as '偿还日期早于',drawings_id as '提款编号',crediter as '授信单位',drawings_money as '提款金额（原币）',currency as '币种',drawings_date as '提款日起',drawings_end_date as '贷款到期日' from vi_financing_drawings_detail where 1=1 "+wherestr+" order by crediter,id ";
%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td scope="row">偿还日期：
 晚于<input type="text" id="refund_date_start" name="refund_date_start"
	 readonly="readonly" 
	 value="<%=refund_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> 
 早于<input type="text" id="refund_date_end" name="refund_date_end"
	 readonly="readonly" 
	value="<%=refund_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
<td>
	年:
	<input type="radio" id="cycle" name="cycle" value="year" <%if(cycle.equals("year")){%>checked="checked"<%}%> />
	&nbsp;&nbsp;&nbsp;&nbsp;
	月:
	<input type="radio" id="cycle" name="cycle" value="month" <%if(cycle.equals("month")){%>checked="checked"<%}%> />
	&nbsp;&nbsp;&nbsp;&nbsp;
	<%-- 天: 
	<input type="radio" id="cycle" name="cycle" value="day" <%if(cycle.equals("day")){%>checked="checked"<%}%> />
 --%>
</td>
<td>
<input type="button" value="查询" onclick="cashFlowSumbit();">
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
		<input name="excel_name" type="hidden" value="financing_cash_flow">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_cash_flow.jsp','financing_cash_flow.jsp');">
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
      	<th>偿还时间晚于</th>
		<th>偿还时间早于</th>
	    <th>提款编号</th>
		<th>授信单位</th>
		<th>提款金额（原币）</th>
        <th>币种</th>
        <th>提款日期</th>	
        <th>货款到期日</th>
        <%
        if(refund_date_start!=null && !"".equals(refund_date_start) && refund_date_end!=null && !"".equals(refund_date_end)){
        	for(Iterator<String> iter = list.iterator();iter.hasNext();){
    			String current = iter.next();
    			%>
    			<th>本金偿还现金流（<%=current %>）</th>
    			<th>利息偿还现金流（<%=current %>）</th>
    			<%
    		}
        }
        %>
	     <!--  增加表头 -->   
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
      	<td align="center"><%=refund_date_start %></td>	
		<td align="center"><%=refund_date_end %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("crediter")) %></td>
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("drawings_money" )) %></td>
		<td align="center"><%=getDBStr( rs.getString("currency")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("drawings_date")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("drawings_end_date")) %></td>
		<%
        if(refund_date_start!=null && !"".equals(refund_date_start) && refund_date_end!=null && !"".equals(refund_date_end)){
        	String drawings = getDBStr( rs.getString("drawings_id"));
        	for(Iterator<String> iter = list.iterator();iter.hasNext();){
    			String current = iter.next();
    			Map<String,Double> map =FinancingCashFlowUtil.getTableCashFlow(drawings,cycle,refund_date_start,refund_date_end,current);
    			System.out.println("current="+current);
    			System.out.println(map.get("refund_corpus")+"----------"+map.get("refund_interest"));
    			%>
    			<td><%=CurrencyUtil.convertFinance( map.get("refund_corpus")) %></td>
    			<td><%=CurrencyUtil.convertFinance( map.get("refund_interest")) %></td>
    			<%
    		}
        }
        %>
		<!-- 待补充列 -->
		
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
