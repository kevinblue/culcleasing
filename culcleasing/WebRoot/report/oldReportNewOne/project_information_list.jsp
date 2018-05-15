<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目基本信息汇总表</title>
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
<form action="project_information_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<!-- 租金逾期报表-->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		项目基本信息汇总表</td>
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

String proj_id = getStr( request.getParameter("proj_id") );
String project_name = getStr( request.getParameter("project_name") );
String dept_name = getStr( request.getParameter("dept_name") );//大区
String industry_type_name = getStr( request.getParameter("industry_type_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String tax_type = getStr( request.getParameter("tax_type") );
String cust_name = getStr( request.getParameter("cust_name") );
String cd_date_start = getStr( request.getParameter("cd_date_start") );
String cd_date_end = getStr( request.getParameter("cd_date_end") );

if(null !=proj_id &&!"".equals(proj_id)){
	wherestr += " and proj_id like '%"+proj_id+"%' "; 
}
if(null !=project_name &&!"".equals(project_name)){
	wherestr += " and project_name like '%"+project_name+"%' "; 
}
if(null !=dept_name &&!"".equals(dept_name)){
	wherestr += " and dept_name = '"+dept_name+"' "; 
}
if(null !=industry_type_name &&!"".equals(industry_type_name)){
	wherestr += " and industry_type_name = '"+industry_type_name+"' "; 
}
if(null !=proj_manage_name &&!"".equals(proj_manage_name)){
	wherestr += " and proj_manage_name = '"+proj_manage_name+"' "; 
}
if(null !=tax_type &&!"".equals(tax_type)){
	wherestr += " and tax_type = '"+tax_type+"' "; 
}
if(null !=cust_name &&!"".equals(cust_name)){
	wherestr += " and cust_name = '"+cust_name+"' "; 
}
if(cd_date_start!=null && !"".equals(cd_date_start) && cd_date_end!=null && !"".equals(cd_date_end)){
	wherestr +=" and cd_date >= '"+cd_date_start+"' and cd_date<='"+cd_date_end+"'";
}
if(cd_date_start!=null && !"".equals(cd_date_start) && "".equals(cd_date_end)){
	wherestr +=" and cd_date >= '"+cd_date_start+"'";
}
if("".equals(cd_date_start) && cd_date_end!=null && !"".equals(cd_date_end)){
	wherestr +=" and cd_date <='"+cd_date_end+"'";
}

String expsqlstr = "select proj_id as '项目编号', project_name as '项目名称',proj_manage_name as '项目经理',parent_deptname as '项目部门',dept_name as '大区',industry_type_name as '项目行业',medical_income as '医疗药品收入',medical_lv as '医疗等级规模',leas_type as '租赁类型',year_rate as '租赁利率',leas_year as '租赁年限',title as '租金测算方式',irr as '内部收益IRR',standardirr as '达标IRR',standardf as '是否达标',approve_date as '签约日期',rent_start_date as '起租日',tyzkkcsj as '项目考察时间',equip_amt as '租赁资产价值',lease_money as '租赁成本',begin_lease_money as '已起租租赁成本',wqz as '未起租租赁成本',total_rent as '租金总额',management_fee as '管理费',handling_charge as '租赁服务费',dangqi as '当期',jjzc as '居间支出',caution_money as '保证金',first_payment as '首付款',name as '质控评审经理',cust_name as '客户名称',cust_lv as '客户资质等级',hyxlmc as '客户行业小类',rent_end_date as '末期租日',zdw_num as '中登网等登记标号',zdw_end_date as '中登网登记到日期',qymc as '区域',sfmc as '省份',csmc as '地市',tax_type as '税种',status_name as '项目状态',income_number_year as '支付周期',period_type as '付租类型' from  vi_report_project_JBXX where 1=1 "+wherestr+"order by project_name,proj_id";
countSql = "select count(proj_id) as amount from  vi_report_project_JBXX where 1=1 "+wherestr;

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
	<td scope="row">项目编号：
		<input style="width:150px;" name="proj_id" id="proj_id" type="text" value="<%=proj_id %>" style="width: 100">
	</td>
	<td scope="row">项目名称：
		<input style="width:150px;" name="project_name" id="project_name" type="text" value="<%=project_name %>" style="width: 100">
	</td>
	<td scope="row">大区：
		<input style="width:150px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('dept.jsp',250,350)" >  
	</td>
	<td scope="row">C-D交接结束日期：
晚于<input type="text" id="cd_date_start" name="cd_date_start"
	 readonly="readonly" 
	 value="<%=cd_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
 早于<input type="text" id="cd_date_end" name="cd_date_end"
	 readonly="readonly" 
	value="<%=cd_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
</tr>
<tr>
	<td scope="row">板块：<input style="width:150px;" name="industry_type_name" id="industry_type_name" type="text" value="<%=industry_type_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('trade.jsp',250,350)" >  
	</td>
	<td scope="row">项目经理：
		<input style="width:150px;" name="proj_manage_name" id="proj_manage_name" type="text" value="<%=proj_manage_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('manage.jsp',250,350)" >  
	</td>
	<td scope="row">税种：
		<select name="tax_type" style="width: 116">
    	<script type="text/javascript">
     	w(mSetOpt('<%=tax_type%>',"|营业税|增值税","|营业税|增值税"));
    	</script>
		 </select>
	</td>
	<td scope="row">客户：<input style="width:150px;" name="cust_name" id="cust_name" type="text" value="<%=cust_name %>" readonly="readonly" style="width: 100" Require="ture">
		<img src="../../images/fdmo_65.gif" alt="选" width="20" height="20" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('cust.jsp',250,350)" >  
	</td>
</tr>
<tr>
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
		<input name="excel_name" type="hidden" value="project_information">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','project_information_list.jsp');">
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
	    <th>项目标号</th>
		<th>项目名称</th>
		<th>项目经理</th>
		<th>项目部门</th>
		<th>大区</th>
		<th>项目行业</th>
		<th>医疗药品收入</th>
		<th>医院等级规模</th>
		<th>租赁类型</th>
		<th>租赁利率</th>
		
		<th>租赁年限</th>
		<th>租金测算方式</th>
		<th>内部收益IRR</th>
		<th>达标IRR</th>
		<th>是否达标</th>
		<th>签约日期</th>
		<th>起租日</th>
		<th>项目考察时间</th>
		<th>租赁资产价值</th>
		<th>租赁成本</th>
		
		<th>已起租租赁成本</th>
		<th>未起租租赁成本</th>
		<th>租金总额</th>
		<th>管理费</th>
		<th>租赁服务费</th>
		<th>当期</th>
		<th>居间支出</th>
		<th>保证金</th>
		<th>首付款</th>
		<th>质控评审经理</th>
		
		<th>客户名称</th>
		<th>客户资质等级</th>
		<th>客户行业小类</th>
		<th>末期租日</th>
		<th>中登网登记编号</th>
		<th>中登网登记到期日</th>
		<th>区域</th>
		<th>省份</th>
		<th>地市</th>
		<th>税种</th>
		
		<th>项目状态</th>
		<th>支付周期</th>
		<th>付租类型</th>
      </tr>
   <tbody id="data">
<%
String col = " proj_id,project_name,proj_manage_name,parent_deptname,dept_name,industry_type_name,medical_income,medical_lv,leas_type,year_rate,leas_year,title,irr,standardirr,standardf,approve_date,rent_start_date,tyzkkcsj,equip_amt,lease_money,begin_lease_money,wqz,total_rent,management_fee,handling_charge,dangqi,jjzc,caution_money,first_payment,name,cust_name,cust_lv,hyxlmc,rent_end_date,zdw_num,zdw_end_date,qymc,sfmc,csmc,tax_type,status_name,income_number_year,period_type,cd_date ";
sqlstr = "select top "+ intPageSize + col+" from vi_report_project_JBXX where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from  vi_report_project_JBXX where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by project_name,proj_id";

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
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("industry_type_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("medical_income"))%></td>
		<td align="left"><%=getDBStr(rs.getString("medical_lv"))%></td>
		<td align="left"><%=getDBStr(rs.getString("leas_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("year_rate"))%></td>
		
		<td align="left"><%=getDBStr(rs.getString("leas_year"))%></td>
		<td align="left"><%=getDBStr(rs.getString("title"))%></td>
		<td align="left"><%=getDBStr(rs.getString("irr"))%></td>
		<td align="left"><%=getDBStr(rs.getString("standardirr"))%></td>
		<td align="left"><%=getDBStr(rs.getString("standardf"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("approve_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("rent_start_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("tyzkkcsj"))%></td>
		<td align="left"><%=getDBStr(rs.getString("equip_amt"))%></td>
		<td align="left"><%=getDBStr(rs.getString("lease_money"))%></td>
	
		<td align="left"><%=getDBStr(rs.getString("begin_lease_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("wqz"))%></td>
		<td align="left"><%=getDBStr(rs.getString("total_rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("management_fee"))%></td>
		<td align="left"><%=getDBStr(rs.getString("handling_charge"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dangqi"))%></td>
		<td align="left"><%=getDBStr(rs.getString("jjzc"))%></td>
		<td align="left"><%=getDBStr(rs.getString("caution_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("first_payment"))%></td>
		<td align="left"><%=getDBStr(rs.getString("name"))%></td>
		
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_lv"))%></td>
		<td align="left"><%=getDBStr(rs.getString("hyxlmc"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("rent_end_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("zdw_num"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("zdw_end_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("qymc"))%></td>
		<td align="left"><%=getDBStr(rs.getString("sfmc"))%></td>
		<td align="left"><%=getDBStr(rs.getString("csmc"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		
		<td align="left"><%=getDBStr(rs.getString("status_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("income_number_year"))%></td>
		<td align="left"><%=getDBStr(rs.getString("period_type"))%></td>
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
