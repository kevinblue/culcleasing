<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金开票申请 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<%
String czyid = (String) session.getAttribute("czyid");

%>
<script type="text/javascript">
	//提交保存资料状态
	function createFundInvoice(){
			var id_list = '';
			var cfpi_id_list = '';
			var contract_id_list = '';
			var tax_type_list = '';
			var tax_type_invoice_list = '';
			var money_list='';
			var fee_name_list='';
			var fee_num_list='';
			var invoice_statues_list='';

			var confirm_user=document.getElementById("confirm_user").value;
			if(!confirm_user){
				alert("请选择发票确认人员！");
				return  false;
			}	
			var selectedIndex = -1;
			var dataNav = document.getElementById("dataNav");
			var str = document.getElementsByName("checkbos_list");
			if(!checkInformation(str)){
				return  false;
			}
			var i = 0;
			for (i = 0; i < str.length; i++)
			{
				if (str[i].checked)
				{
					selectedIndex = i;
					id_list = cfpi_id_list + str[i].value + "#";
					cfpi_id_list = cfpi_id_list + str[i].attributes["cfpi"].nodeValue+"#";
					contract_id_list = contract_id_list + str[i].attributes["contract_id"].nodeValue+"#";
					tax_type_list = tax_type_list + str[i].attributes["tax_type"].nodeValue+"#";
					tax_type_invoice_list = tax_type_invoice_list + str[i].attributes["tax_type_invoice"].nodeValue+"#";
					
					//tes.options["内容值："+tes.selectedIndex].innerHTML+"元素值"+tes.options[tes.selectedIndex].value
					money_list = money_list + str[i].attributes["money"].nodeValue+"#";
					fee_name_list=fee_name_list+str[i].attributes["fee_name"].nodeValue+"#";
					fee_num_list=fee_num_list+str[i].attributes["fee_num"].nodeValue+"#";
					invoice_statues_list=invoice_statues_list+str[i].attributes["invoice_statues"].nodeValue+"#";

					if(str[i].attributes["invoice_statues"].nodeValue=='已申请'||str[i].attributes["invoice_statues"].nodeValue=='已导出'){
						alert("项合同号"+str[i].attributes["contract_id"].nodeValue+"款项名称为"+str[i].attributes["fee_name"].nodeValue+"已申请或已导出，不能再次申请！");
						return false;
					}
					if(str[i].attributes["invoice_statues"].nodeValue=='已手工开票'||str[i].attributes["invoice_statues"].nodeValue=='已导出'){
						alert("项合同号"+str[i].attributes["contract_id"].nodeValue+"款项名称为"+str[i].attributes["fee_name"].nodeValue+"已手工开票，不能再次申请！");
						return false;
					}
				
				}
			}
			if (selectedIndex < 0 )
			{
				alert("请先选择需要开票的数据行!");
				return false;
			}
		   id_list = id_list.substring(0,id_list.length-1);
		   cfpi_id_list = cfpi_id_list.substring(0,cfpi_id_list.length-1);
		   contract_id_list = contract_id_list.substring(0,contract_id_list.length-1);
		   tax_type_list = tax_type_list.substring(0,tax_type_list.length-1);
		   tax_type_invoice_list = tax_type_invoice_list.substring(0,tax_type_invoice_list.length-1);
		   money_list = money_list.substring(0,money_list.length-1);
		   fee_name_list= fee_name_list.substring(0,fee_name_list.length-1);
		   fee_num_list = fee_num_list.substring(0,fee_num_list.length-1);
		   invoice_statues_list = invoice_statues_list.substring(0,invoice_statues_list.length-1);
			
		   document.getElementById('id_list').value = id_list;
		   document.getElementById('cfpi_id_list').value = cfpi_id_list;
		   document.getElementById('contract_id_list').value = contract_id_list;
		   document.getElementById('tax_type_list').value = tax_type_list;
		   document.getElementById('tax_type_invoice_list').value = tax_type_invoice_list;		  
		   document.getElementById('money_list').value = money_list;	
		   document.getElementById('fee_name_list').value = fee_name_list;
		   document.getElementById('fee_num_list').value = fee_num_list;
		   document.getElementById('invoice_statues_list').value = invoice_statues_list;
		   
			dataNav.action="fund_invoice_request_save.jsp";
			dataNav.target="_blank";
			dataNav.submit();
			dataNav.action="fund_invoice_request.jsp";
			dataNav.target="_self";
	}

	function  checkInformation(str){	

		var i = 0;
		var tax_type='';
		var flag1=true;
		var flag2=true;
		var flag3=true;
		var flag4=true;
		var flag5=true;
		var flag6=true;
		for (i = 0; i < str.length; i++)
		{
			
			if (str[i].checked)
			{
				tax_type=str[i].attributes["tax_type_invoice"].nodeValue;
				if(tax_type.length==0){
					alert("请维护增值税发票类型!");
					return  false;
				}
				if(tax_type.indexOf("专用")>0){	
					
					if((str[i].attributes["tax_payer_no"].nodeValue).length==0){
						flag1=false;
					}
					if((str[i].attributes["address"].nodeValue).length==0){
						flag2=false;
					}
					if((str[i].attributes["tel"].nodeValue).length==0){
						flag3=false;
					}
					if((str[i].attributes["bank_name"].nodeValue).length==0){
						flag4=false;
					}
					if((str[i].attributes["bank_no"].nodeValue).length==0){
						flag5=false;
					}
										
				}
				if((str[i].attributes["tax_rate"].nodeValue).length==0&&tax_type!="收据"){					
						flag6=false;
					}
				if(!(flag1&&flag2&&flag3&&flag4&&flag5)){
					alert("请维护纳税人基本信息!");
					return  false;
				}		
				if(!flag6){
					alert("请维护税率信息!");
					return  false;
				}
				return  true;
			}
		}
	}
	function editManualInvoice(){
		var id_list = '';
		var cfpi_id_list = '';
		var contract_id_list = '';
		var tax_type_list = '';
		var tax_type_invoice_list = '';
		var money_list='';
		var fee_name_list='';
		var fee_num_list='';
		var invoice_statues_list='';

		var project_name_list='';
		var cust_name_list='';
		var parent_deptname_list='';
		var dept_name_list='';
		var proj_manage_name_list='';
		var plan_date_list='';
		var fact_date_list='';

		var selectedIndex = -1;
		var dataNav = document.getElementById("dataNav");
		var str = document.getElementsByName("checkbos_list");
//		if(!checkInformation(str)){
//			return  false;
//	    }
		//校验 维护手工开票的权限
		if(!checkCzyid('<%=czyid %>')){
			return false;
		}
		var i = 0;
		var count=0;
		for (i = 0; i < str.length; i++)
		{
			if (str[i].checked)
			{
				count+=1;
				if(count>1){
					alert("只能选择一条记录进行维护!");
					return false;
				}
				selectedIndex = i;
				id_list = cfpi_id_list + str[i].value + "#";
				cfpi_id_list = cfpi_id_list + str[i].attributes["cfpi"].nodeValue+"#";
				contract_id_list = contract_id_list + str[i].attributes["contract_id"].nodeValue+"#";
				tax_type_list = tax_type_list + str[i].attributes["tax_type"].nodeValue+"#";
				tax_type_invoice_list = tax_type_invoice_list + str[i].attributes["tax_type_invoice"].nodeValue+"#";
				
				money_list = money_list + str[i].attributes["money"].nodeValue+"#";
				fee_name_list=fee_name_list+str[i].attributes["fee_name"].nodeValue+"#";
				fee_num_list=fee_num_list+str[i].attributes["fee_num"].nodeValue+"#";
				invoice_statues_list=invoice_statues_list+str[i].attributes["invoice_statues"].nodeValue+"#";

			    project_name_list=cfpi_id_list + str[i].attributes["project_name"].nodeValue+"#";
			    cust_name_list=cfpi_id_list + str[i].attributes["cust_name"].nodeValue+"#";
			    parent_deptname_list=cfpi_id_list + str[i].attributes["parent_deptname"].nodeValue+"#";
			    dept_name_list=cfpi_id_list + str[i].attributes["dept_name"].nodeValue+"#";
			    proj_manage_name_list=cfpi_id_list + str[i].attributes["proj_manage_name"].nodeValue+"#";
			    plan_date_list=plan_date_list + str[i].attributes["plan_date"].nodeValue+"#";
			    fact_date_list=fact_date_list + str[i].attributes["fact_date"].nodeValue+"#";

				if(str[i].attributes["tax_type_invoice"].nodeValue=='收据'){
					alert("项合同号"+str[i].attributes["contract_id"].nodeValue+"款项名称为"+str[i].attributes["fee_name"].nodeValue+"是收据，不能进行维护！");
					return false;
				}
			
				if(str[i].attributes["invoice_statues"].nodeValue=='已申请'||str[i].attributes["invoice_statues"].nodeValue=='已导出'){
					alert("项合同号"+str[i].attributes["contract_id"].nodeValue+"款项名称为"+str[i].attributes["fee_name"].nodeValue+"已申请或已导出，不能再次维护！");
					return false;
				}
				if(str[i].attributes["invoice_statues"].nodeValue=='已手工开票'||str[i].attributes["invoice_statues"].nodeValue=='已导出'){
					alert("项合同号"+str[i].attributes["contract_id"].nodeValue+"款项名称为"+str[i].attributes["fee_name"].nodeValue+"已手工开票，不能再次维护！");
					return false;
				}
			
			}
		}
		if (selectedIndex < 0 )
		{
			alert("请先选择需要开票的数据行!");
			return false;
		}
	   id_list = id_list.substring(0,id_list.length-1);
	   cfpi_id_list = cfpi_id_list.substring(0,cfpi_id_list.length-1);
	   contract_id_list = contract_id_list.substring(0,contract_id_list.length-1);
	   tax_type_list = tax_type_list.substring(0,tax_type_list.length-1);
	   tax_type_invoice_list = tax_type_invoice_list.substring(0,tax_type_invoice_list.length-1);
	   money_list = money_list.substring(0,money_list.length-1);
	   fee_name_list= fee_name_list.substring(0,fee_name_list.length-1);
	   fee_num_list = fee_num_list.substring(0,fee_num_list.length-1);
	   invoice_statues_list = invoice_statues_list.substring(0,invoice_statues_list.length-1);
		
	   document.getElementById('id_list').value = id_list;
	   document.getElementById('cfpi_id_list').value = cfpi_id_list;
	   document.getElementById('contract_id_list').value = contract_id_list;
	   document.getElementById('tax_type_list').value = tax_type_list;
	   document.getElementById('tax_type_invoice_list').value = tax_type_invoice_list;		  
	   document.getElementById('money_list').value = money_list;	
	   document.getElementById('fee_name_list').value = fee_name_list;
	   document.getElementById('fee_num_list').value = fee_num_list;
	   document.getElementById('invoice_statues_list').value = invoice_statues_list;
	   
	   document.getElementById('project_name_list').value = project_name_list;
	   document.getElementById('cust_name_list').value = cust_name_list;
	   document.getElementById('parent_deptname_list').value = parent_deptname_list;
	   document.getElementById('dept_name_list').value = dept_name_list;
	   document.getElementById('proj_manage_name_list').value = proj_manage_name_list;
	   document.getElementById('plan_date_list').value = plan_date_list;
	   document.getElementById('fact_date_list').value = fact_date_list;
	   
		dataNav.action="fund_invoice_request_manual.jsp";
		dataNav.target="_blank";
		dataNav.submit();
		dataNav.action="fund_invoice_request.jsp";
		dataNav.target="_self";
	}
	function  checkCzyid(czyid){
		if(czyid!='ADMN-AP5BVP'&&czyid!='ADMN-AP5BVM'){
			alert("该用户没有维护手工开票的权限,维护失败!");
			return  false;
		}
		return  true;
	}
	//checkbos全选
	function isSelectAll() {
		var names = document.getElementsByName("checkbos_list");
		var isck_all = document.getElementById("ck_all").checked;
		for (var n=0;n<names.length;n++) {
			names[n].checked=isck_all;
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



<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="fund_invoice_request.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="id_list" id="id_list"/>
<input type="hidden" name="cfpi_id_list" id="cfpi_id_list"/>
<input type="hidden" name="contract_id_list" id="contract_id_list"/>
<input type="hidden" name="tax_type_list" id="tax_type_list"/>
<input type="hidden" name="tax_type_invoice_list" id="tax_type_invoice_list"/>
<input type="hidden" name="money_list" id="money_list"/>
<input type="hidden" name="fee_name_list" id="fee_name_list"/>
<input type="hidden" name="fee_num_list" id="fee_num_list"/>
<input type="hidden" name="invoice_statues_list" id="invoice_statues_list"/>

<input type="hidden" name="project_name_list" id="project_name_list"/>
<input type="hidden" name="cust_name_list" id="cust_name_list"/>
<input type="hidden" name="parent_deptname_list" id="parent_deptname_list"/>
<input type="hidden" name="dept_name_list" id="dept_name_list"/>
<input type="hidden" name="proj_manage_name_list" id="proj_manage_name_list"/>
<input type="hidden" name="plan_date_list" id="plan_date_list"/>
<input type="hidden" name="fact_date_list" id="fact_date_list"/>



<!-- 资金计划数据 -->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		资金开票申请</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String pay_obj = getStr(request.getParameter("pay_obj"));
String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));
String invoice_statues=getStr(request.getParameter("invoice_statues"));


