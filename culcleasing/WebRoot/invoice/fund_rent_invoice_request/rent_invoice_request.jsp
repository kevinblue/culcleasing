<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金开票申请 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<%
String czyid = (String) session.getAttribute("czyid");

%>
<script type="text/javascript">
	//提交保存资料状态
	function createFundRentPlan(){
		
			var id_list = '';
			var begin_id_list = '';
			var contract_id_list = '';			
			var invoice_type_list='';
			var tax_type_list = '';
			var tax_type_invoice_list = '';
			var tax_rate_list = '';
			var rent_list = '';
			var interest_list = '';
			var corpus_list = '';
			var rent_num_list='';
			var invoice_statues_list='';
			
			var selectedIndex = -1;
			var dataNav = document.getElementById("dataNav");
			var confirm_user=document.getElementById("confirm_user").value;
			if(!confirm_user){
				alert("请选择发票确认人员！");
				return  false;
			}			
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
					
					id_list = id_list + str[i].value + "#";					
					begin_id_list = begin_id_list + str[i].attributes["begin_id"].nodeValue+"#";					
					contract_id_list = contract_id_list + str[i].attributes["contract_id"].nodeValue+"#";
					invoice_type_list = invoice_type_list + str[i].attributes["invoice_type"].nodeValue+"#";					
					tax_type_list = tax_type_list + str[i].attributes["tax_type"].nodeValue+"#";
					tax_type_invoice_list = tax_type_invoice_list + str[i].attributes["tax_type_invoice"].nodeValue+"#";
					tax_rate_list = tax_rate_list + str[i].attributes["tax_rate"].nodeValue+"#";
					rent_list = rent_list + str[i].attributes["rent"].nodeValue+"#";
					interest_list = interest_list + str[i].attributes["interest"].nodeValue+"#";
					corpus_list = corpus_list + str[i].attributes["corpus"].nodeValue+"#";
					rent_num_list = rent_num_list + str[i].attributes["rent_num"].nodeValue+"#";
					invoice_statues_list = invoice_statues_list + str[i].attributes["invoice_statues"].nodeValue+"#";
					
					if(str[i].attributes["invoice_statues"].nodeValue=='已申请'){
						alert("起租编号为"+str[i].attributes["begin_id"].nodeValue+"期次为"+str[i].attributes["rent_num"].nodeValue+"已申请，不能再次申请！");
						return false;
					}
					if(str[i].attributes["invoice_statues"].nodeValue=='已导出'){
						alert("起租编号为"+str[i].attributes["begin_id"].nodeValue+"；期次为"+str[i].attributes["rent_num"].nodeValue+"已导出，不能再次申请！");
						return false;
					}
					if(str[i].attributes["invoice_statues"].nodeValue=='已手工开票'){
						alert("起租编号为"+str[i].attributes["begin_id"].nodeValue+"；期次为"+str[i].attributes["rent_num"].nodeValue+"已手工开票，不能再次申请！");
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
		   begin_id_list = begin_id_list.substring(0,begin_id_list.length-1);
		   contract_id_list = contract_id_list.substring(0,contract_id_list.length-1);
		   invoice_type_list = invoice_type_list.substring(0,invoice_type_list.length-1);		   
		   tax_type_list = tax_type_list.substring(0,tax_type_list.length-1);
		   tax_type_invoice_list = tax_type_invoice_list.substring(0,tax_type_invoice_list.length-1);
		   tax_rate_list= tax_rate_list.substring(0,tax_rate_list.length-1);
		   rent_list = rent_list.substring(0,rent_list.length-1);
		   interest_list = interest_list.substring(0,interest_list.length-1);
		   corpus_list = corpus_list.substring(0,corpus_list.length-1);
		   rent_num_list= rent_num_list.substring(0,rent_num_list.length-1);
		   invoice_statues_list= invoice_statues_list.substring(0,invoice_statues_list.length-1);
			
		   document.getElementById('id_list').value = id_list;
		   document.getElementById('begin_id_list').value = begin_id_list;
		   document.getElementById('contract_id_list').value = contract_id_list;
		   document.getElementById('invoice_type_list').value = invoice_type_list;	
		   document.getElementById('tax_type_list').value = tax_type_list;
		   document.getElementById('tax_type_invoice_list').value = tax_type_invoice_list;
		   document.getElementById('tax_rate_list').value = tax_rate_list;
		   document.getElementById('rent_list').value = rent_list;
		   document.getElementById('interest_list').value = interest_list;
		   document.getElementById('corpus_list').value = corpus_list;
		    document.getElementById('rent_num_list').value = rent_num_list;
			document.getElementById('invoice_statues_list').value = invoice_statues_list;
		   
			dataNav.action="rent_invoice_request_save.jsp";
			dataNav.target="_blank";
			dataNav.submit();
			dataNav.action="rent_invoice_request.jsp";
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
					if(str[i].attributes["tax_payer_no"].nodeValue.length==0){
						flag1=false;
					}
					if(str[i].attributes["address"].nodeValue.length==0){
						flag2=false;
					}
					if(str[i].attributes["tel"].nodeValue.length==0){
						flag3=false;
					}
					if(str[i].attributes["bank_name"].nodeValue.length==0){
						flag4=false;
					}
					if(str[i].attributes["bank_no"].nodeValue.length==0){
						flag5=false;
					}
					
				}
				if(!(flag1&&flag2&&flag3&&flag4&&flag5)){
					alert("请维护纳税人基本信息!");
					return  false;
				}		
				return  true;
			}
		}
	}
	function editManualInvoice(){
		var id_list = '';
		var begin_id_list = '';
		var contract_id_list = '';			
		var invoice_type_list='';
		var tax_type_list = '';
		var tax_type_invoice_list = '';
		var tax_rate_list = '';
		var rent_list = '';
		var interest_list = '';
		var corpus_list = '';
		var rent_num_list='';
		var invoice_statues_list='';
		var project_name_list='';
		var cust_name_list='';
		var parent_deptname_list='';
		var dept_name_list='';
		var proj_manage_name_list='';
		var plan_date_list='';
		var last_hire_date_list='';			

		
		var selectedIndex = -1;
		var dataNav = document.getElementById("dataNav");
			
		var str = document.getElementsByName("checkbos_list");
		if(!checkCzyid('<%=czyid %>')){
			return false;
		}
		//if(!checkInformation(str)){
		//	return  false;
	//	}
		
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
				id_list = id_list + str[i].value + "#";					
				begin_id_list = begin_id_list + str[i].attributes["begin_id"].nodeValue+"#";					
				contract_id_list = contract_id_list + str[i].attributes["contract_id"].nodeValue+"#";
				invoice_type_list = invoice_type_list + str[i].attributes["invoice_type"].nodeValue+"#";					
				tax_type_list = tax_type_list + str[i].attributes["tax_type"].nodeValue+"#";
				tax_type_invoice_list = tax_type_invoice_list + str[i].attributes["tax_type_invoice"].nodeValue+"#";
				tax_rate_list = tax_rate_list + str[i].attributes["tax_rate"].nodeValue+"#";
				rent_list = rent_list + str[i].attributes["rent"].nodeValue+"#";
				interest_list = interest_list + str[i].attributes["interest"].nodeValue+"#";
				corpus_list = corpus_list + str[i].attributes["corpus"].nodeValue+"#";
				rent_num_list = rent_num_list + str[i].attributes["rent_num"].nodeValue+"#";
				invoice_statues_list = invoice_statues_list + str[i].attributes["invoice_statues"].nodeValue+"#";

				project_name_list= project_name_list + str[i].attributes["project_name"].nodeValue+"#";
				cust_name_list= cust_name_list + str[i].attributes["cust_name"].nodeValue+"#";
				parent_deptname_list= parent_deptname_list + str[i].attributes["parent_deptname"].nodeValue+"#";
				dept_name_list= dept_name_list + str[i].attributes["dept_name"].nodeValue+"#";
				proj_manage_name_list= proj_manage_name_list + str[i].attributes["proj_manage_name"].nodeValue+"#";
				plan_date_list= plan_date_list + str[i].attributes["plan_date"].nodeValue+"#";
				last_hire_date_list= last_hire_date_list + str[i].attributes["last_hire_date"].nodeValue+"#";
				
				if(str[i].attributes["invoice_statues"].nodeValue=='已申请'){
					alert("起租编号为"+str[i].attributes["begin_id"].nodeValue+"期次为"+str[i].attributes["rent_num"].nodeValue+"已申请，不能再次维护！");
					return false;
				}
				if(str[i].attributes["invoice_statues"].nodeValue=='已导出'){
					alert("起租编号为"+str[i].attributes["begin_id"].nodeValue+"；期次为"+str[i].attributes["rent_num"].nodeValue+"已导出，不能再次维护！");
					return false;
				}
				if(str[i].attributes["invoice_statues"].nodeValue=='已手工开票'){
					alert("起租编号为"+str[i].attributes["begin_id"].nodeValue+"；期次为"+str[i].attributes["rent_num"].nodeValue+"已手工开票，不能再次维护！");
					return false;
				}
			}
		}
		
		if (selectedIndex < 0 )
		{
			alert("请先选择需要维护的数据行!");
			return false;
		}
		
	   id_list = id_list.substring(0,id_list.length-1);
	   begin_id_list = begin_id_list.substring(0,begin_id_list.length-1);
	   contract_id_list = contract_id_list.substring(0,contract_id_list.length-1);
	   invoice_type_list = invoice_type_list.substring(0,invoice_type_list.length-1);		   
	   tax_type_list = tax_type_list.substring(0,tax_type_list.length-1);
	   tax_type_invoice_list = tax_type_invoice_list.substring(0,tax_type_invoice_list.length-1);
	   tax_rate_list= tax_rate_list.substring(0,tax_rate_list.length-1);
	   rent_list = rent_list.substring(0,rent_list.length-1);
	   interest_list = interest_list.substring(0,interest_list.length-1);
	   corpus_list = corpus_list.substring(0,corpus_list.length-1);
	   rent_num_list= rent_num_list.substring(0,rent_num_list.length-1);
	   invoice_statues_list= invoice_statues_list.substring(0,invoice_statues_list.length-1);

	   project_name_list= project_name_list.substring(0,project_name_list.length-1);
	   cust_name_list= cust_name_list.substring(0,cust_name_list.length-1);
	   parent_deptname_list= parent_deptname_list.substring(0,parent_deptname_list.length-1);
	   dept_name_list= dept_name_list.substring(0,dept_name_list.length-1);
	   proj_manage_name_list= proj_manage_name_list.substring(0,proj_manage_name_list.length-1);
	   plan_date_list= plan_date_list.substring(0,plan_date_list.length-1);
	   last_hire_date_list= last_hire_date_list.substring(0,last_hire_date_list.length-1);
		
	   document.getElementById('id_list').value = id_list;
	   document.getElementById('begin_id_list').value = begin_id_list;
	   document.getElementById('contract_id_list').value = contract_id_list;
	   document.getElementById('invoice_type_list').value = invoice_type_list;	
	   document.getElementById('tax_type_list').value = tax_type_list;
	   document.getElementById('tax_type_invoice_list').value = tax_type_invoice_list;
	   document.getElementById('tax_rate_list').value = tax_rate_list;
	   document.getElementById('rent_list').value = rent_list;
	   document.getElementById('interest_list').value = interest_list;
	   document.getElementById('corpus_list').value = corpus_list;
	   document.getElementById('rent_num_list').value = rent_num_list;
	   document.getElementById('invoice_statues_list').value = invoice_statues_list;

	   document.getElementById('project_name_list').value = project_name_list;
	   document.getElementById('cust_name_list').value = cust_name_list;
	   document.getElementById('parent_deptname_list').value = parent_deptname_list;
	   document.getElementById('dept_name_list').value = dept_name_list;
	   document.getElementById('proj_manage_name_list').value = proj_manage_name_list;
	   document.getElementById('plan_date_list').value = plan_date_list;
	   document.getElementById('last_hire_date_list').value = last_hire_date_list;
	   
		dataNav.action="rent_invoice_request_manual.jsp";
		dataNav.target="_blank";
		dataNav.submit();
		dataNav.action="rent_invoice_request.jsp";
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
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="rent_invoice_request.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="id_list" id="id_list"/>
<input type="hidden" name="begin_id_list" id="begin_id_list"/>
<input type="hidden" name="contract_id_list" id="contract_id_list"/>
<input type="hidden" name="invoice_type_list" id="invoice_type_list"/>
<input type="hidden" name="tax_type_list" id="tax_type_list"/>
<input type="hidden" name="tax_type_invoice_list" id="tax_type_invoice_list"/>
<input type="hidden" name="tax_rate_list" id="tax_rate_list"/>
<input type="hidden" name="rent_list" id="rent_list"/>
<input type="hidden" name="interest_list" id="interest_list"/>
<input type="hidden" name="corpus_list" id="corpus_list"/>
<input type="hidden" name="rent_num_list" id="rent_num_list"/>
<input type="hidden" name="invoice_statues_list" id="invoice_statues_list"/>

