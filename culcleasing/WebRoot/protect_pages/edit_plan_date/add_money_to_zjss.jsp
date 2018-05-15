<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同层资金信息维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script  type="text/javascript">
  function checkstatus(a){ 
   var url = a.href;//url就是你要跳去的地方了。
	 if(url.indexOf("是")==-1){
		opener.open(url);
	 }else{
		 alert("如需，请走资金计划上报流程！");		  
	 }	   	 
 }
</script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="add_money_to_zjss.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		合同层资金信息维护</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";
String wh_userid=(String) session.getAttribute("czyid");
if(wh_userid.equals("ADMN-8GRBW4")){
   wherestr += "or 1=1 and pp.plan_status='未核销'";
}
//本页查询参数
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and pi.project_name like '%" + project_name + "%'";
}

countSql = "select count(pp.id) as amount from contract_fund_fund_charge_plan pp left join contract_info pi  on pi.contract_id=pp.contract_id  where 1=1 and pp.plan_status='未核销' and ";
countSql+=" pi.proj_dept in  (select department from base_user where id='"+wh_userid+"')"+wherestr;

//剩余金额>0
%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="30" value="<%=project_name %>"></td>

<td>
<input type="button" value="查询" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="清空" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--操作按钮开始-->	
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%"><!--翻页控制开始-->
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>


<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
         <th>编号</th>	  
	    <th>合同编号</th>
		<th>项目名称</th>
		<th>项目经理</th>
		<th>大区</th>
        <th>部门</th>		
        <th>计划金额 </th>        
        <th>计划日期</th>
        <th>费用类型</th>
        <th>预期金额</th>
		<th>预期投放日期</th>
		<th>维护人</th>
        <th>维护日期</th>
		<th>同步状态</th> 
      <th>是否资金计划上报</th>   		
        <th>操作</th>
        <th>同步</th>          
      </tr>
      <tbody id="data">
<%
String col_str="pp.id as id ,bu.name as projmanage,pp.is_sb,pp.contract_id as contract_id ,bd.dept_name,bd.parent_deptname,pp.wh_status,pi.project_name as project_name,pp.plan_money as plan_money,"
+"pp.plan_date as plan_date,pp.fee_name as fee_name,isnull(pp.expect_money,pc.equip_amt) as expect_money,isnull(pp.expect_put_time,CONVERT(varchar(100), pp.plan_date, 23)) as expect_put_time,pp.wh_modificator,pp.wh_modify_date";
int i=1;
sqlstr = "select top "+ intPageSize +" "+col_str+" from contract_fund_fund_charge_plan pp ";
sqlstr += "left join contract_condition pc on pc.contract_id=pp.contract_id left join contract_info pi on";
sqlstr +=" pi.contract_id=pp.contract_id left join v_select_base_department  bd  on bd.id= pi.proj_dept ";
sqlstr += "left join base_user bu on bu.id=pi.proj_manage ";
sqlstr +="where 1=1  and pi.proj_dept in  (select department from base_user where id='"+wh_userid+"') "+wherestr+ " and pp.plan_status='未核销' and pp.id not in("; 
sqlstr += " select top "+ (intPage-1)*intPageSize +" pp.id from "; 
sqlstr += "contract_fund_fund_charge_plan pp  left join contract_info pi on pi.contract_id=pp.contract_id where 1=1  and pi.proj_dept in  (select department from base_user where id='"+wh_userid+"')  "+wherestr+ " and pp.plan_status='未核销' order by ";
sqlstr += "pp.contract_id ) order by pp.contract_id";
rs = db.executeQuery(sqlstr);


while ( rs.next() ) {
%>
      <tr>
        <td align="center"><%=i %></td>
        <td align="left"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("projmanage")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("dept_name")) %></td>
		<td align="left"><%=getDBStr( rs.getString("parent_deptname")) %></td>
		<td align="center"><%=getDBStr( rs.getString("plan_money")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("plan_date")) %></td>		

		<td align="center"><%=getDBStr( rs.getString("fee_name")) %></td>			
		<td align="center"><%=getDBStr( rs.getString("expect_money")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("expect_put_time")) %></td>
		<td align="center"><%=getDBStr( rs.getString("wh_modificator")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("wh_modify_date")) %></td>	
        <td align="center"><%=getDBStr( rs.getString("wh_status")) %></td>
        <td align="center"><%=getDBStr( rs.getString("is_sb")) %></td>		
		<td align="center">
     	<a  onclick="checkstatus(this);return false" href='add_money_to_zjss_mod.jsp?id=<%=getDBStr(rs.getString("id"))%>&is_sb=<%=getDBStr( rs.getString("is_sb"))%>' onclick="return myclick();" target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">修改</a>  	
     	</td>	
		<td align="center">
     	<a href='fund_info_add.jsp?contract_id=<%=getDBStr(rs.getString("contract_id"))%>&id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/sbtn_quick_up.gif" align="bottom" border="0">单个执行同步</a>
     	
     	</td>
      </tr>
	  
<%
i++;
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
