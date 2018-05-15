<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>融资项目筛选表 </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>

<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	//提交保存资料状态
	function updMaterStatus(temp){
		var up_status="";
		if(temp==3){
			up_status="nocallback";
			}else{
				if(temp==1)
					up_status="callback";
				else{
				up_status='seal_callback'}
			}

			dataNav.action="proj_4materials_save.jsp?up_status="+up_status;
			dataNav.target="_blank"
			dataNav.submit();
			dataNav.action="proj_4materials_list.jsp";
			dataNav.target="_self"
	}

	//是否全选
function SelectAll(){
	var checkboxs=document.getElementsByName("list");
	var all=document.getElementsByName("all");
	all.checked=!all.checked;
	for (var i=0;i<checkboxs.length;i++) {
	var e=checkboxs[i];
	e.checked=!e.checked;
 }
	}
	</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="proj_4material_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		融资项目筛选表</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String dept_name = getStr( request.getParameter("dept_name") );
String parent_deptname = getStr( request.getParameter("parent_deptname") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );

String material_type = getStr( request.getParameter("material_type") );
String material_status = getStr( request.getParameter("material_status") );
String material_name = getStr( request.getParameter("material_name") );

String materialSL_date =getStr(request.getParameter("materialSL_date"));
String materialRD_date_add =getStr(request.getParameter("materialRD_date_add"));


String materialRD_date_begin =getStr(request.getParameter("materialRD_date_begin"));
String materialRD_date_end =getStr(request.getParameter("materialRD_date_end"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}

if ( material_name!=null && !material_name.equals("") ) {
	wherestr += " and material_name like '%" + material_name + "%'";
}

if ( parent_deptname!=null && !parent_deptname.equals("") ) {
	wherestr += " and parent_deptname like '%" + parent_deptname + "%'";
}

if ( dept_name!=null && !dept_name.equals("") ) {
	wherestr += " and dept_name like '%" + dept_name + "%'";
}

if ( material_type!=null && !material_type.equals("") ) {
	wherestr += " and material_type like '%" + material_type + "%'";
}

if ( material_status!=null && !material_status.equals("") ) {
	wherestr += " and material_status like '%" + material_status + "%'";
}

if ( materialRD_date_begin!=null && !materialRD_date_begin.equals("") ) {
	wherestr += " and materialRD_date >='" + materialRD_date_begin + "'";
}

if ( materialRD_date_end!=null && !materialRD_date_end.equals("") ) {
	wherestr += " and materialRD_date <='" + materialRD_date_end + "'";
}

//2013-08-02新增查询条件
countSql = "select count(contract_id) as amount from vi_contract_4material where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select project_name 项目名称,parent_deptname 部门,dept_name 大区,proj_manage_name 项目经理,material_name 材料名称,material_type 材料类型,material_status 材料状态,materialRD_name 回收人,materialRD_date 回收时间,materialSL_date 盖章时间 from vi_contract_4material where 1=1 "+wherestr;
String updSql="select contract_id from vi_contract_4material where 1=1 "+wherestr;
%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称：&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>资料名称：&nbsp;<input name="material_name"  type="text" size="15" value="<%=material_name%>"></td>

<td>材料类型：
 <select name="material_type" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=material_type %>',"|只盖章|只回收|盖章+回收","|只盖章|只回收|盖章+回收"));
    </script>
 </select>
</td>
<td>材料状态：
 <select name="material_status" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=material_status%>',"|已盖章|已回收|未回收|已盖章已回收|已盖章未回收","|已盖章|已回收|未回收|已盖章已回收|已盖章未回收"));
    </script>
 </select>
</td>
</tr>
<tr>

<td scope="row">
出单部门:
<input style="width:115px;" name="dept_name" id="dept_name" type="text" readonly="readonly">
<input style="width:150px;" name="dept_no" id="dept_no" type="hidden" readonly="readonly">
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','出单部门','base_department','dept_name','dept_name|id','id','id','asc','dataNav.dept_name','dataNav.dept_name|dataNav.dept_no');">  
</td>



<td scope="row" id="bj_4">开始时间：&nbsp;
	<input type="text" id="materialRD_date" name="materialRD_date_begin" readonly="readonly"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>

<td scope="row" id="bj_4">结束时间：&nbsp;
	<input type="text" id="materialRD_date" name="materialRD_date_end" readonly="readonly"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>

</tr>

<tr>
<td></td>
<td></td>
<td></td>
<td align="right"> <input type="button" value="查询" onclick="dataNav.submit();">
<input type="button" value="清空" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->
<!--可折叠查询开始-->
	<div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;批量修改
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
	</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>

	<td scope="row" id="bj_4">选择回收时间：&nbsp;
	<input type="text" id="materialRD_date" name="materialRD_date" readonly="readonly"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>

	 	<input type="button" value="确认回收" onclick="return updMaterStatus(1);">
		<input type="button" value="取消回收" onclick="return updMaterStatus(3);">
	&nbsp;
    </td>
	<td>		
	<!--0~盖章，1~回收，2~盖章+回收-->				
	</tr>
	</table>
	</fieldset>
	</div>
	<!--可折叠查询结束-->
<!-- end cwTop -->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		
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
		<td width="60%" align="right"><!--翻页控制开始-->
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
	  <th align="center"><input type="checkbox" name="all" id="all" style="border:0px;" onclick="SelectAll()">全/反选</th> 
	    <th>项目名称</th>
		<th>部门</th>
		<th>大区</th>
		<th>项目经理</th>

		<th>材料名称</th>
		
		<th>材料类型</th>
		<th>材料状态</th>
		<th>回收人</th>

		<th>回收时间</th>


		<th>盖章时间</th>

      </tr>
   <tbody id="data">
<%

String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_contract_4material where  contract_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +"  contract_id from vi_contract_4material where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr +=" order by contract_id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
		<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>

        <td align="left"><%=getDBStr(rs.getString("material_name"))%></td>
        
        <td align="left"><%=getDBStr(rs.getString("material_type"))%></td>
        <td align="left"><%=getDBStr(rs.getString("material_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("materialRD_name"))%></td>


		<td align="left"><%=getDBDateStr(rs.getString("materialRD_date"))%></td>

        <td align="left"><%=getDBDateStr(rs.getString("materialSL_date"))%></td>
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
