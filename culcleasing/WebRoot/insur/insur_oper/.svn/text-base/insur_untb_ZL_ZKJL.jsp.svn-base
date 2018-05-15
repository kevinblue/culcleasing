<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 待投保项目(租赁)</title>
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
	var flag = $(":input[name='list']:checked").attr("flag");
	var contrId = $(":input[name='list']:checked").attr("contrId");
	var cid = $(":input[name='list']:checked").attr("cid");
	var projName = $(":input[name='list']:checked").attr("projName");
	var projId = $(":input[name='list']:checked").attr("projId");
	var fkPlanId = $(":input[name='list']:checked").attr("fk_id");
	
	if(	priId==undefined || priId==""){
		alert("请选择要投保的项目！");
	}else if(flag>0){
		alert("该保险正在流程中，请选择其他保险！");
	}else{
		window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/Insurance.nsf/OSNewWorkFlowFromBXTBZL?openagent&priId="+priId+"&contractId="+contrId+"&cid="+cid+"&projId="+projId+"&projName="+projName+"&fkPlanId="+fkPlanId);
	}
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="insur_untb_ZL.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		保险管理&gt; 待投保项目(租赁)</td>
	</tr>
</table>
<!--标题结束-->

<%

String wherestr1=" viu.create_date desc ";
wherestr = " and ((viu.leas_form='直租' and viu.equip_amount>viu.equip_JF_amount) or (viu.leas_form='回租' and viu.equip_amt>viu.sum_insur_money) )and viu.insur_type in('本司付款','本司代付')";
wherestr +=" and viu.contract_id = ci.contract_id and PBM.proj_id = ci.proj_id and PBM.BusinessManager_id = '"+dqczy+"' ";
//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
String cd=getStr( request.getParameter("CD") );
if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if(!cd.equals("") || cd!=null){
	if(cd.equals("升序")){
	wherestr1="cd_date asc";
	}else if (cd.equals("降序")){
	wherestr1="cd_date desc";
	}
}
//暂不区分投保租赁物件数量

countSql = "select count(viu.id) as amount FROM vi_insur_untb viu ,proj_Business_Manager PBM ,contract_info ci where 1=1 "+wherestr;

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
<td>CD交接排序方式
<select name="CD" style="width: 120px;" >
	<script type="text/javascript">
		w(mSetOpt("<%=cd %>","|升序|降序","|升序|降序")); 
	</script>
</select>
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
	  		<td><a href="#" accesskey="m" onclick="start_flow()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="投保(Alt+M)" align="absmiddle">投保</a></td>
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
      	<th width="1%"></th>
		<th>项目名称</th>
		<th>合同编号</th>
		<th>承租人</th>
        <th>文档编号</th>
		<th>项目经理</th>
		<th>投保方式</th>
		<th>保费收取方式</th>
		<th>项目金额</th>
		<th>租赁期限(月)</th>
		<th>CD交接时间</th>

		<th>险种</th>
		<th>投保支付周期</th>
		<th>保单有效期(月)</th>
		
        <th>租赁物件数量</th>
        <th>已投保数量</th>
        <th>未投保数量</th>
        <th>状态</th>
        <th>已投保金额</th>
        <th>未投保金额</th>
      </tr>
      <tbody id="data">
<%
String col_str=" viu.*,(select archive_no from contract_archive where contract_id=viu.contract_id) as archive_no ";

sqlstr = "select top "+ intPageSize +" "+col_str+" FROM vi_insur_untb viu ,proj_Business_Manager PBM ,contract_info ci where viu.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" viu1.id FROM vi_insur_untb viu1 ,proj_Business_Manager PBM1 ,contract_info ci1 where 1=1 "+wherestr+" order by "+wherestr1+" ) "+wherestr ;
sqlstr += " order by   "+wherestr1+" ";
System.out.println("aaaaaaaaaa"+sqlstr);
rs = db.executeQuery(sqlstr);
String pFl = "";
int flag = 0;

%>
<%-- <tr>
	<td colspan="100">
      		countSql=<%=countSql %>
      	</td>
</tr>
<tr>
	<td colspan="100">
      		sqlstr=<%=sqlstr %>
      	</td>
</tr> --%>
<%

while ( rs.next() ) {
	flag=  rs.getInt("flag");
%>
      <tr>
      	<td>
			<input type="radio" name="list" style="border: none;" 
			value="<%=getDBStr(rs.getString("id"))%>" contrId="<%=getDBStr( rs.getString("contract_id")) %>" 
			cid="<%=getDBStr( rs.getString("cid")) %>" fk_id="<%=getDBStr( rs.getString("fk_id")) %>"
			flag="<%=flag %>"  projName="<%=getDBStr( rs.getString("project_name")) %>" projId="<%=getDBStr( rs.getString("proj_id")) %>">
      	</td>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("archive_no")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_type")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insure_pay_type")) %></td>	

		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("equip_amt" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("lease_term" )) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("cd_date" )) %></td>	
		
		<td align="center"><%=getDBStr( rs.getString("insur_type_c")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_period")) %></td>	
		
		<td align="center"><%=CurrencyUtil.convertIntAmount( rs.getString("insur_indate")) %></td>	
		
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("equip_amount" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("equip_JF_amount" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getInt("equip_amount")-rs.getInt("equip_JF_amount") ) %></td>	
      	<td align="center">
			<font color="blue"><%=flag>0?"投保中":"未投保" %></font>
		</td>
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("sum_insur_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("left_insur_money" )) %></td>	
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
