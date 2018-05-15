<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>利息修改 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="interest_upd.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		利息修改</td>
	</tr>
</table> 

<%
wherestr = " and remark_O='增值税'";

String proj_name = getStr( request.getParameter("proj_name") );

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and pcode like '%" + proj_name + "%'";
}

countSql = "select count(id) as amount from vi_INTERFACE_fina_global_interest where 1=1 "+wherestr;

//导出类型2--数据导出
//String expsqlstr = "select proj_id 项目编号,begin_id 起租编号,project_name 项目名称,cust_name as 客户名称,parent_deptname 部门名称, dept_name 大区名称,proj_manage_name 项目经理,"+
//					"rent_list 租金笔数,plan_date 应收日期,rent 应收金额,interest 应收利息,invoice_type 发票开具方式,"+
//				"invoice_is 是否开具,invoice_normal 是否正常开具,invoice_remark 备注,plan_status 租金是否核销,modificator 最后更新人,tax_type 税种,tax_type_invoice 增值税发票类型"+
//			" from vi_func_rent_manage where 1=1 "+wherestr;
//String updSql="select begin_id,rent_list from vi_INTERFACE_fina_global_interest where 1=1 "+wherestr;
%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td> <input type="button" value="查询" onclick="dataNav.submit();"></td>
<td><input type="button" value="清空" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!-- end cwTop -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		<!-- 翻页控制 -->
		<td align="right" width="40%"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->
		</td><!-- 翻页结束 -->
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      	<th>单据号</th>
      	<th>承租客户</th>
      	<th>项目经理</th>
     	<th>项目编号</th>
	    <th>项目名称</th>
		<th>合同号</th>
	    <th>传输日期</th>
     	<th>年</th>
 		<th>月</th>
 		
		<th>款项内容</th>
	 	<th>金额</th>
	 	<th>利息年月</th>
	 	<th>备注</th>
	 	<th>内部行业</th>
	 	<th>操作</th>
      </tr>
   <tbody id="data">
<%
sqlstr = "select top "+ intPageSize +" * from vi_INTERFACE_fina_global_interest where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_INTERFACE_fina_global_interest where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
        <td align="left"><%=getDBStr(rs.getString("invcode"))%></td>
        <td align="left"><%=getDBStr(rs.getString("ccode"))%></td>
        <td align="left"><%=getDBStr(rs.getString("bcode"))%></td>
        <td align="left"><%=getDBStr(rs.getString("picode"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pcode"))%></td>
        <td align="left"><%=getDBStr(rs.getString("ordcode"))%></td>
        <td align="left"><%=getDBStr(rs.getString("modifydate"))%></td>
        <td align="left"><%=getDBStr(rs.getString("invyear"))%></td>
        <td align="left"><%=getDBStr(rs.getString("invmonth"))%></td>
	    
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("invtype"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rmb"))%></td>	
		<td align="left"><%=getDBStr(rs.getString("invyear_month"))%></td>
		<td align="left"><%=getDBStr(rs.getString("remark_o"))%></td>
		<td align="left"><%=getDBStr(rs.getString("industry"))%></td>
		<td align="left">
		<a href='interest_upd_detail.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改利息金额</a>
	    </td>
      </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>