<input type="hidden" name="project_name_list" id="project_name_list"/>
<input type="hidden" name="cust_name_list" id="cust_name_list"/>
<input type="hidden" name="parent_deptname_list" id="parent_deptname_list"/>
<input type="hidden" name="dept_name_list" id="dept_name_list"/>
<input type="hidden" name="proj_manage_name_list" id="proj_manage_name_list"/>
<input type="hidden" name="plan_date_list" id="plan_date_list"/>
<input type="hidden" name="last_hire_date_list" id="last_hire_date_list"/>

			
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		租金开票申请111</td>
	</tr>
</table> 

<%
wherestr = "";
String tax_type=getStr( request.getParameter("tax_type") );
String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String leas_form = getStr( request.getParameter("leas_form") );
String plan_status =getStr(request.getParameter("plan_status"));
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String start_hire_date = getStr(request.getParameter("start_hire_date"));
String end_hire_date = getStr(request.getParameter("end_hire_date"));
String invoice_is=getStr(request.getParameter("invoice_is"));
String contract_is_advance=getStr(request.getParameter("contract_is_advance"));
String contract_is_normal=getStr(request.getParameter("contract_is_normal"));
String is_invoice=getStr(request.getParameter("is_invoice"));
String is_planstatues=getStr(request.getParameter("is_planstatues"));

