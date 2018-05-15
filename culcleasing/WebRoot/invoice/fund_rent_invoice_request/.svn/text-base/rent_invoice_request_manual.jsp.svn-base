<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金发票手工维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<%
System.out.println("租金发票数据提前申请：aaaaaaaaaaaaaaaaa");
String czyid = (String) session.getAttribute("czyid");
String datestr = getSystemDate(0);

String id_list = getStr(request.getParameter("id_list"));
String begin_id_list = getStr(request.getParameter("begin_id_list"));
String contract_id_list = getStr(request.getParameter("contract_id_list"));
String invoice_type_list = getStr(request.getParameter("invoice_type_list"));
String tax_type_list = getStr(request.getParameter("tax_type_list"));
String tax_type_invoice_list = getStr(request.getParameter("tax_type_invoice_list"));
String tax_rate_list = getStr(request.getParameter("tax_rate_list"));
String rent_list = getStr(request.getParameter("rent_list"));
String interest_list = getStr(request.getParameter("interest_list")); 
String corpus_list = getStr(request.getParameter("corpus_list")); 
String rent_num_list = getStr(request.getParameter("rent_num_list")); 
String invoice_statues_list = getStr(request.getParameter("invoice_statues_list"));

String project_name_list = getStr(request.getParameter("project_name_list"));
String cust_name_list = getStr(request.getParameter("cust_name_list"));
String parent_deptname_list = getStr(request.getParameter("parent_deptname_list"));
String dept_name_list = getStr(request.getParameter("dept_name_list"));
String proj_manage_name_list = getStr(request.getParameter("proj_manage_name_list"));
String plan_date_list = getStr(request.getParameter("plan_date_list"));
String last_hire_date_list = getStr(request.getParameter("last_hire_date_list"));


//ResultSet rs;
String [] id_arr =id_list.split("#");
String [] begin_arr =begin_id_list.split("#");//起租编号
String [] contract_arr = contract_id_list.split("#");//合同编号
String [] invoice_type_arr =invoice_type_list.split("#");//发票开具方式
String [] tax_type_arr = tax_type_list.split("#");//税种
String [] tax_type_invoice_arr = tax_type_invoice_list.split("#");//增值税发票类型
String [] tax_rate_arr = tax_rate_list.split("#");
String [] rent_arr =rent_list.split("#");//租金
String [] interest_arr = interest_list.split("#");//利息
String [] corpus_arr = corpus_list.split("#");//本金
String [] rent_num_arr = rent_num_list.split("#");//期次
String [] invoice_statues_arr = invoice_statues_list.split("#");

String [] project_name_arr = project_name_list.split("#");//项目名称
String [] cust_name_arr = cust_name_list.split("#");//客户名称
String [] parent_deptname_arr = parent_deptname_list.split("#");//部门名称
String [] dept_name_arr = dept_name_list.split("#");//大区名称
String [] proj_manage_name_arr = proj_manage_name_list.split("#");//项目经理
String [] plan_date_arr = plan_date_list.split("#");//计划日期
String [] last_hire_date_arr = last_hire_date_list.split("#");//实收日期
System.out.println("合同号:"+contract_arr[0]);
%>
<script type="text/javascript">
onbeforeunload=function()
{
	window.navigate(location); 
   opener.location.reload();
}
function isSelectAll() {
	var names = document.getElementsByName("checkbos_list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
}

function  getList(){
	//得到复选框的集合
	var sqlIds="";
 	//var check_amount=0;//选中行的数量
	$("input[name^='checkbos_list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds +=id +"#";		
	});
	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1));
	$("#plan_id").val('<%=id_arr[0].toString() %>');
	$("#contract_id").val('<%=contract_arr[0] %>');
	$("#begin_id").val('<%=begin_arr[0]%>');
	$("#project_name").val('<%=project_name_arr[0].toString() %>');
	$("#cust_name").val('<%=cust_name_arr[0].toString() %>');
	$("#parent_deptname").val('<%=parent_deptname_arr[0].toString() %>');
	$("#dept_name").val('<%=dept_name_arr[0].toString() %>');
	$("#proj_manage_name").val('<%=proj_manage_name_arr[0].toString() %>');
	$("#rent_num").val('<%=rent_num_arr[0].toString() %>');
	$("#plan_date").val('<%=plan_date_arr[0].toString() %>');
	$("#last_hire_date").val('<%=last_hire_date_arr[0].toString() %>');
	$("#rent").val('<%=rent_arr[0].toString() %>');
	$("#interest").val('<%=interest_arr[0].toString() %>');
	$("#corpus").val('<%=corpus_arr[0].toString() %>');
	
			dataNav.action="rent_invoice_request_manual_save.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			dataNav.action="rent_invoice_request_manual.jsp";
			dataNav.target="_self";
			
}
--></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->


