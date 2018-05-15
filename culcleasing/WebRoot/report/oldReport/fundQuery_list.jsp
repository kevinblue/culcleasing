<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金查询</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="fundQuery_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<!-- 租金逾期报表-->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		资金查询</td>
	</tr>
</table> 

<%
wherestr = "";

String parent_deptname = "";
sqlstr = "select parent_deptname from v_base_user where id='"+dqczy+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	parent_deptname = rs.getString("parent_deptname");
	wherestr = " and parent_deptname = '"+parent_deptname+"' ";
}else{
	wherestr = " and 1<>1 ";
}
rs.close();  

String fact_date_start = getStr( request.getParameter("fact_date_start") );
String fact_date_end = getStr( request.getParameter("fact_date_end") );
String plan_date_start = getStr( request.getParameter("plan_date_start") );
String plan_date_end = getStr( request.getParameter("plan_date_end") );
String dept_name = getStr( request.getParameter("dept_name") );//大区
String project_name = getStr( request.getParameter("project_name") );
String manage_name = getStr( request.getParameter("manage_name") );
String proj_id = getStr( request.getParameter("proj_id") );
String pay_way = getStr( request.getParameter("pay_way") );
String feetype_name = getStr( request.getParameter("feetype_name") );
String pay_type_name = getStr( request.getParameter("pay_type_name") );
String leas_type = getStr( request.getParameter("leas_type") );
String sfmc = getStr( request.getParameter("sfmc") );
String qymc = getStr( request.getParameter("qymc") );
String status = getStr( request.getParameter("status") );
String fee_name = getStr( request.getParameter("fee_name") );

if(fact_date_start!=null && !"".equals(fact_date_start) && fact_date_end!=null && !"".equals(fact_date_end)){
	wherestr +=" and fact_date >= '"+fact_date_start+"' and fact_date<='"+fact_date_end+"'";
}
if(fact_date_start!=null && !"".equals(fact_date_start) && "".equals(fact_date_end)){
	wherestr +=" and fact_date >= '"+fact_date_start+"'";
}
if("".equals(fact_date_start) && fact_date_end!=null && !"".equals(fact_date_end)){
	wherestr +=" and fact_date <='"+fact_date_end+"'";
}
if(plan_date_start!=null && !"".equals(plan_date_start) && plan_date_end!=null && !"".equals(plan_date_end)){
	wherestr +=" and plan_date >= '"+plan_date_start+"' and plan_date<='"+plan_date_end+"'";
}
if(plan_date_start!=null && !"".equals(plan_date_start) && "".equals(plan_date_end)){
	wherestr +=" and plan_date >= '"+plan_date_start+"'";
}
if("".equals(plan_date_start) && plan_date_end!=null && !"".equals(plan_date_end)){
	wherestr +=" and plan_date <='"+plan_date_end+"'";
}
if(null !=dept_name &&!"".equals(dept_name)){
	wherestr += " and dept_name = '"+dept_name+"' "; 
}
if(null !=manage_name &&!"".equals(manage_name)){
	wherestr += " and manage_name = '"+manage_name+"' "; 
}
if(null !=pay_way &&!"".equals(pay_way)){
	wherestr += " and pay_way = '"+pay_way+"' "; 
}
if(null !=fee_name &&!"".equals(fee_name)){
	wherestr += " and fee_name like '%"+fee_name+"%' "; 
}
if(null !=project_name &&!"".equals(project_name)){
	wherestr += " and project_name like '%"+project_name+"%' "; 
}
if(null !=proj_id &&!"".equals(proj_id)){
	wherestr += " and proj_id like '%"+proj_id+"%' "; 
}
if(null !=leas_type &&!"".equals(leas_type)){
	wherestr += " and leas_type = '"+leas_type+"' "; 
}
if(null !=qymc &&!"".equals(qymc)){
	wherestr += " and qymc = '"+qymc+"' "; 
}
if(null !=feetype_name &&!"".equals(feetype_name)){
	wherestr += " and feetype_name = '"+feetype_name+"' "; 
}
if(null !=pay_type_name &&!"".equals(pay_type_name)){
	wherestr += " and pay_type_name = '"+pay_type_name+"' "; 
}
if(null !=sfmc &&!"".equals(sfmc)){
	wherestr += " and sfmc = '"+sfmc+"' "; 
}
if(null !=status &&!"".equals(status)){
	wherestr += " and status = '"+status+"' "; 
}
String expsqlstr = "select plan_date as '应收日期', fact_date as '实收日期',project_name as '项目名称',receipt_money as '收款金额',pay_money as '付款金额',feetype_name as '款项内容',fee_name as '款项名称' ,pay_type_name as '结算方式',plan_status as '状态',status as '资金状态' from  vi_report_ZJCX_fund where 1=1 "+wherestr+"order by project_name,id";
countSql = "select count(id) as amount from  vi_report_ZJCX_fund where 1=1 "+wherestr;

