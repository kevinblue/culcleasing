<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>付款材料交接 </title>
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
	 function updMaterStatus(){

		var contract_status = document.getElementById("contract_status").value;
		var change_date = document.getElementById("change_date").value;
		
		if(null == contract_status || '' == contract_status){
			alert("付款材料交接状态不能为空！");
			return false;
		}else if("已收" == contract_status  ){
			if(null == change_date || '' == change_date){
				alert("付款材料已交接状态交接时间不能为空！");
				return false;
			}
		}/* else if("未收" == contract_status){
			document.getElementById("change_date").value = '';
		}  */
		
		dataNav.action="contract_fund_fund_charge_condition_upd.jsp";
		dataNav.target="_blank"
		dataNav.submit();
		dataNav.action="proj_selection_list_mine.jsp";
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
<form action="proj_selection_list_mine.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		付款材料交接表</td>
	</tr>
</table> 

<%

wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );

String fact_date_start =getStr(request.getParameter("fact_date_start"));
String fact_date_end =getStr(request.getParameter("fact_date_end"));
String fact_date_mid =getStr(request.getParameter("fact_date_mid"));

String recycle_date_start =getStr(request.getParameter("recycle_date_start"));
String recycle_date_end =getStr(request.getParameter("recycle_date_end"));
String recycle_date_status =getStr(request.getParameter("recycle_date_status"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( recycle_date_status!=null && !"".equals(recycle_date_status) ) {
	if("未收".equals(recycle_date_status)){
		wherestr += " and recycle_date is null ";
	}
	if("已收".equals(recycle_date_status)){
		wherestr += " and recycle_date is not null ";
	}
}

if(fact_date_mid == null || fact_date_mid.equals("")){
	if(fact_date_start!=null && !"".equals(fact_date_start) && fact_date_end!=null && !"".equals(fact_date_end)){
		wherestr +=" and fact_date >= '"+fact_date_start+"' and fact_date<='"+fact_date_end+"'";
	}
	if(fact_date_start!=null && !"".equals(fact_date_start) && "".equals(fact_date_end)){
		wherestr +=" and fact_date>= '"+fact_date_start+"'";
	}
	if("".equals(fact_date_start) && fact_date_end!=null && !"".equals(fact_date_end)){
		wherestr +=" and fact_date<='"+fact_date_end+"'";
	}
}else if(fact_date_mid.equals("大于30天")){
	wherestr +=" and getdate() >= dateadd(day,30,fact_date) "; 
}else if(fact_date_mid.equals("大于60天")){
	wherestr +=" and getdate() >= dateadd(day,60,fact_date) ";
}


if(recycle_date_start!=null && !"".equals(recycle_date_start) && recycle_date_end!=null && !"".equals(recycle_date_end)){
	wherestr +=" and recycle_date >= '"+recycle_date_start+"' and recycle_date<='"+recycle_date_end+"'";
}
if(recycle_date_start!=null && !"".equals(recycle_date_start) && "".equals(recycle_date_end)){
	wherestr +=" and recycle_date >= '"+recycle_date_start+"'";
}
if("".equals(recycle_date_start) && recycle_date_end!=null && !"".equals(recycle_date_end)){
	wherestr +=" and recycle_date <='"+recycle_date_end+"'";
}

countSql = "select count(proj_id) as amount from vi_contract_fund_fund_charge_condition where 1=1 "+wherestr;

//导出类型2--数据导出
String expsqlstr = "select proj_id as '项目编号' "
	+" , project_name as '项目名称' ,cust_name as '承租人信息',make_contract_id as '合同编号' "
	+" ,  parent_deptname as '部门' ,dept_name as '大区' ,proj_manage_name as '项目经理' "
	+" , fee_name as '设备款项' , plan_money as '设备金额' "
	+" , currency as '币种' " 
	+" , pay_condition as '付款前提'  ,remark as '付款前提备注' " 
	+" , CASE  WHEN recycle_date is null THEN '未回收' ELSE '已回收' END as '设备是否交接',fact_date as '实际付款时间' "
	+" , recycle_date as '回收日期' ,recycle_name as '回收人员' "
	+" from vi_contract_fund_fund_charge_condition where 1=1 "+wherestr+"order by id";

%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<!-- 查询内容 -->
</tr>
<tr>

<td>项目名称：&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td scope="row" id="bj_4">付款材料交接状态：&nbsp;
 <select name="recycle_date_status" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=recycle_date_status %>',"|未收|已收","|未收|已收"));
    </script>
 </select>
</td>
</tr><tr>
<td colspan="2">实际付款时间：
<select name="fact_date_mid" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=fact_date_mid %>',"|大于30天|大于60天","|大于30天|大于60天"));
    </script>
 </select>
 晚于<input type="text" id="fact_date_start" name="fact_date_start"
	 readonly="readonly" 
	value="<%=fact_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 早于<input type="text" id="fact_date_end" name="fact_date_end"
	 readonly="readonly" 
	value="<%=fact_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
</tr>
<tr>
<td>材料回收时间：
晚于<input type="text" id="recycle_date_start" name="recycle_date_start"
	 readonly="readonly" 
	 value="<%=recycle_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 早于<input type="text" id="recycle_date_end" name="recycle_date_end"
	 readonly="readonly" 
	value="<%=recycle_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
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
	
	<td scope="row" id="bj_4">付款材料交接状态：&nbsp;
 <select name="contract_status" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('',"已收|未收","已收|未收"));
    </script>
 </select>
</td>
	
<td scope="row" id="bj_4">付款材料交接时间：&nbsp;
	<input type="text" id="change_date" name="change_date" readonly="readonly"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>

<td>			
	<input type="button" value="确定" onclick="return updMaterStatus();">
	&nbsp;&nbsp;
	<!-- <input type="button" value="清空" onclick="clearQuery();" > -->
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
		
		<td>
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="Payment_data_transfer">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','proj_seletion_list_mine.jsp');">
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
	    <th>项目编号</th>
		<th>项目名称</th>
		<th>承租人信息</th>
		<th>合同编号</th>
		<th>部门</th>
		<th>大区</th>
		<th>项目经理</th>
     	<th>设备款项</th>
 		<th>设备金额</th>
		<th>币种</th>
		<th>付款前提</th>
		<th>付款前提备注</th>
	 	<th>付款材料是否交接</th>
	 	<th>实际付款时间</th>
	 	<th>回收日期</th>
		<th>回收人员</th>

      </tr>
   <tbody id="data">
<%

String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_contract_fund_fund_charge_condition where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_contract_fund_fund_charge_condition where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
%>
<%-- <tr><td colspan="100"><%=sqlstr %></td></tr> --%>
<%
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
		<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("make_contract_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("fee_name"))%></td>
        <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money"))%></td>
        <td align="left"><%=getDBStr(rs.getString("currency"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("pay_condition"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("remark"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("recycle_date"))==""?"未回收":"已回收"%></td>
		<td align="left"><%=getDBDateStr(rs.getString("fact_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("recycle_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("recycle_name"))%></td>	
      </tr>
<%}
			//System.out.println("test=========="+index_no);
rs.close();
db.close();
%>  

<%-- <tr><td colspan='20'>调试的SQL<%=sqlstr %></td></tr> --%>   
     </tbody>
</table>
</div>
</form>

</body>
</html>
