<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>融资还款计划制定</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function sub_startFlow(){
	//判断是否有选中
	var priId = $(":input[name='itemselect']:checked").val();
	var flag = $(":input[name='itemselect']:checked").attr("flag");
	var FinancingCrediter = $(":input[name='itemselect']:checked").attr("FinancingCrediter");
	var FinancingCreditId = $(":input[name='itemselect']:checked").attr("FinancingCreditId");
	var FinancingDrawingsId = $(":input[name='itemselect']:checked").attr("FinancingDrawingsId");

	if(	priId==undefined || priId==""){
		alert("请选择你要制定还款的提款信息！");
	}else{
		window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/Financing.nsf/OSNewFlowFromMenuHKZDJSP?openagent&priId="+priId+"&FinancingCrediter="+FinancingCrediter+"&FinancingCreditId="+FinancingCreditId+"&FinancingDrawingsId="+FinancingDrawingsId);
	}
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="financing_amortize.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		融资还款计划
		</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = " ";

//本页查询参数
String crediter = getStr( request.getParameter("crediter") );

if ( crediter!=null && !"".equals(crediter) ) {
	wherestr += " and fc.crediter like '%" + crediter + "%'";
}

countSql = "select count(fd.id) as amount From financing_drawings fd Left join financing_credit fc on fd.credit_id=fc.credit_id where 1=1 "+wherestr;
//提款条件 - 可提款金额>0

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>
	<td scope="row">授信单位：<input style="width:150px;" name="crediter" id="crediter" type="text" value="<%=crediter %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('crediter.jsp',250,350)" >  
	</td>
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
	<!-- <table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	    	<td><a href="#" accesskey="m" onclick="sub_startFlow()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="发起提款(Alt+M)" align="absmiddle">还款计划制定</a></td>
	    </tr>
	</table> -->
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
	   <!--  <th width="1%"></th> -->
		<th>授信单位</th>
		<th>提款编号</th>

		<th>提款金额</th>
        <th>提款日期</th>
        <th>利率</th>
        <th>合同利率</th>
        <th>贷款类型</th>
        <th>还款方式</th>
        
        <th>上传状态</th>
        <th>手续费总额</th>
        <th>查看</th>
        <th>修改</th>
        <th>摊销手续费明细</th>
      </tr>
      <tbody id="data">
<%
String col_str=" fd.id,fd.drawings_id,fd.credit_id,fc.crediter,fd.drawings_money,fd.drawings_date,fd.drawings_rate,fd.drawings_rate_float_type,fd.drawings_fact_rate,fd.drawings_time_limit,(drawings_time_limit-datediff(mm,drawings_date,getdate())) as drawings_left_time,fd.drawings_type,fd.refund_type,fd.refund_way ";

sqlstr = "select top "+ intPageSize +" "+col_str+" From financing_drawings fd Left join financing_credit fc on fd.credit_id=fc.credit_id where fd.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" fd1.id From financing_drawings fd1 Left join financing_credit fc1 on fd1.credit_id=fc1.credit_id where 1=1 "+wherestr+" ) "+wherestr ;
sqlstr += " order by fc.crediter,fd.id ";

rs = db.executeQuery(sqlstr);

while ( rs.next() ) {
%>
      <tr>
      	 <%-- <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") ) %>" 
        flag="0" FinancingCrediter="<%=getDBStr( rs.getString("crediter")) %>" 
        FinancingCreditId="<%=getDBStr( rs.getString("credit_id")) %>"
        FinancingDrawingsId="<%=getDBStr( rs.getString("drawings_id")) %>"></td> --%>
		<td align="left"><%=getDBStr( rs.getString("crediter")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("drawings_id")) %></td>
		
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("drawings_money" )) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("drawings_date")) %></td>	
		
		<td align="center"><%=getDBStr( rs.getString("drawings_rate")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("drawings_fact_rate" )) %></td>	
		<td align="center"><%=getDBStr( rs.getString("drawings_type")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("refund_way")) %></td>
		<%
		int i=0;
		String drawings_id = getDBStr( rs.getString("drawings_id"));
		ResultSet rs1=db1.executeQuery("select count(id) as num  from financing_amortize where '"+drawings_id+"' = drawings_id");
		if(rs1.next()){
			i=rs1.getInt("num");
		}
		%> 	
		<td align="center">
			<%
				if(i>0){
					%>已导入<%
				}else{
					%>未导入<%
				}
			%>
		</td>
		<%
			Conn conn = new Conn();
			String sql = "select sum(factorage_money) as sum_factorage_money from financing_drawings_factorage where drawings_id ='"+drawings_id+"'";
			ResultSet rs2 = conn.executeQuery(sql);
			if(rs2.next()){
				%>
				<td align="left"><%=CurrencyUtil.convertFinance(rs2.getString("sum_factorage_money")) %></td>
				<%
			}else{
				%><td>0.00</td><%
			}
			if(conn!=null){
				conn.close();
			}
		%>
		<td align="center"><a target="_blank" href="amortize_list_read.jsp?drawings_id=<%=drawings_id %>">查看</a></td>	
		<td align="center"><a target="_blank" href="amortize_list_upd.jsp?drawings_id=<%=drawings_id %>">修改</a></td>
		<td align="center"><a target="_blank" href="financing_drawings_factorage.jsp?drawings_id=<%=drawings_id %>">摊销手续费明细</a></td>
      </tr>
<%
}
rs.close(); 
db1.close();
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
