<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>其它功能 - 租赁物件维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function sub_FlowForm(){
	//判断是否有选中
	var priId = $(":input[name='itemselect']:checked").val();
	var flag = $(":input[name='itemselect']:checked").attr("flag");
	var contrId = $(":input[name='itemselect']:checked").attr("contrId");
	var projId = $(":input[name='itemselect']:checked").attr("projId");
	var projName = $(":input[name='itemselect']:checked").attr("projName");

	if(	priId==undefined || priId==""){
		alert("请选择你要维护的项目！");
	}else if(flag>0){
		alert("该项目正在流程中，请选择其他项目！");
	}else{
		window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/Insurance.nsf/OSNewFlowFromMenuZLWWH?openagent&priId="+priId+"&contractId="+contrId+"&projId="+projId+"&projName="+projName);
	}
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="proj_equip_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		租赁物件维护</td>
	</tr>
</table>
<!--标题结束-->

<%
//项目经理查询自己项目
wherestr = " and proj_manage='"+dqczy+"'";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}

countSql = "select count(ci.id) as amount from vi_flow_equip_wh ci where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="25" value="<%=project_name %>"></td>

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
	  		<td><a href="#" accesskey="m" onclick="sub_FlowForm()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="投保(Alt+M)" align="absmiddle">维护</a></td>
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
		<th>承租人</th>
		<th>行业</th>
		<th>项目经理</th>
		<th>项目金额</th>
		<th>租赁期限(月)</th>
        <th>租赁物件数量</th>
        <th>操作</th>
		<th></th>
      </tr>
      <tbody id="data">
<%
String col_str=" ci.id,ci.proj_id,flag,ci.contract_id,ci.project_name,ci.industry_type_name,ci.cust_name,ci.proj_manage_name,ci.equip_amt,ci.lease_term,ci.equip_amount ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_flow_equip_wh ci where ci.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_flow_equip_wh where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr += " order by ci.contract_id ";
LogWriter.logDebug(request, "#########"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
      	<td>
			<input type="radio" name="itemselect" style="border: none;" 
			value="<%=getDBStr(rs.getString("id"))%>" 
			contrId="<%=getDBStr( rs.getString("contract_id")) %>" 
			projId="<%=getDBStr( rs.getString("proj_id")) %>" 
			projName="<%=getDBStr( rs.getString("project_name")) %>" 
			flag="<%=getDBStr( rs.getString("flag")) %>">
      	</td>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("industry_type_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("equip_amt" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("lease_term" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("equip_amount" )) %></td>	
		<td align="center"><a href="proj_equip_detail.jsp?contractId=<%=getDBStr( rs.getString("contract_id")) %>" target="_blank">查看明细</a></td>	
		<td align="center">
			<font color="blue">
			<%=rs.getInt("flag")>0?"流程中":"未维护" %>
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