String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if ( leas_form!=null && !leas_form.equals("") ) {
	wherestr += " and leas_form like '%" + leas_form + "%'";
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
if(contract_is_advance != null && !contract_is_advance.equals("")){
	wherestr +=" and contract_is_advance like '%" + contract_is_advance + "%'";
}
if(contract_is_normal != null && !contract_is_normal.equals("")){
	wherestr +=" and contract_is_normal like '%" + contract_is_normal + "%'";
}

if(is_invoice != null && !is_invoice.equals("")){
	wherestr +=" and invoice_statues like '%" + is_invoice + "%'";
}
if(tax_type!=null && !tax_type.equals("")){
	wherestr +=" and tax_type like '%" + tax_type + "%'";
}
if(is_planstatues != null && !is_planstatues.equals("")){
	wherestr +=" and plan_status like '%" + is_planstatues + "%'";
}

countSql = "select count(proj_id) as amount from vi_func_rent_invoice where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr ="select proj_id 项目编号,contract_id 合同编号,begin_id 起租编号,project_name 项目名称,leas_form 租赁类型"+
	"cust_name 客户名称,parent_deptname 部门名称,dept_name 大区名称,"+
	"proj_manage_name 项目经理,rent_list 租金期次,contract_is_normal 是否正常,contract_is_advance 是否提前,"+
	"invoice_remark 备注,plan_date 计划日期,last_hire_date 实收日期,"+
	"rent 应收租金,interest 应收利息,corpus 应收本金,curr_rent 剩余租金,"+
	"invoice_statues 申请状态,plan_status 租金是否核销,invoice_type 发票开具方式,tax_type 税种,"+
	"tax_type_invoice 增值税发票类型,tax_rate 税率,tax_payer_no 纳税人识别号,"+
	"address 纳税人地址,tel 纳税人电话,bank_name 纳税人基本开户行,bank_no 纳税人账号 "+
"  from vi_func_rent_invoice  where 1=1 "+wherestr;
String updSql="select begin_id,rent_list from vi_func_rent_invoice where 1=1 "+wherestr;
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
<td>是否正常:
		<select name="contract_is_normal" style="width:105">
	<script type="text/javascript">
	w(mSetOpt('<%=contract_is_normal %>',"|是|否","|是|否"));
	</script>
	</select>
</td>
<td>是否提前:
	 <select name="contract_is_advance" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=contract_is_advance %>',"|是|否","|是|否"));
		</script>
	 </select>
</td>
<td>是否申请:
	 <select name="is_invoice" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=is_invoice %>',"|未申请|已申请|已退回|已导出|已手工开票","|未申请|已申请|已退回|已导出|已手工开票"));
		</script>
	 </select>
</td>
<td>租赁类型:
	 <select name="leas_form" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=leas_form %>',"|直租|回租","|直租|回租"));
		</script>
	 </select>
</td>
</tr>
<tr>
<td>是否核销:
	 <select name="is_planstatues" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=is_planstatues %>',"|未回笼|已回笼","|未回笼|已回笼"));
		</script>
	 </select>
</td>
<td>税种:
	 <select name="tax_type" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=tax_type %>',"|增值税|营业税","|增值税|营业税"));
		</script>
	 </select>
</td>
<td> <input type="button" value="查询" onclick="dataNav.submit();">
<input type="button" value="清空" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!-- end cwTop -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		<td width="10%" >
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="提交(Alt+N)">
			<input class="btn_2" type="button"  value="提交" onclick="createFundRentPlan();">
		</td>
		
		<td >发票确认人员:
		<select id="confirm_user" name="confirm_user" style="width:80">
			<script type="text/javascript">
			w(mSetOpt('',"|李悦欣|孙梦琳","|ADMN-AP5BVP|ADMN-AP5BVM"));
			</script>
		</select>
		</td>
		<td width="10%" >
			<input  type="button"  value="维护手工开票" onclick="editManualInvoice();">
		</td>
		
		<td>
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="FundInvoice">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','rent_invoice_request.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	<!--操作按钮结束-->
	    </td>		

		<!-- 翻页控制 -->
		<td align="right"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="pageSplit.jsp"%>
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
		<th>合同编号</th>
		<th>起租编号</th>
	    <th>项目名称</th>
		<th>租赁类型</th>
		<th>客户名称</th>
		<th>部门名称</th>
	    <th>大区名称</th>
     	<th>项目经理</th>
		<th>租金期次</th>
		<th>是否正常</th>
		<th>是否提前</th>
		<th>备注</th>
		<th>计划日期</th>
		<th>实收日期</th>
	 	<th>应收租金</th>
	 	<th>应收利息</th>
	 	<th>应收本金</th>
		<th>剩余租金</th>
		<th>申请状态</th>
		<th>租金是否核销</th>
	 	<th>发票开具方式</th>	 	
		<th>税种</th>
		<th>增值税发票类型</th>
		<th>税率</th>
		<th>纳税人识别号</th>
		<th>纳税人地址</th>
		<th>纳税人电话</th>
		<th>纳税人基本开户行</th>
		<th>纳税人账号</th>
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_func_rent_invoice where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_func_rent_invoice where 1=1 "+wherestr+" order by begin_id,rent_list,id ) "+wherestr ;
sqlstr +=" order by  begin_id,rent_list,id   ";

