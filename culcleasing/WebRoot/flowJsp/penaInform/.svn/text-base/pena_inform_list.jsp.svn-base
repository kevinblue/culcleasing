<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>逾期通知</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function sub_penaInform(type){
	//判断是否有选中
	var priId = $(":input[name='itemselect']:checked").val();
	var flag = $(":input[name='itemselect']:checked").attr("flag");
	var contrId = $(":input[name='itemselect']:checked").attr("contrId");
	var projId = $(":input[name='itemselect']:checked").attr("projId");
	var projName = $(":input[name='itemselect']:checked").attr("projName");
	var beginId = $(":input[name='itemselect']:checked").attr("beginId");

	if(	priId==undefined || priId==""){
		alert("请选择你要冲抵的资金！");
	}else if(flag>0){
		alert("该资金正在流程中，请选择其他资金！");
	}else{
		if(type=="A"){
			window.open("http://domino.culc.com/ELeasing/ProjectWF/ProjectEother.nsf/OSNewFlowFromMenuYQTZ?openagent&priId="+priId+"&beginId="+beginId+"&contractId="+contrId+"&projId="+projId+"&projName="+projName);
		}else{
			window.open("http://domino.culc.com/ELeasing/ProjectWF/ProjectEother.nsf/OSNewFlowFromMenuYQTZJJ?openagent&priId="+priId+"&beginId="+beginId+"&contractId="+contrId+"&projId="+projId+"&projName="+projName);
		}
	}
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="pena_inform_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		逾期通知</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}

countSql = "select count(id) as amount from vi_Flow_YQTZ_data where 1=1 "+wherestr;
//状态表示含义：1 流程中
%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="20" value="<%=project_name %>"></td>

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
	<td align="left" width="40%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	    	<td><a href="#" accesskey="m" onclick="sub_penaInform('A')">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="逾期通知(Alt+M)" align="absmiddle">逾期通知</a></td>
		    
	    	<td>&nbsp;&nbsp;&nbsp;&nbsp;
	    	<a href="#" accesskey="m" onclick="sub_penaInform('S')">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="逾期通知精简(Alt+S)" align="absmiddle">逾期通知精简</a></td>
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
		<th>项目名称</th>
		<th>合同编号</th>
		<th>起租编号</th>

        <th>客户名称</th>
        <th>行业</th>
        <th>逾期租金</th>
        <th>计划日期</th>
        
        <th>期次</th>
        <th>计划收取日期</th>
        <th>实际收取日期</th>
        <th>逾期天数</th>
        <th>罚息</th>

        <th>剩余罚息</th>
        <th>减免罚息</th>
        <th>状态</th>
        <th></th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";
//id,contract_id,begin_id,rent_start_date,income_number_year,project_name,cust_name,proj_dept,industry_type_name,
//penalty_rent,rent_list,penalty_rent_planDate,penalty_rent_hireDate,penalty_day_amount,penalty,curr_penalty,penalty_rid,
//paid_penalty,plan_date,plan_status,flag

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_Flow_YQTZ_data where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_Flow_YQTZ_data where 1=1 "+wherestr+" order by begin_id,rent_list ) "+wherestr ;
sqlstr += " order by begin_id,rent_list ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
      	 <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") ) %>" 
        flag="<%=getDBStr( rs.getString("flag")) %>" contrId="<%=getDBStr( rs.getString("contract_id")) %>" 
        projId="<%=getDBStr( rs.getString("proj_id")) %>" beginId="<%=getDBStr( rs.getString("begin_id")) %>"
        projName="<%=getDBStr( rs.getString("project_name")) %>"></td>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("begin_id")) %></td>	
		
		<td align="center"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("industry_type_name")) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("penalty_rent" )) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("plan_date")) %></td>	
			
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("rent_list" )) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("penalty_rent_planDate")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("penalty_rent_hireDate")) %></td>	
		<td align="left"><%= CurrencyUtil.convertIntAmount( rs.getString("penalty_day_amount" )) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("penalty" )) %></td>	
		
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("curr_penalty" )) %></td>	
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("penalty_rid" )) %></td>	
		<td align="center">
			<font color="blue">
			<%
				String pFl = rs.getString("flag");
				if("0".equals(pFl)){%>
					未操作
				<%}else { %>
					流程中
			   <% } %>
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
