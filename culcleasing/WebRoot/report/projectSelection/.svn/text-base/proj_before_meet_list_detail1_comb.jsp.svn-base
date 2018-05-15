<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>非标会前客户信息统计表-明细 （合并）  </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">


</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="proj_before_meet_list_detail1_comb.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<%
String cust_idnew  = getStr( request.getParameter("cust_id") );
String sqlstrCou="";
String columnCou="";

%>
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">

<input type="hidden" name="cust_id" value="<%=cust_idnew%>">
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		逾期明细</td>
	</tr>
</table> 

<%
wherestr = "";

String cust_id = getStr( request.getParameter("cust_id") );




//2013-08-02新增查询条件
countSql = "select count(pi.proj_id) as amount from vi_proj_info_comb pi left join (select  vrpd.proj_id,vrpd.project_name,isnull(COUNT(vrpd.proj_id),0) yq_num ,isnull(SUM(penalty_day_amount)/COUNT(vrpd.proj_id),0) "; 
countSql +="avg_day from vi_before_meet_penalty_detail_comb  vrpd  group by  vrpd.proj_id,vrpd.project_name  ) v ";
countSql +="on v.proj_id=pi.proj_id where cust_id='"+cust_id+"' ";

//导出类型2--数据导出
String expsqlstr = "select project_name 项目名称,bank 申报银行, bank_str 拟银行,not_income_rent 未回收租金,not_income_corpus 未回收本金,"+
"penalty_num 逾期次数,penalty_day_amount 逾期天数,proj_manage_name 项目经理,parent_deptname 项目部门,dept_name 大区,"+								"industry_type_name 项目行业,medical_revenue 医疗药品收入,hospital_scale_level 医院等级规模,leas_type 租赁类型,lease_term 租赁年限,"+
"settle_method 租金测算方式,irr 内部收益IRR,StandardIrr 达标IRR,approve_date 签约日期,rent_start_date 起租日,equip_amt 租赁资产价值,"+
"lease_money 租赁成本,yqz_lease_money 已起租租赁成本,fact_fund_pay 实际资金支付,sum_rent 租金总额,management_fee 管理费,"+
"handling_charge 租赁服务费,caution_money 保证金,caution_money_ratio 保证金比例,first_payment 首付款,first_payment_ratio 首付款比例,"+
"cust_name 客户名称,qualification_grade 客户资质等级,hyxlmc 客户行业小类,end_date 末期租日,syqx 剩余期限 from vi_fina_detail where 1=1 "+wherestr;
String updSql="select proj_id,contract_id from vi_fina_detail where 1=1 "+wherestr;
%>
<!--可折叠查询开始-->
<%-- 
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称：&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>客户名称：&nbsp;<input name="cust_name"  type="text" size="15" value="<%=cust_name %>"></td>
<td>行&nbsp;&nbsp;业：
 <select name="industry_type_name" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=industry_type_name %>',"|医疗事业|教育|船舶|机床|通用|医疗管理","|医疗事业|教育|船舶|机床|通用|医疗管理"));
    </script>
 </select>
</td>


</tr>
<tr>
<td>医疗药品收入：
 大于<input style="width:116px;" name="medical_revenue_start" id="medical_revenue_start" type="text" value="<%=medical_revenue_start%>">
 小于<input style="width:116px;" name="medical_revenue_end" id="medical_revenue_end" type="text" value="<%=medical_revenue_end%>">
</td>
<td>租赁类型：
 <select name="leas_type" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=leas_type %>',"|融资租赁|售后回租赁","|融资租赁|售后回租赁"));
    </script>
 </select>
</td>


</tr>
<tr>




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
--%>
<!--可折叠查询开始-->

<!-- end cwTop -->
<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		
		<td>
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="RentInvoice">
		<!--
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','insur_pay.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>-->
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
<div style="vertical-align:top;width:100%;height:200px;overflow:auto;position: relative; left: 0px; top: 0px"   id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	  <th align="center"></th> 
	    <th>项目编号</th>
	    <th>项目名称</th>
	    <th>逾期总次数</th>
	    <th>平均逾期天数</th>
	 	<th>应收罚息</th>
	 	<th>减免罚息</th>
		<th>实收罚息</th>
	 	<th>剩余罚息</th>
		


      </tr>
   <tbody id="data">