if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr +=" and plan_date>= '"+start_date+"' and plan_date<='"+end_date+"'";
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
if(invoice_statues!=null && !invoice_statues.equals("")){
	wherestr +=" and invoice_statues = '" + invoice_statues + "'";
}
//wherestr +=" and (tax_type_invoice = '增值税专用发票' or tax_type_invoice = '增值税普通发票' or tax_type_invoice = '收据') ";
countSql = "select count(proj_id) as amount from vi_func_fund_invoice where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select proj_id 项目编号,contract_id 合同编号,project_name 项目名称,cust_name 客户名称,parent_deptname 部门名称, dept_name 大区名称,proj_manage_name 项目经理,fee_name 款项名称,fee_num 资金期次,plan_date 计划日期,plan_money 计划金额,fact_money 已收金额,over_money 剩余金额,invoice_is 是否开具,invoice_remark 备注,pay_obj 付款人,tax_type_invoice 增值税发票类型,invoice_date 开票日期 from vi_func_fund_invoice where 1=1 "+wherestr;
System.out.println("vvvvvvvvvvvvv"+expsqlstr);

String updSql="select contract_id,fee_name,fee_num,id from vi_func_fund_invoice where 1=1 "+wherestr;
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
<td>付&nbsp;款&nbsp;人:&nbsp;<input name="pay_obj"  type="text" size="15" value="<%=pay_obj %>"></td>
<td>是否申请:
	 <select name="invoice_statues" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=invoice_statues %>',"|已申请|未申请|已退回|已导出|已手工开票","|已申请|未申请|已退回|已导出|已手工开票"));
		</script>
	 </select>
