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
<title>资金发票确认 </title>
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
	//提交保存资料状态
	function FundInvoiceConfirm(){
		//alert("开始");
			var id_list = '';
			var contract_id_list = '';
			var fee_name_list='';
			var fee_num_list='';
			var invoice_statues_list='';
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
					contract_id_list = contract_id_list + str[i].attributes["contract_id"].nodeValue+"#";
					fee_name_list=fee_name_list+str[i].attributes["fee_name"].nodeValue+"#";
					fee_num_list=fee_num_list+str[i].attributes["fee_num"].nodeValue+"#";
					invoice_statues_list=invoice_statues_list+str[i].attributes["invoice_statues"].nodeValue+"#";
					if(str[i].attributes["invoice_statues"].nodeValue=='已退回'||str[i].attributes["invoice_statues"].nodeValue=='已确认'){
						alert("项合同号"+str[i].attributes["contract_id"].nodeValue+"款项名称为"+str[i].attributes["fee_name"].nodeValue+"已退回或已确认，不能提交！");
						return false;
					}
						if(!str[i].attributes["tax_rate"].nodeValue){
						alert("项合同号"+str[i].attributes["contract_id"].nodeValue+"税率为空，请先维护资金税率信息！");
						return false;
					}
				}
			}
			if (selectedIndex < 0 )
			{
				alert("请先选择需要确认的数据行!");
				return false;
			}
		   id_list = id_list.substring(0,id_list.length-1);		   
		   
		   var userId="<%=userId %>";
		  $.ajax({  
					  url: '<%=context %>/servlet/InvoiceCheckServlet',  
					  type: 'POST', 
					  cache: false,
					  async: false,							  
					  dataType: 'text',//返回数据的类型 
					  data: {'id_list':id_list,'invoice_flag':'fund_invoice_confirm','userId':userId},  
					  success: function (resdata) {							
								message=resdata;							
					  },
					  error: function (resdata) {  
						message="失败:"+resdata;
					} 
			 });
		if(message=='success!'){
			 alert("发票确认成功！");
			 window.location.reload(); 
			return  true;
	   }else{
			alert(message);
			window.location.reload(); 
			return  false;
	   }
	}
	
	function FundInvoiceBack(){
		//alert("退回开始");
		
			var id_list = '';
			var contract_id_list = '';
			var fee_name_list='';
			var fee_num_list='';
			var invoice_statues_list='';
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
					contract_id_list = contract_id_list + str[i].attributes["contract_id"].nodeValue+"#";
					fee_name_list=fee_name_list+str[i].attributes["fee_name"].nodeValue+"#";
					fee_num_list=fee_num_list+str[i].attributes["fee_num"].nodeValue+"#";
					invoice_statues_list=invoice_statues_list+str[i].attributes["invoice_statues"].nodeValue+"#";
					if(str[i].attributes["invoice_statues"].nodeValue=='已退回'||str[i].attributes["invoice_statues"].nodeValue=='已确认'){
						alert("项合同号"+str[i].attributes["contract_id"].nodeValue+"款项名称为"+str[i].attributes["fee_name"].nodeValue+"已退回或已导出，不能退回！");
						return false;
					}
				}
			}
			if (selectedIndex < 0 )
			{
				alert("请先选择需要确认的数据行!");
				return false;
			}
		   id_list = id_list.substring(0,id_list.length-1);		   
		  $.ajax({  
					  url: '<%=context %>/servlet/InvoiceCheckServlet',  
					  type: 'POST', 
					  cache: false,
					  async: false,							  
					  dataType: 'text',//返回数据的类型 
					  data: {'id_list':id_list,'invoice_flag':'fund_invoice_back'},  
					  success: function (resdata) {							
								message=resdata;							
					  },
					  error: function (resdata) {  
						message="失败:"+resdata;
					} 
			 });
		if(message=='success!'){
			 alert("发票退回成功！");
			 window.location.reload();
			return  true;
	   }else{
			alert(message);
			window.location.reload();
			return  false;
	   }
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
<form action="fund_invoice_confirm.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">

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
		资金发票确认</td>
	</tr>
</table> 

<%
wherestr = "";
String czyid = (String) session.getAttribute("czyid");
String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));
String invoice_statu=getStr(request.getParameter("invoice_statu"));


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

if(invoice_statu!=null && !invoice_statu.equals("")){
	wherestr +=" and invoice_statues ='" +invoice_statu +"'";
}

wherestr+=" and bill_type='invoice' "; 
//加人员权限
//wherestr+=" and confirm_user='"+czyid+"' "; 
countSql = "select count(proj_id) as amount from vi_fund_receipt_confirm where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select '' 单据编号,'' 单据日期,'' 发票号,'' 发票日期, cust_name 客户名称,'第'+convert(varchar(20),fee_num)+'期资金'+fee_name+'(融资租赁)'  商品,'1' 数量,plan_money   单价,plan_money 金额,invoice_remark 备注,'' 收款人,'0' 状态 from vi_fund_receipt_confirm where 1=1 "+wherestr; 
System.out.println("vvvvvvvvvvvvv"+expsqlstr);

String updSql="select contract_id,fee_name,fee_num,id from vi_fund_receipt_confirm where 1=1 "+wherestr;
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

<td>申请状态:
	<select name="invoice_statu" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=invoice_statu%>',"|已申请|未申请|已退回|已确认","|已申请|未申请|已退回|已确认"));
		</script>
	 </select>
</td>
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
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="发票确认(Alt+N)">&nbsp;&nbsp;
			<input  class="btn_2" type="button"  value="发票确认提交"  onclick="FundInvoiceConfirm();">&nbsp;&nbsp;
		</td>
		
		<td  width="10%">
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="发票退回(Alt+N)">&nbsp;&nbsp;
			<input  class="btn_2" type="button"  value="发票退回"  onclick="FundInvoiceBack();">&nbsp;&nbsp;
		</td>
		<td align="left">
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="FundInvoice">
		<!--<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','fund_receipt_confirm.jsp');">
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
		<th>计划余额</th>
		<th>开票金额</th>
		<th>备注</th>
		<th>申请状态</th>
		<th>税种</th>
		<th>增值税发票类型</th>
		<th>资金税率</th>
		<th>纳税人识别号</th>
		<th>纳税人地址</th>
		<th>纳税人电话</th>
		<th>纳税人基本开户行</th>
		<th>纳税人账号</th>
		
		
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_fund_receipt_confirm where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_fund_receipt_confirm where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

System.out.println("sqlstr查询条件"+sqlstr);

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
	
     <tr class="materTr_<%=index_no %>" id="materTr_<%=index_no %>">
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("id")) %>"
		contract_id="<%=getDBStr(rs.getString("contract_id"))%>"
		plid="<%=getDBStr(rs.getString("plid"))%>"
		fee_name="<%=getDBStr(rs.getString("fee_name"))%>"
		fee_num="<%=getDBStr(rs.getString("fee_num"))%>"
		tax_rate="<%=getDBStr(rs.getString("tax_rate"))%>"
		invoice_statues="<%=getDBStr(rs.getString("invoice_statues"))%>"
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
		<td align="left"><%=getDBStr(rs.getString("plan_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("curr_plan_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_remark"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_statues"))%></td>
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
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>
