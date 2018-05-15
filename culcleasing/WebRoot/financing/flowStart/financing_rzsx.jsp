<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>融资授信</title>
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
	var FinancingCrediterCode = $(":input[name='itemselect']:checked").attr("FinancingCrediterCode");
	var FinancingCrediterType = $(":input[name='itemselect']:checked").attr("FinancingCrediterType");
	var FinancingCreditType = $(":input[name='itemselect']:checked").attr("FinancingCreditType");

	if(	priId==undefined || priId==""){
		alert("请选择授信信息！");
	}else{
		window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/Financing.nsf/OSNewFlowFromMenuSXJSP?openagent&priId="+priId+"&FinancingCrediter="+FinancingCrediter+"&FinancingCrediterCode="+FinancingCrediterCode+"&FinancingCrediterType="+FinancingCrediterType+"&FinancingCreditType="+FinancingCreditType);
	}
}
</script>
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="financing_rzsx.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		融资授信</td>
	</tr>
</table>
<!--标题结束-->

<%
//wherestr = " and isnull(credit_left_money,0)>0 ";

//本页查询参数
String crediter = getStr( request.getParameter("crediter") );

if ( crediter!=null && !"".equals(crediter) ) {
	wherestr += " and unit_name like '%" + crediter + "%'";
}

countSql = "select count(id) as amount from vi_select_fina_credit_FLOW_SX where 1=1 "+wherestr;
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
<td>授信单位:&nbsp;<input name="crediter"  type="text" size="15" value="<%=crediter %>"></td>

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
	    	<td><a href="#" accesskey="m" onclick="sub_startFlow()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="变更(Alt+M)" align="absmiddle">授信</a></td>
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
		<th>授信单位</th>
		<th>机构类型</th>
		<th>授信种类</th>    
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_select_fina_credit_FLOW_SX where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_select_fina_credit_FLOW_SX where 1=1 "+wherestr+" order by unit_name,id ) "+wherestr ;
sqlstr += " order by unit_name,id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
      	 <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") ) %>" 
		 flag="0" FinancingCrediter="<%=getDBStr( rs.getString("unit_name")) %>" 
        FinancingCrediterCode="<%=getDBStr( rs.getString("unit_code")) %>" FinancingCrediterType="<%=getDBStr( rs.getString("unit_property")) %>"
		FinancingCreditType="<%=getDBStr( rs.getString("credit_type")) %>"></td>
		<td align="left"><%=getDBStr( rs.getString("unit_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("unit_property")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("credit_type")) %></td>	
		
		<%-- 
		<td align="center">
			<font color="blue">
			未操作
			</font>
		</td>
		--%>
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
