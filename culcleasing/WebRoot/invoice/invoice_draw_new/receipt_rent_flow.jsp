<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>票据管理 - 租金收据领取列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">	
//删除时
function validate_del() {
	var fpId = $(":checkbox[name='list']:checked").val();
	
	if(fpId==undefined){
		alert("请选择您要删除的租金发票!");
		return false;
	}else{
		document.dataNav.action="receipt_rent_save.jsp";
		document.dataNav.target="_blank";
		document.dataNav.submit();
		document.dataNav.action="receipt_rent_flow.jsp";
		document.dataNav.target="_self";
	}
}
</script>		
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String glide_id= getStr( request.getParameter("glide_id") );
String proj_name = getStr( request.getParameter("proj_name") );
String proj_assistant_name = getStr( request.getParameter("proj_assistant_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String start_hire_date = getStr(request.getParameter("start_hire_date"));
String end_hire_date = getStr(request.getParameter("end_hire_date"));
if ( proj_name != null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr +=" and plan_date>= '"+start_date+"' and plan_date<='"+end_date+"'";
}
if(start_hire_date!=null && !"".equals(start_hire_date) && end_hire_date!=null && !"".equals(end_hire_date)){
	wherestr +=" and last_hire_date>= '"+start_hire_date+"' and last_hire_date<='"+end_hire_date+"'";
}

if ( proj_assistant_name!=null && !proj_assistant_name.equals("") ) {
	wherestr += " and proj_assistant_name like '%" + proj_assistant_name + "%'";
}

String wheretemp="";
 ///wheretemp = ",isnull((select count(rent_list) from vi_func_rent_manage_draw a where a.begin_id=vi_func_rent_manage_draw.begin_id ";
	//wheretemp += "and a.plan_date<=vi_func_rent_manage_draw.plan_date and plan_status<>'已回笼'),0) as count_rent,";
	//wheretemp += "(select sum(curr_rent) from vi_func_rent_manage_draw a where a.begin_id=vi_func_rent_manage_draw.begin_id and ";
	//wheretemp += "a.plan_date<=vi_func_rent_manage_draw.plan_date and plan_status<>'已回笼') as sum_rent ";
	
	//String expwheretemp = ",isnull((select count(rent_list) from vi_func_rent_manage_draw_new a where a.begin_id=vi_func_rent_manage_draw_new.begin_id ";
	//expwheretemp += "and a.plan_date<=vi_func_rent_manage_draw_new.plan_date and plan_status<>'已回笼'),0) 未还租金笔数,";
	//expwheretemp += "(select sum(curr_rent) from vi_func_rent_manage_draw_new a where a.begin_id=vi_func_rent_manage_draw_new.begin_id and ";
	//expwheretemp += "a.plan_date<=vi_func_rent_manage_draw_new.plan_date and plan_status<>'已回笼') as 未还租金金额, ";

wherestr += " and id in(Select pri_id from invoice_draw_detail where apply_id='"+glide_id+"' and invoice_type='本金收据')";
//导出类型2--数据导出
String expsqlstr = "select proj_id 项目编号, begin_id 起租编号,project_name 项目名称,cust_name 客户名称,parent_deptname 部门名称,";
expsqlstr += " dept_name 大区名称,proj_manage_name 项目经理,rent_list 租金笔数,";
expsqlstr += "plan_date 应收日期,last_hire_date 实收日期,plan_money 应收本金,invoice_money 导出金额 ,invoice_type 发票开具方式,";
expsqlstr += "plan_status 租金是否核销 ,tax_type 税种,tax_type_invoice  增值税发票类型 from"; 
expsqlstr += " vi_func_rent_manage_draw_receipt where 1=1 "+wherestr;
countSql = "select count(id) as amount from vi_func_rent_manage_draw_receipt where 1=1 "+wherestr;

%>

<body onload="public_onload(0);">
<form action="receipt_rent_flow.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="savetype" value="del"/>
<input type="hidden" name="glide_id" value="<%=glide_id %>"/>


<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			票据管理 - 租金收据领取
		</td>
	</tr>
</table><!--标题结束-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td >应收日期:&nbsp;<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
至
<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td >实收日期:&nbsp;<input name="start_hire_date" type="text" size="15" readonly dataType="Date" value="<%=start_hire_date %>">
<img  onClick="openCalendar(start_hire_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
至
<input name="end_hire_date" type="text" size="15" readonly dataType="Date" value="<%=end_hire_date %>">
<img  onClick="openCalendar(end_hire_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>

<td>项目助理:&nbsp;<input name="proj_assistant_name"  type="text" size="15" value="<%=proj_assistant_name %>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 项目经理','(select distinct proj_assistant_name as proj_assistant_name from vi_contract_info) a ','proj_assistant_name','','proj_assistant_name','proj_assistant_name','asc','dataNav.proj_assistant_name','');">
</td>
<td align="center"><input type="button" value="查询" onclick="dataNav.submit();"></td>
<td align="center"><input type="button" value="清空" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
		<%--- 	<td>
				<BUTTON class="btn_2" name="btndel" value="删除"  type="button" onclick="validate_del();">
				<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">&nbsp;删除</button>
			</td>  --%> 
			<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','receipt_rent_flow.jsp');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
			</td>
			<td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
			</td>
			<td nowrap>
			</td>
		</tr>
		</table>
		<!--操作按钮结束-->
	</td>
	<td align="right" width="90%">
	<!--翻页控制开始-->
	<%@ include file="../../public/pageSplit.jsp"%>
	</td><!--翻页控制结束-->	
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
		<tr class="maintab_content_table_title">
			<th width="1%"></th> 			 						
	     	<th>项目编号</th>
			<th>起租编号</th>
		    <th>项目名称</th>
		    <th>客户名称</th>
			<th>部门名称</th>
		    <th>大区名称</th>
	     	<th>项目经理</th>
	     	<th>项目助理</th>
	 		<th>租金笔数</th>		
			<th>应收日期</th>
			<th>实收日期</th>
		 	<th>应收本金</th>
		 	<th>开票金额</th>
		 	<th>发票开具方式</th>
		 	<th>租金是否核销</th>
			<th>税种</th>
			<th>增值税发票类型</th>
				
		</tr>
<tbody id="data">
<%
sqlstr = "select top "+ intPageSize +" *"+wheretemp+"from vi_func_rent_manage_draw_receipt where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_func_rent_manage_draw_receipt where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";
System.out.println("-=======-------==="+sqlstr);
rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
      	<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>	
		<td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_assistant_name"))%></td>
        
        <td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("last_hire_date"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("invoice_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_type"))%></td>	
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
		
      </tr>
<%}
rs.close();
db.close();
%>     
	</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>

