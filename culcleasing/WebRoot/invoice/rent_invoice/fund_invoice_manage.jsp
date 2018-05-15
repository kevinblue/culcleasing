<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金发票管理 </title>
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
	function updMaterStatus(){
		var flag = 0;
		var erItems = "";
		var items = "";
		var item="";
		var invoice_is="";
		var invoice_normal="";
		var begin_id="";
		var rent_list="";
		var invoice_remark="";
		$("#data>tr").each(function(i){
		    var $materTr = $(this); 
		    item = $materTr.find("td>:input[name^='it_']");
		    invoice_is = $materTr.find("td>:input[name^='invoice_is_']:checked");
		    invoice_normal = $materTr.find("td>:input[name^='invoice_normal_']:checked");
		    begin_id=$materTr.find("td>:input[name^='begin_id_']");
		    rent_list=$materTr.find("td>:input[name^='rent_list_']");
		    invoice_remark=$materTr.find("td>:input[name^='invoice_remark_']");
			//判断数据的正确性
			if($.trim(invoice_is.val())==""  ){
				flag = 1;
				erItems += " ["+(i+1)+"] ";
			}
			
			items += $.trim(item.val())+"|";// 以|分实体以-分字段
		});
	
		if(flag!=0){
		    alert("请确认每1条资金的发票是否开具！其中第 "+erItems+" 行没有确认！");
			return false;
		}else{
			var itemStr=$(":input[name=itemStr]").val(items.substring(0,items.length-1));
			//alert(itemStr);
			dataNav.action="fund_invoice_manage_save.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			dataNav.action="fund_invoice_manage.jsp";
			dataNav.target="_self"
		}
	}
	function allbool(va){
		var v=va;
		if(v=='是1'){
			$(":radio[id='invoice_is']").removeAttr("checked");
			$("input[id='invoice_is'][value='是']").attr("checked","checked");	
		
		}else if(v=='否1'){
		    $(":radio[id='invoice_is']").removeAttr("checked");
			$("input[id='invoice_is'][value='否']").attr("checked","checked");
		}
	}


	function piliang(beizhu){
		var bz='invoice_remark_'+beizhu;
		var vu = $("input[name='"+bz+"']").val();
		$("input[id='invoice_remark']").val(vu);
	}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="fund_invoice_manage.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		资金发票管理</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String start_hire_date = getStr(request.getParameter("start_hire_date"));