</td>
</tr>
<tr>
<td >计划日期:&nbsp;<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
至
<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
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
		<td  width="10%">
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="申请开票(Alt+N)">&nbsp;&nbsp;
			<input  class="btn_2" type="button"  value="提交"  onclick="createFundInvoice();">&nbsp;&nbsp;
		</td>
		
		<td>发票确认人员:
		<select id="confirm_user"  name="confirm_user" style="width:80">
			<script type="text/javascript">
			w(mSetOpt('',"|李悦欣|孙梦琳","|ADMN-AP5BVP|ADMN-AP5BVM"));
			</script>
		</select>
		</td>
		<td width="10%" >
			<input  type="button"  value="维护手工开票" onclick="editManualInvoice();">
		</td>
		<td align="left">
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="FundInvoice">
		<!--<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','fund_invoice_manage.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>-->
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
   class="maintab_content_table"  >
      <tr class="maintab_content_table_title">
	   <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选
	    </th>
     	<th>项目编号</th>
		<th>合同编号</th>
	    <th>项目名称</th>
	    <th>客户名称</th>
		<th>部门名称</th>
	    <th>大区名称</th>
     	<th>项目经理</th>

		<th>款项名称</th>
		<th>资金期次</th>
		<th>计划日期</th>
		<th>实收日期</th>
	 	<th>计划金额</th>
		<th>已收金额</th>
		<th>剩余金额</th>
		<th>申请状态</th>
		<th>付款人</th>
		<th>税种</th>
		<th>增值税发票类型</th>
		<th>资金税率</th>
		<th>备注</th>
		<!--  ADD -->
		<th>纳税人识别号</th>
		<th>纳税人地址</th>
		<th>纳税人电话</th>
		<th>纳税人基本开户行</th>
		<th>纳税人账号</th>
		<th>发票类型维护</th>
		<!--  hu新增-->
		
		
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_func_fund_invoice where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_func_fund_invoice where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
	
     <tr class="materTr_<%=index_no %>" id="materTr_<%=index_no %>">
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("id")) %>"
		cfpi="<%=getDBStr(rs.getString("id"))%>"
		contract_id="<%=getDBStr(rs.getString("contract_id"))%>"
		tax_type="<%=getDBStr(rs.getString("tax_type"))%>"
		tax_type_invoice="<%=getDBStr(rs.getString("tax_type_invoice"))%>"
		money="<%=CurrencyUtil.convertFinance(rs.getString("plan_money"))%>"
		fee_name="<%=getDBStr(rs.getString("fee_name"))%>"
		fee_num="<%=getDBStr(rs.getString("fee_num"))%>"
		invoice_statues="<%=getDBStr(rs.getString("invoice_statues"))%>"
		
		project_name="<%=getDBStr(rs.getString("project_name"))%>"
		cust_name="<%=getDBStr(rs.getString("cust_name"))%>"
		parent_deptname="<%=getDBStr(rs.getString("parent_deptname"))%>"
		dept_name="<%=getDBStr(rs.getString("dept_name"))%>"
		proj_manage_name="<%=getDBStr(rs.getString("proj_manage_name"))%>"
		plan_date="<%=getDBStr(rs.getString("plan_date"))%>"
		fact_date="<%=getDBStr(rs.getString("fact_date"))%>"
		tax_rate="<%=getDBStr(rs.getString("tax_rate"))%>"
		
		/></td>
	 
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%>	</td>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
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
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("fact_money"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("over_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_statues"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pay_obj"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left">
        <select class="text" Require="true" name="tax_type_invoice"><script>w(mSetOpt("<%=getDBStr(rs.getString("tax_type_invoice"))%>","|增值税普通发票|增值税专用发票"));</script></select>
       </td>
		</td>
		<td align="left"><%=getDBStr(rs.getString("tax_rate"))%></td>
		<td align="left">
		<input type="text" id="invoice_remark" name="invoice_remark_<%=getDBStr(rs.getString("id")) %>" value="<%=getDBStr(rs.getString("invoice_remark"))%>"/>
		<BUTTON class="btn_2" type="button" onclick="return piliang('<%=getDBStr(rs.getString("id")) %>');">&nbsp;批量备注</button>	
		</td> 
		<!-- add -->
		<td align="left"><%=getDBStr(rs.getString("tax_payer_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("address"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tel"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_no"))%></td>
		<td align="center">		
        <a href='fund_invoice_edit.jsp?id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/sbtn_quick_up.gif" align="bottom" border="0">维护发票类型</a> 
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