<body onLoad="public_onload(0);">
<form action="rent_invoice_request_manual.jsp"  confirm="false" name="dataNav">
<input id="sqlIds" name="sqlIds" type="hidden" >
<input id="plan_id" name="plan_id" type="hidden" >
<input id="contract_id" name="contract_id" type="hidden" >
<input id="begin_id" name="begin_id" type="hidden" >
<input id="project_name" name="project_name" type="hidden" >
<input id="cust_name" name="cust_name" type="hidden" >
<input id="parent_deptname" name="parent_deptname" type="hidden" >
<input id="dept_name" name="dept_name" type="hidden" >
<input id="proj_manage_name" name="proj_manage_name" type="hidden" >
<input id="rent_num" name="rent_num" type="hidden" >
<input id="plan_date" name="plan_date" type="hidden" >
<input id="last_hire_date" name="last_hire_date" type="hidden" >
<input id="rent" name="rent" type="hidden" >
<input id="interest" name="interest" type="hidden" >
<input id="corpus" name="corpus" type="hidden" >
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	租金发票手工维护</td>
    </tr>
  </table>
  <!--标题结束-->

<%
wherestr = "";

String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );


if(cust_id!=null && !"".equals(cust_id)){
	wherestr+= " and cust_id like '%" + cust_id + "%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+= " and cust_name like '%" + cust_name + "%'";
}


//权限判断
//wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(out_no) as amount from manual_open_invoice_info where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>               
		客户编号&nbsp;<input name="cust_id" type="text" size="15" value="<%=cust_id %>">
	</td>
	<td>
		客户名称&nbsp;<input name="cust_name" type="text" size="15" value="<%=cust_name %>">
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


    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
        <td align="left" width="90%" rowspan="2">
        <!--操作按钮开始-->
      <table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	    
		    <!-- <td><a href="#" accesskey="n" onClick="getList();">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="手工维护" align="absmiddle">维护手工开票</a></td>-->

		<td width="10%" >
			<input  type="button"  value="维护手工开票" onclick="getList();">
		</td>	    
	    </tr>
	</table>
        <!--操作按钮结束--></td>
        <td align="right" width="20%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--翻页控制结束-->
  
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <!-- <th width="1%">编号</th> -->
	    <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选
	    </th>
	    <th>ERP单据号</th>
	    <th>客户编码</th>
	    <th>客户名称</th>
	    <th>纳税人税号</th>
	    <th>地址</th>
	    <th>电话</th>
	    <th>纳税人基本开户行</th>
	    <th>纳税人账号</th>
	    <th>备注</th>
	    <th>商品编码</th>
	    <th>商品名称</th>
	    <th>规格型号</th>
	    <th>计量单位</th>
	    <th>单价</th>
	    <th>是否含税</th>
	    <th>开票金额</th>
	    <th>发票类型</th>
		<th>创建时间</th>
		<th>是否是erp数据</th>
		<th>发票号码</th>
		<th>发票代码</th>
		<th>开票日期</th>
		<th>开票状态</th>
      </tr>
      <tbody id="data">
<%
String col_str="out_no,cust_id,cust_name,tax_payer_no,address,tel,bank_name,bank_no,remark,product_number";
col_str +=",product_name,commercial_specification,unit,unit_price,if_tax";
col_str +=",invoice_money,invoice_type,create_date,if_erp,invoice_number,invoice_code,open_invoice_date,open_invoice_status";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_func_rent_invoice_manual where out_no not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" out_no from vi_func_rent_invoice_manual where 1=1 "+wherestr+" order by cust_id,create_date desc ) "+wherestr ;
sqlstr += " order by cust_id,create_date desc ";

LogWriter.logDebug(request, "租金开票手工维护###"+sqlstr);
int i=0;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
       <!--  <td align="center"><%=i %></td>  -->
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("out_no")) %>"
		/></td>
        <td align="center"><%=getDBStr( rs.getString("out_no") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_id") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("tax_payer_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("address") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("tel") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("bank_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("bank_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("remark") ) %></td>	
		<td align="center"><%= getDBStr( rs.getString("product_number") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("product_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("commercial_specification") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("unit") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("unit_price") ) %></td>
		
		<td align="center"><%= getDBStr( rs.getString("if_tax") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("invoice_money") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("invoice_type") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("create_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("if_erp") ) %></td>
		
		<td align="center"><%= getDBStr( rs.getString("invoice_number") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("invoice_code") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("open_invoice_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("open_invoice_status") ) %></td>
		
      </tr>
<%
i++;
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- 报表结束 -->

</form>
</body>
</html>
