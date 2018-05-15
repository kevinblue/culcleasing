<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String context = request.getContextPath();
String userId=(String) session.getAttribute("czyid");
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>开票接口回传 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">	
	//checkbos全选
	function isSelectAll() {
		var names = document.getElementsByName("checkbos_list");
		var isck_all = document.getElementById("ck_all").checked;
		for (var n=0;n<names.length;n++) {
			names[n].checked=isck_all;
		}
	}
		
</script>



<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="invoice_export_result.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">
<input id="sqlIds" name="sqlIds" type="hidden" >
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="id_list" id="id_list"/>
<input type="hidden" name="contract_id_list" id="contract_id_list"/>
<input type="hidden" name="fee_name_list" id="fee_name_list"/>
<input type="hidden" name="fee_num_list" id="fee_num_list"/>
<input type="hidden" name="invoice_statues" id="invoice_statues"/>
<input type="hidden" name="invoice_statues_list" id="invoice_statues_list"/>


<!-- 资金计划数据 -->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		开票接口回传</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String cust_name = getStr( request.getParameter("cust_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

String invoice_start_date = getStr(request.getParameter("invoice_start_date"));
String invoice_end_date = getStr(request.getParameter("invoice_end_date"));

String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));
String invoice_statu=getStr(request.getParameter("invoice_statu"));
String open_invoice_status=getStr(request.getParameter("open_invoice_status"));


if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( cust_name!=null && !cust_name.equals("") ) {
	wherestr += " and cust_name like '%" + cust_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr +=" and plan_date>= '"+start_date+"' and plan_date<='"+end_date+"'";
}


if(invoice_start_date!=null && !"".equals(invoice_start_date) && invoice_end_date!=null && !"".equals(invoice_end_date)){
	wherestr +=" and open_invoice_date>= '"+invoice_start_date+"' and open_invoice_date<='"+invoice_end_date+"'";
}
if(parent_deptname!=null && !parent_deptname.equals("")){
	wherestr +=" and parent_deptname like '%" + parent_deptname + "%'";
}
if(dept_name!=null && !dept_name.equals("")){
	wherestr +=" and dept_name like '%" + dept_name + "%'";
}

if(invoice_statu!=null && !invoice_statu.equals("")){
	wherestr +=" and invoice_statues ='" +invoice_statu +"'";
}
if(open_invoice_status!=null && !open_invoice_status.equals("")){
	wherestr +=" and open_invoice_status ='" +open_invoice_status +"'";
}

countSql = "select count(out_no) as amount from vi_invoice_export_result_show where 1=1 "+wherestr;

//导出类型2--数据导出
String  exportcolumn=" proj_id 项目编号,contract_id 合同编号,project_name 项目名称,cust_name 客户名称,parent_deptname 部门名称,dept_name 大区名称,proj_manage_name 项目经理,fee_name 款项名称,fee_num 期次,plan_date 计划日期,plan_money 计划金额,invoice_money 导出金额,tax_money 税额,";
exportcolumn +=" tax_type_invoice 增值税发票类型,tax_rate 资金税率,tax_payer_no 纳税人识别号,address 纳税人地址,tel 纳税人电话,bank_name 纳税人基本开户行,bank_no 纳税人账号,invoice_number 发票号码,invoice_code 发票代码,open_invoice_date 开票日期,open_invoice_status 开票状态";
String expsqlstr = "select "+exportcolumn+" from vi_invoice_export_result_show where 1=1 "+wherestr; 
System.out.println("vvvvvvvvvvvvv"+expsqlstr);

String updSql="select contract_id,fee_name,fee_num,id from vi_invoice_export where 1=1 "+wherestr;
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
<td>项目经理:&nbsp;<input name="proj_manage_name"  type="text" size="15" value="<%=proj_manage_name %>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 项目经理','(select distinct proj_manage_name as proj_manage_name from vi_contract_info) a ','proj_manage_name','','proj_manage_name','proj_manage_name','asc','dataNav.proj_manage_name','');">
</td>
<td>部门:&nbsp;<input  name="parent_deptname" id="parent_deptname" size="15"  type="text" value="<%=parent_deptname%>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 部门','(select distinct parent_deptname as parent_deptname from v_select_base_department ) a ','parent_deptname','','parent_deptname','parent_deptname','asc','dataNav.parent_deptname','');">
</td>
</tr>
<tr>
<td>大&nbsp;&nbsp;&nbsp;&nbsp;区:
 <input style="width:116px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name%>">
  <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 大区','(select distinct dept_name as dept_name,order_field from v_select_base_department ) a ','dept_name','','dept_name','order_field','asc','dataNav.dept_name','');">
</td>

<td >计划日期:&nbsp;<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
至
<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>客户名称:&nbsp;<input name="cust_name"  type="text" size="15" value="<%=cust_name %>"></td>
</tr>

<tr>
 <td >开票日期:&nbsp;<input name="invoice_start_date" type="text" size="15" readonly dataType="Date" value="<%=invoice_start_date %>">
<img  onClick="openCalendar(invoice_start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
至
<input name="invoice_end_date" type="text" size="15" readonly dataType="Date" value="<%=invoice_end_date %>">
<img  onClick="openCalendar(invoice_end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>开票状态:
	<select name="open_invoice_status" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=open_invoice_status%>',"|正常|作废|红票|未开票","|正常|作废|红票|未开票"));
		</script>
	 </select>
</td>
</tr>
<tr>

<td ><input type="button" value="清空" onclick="clearQuery();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="查询" onclick="dataNav.submit();"></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!-- end cwTop -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
<td align="left" width="20%">
	<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="FundInvoice">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','invoice_export_result.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%">
	<!-- 翻页控制开始 -->
	<%@ include file="pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table"  >
      <tr class="maintab_content_table_title">
	   <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选
	    </th>
     <!--	<th>发票单据号</th>-->
		<th>项目编号</th>
	    <th>合同编号</th>
		<th>项目名称</th>
	    <th>客户名称</th>
		<th>部门名称</th>
		<th>大区名称</th>
		<th>项目经理</th>

		<th>款项名称</th>
		<th>期次</th>
		<th>计划日期</th>
		<!--<th>实收日期</th>-->
	 	<th>计划金额</th>
		<th>导出金额</th>
		<th>税额</th>
		<th>增值税发票类型</th>
		<th>资金税率</th>
		<th>纳税人识别号</th>
		<th>纳税人地址</th>
		<th>纳税人电话</th>
		<th>纳税人基本开户行</th>
		<th>纳税人账号</th>
		<th>发票号码</th>
		<th>发票代码</th>
		<th>开票日期</th>
		<th>发票状态</th>
		
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_invoice_export_result_show where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_invoice_export_result_show where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

System.out.println("sqlstr查询条件"+sqlstr);

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
	
     <tr class="materTr_<%=index_no %>" id="materTr_<%=index_no %>">
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("out_no")) %>"
		contract_id="<%=getDBStr(rs.getString("contract_id"))%>"
		tax_rate="<%=getDBStr(rs.getString("tax_rate"))%>"
		/></td>	 
		<td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_num"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
     	<td align="left"><%=getDBStr(rs.getString("tax_rate"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_payer_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("address"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tel"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_number"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_code"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("open_invoice_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("open_invoice_status"))%></td>
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