System.out.println("sqlstr语句展示-----："+sqlstr);

rs = db.executeQuery(sqlstr);
int index_no = 0;

while (rs.next()) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
	 	<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("id")) %>"
		contract_id="<%=getDBStr(rs.getString("contract_id"))%>"		
		begin_id="<%=getDBStr(rs.getString("begin_id"))%>"
		invoice_type="<%=getDBStr(rs.getString("invoice_type"))%>"		
		tax_type="<%=getDBStr(rs.getString("tax_type"))%>"
		tax_type_invoice="<%=getDBStr(rs.getString("tax_type_invoice"))%>"
		tax_rate="<%=getDBStr(rs.getString("tax_rate"))%>"
		rent="<%=getDBStr(rs.getString("rent"))%>"
		interest="<%=getDBStr(rs.getString("interest"))%>"
		corpus="<%=getDBStr(rs.getString("corpus"))%>"
		rent_num="<%=getDBStr(rs.getString("rent_list"))%>"
		invoice_statues="<%=getDBStr(rs.getString("invoice_statues"))%>"
		tax_type_invoice="<%=getDBStr(rs.getString("tax_type_invoice"))%>"
		tax_payer_no="<%=getDBStr(rs.getString("tax_payer_no"))%>"
		address="<%=getDBStr(rs.getString("address"))%>"
		tel="<%=getDBStr(rs.getString("tel"))%>"
		bank_name="<%=getDBStr(rs.getString("bank_name"))%>"
		bank_no="<%=getDBStr(rs.getString("bank_no"))%>"
		
		project_name="<%=getDBStr(rs.getString("project_name"))%>"
		leas_form="<%=getDBStr(rs.getString("leas_form"))%>"
		cust_name="<%=getDBStr(rs.getString("cust_name"))%>"
		parent_deptname="<%=getDBStr(rs.getString("parent_deptname"))%>"
		dept_name="<%=getDBStr(rs.getString("dept_name"))%>"
		proj_manage_name="<%=getDBStr(rs.getString("proj_manage_name"))%>"		
		plan_date="<%=getDBStr(rs.getString("plan_date"))%>"
		last_hire_date="<%=getDBStr(rs.getString("last_hire_date"))%>"
		
		/></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%>
	        <input type="hidden" name="it_<%=index_no %>" value="<%=index_no %>">
	        <input type="hidden" name="begin_id_<%=index_no %>" value="<%=getDBStr(rs.getString("begin_id")) %>"/>
	        <input type="hidden" name="rent_list_<%=index_no %>" value="<%=getDBStr(rs.getString("rent_list")) %>"/>
        </td>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		 <td align="left"><%=getDBStr(rs.getString("leas_form"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_is_normal"))%></td>
        <td align="left"><%=getDBStr(rs.getString("contract_is_advance"))%></td>
		<td align="left">
		<input type="text" id="invoice_remark" name="invoice_remark_<%=getDBStr(rs.getString("id")) %>" value="<%=getDBStr(rs.getString("invoice_remark"))%>"/>
		<BUTTON class="btn_2" type="button" onclick="return piliang('<%=getDBStr(rs.getString("id")) %>');">&nbsp;批量备注</button>	
		</td> 
		<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("last_hire_date"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("interest"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("corpus"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("curr_rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_statues"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_type"))%></td>			
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_rate"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_payer_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("address"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tel"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_no"))%></td>
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
