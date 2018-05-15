<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金实收全额收据 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	//提交保存资料状态
	function createFundRentPlan(){
		
			var id_list = '';
			var begin_id_list = '';
			var cfri_id_list = '';
			var invoice_type_list='';
			var tax_type_list = '';
			var tax_type_invoice_list = '';
			var rent_list = '';
			var interest_list = '';
			var corpus_list = '';
			var rent_num_list='';
			var selectedIndex = -1;
			var dataNav = document.getElementById("dataNav");
			var str = document.getElementsByName("checkbos_list");
			var i = 0;
			for (i = 0; i < str.length; i++)
			{
				if (str[i].checked)
				{
					selectedIndex = i;
					
					id_list = id_list + str[i].value + "#";					
					begin_id_list = begin_id_list + str[i].attributes["begin_id"].nodeValue+"#";					
					cfri_id_list = cfri_id_list + str[i].attributes["cfri_id"].nodeValue+"#";
					invoice_type_list = invoice_type_list + str[i].attributes["invoice_type"].nodeValue+"#";					
					tax_type_list = tax_type_list + str[i].attributes["tax_type"].nodeValue+"#";
					tax_type_invoice_list = tax_type_invoice_list + str[i].attributes["tax_type_invoice"].nodeValue+"#";
					rent_list = rent_list + str[i].attributes["rent"].nodeValue+"#";
					interest_list = interest_list + str[i].attributes["interest"].nodeValue+"#";
					corpus_list = corpus_list + str[i].attributes["corpus"].nodeValue+"#";
					rent_num_list = rent_num_list + str[i].attributes["rent_num"].nodeValue+"#";
					
				}
			}
			
			if (selectedIndex < 0 )
			{
				alert("请先选择需要开票的数据行!");
				return false;
			}
			
		   id_list = id_list.substring(0,id_list.length-1);
		   begin_id_list = begin_id_list.substring(0,begin_id_list.length-1);
		   cfri_id_list = cfri_id_list.substring(0,cfri_id_list.length-1);
		   invoice_type_list = invoice_type_list.substring(0,invoice_type_list.length-1);		   
		   tax_type_list = tax_type_list.substring(0,tax_type_list.length-1);
		   tax_type_invoice_list = tax_type_invoice_list.substring(0,tax_type_invoice_list.length-1);
		   rent_list = rent_list.substring(0,rent_list.length-1);
		   interest_list = interest_list.substring(0,interest_list.length-1);
		   corpus_list = corpus_list.substring(0,corpus_list.length-1);
		   rent_num_list= rent_num_list.substring(0,rent_num_list.length-1);
			
		   document.getElementById('id_list').value = id_list;
		   document.getElementById('begin_id_list').value = begin_id_list;
		   document.getElementById('cfri_id_list').value = cfri_id_list;
		   document.getElementById('invoice_type_list').value = invoice_type_list;	
		   document.getElementById('tax_type_list').value = tax_type_list;
		   document.getElementById('tax_type_invoice_list').value = tax_type_invoice_list;
		   document.getElementById('rent_list').value = rent_list;
		   document.getElementById('interest_list').value = interest_list;
		   document.getElementById('corpus_list').value = corpus_list;
		    document.getElementById('rent_num_list').value = rent_num_list;
		   
			dataNav.action="rent_receipt_charge_save.jsp";
			dataNav.target="_blank";
			dataNav.submit();
			dataNav.action="rent_receipt_charge.jsp";
			dataNav.target="_self";
	}
	//checkbos全选
	function isSelectAll() {
		var names = document.getElementsByName("checkbos_list");
		var isck_all = document.getElementById("ck_all").checked;
		for (var n=0;n<names.length;n++) {
			names[n].checked=isck_all;
		}
	}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="rent_receipt_plan.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="id_list" id="id_list"/>
<input type="hidden" name="begin_id_list" id="begin_id_list"/>
<input type="hidden" name="cfri_id_list" id="cfri_id_list"/>
<input type="hidden" name="invoice_type_list" id="invoice_type_list"/>
<input type="hidden" name="tax_type_list" id="tax_type_list"/>
<input type="hidden" name="tax_type_invoice_list" id="tax_type_invoice_list"/>
<input type="hidden" name="rent_list" id="rent_list"/>
<input type="hidden" name="interest_list" id="interest_list"/>
<input type="hidden" name="corpus_list" id="corpus_list"/>
<input type="hidden" name="rent_num_list" id="rent_num_list"/>
			
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		租金实收全额收据</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String plan_status =getStr(request.getParameter("plan_status"));
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String start_hire_date = getStr(request.getParameter("start_hire_date"));
String end_hire_date = getStr(request.getParameter("end_hire_date"));
String invoice_is=getStr(request.getParameter("invoice_is"));

String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(plan_status!=null && !plan_status.equals("")){
	wherestr +=" and plan_status like '%" + plan_status + "%'";
}
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr +=" and plan_date>= '"+start_date+"' and plan_date<='"+end_date+"'";
}
if(start_hire_date!=null && !"".equals(start_hire_date) && end_hire_date!=null && !"".equals(end_hire_date)){
	wherestr +=" and last_hire_date>= '"+start_hire_date+"' and last_hire_date<='"+end_hire_date+"'";
}
if(invoice_is!=null && !invoice_is.equals("")){
	wherestr +=" and invoice_is = '" + invoice_is + "'";
}
if(parent_deptname!=null && !parent_deptname.equals("")){
	wherestr +=" and parent_deptname like '%" + parent_deptname + "%'";
}
if(dept_name!=null && !dept_name.equals("")){
	wherestr +=" and dept_name like '%" + dept_name + "%'";
}

