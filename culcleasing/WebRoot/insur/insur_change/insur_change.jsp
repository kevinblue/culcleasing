<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险变更</title>
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
	if(	priId==undefined || priId==""){
		alert("请选择要变更的项目！");
	}else if(flag > 0){
		alert("该保险正在流程中，请选择其他保险！");
	}else{
		window.open("http://domino.culc.com/ELeasing/ProjectWF/Insurance.nsf/OSNewWorkFlowFromBXBG?openagent&priId="+priId+"&contractId="+contrId);
	}
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="insur_change.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		保险管理&gt; 保险变更</td>
	</tr>
</table>
<!--标题结束-->

<%
//项目经理只允许修改自己项目
wherestr = " and proj_manage='"+dqczy+"'";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}

countSql = "select count(id) as amount from vi_flow_insur_change where 1=1 "+wherestr;

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
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="变更(Alt+M)" align="absmiddle">保险变更</a></td>
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
		<th>合同编号</th>
		<th>项目名称</th>
		<th>内部行业</th>
		<th>项目经理</th>
		<th>投保方式</th>
		<th>投保类型</th>
		<th>保费收取方式</th>
		
		<th>状态</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_flow_insur_change where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_flow_insur_change where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr += " order by contract_id ";
rs = db.executeQuery(sqlstr);

String pFl = "";
int flag = 0;

while ( rs.next() ) {
	pFl = getDBStr( rs.getString("flag") );
	flag= Integer.parseInt(pFl.isEmpty()?"0":pFl);
%>
      <tr>
      	<td>
			<input type="radio" name="list" style="border: none;" 
			value="<%=getDBStr(rs.getString("id"))%>" 
			contrId="<%=getDBStr( rs.getString("contract_id")) %>"
			flag="<%=flag %>">
      	</td>
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>			
		<td align="center"><%=getDBStr( rs.getString("board_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("leas_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("insur_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("insure_pay_type")) %></td>
		<td align="center">
			<font color="blue">
			<%
				if( flag>0 ){
			%>
					变更中
			<%	
			}else {
			%>
					未变更
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