String end_hire_date = getStr(request.getParameter("end_hire_date"));
String invoice_is=getStr(request.getParameter("invoice_is"));
String pay_obj = getStr(request.getParameter("pay_obj"));
String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));
String status=getStr(request.getParameter("status"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr +=" and plan_date>= '"+start_date+"' and plan_date<='"+end_date+"'";
}
if(start_hire_date!=null && !"".equals(start_hire_date) && end_hire_date!=null && !"".equals(end_hire_date)){
	wherestr +=" and fact_date>= '"+start_hire_date+"' and fact_date<='"+end_hire_date+"'";
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
if(pay_obj != null && !pay_obj.equals("")){
	wherestr +=" and pay_obj like '%" + pay_obj + "%'";
}
if(status!=null && !status.equals("")){
	wherestr +=" and status = '" + status + "'";
}


countSql = "select count(proj_id) as amount from vi_func_fund_manage where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select proj_id 项目编号,contract_id 合同编号,project_name 项目名称,cust_name 客户名称,parent_deptname 部门名称, dept_name 大区名称,proj_manage_name 项目经理,fee_name 款项名称,fee_num 资金期次,plan_date 应收日期,fact_date 实收日期,plan_money 应收金额,invoice_is 是否开具,invoice_remark 备注,pay_obj 付款人,tax_type_invoice 增值税发票类型,invoice_date 开票日期 from vi_func_fund_manage where 1=1 "+wherestr;
System.out.println("vvvvvvvvvvvvv"+expsqlstr);

String updSql="select contract_id,fee_name,fee_num,id from vi_func_fund_manage where 1=1 "+wherestr;
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
<td>大&nbsp;&nbsp;&nbsp;&nbsp;区:
 <input style="width:116px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name%>">
  <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' 大区','(select distinct dept_name as dept_name,order_field from v_select_base_department ) a ','dept_name','','dept_name','order_field','asc','dataNav.dept_name','');">
</td>

<td>是否开具:
 <select name="invoice_is" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=invoice_is %>',"|是|否","|是|否"));
    </script>
 </select>
</td>



</tr>
<tr>
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
<td>付款人:&nbsp;<input name="pay_obj"  type="text" size="15" value="<%=pay_obj %>"></td>
<td>领取状态
	<select name="status" style="width: 115px;">
		<script type="text/javascript">
			w(mSetOpt('<%=status %>',"|未领取|已领取","|未领取|已领取")); 
		</script>
	</select>
</td>
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
		<td  width="30%">
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="提交(Alt+N)">&nbsp;&nbsp;
			<input class="btn_2" type="button"  value="提交" onclick="return updMaterStatus();">&nbsp;&nbsp;

			<input type="button" value="开具" onclick="return allbool('是1');">&nbsp;
			<input type="button" value="不开具" onclick="return allbool('否1');">&nbsp;
			<input type="checkbox" value="开具" name="kj">开具&nbsp;
		</td>
		<td width="20%">
		开票日期：<input name="invoice_date" type="text" size="15" readonly dataType="Date">
		<img  onClick="openCalendar(invoice_date);return false" style="cursor:pointer; " 
		src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		</td>
		<td align="left">
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="FundInvoice">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','fund_invoice_manage.jsp');">
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
     	<th>项目编号</th>
		<th>合同编号</th>
	    <th>项目名称</th>
	    <th>客户名称</th>
		<th>部门名称</th>
	    <th>大区名称</th>
     	<th>项目经理</th>

		<th>款项名称</th>
		<th>资金期次</th>
		<th>应收日期</th>
		<th>实收日期</th>
	 	<th>应收金额</th>
	 	
	 	<th>是否开具</th>
	 	<th>备注</th>
		<th>付款人</th>

		<th>增值税发票类型</th>
		<th>开票日期</th>
		<th>领取状态</th>
		<!--  ADD -->
		<th>纳税人识别号</th>
		<th>纳税人地址</th>
		<th>纳税人电话</th>
		<th>纳税人基本开户行</th>
		<th>纳税人账号</th>
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_func_fund_manage where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_func_fund_manage where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%>
	        <input type="hidden" name="it_<%=index_no %>" value="<%=index_no %>">
			<input type="hidden" name="contract_id_<%=index_no %>" value="<%=getDBStr(rs.getString("contract_id")) %>"/>
	        <input type="hidden" name="fee_name_<%=index_no %>" value="<%=getDBStr(rs.getString("fee_name")) %>"/>
			<input type="hidden" name="fee_num_<%=index_no %>" value="<%=getDBStr(rs.getString("fee_num")) %>"/>
			<input type="hidden" name="pri_id_<%=index_no %>" value="<%=getDBStr(rs.getString("id")) %>"/>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_num"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
	    <td align="left"><%=getDBDateStr(rs.getString("fact_date"))%></td>
	    <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money"))%></td>
			
		<td align="center">
			<input type="radio" class="rd" id="invoice_is" name="invoice_is_<%=index_no %>" value="是" 
     			<%="是".equals(getDBStr(rs.getString("invoice_is")))?"checked='checked'":"" %>>是&nbsp;&nbsp;
     		<input type="radio" class="rd" id="invoice_is" name="invoice_is_<%=index_no %>" value="否" 
     			<% if ("否".equals(getDBStr(rs.getString("invoice_is")))||"".equals(getDBStr(rs.getString("invoice_is")))){ %> checked='checked' <%} %>>否
		</td>
		<td align="left">
		<input type="text" id="invoice_remark" name="invoice_remark_<%=index_no %>" value="<%=getDBStr(rs.getString("invoice_remark"))%>"/>
		<BUTTON class="btn_2" type="button" onclick="return piliang('<%=index_no %>');">&nbsp;批量备注</button>	
		</td> 
		<td align="left"><%=getDBStr(rs.getString("pay_obj"))%></td>

		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("invoice_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("status"))%></td>
		<!-- add -->
		<td align="left"><%=getDBStr(rs.getString("tax_payer_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("address"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tel"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_no"))%></td>
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
