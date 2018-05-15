<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title> </title>
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
<form action="financing_manage.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<!-- 资金计划数据 -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		</td>
	</tr>
</table> 

<%
wherestr = "";

String industry_type_name = getStr( request.getParameter("industry_type_name") );
String start_medical_revenue = getStr( request.getParameter("start_medical_revenue") );
String end_medical_revenue = getStr( request.getParameter("end_medical_revenue") );
String bank_name = getStr( request.getParameter("bank_name") );
String qualification_grade = getStr( request.getParameter("qualification_grade") );

if ( industry_type_name!=null && !industry_type_name.equals("") ) {
	wherestr += " and industry_type_name like '%" + industry_type_name + "%'";
}
if ( start_medical_revenue!=null && !start_medical_revenue.equals("") ) {
	wherestr += " and medical_revenue >="+start_medical_revenue;
}
if ( end_medical_revenue!=null && !end_medical_revenue.equals("") ) {
	wherestr += " and medical_revenue <="+end_medical_revenue;
}
if ( bank_name!=null && !bank_name.equals("") ) {
	wherestr += " and bank like '%"+bank_name+"%";
}
if ( qualification_grade!=null && !qualification_grade.equals("") ) {
	wherestr += " and qualification_grade like '%"+qualification_grade+"%'";
}


countSql = "select count(proj_id) as amount from vi_fina_detail where 1=1 "+wherestr;

//导出类型2--数据导出
%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>行业:&nbsp;
 <select name="industry_type_name" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=industry_type_name %>',"|医疗事业|教育|船舶|机械|其他|医疗管理","|医疗事业|教育|船舶|机械|其他|医疗管理"));
    </script>
 </select>
</td>
<td>资质等级:&nbsp;<input name="qualification_grade"  type="text" size="15" value="<%=qualification_grade %>"></td>
<td>医疗药品收入:&nbsp;<input name="start_medical_revenue" type="text" size="15" dataType="Money" value="<%=start_medical_revenue %>">
&nbsp;至&nbsp;<input name="end_medical_revenue" type="text" size="15" dataType="Money" value="<%=end_medical_revenue %>">
</td>
<td>银行:
<input name="bank_name"  type="text" size="15" value="<%=bank_name %>">
</td>
<td> <input type="button" value="查询" onclick="dataNav.submit();">
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

		<td align="left" width="10%">
		<!--操作按钮开始-->
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','insur_pay.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	    <!--操作按钮结束-->
	    </td>

		<!-- 翻页控制 -->
		<td align="right" width="40%"><!--翻页控制开始-->
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
	    <th>项目名称</th>
	    <th>银行</th>
		<th>未回收租金</th>
	    <th>未回收本金</th>
     	<th>逾期次数</th>
 		<th>逾期天数</th>																								
		<th>项目经理</th>
	 	<th>项目部门</th>
	 	<th>项目行业</th>
	 	<th>医疗药品收入</th>
	 	<th>医院等级规模</th>
	 	<th>租赁类型</th>
	 	<th>租赁年限</th>
	 	<th>租金测算方式</th>
	 	<th>内部收益IRR</th>
	 	<th>达标IRR</th>
		<th>签约日期</th>
		<th>起租日</th>
		<th>租赁资产价值</th>
		<th>租赁成本</th>
		<th>已起租租赁成本</th>
		<th>实际资金支付</th>
		<th>租金总额</th>
		<th>管理费</th>
		<th>租赁服务费</th>
		<th>保证金</th>
		<th>保证金比例</th>
		<th>首付款</th>
		<th>首付款比例</th>
		<th>客户名称</th>
		<th>客户资质等级</th>
		<th>客户行业小类</th>
		<th>末期租日</th>
		<th>剩余期限</th>
      </tr>
   <tbody id="data">
<%
String expsqlstr = "select project_name 项目名称,bank as 银行,not_income_rent 未回收租金, not_income_corpus 未回收本金,penalty_num 逾期次数,penalty_day_amount as 逾期天数,proj_manage_name as 项目经理,dept_name 项目部门,industry_type_name 项目行业,medical_revenue 医疗药品收入,hospital_scale_level 医院等级规模,leas_type 租赁类型,leas_year 租赁年限,settle_method 租金测算方式,irr 内部收益IRR,StandardIrr 达标IRR,approve_date 签约日期,rent_start_date 起租日,equip_amt as 租赁资产价值 from vi_fina_detail where 1=1 "+wherestr;

String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_fina_detail where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from vi_fina_detail where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by proj_id ";
System.out.println("ccccccccc"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>   
     <tr>
    
        
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><input name="bank_str"  type="text" size="20" value="<%=getDBStr(rs.getString("bank")) %>"></td>
		<td align="left"><%=getDBStr(rs.getString("not_income_rent"))%></td>
        <td align="left"><%=getDBStr(rs.getString("not_income_corpus"))%></td>
        <td align="left"><%=getDBStr(rs.getString("penalty_num"))%></td>
        <td align="left"><%=getDBStr(rs.getString("penalty_day_amount"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("industry_type_name"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("medical_revenue"))%></td>
		<td align="left"><%=getDBStr(rs.getString("hospital_scale_level"))%></td>		
		<td align="left"><%=getDBStr(rs.getString("leas_type"))%></td> 
		<td align="left"><%=getDBStr(rs.getString("leas_year"))%></td>
		<td align="left"><%=getDBStr(rs.getString("settle_method"))%></td>

		<td align="left"><%=getDBStr(rs.getString("irr"))%></td>
		<td align="left"><%=getDBStr(rs.getString("StandardIrr"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("approve_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("rent_start_date"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("equip_amt"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("lease_money"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("yqz_lease_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fact_fund_pay"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("sum_rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("management_fee"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("handling_charge"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("caution_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("caution_money_ratio"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("first_payment"))%></td>

		<td align="left"><%=getDBStr(rs.getString("first_payment_ratio"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("qualification_grade"))%></td>
		<td align="left"><%=getDBStr(rs.getString("hyxlmc"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("end_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("syqx"))%></td>
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
