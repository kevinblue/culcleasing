<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 待续保项目(租赁)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
//走流程
function start_flow() {
	//判断是否有选中
	var priId = $(":input[name='list']:checked").val();
	var contrId = $(":input[name='list']:checked").attr("contrId");
	var flag = $(":input[name='list']:checked").attr("flag");
	var projName = $(":input[name='list']:checked").attr("projName");
	var projId = $(":input[name='list']:checked").attr("projId");

	if(	priId==undefined || priId==""){
		alert("请选择要投保的项目！");
	}else if(flag!=0){
		alert("该保险正在流程中，请选择其他保险！");
	}else{
		window.open("http://domino.culc.com/ELeasing/ProjectWF/Insurance.nsf/OSNewWorkFlowFromBXXBZL?openagent&priId="+priId+"&contractId="+contrId+"&projId="+projId+"&projName="+projName);
	}
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="insur_unxb_ZL.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		保险管理&gt; 待续保项目(租赁)</td>
	</tr>
</table>
<!--标题结束-->

<%
//租赁续保 - 提前30天
wherestr = " and xbmonth_amount>0 and insur_end_date<=dateadd(dd,30,getdate()) and isnull(status,'')='' and insur_type in('本司付款','本司代付')";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
//提前15天显示续保保单号
countSql = "select count(id) as amount from vi_insur_unxb where 1=1 "+ wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>

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
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	  		<td><a href="#" accesskey="m" onclick="start_flow()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="续保(Alt+M)" align="absmiddle">续保</a></td>
	    </tr>
	</table>
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
      	<th width="1%"></th>
		<th>保单号</th>
		<th>保费金额</th>
		<th>投保金额</th>
		<th>费率</th>
		
		<th>险种</th>
		<th>投保支付周期</th>
		
		<th>项目金额</th>
		<th>项目名称</th>
		<th>投保方式</th>
		<th>保费收取方式</th>
		<th>承租客户</th>
		<th>项目经理</th>
		
		<th>投保方</th>
		<th>投保日期</th>
		<th>投保起始日期</th>
        <th>投保期限</th>
        <th>投保到期日</th>
        <th>租赁到期日</th>
        <th>待续保期限</th>
        <th>状态</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_insur_unxb where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_insur_unxb where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr += " order by contract_id ";

String pFl = "";
int flag = 0;

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
	pFl = getDBStr( rs.getString("flag") );
	flag= Integer.parseInt(pFl.isEmpty()?"0":pFl);
%>
      <tr>
      	<td>
			<input type="radio" name="list" style="border: none;" value="<%=getDBStr(rs.getString("id"))%>" 
			contrId="<%=getDBStr( rs.getString("contract_id")) %>"
			flag="<%=flag %>" projName="<%=getDBStr( rs.getString("project_name")) %>" projId="<%=getDBStr( rs.getString("proj_id")) %>">
      	</td>
		<td align="left"><%=getDBStr( rs.getString("insur_no")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("insur_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("insur_charge_money" )) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_rate")) %></td>	

		<td align="center"><%=getDBStr( rs.getString("insur_type_c")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_period")) %></td>	
		
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("equip_amt" )) %></td>	
		<td align="center"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("insure_pay_type")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		
		<td align="center"><%=getDBStr( rs.getString("insur_obj")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("insur_date")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("insur_start_date")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("insur_term" )) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("insur_end_date")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("leas_end_date")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("xbmonth_amount" )) %></td>
		<td align="center">
			<font color="blue">
			<%
				if( flag>0 ){
			%>
					续保中
			<%	
				}else {
			%>
					未续保
			<% 
				}
			%>
			</font>
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