wherestr +=" and charge_id  is  not  null";
wherestr +=" and invoice_type  like '%全额收据%'"; 

countSql = "select count(proj_id) as amount from vi_func_rent_manage where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select proj_id 项目编号,begin_id 起租编号,project_name 项目名称,cust_name as 客户名称,parent_deptname 部门名称, dept_name 大区名称,proj_manage_name 项目经理,"+
					"rent_list 租金笔数,plan_date 应收日期,rent 应收金额,interest 应收利息,corpus 应收本金,curr_rent 剩余租金,invoice_type 发票开具方式,"+
					"invoice_is 是否开具,invoice_normal 是否正常开具,invoice_remark 备注,plan_status 租金是否核销,modificator 最后更新人,tax_type 税种,tax_type_invoice 增值税发票类型,invoice_date 开票日期"+
					" from vi_func_rent_manage where 1=1 "+wherestr;
String updSql="select begin_id,rent_list from vi_func_rent_manage where 1=1 "+wherestr;
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
<td>部&nbsp;&nbsp;&nbsp;&nbsp;门:
<input style="width:116px;" name="parent_deptname" id="parent_deptname" type="text" value="<%=parent_deptname%>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 部门','(select distinct parent_deptname as parent_deptname from v_select_base_department ) a ','parent_deptname','','parent_deptname','parent_deptname','asc','dataNav.parent_deptname','');">
</td>
</tr>

<tr>
<td colspan="2">应收日期:&nbsp;<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>大&nbsp;&nbsp;&nbsp;&nbsp;区:
 <input style="width:116px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name%>">
  <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 大区','(select distinct dept_name as dept_name,order_field from v_select_base_department ) a ','dept_name','','dept_name','order_field','asc','dataNav.dept_name','');">
</td>

</tr>

<tr>
<td colspan="2">实收日期:&nbsp;<input name="start_hire_date" type="text" size="15" readonly dataType="Date" value="<%=start_hire_date %>">
<img  onClick="openCalendar(start_hire_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_hire_date" type="text" size="15" readonly dataType="Date" value="<%=end_hire_date %>">
<img  onClick="openCalendar(end_hire_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
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
		<td width="30%">
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="提交(Alt+N)">
			<input class="btn_2" type="button"  value="生成开票清单" onclick="createFundRentPlan();">
		</td>
		<td>
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="RentInvoice">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','insur_pay.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	    <!--操作按钮结束-->
	    </td>		

		<!-- 翻页控制 -->
		<td align="right"><!--翻页控制开始-->
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
	     <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选
	    </th>
     	<th>项目编号</th>
		<th>起租编号</th>
	    <th>项目名称</th>
		<th>客户名称</th>
		<th>部门名称</th>
	    <th>大区名称</th>
     	<th>项目经理</th>
		<th>租金期次</th>
		
		<th>计划日期</th>
		<th>实收日期</th>
	 	<th>应收金额</th>
	 	<th>应收利息</th>
	 	<th>应收本金</th>
		<th>实收租金</th>
	 	<th>实收利息</th>
	 	<th>实收本金</th>
		<th>剩余租金</th>
	 	<th>发票开具方式</th>
	 	<th>租金是否核销</th>
	 	<th>最后更新人</th>
		<th>税种</th>
		<th>增值税发票类型</th>
		<th>申请状态</th>
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_func_rent_manage where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_func_rent_manage where 1=1 "+wherestr+" order by begin_id,rent_list,id ) "+wherestr ;
sqlstr +=" order by  begin_id,rent_list,id ";

System.out.println("sqlstr语句展示-----："+sqlstr);

rs = db.executeQuery(sqlstr);
int index_no = 0;
while (rs.next()) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
	 	<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("id")) %>" 
		begin_id="<%=getDBStr(rs.getString("begin_id"))%>"
		cfri_id="<%=getDBStr(rs.getString("charge_id"))%>"
		invoice_type="<%=getDBStr(rs.getString("invoice_type"))%>"		
		tax_type="<%=getDBStr(rs.getString("tax_type"))%>"
		tax_type_invoice="<%=getDBStr(rs.getString("tax_type_invoice"))%>"
		rent="<%=getDBStr(rs.getString("rent"))%>"
		interest="<%=getDBStr(rs.getString("interest"))%>"
		corpus="<%=getDBStr(rs.getString("corpus"))%>"
		rent_num="<%=getDBStr(rs.getString("rent_list"))%>"
		
		/></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%>
	        <input type="hidden" name="it_<%=index_no %>" value="<%=index_no %>">
	        <input type="hidden" name="begin_id_<%=index_no %>" value="<%=getDBStr(rs.getString("begin_id")) %>"/>
	        <input type="hidden" name="rent_list_<%=index_no %>" value="<%=getDBStr(rs.getString("rent_list")) %>"/>
        </td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
		
		<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
	    <td align="left"><%=getDBDateStr(rs.getString("last_hire_date"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("interest"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("corpus"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("charge_rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("charge_interest"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("charge_corpus"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("curr_rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_type"))%></td>		
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("modificator"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_statues"))%></td>
		<!--<td align="left"><%=getDBDateStr(rs.getString("invoice_date"))%></td>-->
      </tr>
<%}
			System.out.println("test=========="+index_no);
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>