<%
String column=" pi.proj_id,pi.project_name,isnull(v.yq_num,0) yq_num ,isnull(v.avg_day,0) avg_day,isnull(v.penalty,0) penalty,isnull(v.penalty_rid,0)"; 
column+="penalty_rid,isnull(v.income_pena,0) income_pena,isnull(v.curr_penalty,0) curr_penalty";
sqlstr =" select top "+ intPageSize +" "+column+" from vi_proj_info_comb pi left join (  ";
sqlstr+= " select vrpd.proj_id,vrpd.project_name,isnull(COUNT(vrpd.proj_id),0) yq_num ,isnull(SUM(penalty_day_amount)/COUNT(vrpd.proj_id),0) avg_day, ";
sqlstr+=" isnull(sum(penalty),0) penalty,isnull(sum(penalty_rid),0) penalty_rid,isnull(sum(income_pena),0) income_pena,isnull(sum(curr_penalty),0) curr_penalty from vi_before_meet_penalty_detail_comb vrpd  ";
sqlstr+=" group by  vrpd.proj_id,vrpd.project_name ";
sqlstr+=" ) v on v.proj_id=pi.proj_id where pi.id not in( select top "+ (intPage-1)*intPageSize +" id from vi_proj_info_comb pi left join (  ";
sqlstr+= " select vrpd.proj_id,vrpd.project_name,isnull(COUNT(vrpd.proj_id),0) yq_num ,isnull(SUM(penalty_day_amount)/COUNT(vrpd.proj_id),0) avg_day, ";
sqlstr+=" isnull(sum(penalty),0) penalty,isnull(sum(penalty_rid),0) penalty_rid,isnull(sum(income_pena),0) income_pena,isnull(sum(curr_penalty),0) curr_penalty from vi_before_meet_penalty_detail_comb vrpd  ";
sqlstr+=" group by  vrpd.proj_id,vrpd.project_name ) v on v.proj_id=pi.proj_id where pi.cust_id='"+cust_id+"' ";
sqlstr+=") ";	
sqlstr+=" and  pi.cust_id='"+cust_id+"'";
rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%> 



     <tr class="materTr_<%=index_no %>">
		<td></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("yq_num"))%>
       
        </td>
        <td align="left"><%=getDBStr(rs.getString("avg_day"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("penalty"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("penalty_rid"))%></td>
	    <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("income_pena"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("curr_penalty"))%></td>
		
      </tr>
<%}
columnCou=" sum(isnull(v.yq_num,0)) yq_num ,sum(isnull(v.avg_day,0)) avg_day,sum(isnull(v.penalty,0)) penalty,sum(isnull(v.penalty_rid,0))"; 
columnCou+=" penalty_rid,sum(isnull(v.income_pena,0)) income_pena,sum(isnull(v.curr_penalty,0)) curr_penalty";
sqlstrCou =" select top "+ intPageSize +" "+columnCou+" from vi_proj_info_comb pi left join (  ";
sqlstrCou+= " select vrpd.proj_id,vrpd.project_name,isnull(COUNT(vrpd.proj_id),0) yq_num ,isnull(SUM(penalty_day_amount)/COUNT(vrpd.proj_id),0) avg_day, ";
sqlstrCou+=" isnull(sum(penalty),0) penalty,isnull(sum(penalty_rid),0) penalty_rid,isnull(sum(income_pena),0) income_pena,isnull(sum(curr_penalty),0) curr_penalty from vi_before_meet_penalty_detail_comb vrpd  ";
sqlstrCou+=" group by  vrpd.proj_id,vrpd.project_name ";
sqlstrCou+=" ) v on v.proj_id=pi.proj_id where pi.id not in( select top "+ (intPage-1)*intPageSize +" id from vi_proj_info_comb pi left join (  ";
sqlstrCou+= " select vrpd.proj_id,vrpd.project_name,isnull(COUNT(vrpd.proj_id),0) yq_num ,isnull(SUM(penalty_day_amount)/COUNT(vrpd.proj_id),0) avg_day, ";
sqlstrCou+=" isnull(sum(penalty),0) penalty,isnull(sum(penalty_rid),0) penalty_rid,isnull(sum(income_pena),0) income_pena,isnull(sum(curr_penalty),0) curr_penalty from vi_before_meet_penalty_detail_comb vrpd  ";
sqlstrCou+=" group by  vrpd.proj_id,vrpd.project_name ) v on v.proj_id=pi.proj_id where pi.cust_id='"+cust_id+"' ";
sqlstrCou+=") ";	
sqlstrCou+=" and  pi.cust_id='"+cust_id+"'";
rs = db.executeQuery(sqlstrCou);
while ( rs.next() ) {
	index_no++;
%>
      <tr class="materTr_<%=index_no %>"  bgcolor="#FF0000">
		<td></td>
        <td align="left">总计：</td>
        <td align="left"></td>
        <td align="left"><%=getDBStr(rs.getString("yq_num"))%>
        </td>
        <td align="left"><%=getDBStr(rs.getString("avg_day"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("penalty"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("penalty_rid"))%></td>
	    <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("income_pena"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("curr_penalty"))%></td>
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