%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<!-- 查询内容 -->
<tr>
	<td scope="row">大区：
		<input style="width:150px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('dept.jsp',250,350)" >  
	</td>
	<td scope="row">项目经理：
		<input style="width:150px;" name="manage_name" id="manage_name" type="text" value="<%=manage_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('manage.jsp',250,350)" >  
	</td>
	<td scope="row">项目名称：
		<input style="width:150px;" name="project_name" id="project_name" type="text" value="<%=project_name %>" style="width: 100">
	</td>
	<td scope="row">计划时间：
晚于<input type="text" id="plan_date_start" name="plan_date_start"
	 readonly="readonly" 
	 value="<%=plan_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 早于<input type="text" id="plan_date_end" name="plan_date_end"
	 readonly="readonly" 
	value="<%=plan_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
	</td>
</tr>
<tr>
	<td scope="row">项目编号：
		<input style="width:150px;" name="proj_id" id="proj_id" type="text" value="<%=proj_id %>" style="width: 100">
	</td>
	<td scope="row">收支方式：
		<select name="pay_way" style="width: 116">
    	<script type="text/javascript">
     	w(mSetOpt('<%=pay_way%>',"|收款|付款","|收款|付款"));
    	</script>
 </select>
	</td>
	<td scope="row">款项内容：<input style="width:150px;" name="feetype_name" id="feetype_name" type="text" value="<%=feetype_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('fund_feetype.jsp',250,350)" >  
	</td>
	<td scope="row">实际时间：
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
	<td scope="row">结算方式：
		<input style="width:150px;" name="pay_type_name" id="pay_type_name" type="text" value="<%=pay_type_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('fund_pay_type.jsp',250,350)" >  
	</td>
	<td scope="row">租赁类型：<input style="width:150px;" name="leas_type" id="leas_type" type="text" value="<%=leas_type %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('rent_leas.jsp',250,350)" >  
	</td>
	<td scope="row">省份：<input style="width:150px;" name="sfmc" id="sfmc" type="text" value="<%=sfmc %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('sfmc.jsp',250,350)" >  
	</td>
	<td scope="row">区域：<input style="width:150px;" name="qymc" id="qymc" type="text" value="<%=qymc %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('qymc.jsp',250,350)" >  
	</td>
</tr>
<tr>
	<td scope="row">资金状态：
		<select name="status" style="width: 116">
    	<script type="text/javascript">
     	w(mSetOpt('<%=status%>',"|提前|正常|逾期","|提前|正常|逾期"));
    	</script>
 		</select>
	</td>
	<td scope="row">款项名称：
		<input style="width:150px;" name="fee_name" id="fee_name" type="text" value="<%=fee_name %>" style="width: 100">
	</td>
<td align="right"> <input type="button" value="查询" onclick="dataNav.submit();">
	<input type="button" value="清空" onclick="clearQuery();" ></td>
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
		<input name="excel_name" type="hidden" value="fund_query">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','fundQuery_list.jsp');">
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
		<th>应收日期</th>
		<th>实收日期</th>
		<th>项目名称</th>
		<th>收款金额</th>
		<th>付款金额</th>
		<th>款项内容</th>
		<th>款项名称</th>
		<th>结算方式</th>
		<th>状态</th>
		<th>资金状态</th>
      </tr>
   <tbody id="data">
<%
String col = " id,plan_date,fact_date,project_name,receipt_money,pay_money,feetype_name,fee_name,pay_type_name,plan_status,status,manage_name,dept_name,proj_id,pay_way,qymc,sfmc,leas_type ";
sqlstr = "select top "+ intPageSize + col+" from vi_report_ZJCX_fund where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from  vi_report_ZJCX_fund where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by project_name,id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
%>
<%-- <tr><td>sqlstr</td><td colspan="100"><%=sqlstr %></td></tr>
<tr><td>expsqlstr</td><td colspan="100"><%=expsqlstr %></td></tr>
<tr><td>countSql</td><td colspan="100"><%=countSql %></td></tr> --%>
<%
while ( rs.next() ) {
%>   
     <tr >
		<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("fact_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("receipt_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pay_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("feetype_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pay_type_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("status"))%></td>
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
