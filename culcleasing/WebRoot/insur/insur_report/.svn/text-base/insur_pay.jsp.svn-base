<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>付款材料附件</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<%
wherestr = "";
String searchKey = getStr(request.getParameter("cust_name"));
if ( searchKey!=null && !"".equals(searchKey))
{
   wherestr += " and cust_name like '%"+searchKey+"%' "; 
   LogWriter.logDebug(request, "######"+sqlstr);
}

countSql = "select count(id) as amount from vi_insur_pay  where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select id 序号,cust_name 客户名称,proj_id 项目编号,project_name 项目名称,proj_manage_name 项目经理,insur_no 保单号,insur_start_date 保险开始日期,curr_plan_money 保险费,insure_type_name 保费支付,insur_term 保险年限,init_insur_status 投保状态,archive_no 文档编号,insur_company 保险公司 from vi_insur_pay where 1=1 "+wherestr+"  order by cd_date";
%>



<body onLoad="public_onload(0)">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<form action="insur_pay.jsp" name="dataNav" onSubmit="return goPage()">
<!-- end cwTop -->
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;查询条件
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
	</legend>
		<table border="0" width="100%" cellspacing="5" cellpadding="0">
			<tr>
				<td>客户名称:&nbsp;<input name="cust_name"  type="text" size="15" value="<%=searchKey %>"></td>
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


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
      	<td align="left" width="10%">
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="InsurPay">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','insur_pay.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	    <!--操作按钮结束-->
	   </td>

        <td align="right" width="80%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
  		<tr class="maintab_content_table_title">
			<th>序号</th>
			<th>客户名称</th>
			<th>项目编号</th>
			<th>文档编号</th>
			<th>项目名称</th>
			<th>项目经理</th>
			<th>保单号</th>
			<th>保险开始日期</th>
			<th>保险费</th>
			<th>保费支付</th>
			<th>保险年限</th>
			<th>CD交接时间</th>
			<th>投保状态</th>
			<th>保险公司</th>
		</tr>
   <tbody id="data">
<%	  
String col_str="id,cust_name,proj_id,insur_no,insur_start_date,project_name,proj_manage_name,curr_plan_money,insure_type_name,insur_term,cd_date,init_insur_status,archive_no,insur_company ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_insur_pay where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_insur_pay where 1=1 "+wherestr+" order by cd_date ) "+wherestr ;
sqlstr += " order by cd_date ";

LogWriter.logDebug(request, "@@@@@@@"+sqlstr);
int index = 1;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
 		<td align="center"><%=index++ %></td>
	 	<td align="center"><%=getDBStr(rs.getString("cust_name")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("proj_id")) %></td>
		<td align="center"><%=getDBStr(rs.getString("archive_no")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("project_name")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("proj_manage_name")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("insur_no")) %></td>
	 	<td align="center"><%=getDBDateStr(rs.getString("insur_start_date")) %></td>
	 	<td align="center"><%=CurrencyUtil.convertFinance(rs.getString("curr_plan_money")) %></td>
	 	<td align="center"><%=getDBStr(rs.getString("insure_type_name")) %></td>
	 	<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getString("insur_term")) %>个月</td>
	
		<td align="center"><%=getDBDateStr(rs.getString("cd_date")) %></td>
		<td align="center"><%=getDBStr(rs.getString("init_insur_status")) %></td>
		<td align="center"><%=getDBStr(rs.getString("insur_company")) %></td>
    </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>

</form>
</body>
<script type="text/javascript">
 function exportData(){
 	if(confirm("是否确定导出excel?")){
 		dataNav.action="insur_pay_erport_save.jsp";
 		dataNav.target="_black";
 		dataNav.submit();
 		dataNav.action="insur_pay.jsp";
 		dataNav.target="_self";
 	}
 }
</script>
</html>
