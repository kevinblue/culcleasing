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
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	//提交保存资料状态
	function updMaterStatus(){
		var bank_str1 = document.getElementById("bank_str1").value;
			if(null==bank_str1||''==bank_str1)
			{
			alert("拟银行不能为空！");
			return false;
			}
			dataNav.action="bank_save.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			dataNav.action="proj_selection_list.jsp";
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
<form action="proj_selection_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">

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
String bank = getStr( request.getParameter("bank") );
String bank_str = getStr( request.getParameter("bank_str") );
String lease_term = getStr( request.getParameter("lease_term") );
String qualification_grade = getStr( request.getParameter("qualification_grade") );
String medical_revenue_start =getStr(request.getParameter("medical_revenue_start"));
String medical_revenue_end =getStr(request.getParameter("medical_revenue_end"));
String leas_type=getStr(request.getParameter("leas_type"));
String industry_type_name=getStr(request.getParameter("industry_type_name"));

String not_income_rent_start =getStr(request.getParameter("not_income_rent_start"));
String not_income_rent_end =getStr(request.getParameter("not_income_rent_end"));

String penalty_num_start =getStr(request.getParameter("penalty_num_start"));
String penalty_num_end =getStr(request.getParameter("penalty_num_end"));

String penalty_day_amount_start =getStr(request.getParameter("penalty_day_amount_start"));
String penalty_day_amount_end =getStr(request.getParameter("penalty_day_amount_end"));

String syqx_start =getStr(request.getParameter("syqx_start"));
String syqx_end =getStr(request.getParameter("syqx_end"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( bank!=null && !bank.equals("") ) {
	wherestr += " and bank like '%" + bank + "%'";
}
if(bank_str!=null && !bank_str.equals("")){
	wherestr +=" and bank_str like '%" + bank_str + "%'";
}
if(lease_term!=null && !lease_term.equals("")){
	wherestr +=" and lease_term = '" + lease_term + "'";
}
if(qualification_grade!=null && !qualification_grade.equals("")){
	wherestr +=" and qualification_grade = '" + qualification_grade + "'";
}
if(leas_type!=null && !leas_type.equals("")){
	wherestr +=" and leas_type = '" + leas_type + "'";
}
if(industry_type_name!=null && !industry_type_name.equals("")){
	wherestr +=" and industry_type_name = '" + industry_type_name + "'";
}

if(medical_revenue_start!=null && !"".equals(medical_revenue_start) && medical_revenue_end!=null && !"".equals(medical_revenue_end)){
	wherestr +=" and medical_revenue>= '"+medical_revenue_start+"' and medical_revenue<='"+medical_revenue_end+"'";
}
if(not_income_rent_start!=null && !"".equals(not_income_rent_start) && not_income_rent_end!=null && !"".equals(not_income_rent_end)){
	wherestr +=" and not_income_rent>= '"+not_income_rent_start+"' and not_income_rent<='"+not_income_rent_end+"'";
}
if(penalty_num_start!=null && !"".equals(penalty_num_start) && penalty_num_end!=null && !"".equals(penalty_num_end)){
	wherestr +=" and penalty_num>= '"+penalty_num_start+"' and penalty_num<='"+penalty_num_end+"'";
}
if(penalty_day_amount_start!=null && !"".equals(penalty_day_amount_start) && penalty_day_amount_end!=null && !"".equals(penalty_day_amount_end)){
	wherestr +=" and penalty_day_amount>= '"+penalty_day_amount_start+"' and penalty_day_amount<='"+penalty_day_amount_end+"'";
}
if(syqx_start!=null && !"".equals(syqx_start) && syqx_end!=null && !"".equals(syqx_end)){
	wherestr +=" and syqx>= '"+syqx_start+"' and syqx<='"+syqx_end+"'";
}
countSql = "select count(proj_id) as amount from vi_fina_detail where 1=1 "+wherestr;

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
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称：&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>行&nbsp;&nbsp;业：
 <select name="industry_type_name" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=industry_type_name %>',"|医疗事业|教育|船舶|机床|通用|医疗管理","|医疗事业|教育|船舶|机床|通用|医疗管理"));
    </script>
 </select>
</td>
<td>资质等级：
 <select name="qualification_grade" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=qualification_grade %>',"|三甲|三乙|三丙|二甲|二乙","|三甲|三乙|三丙|二甲|二乙"));
    </script>
 </select>
</td>
<td>医疗药品收入：
 大于<input style="width:116px;" name="medical_revenue_start" id="medical_revenue_start" type="text" value="<%=medical_revenue_start%>">
 小于<input style="width:116px;" name="medical_revenue_end" id="medical_revenue_end" type="text" value="<%=medical_revenue_end%>">
</td>
</tr>
<tr>
<td>银&nbsp;&nbsp;&nbsp;&nbsp;行：&nbsp;<input name="bank"  type="text" size="15" value="<%=bank %>"></td>
<td>拟银行：&nbsp;<input name="bank_str"  type="text" size="15" value="<%=bank_str %>"></td>
<td>租赁类型：
 <select name="leas_type" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=leas_type %>',"|融资租赁|售后回租赁","|融资租赁|售后回租赁"));
    </script>
 </select>
</td>
<td>未回收租金：
 大于<input style="width:116px;" name="not_income_rent_start" id="medical_revenue_start" type="text" value="<%=not_income_rent_start%>">
 小于<input style="width:116px;" name="not_income_rent_end" id="medical_revenue_end" type="text" value="<%=not_income_rent_end%>">
</td>

</tr>
<tr>
<td>租赁年限：&nbsp;<input name="lease_term"  type="text" size="15" value="<%=lease_term %>"></td>
<td>逾期次数：
 大于<input style="width:116px;" name="penalty_num_start" id="medical_revenue_start" type="text" value="<%=penalty_num_start%>">
 小于<input style="width:116px;" name="penalty_num_end" id="medical_revenue_end" type="text" value="<%=penalty_num_end%>">
</td>
<td>逾期天数：
 大于<input style="width:116px;" name="penalty_day_amount_start" id="medical_revenue_start" type="text" value="<%=penalty_day_amount_start%>">
 小于<input style="width:116px;" name="penalty_day_amount_end" id="medical_revenue_end" type="text" value="<%=penalty_day_amount_end%>">
</td>

<td>剩余期限：
 大于<input style="width:116px;" name="syqx_start" id="medical_revenue_start" type="text" value="<%=syqx_start%>">
 小于<input style="width:116px;" name="syqx_end" id="medical_revenue_end" type="text" value="<%=syqx_end%>">
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
	
	<td scope="row" id="bj_4">批量修改拟银行：&nbsp;<input name="bank_str1" id="bank_str1" type="text" size="100">
			
	<input type="button" value="确定" onclick="return updMaterStatus();">
	&nbsp;&nbsp;
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
	    <th>申报银行</th>
		<th>拟银行</th>
	    <th>未回收租金</th>
     	<th>未回收本金</th>
 		<th>逾期次数</th>
 		
		<th>逾期天数</th>
		<th>项目经理</th>
	 	<th>项目部门</th>
	 	<th>大区</th>
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

String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_fina_detail where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from vi_fina_detail where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by proj_id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
		<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("contract_id"))%>"></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("bank"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_str"))%></td>
        <td align="left"><%=getDBStr(rs.getString("not_income_rent"))%></td>
        <td align="left"><%=getDBStr(rs.getString("not_income_corpus"))%></td>
        <td align="left"><%=getDBStr(rs.getString("penalty_num"))%></td>

        <td align="left"><%=getDBStr(rs.getString("penalty_day_amount"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("industry_type_name"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("medical_revenue"))%></td>
		<td align="left"><%=getDBStr(rs.getString("hospital_scale_level"))%></td>	
		<td align="left"><%=getDBStr(rs.getString("leas_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("lease_term"))%></td>
		<td align="left"><%=getDBStr(rs.getString("settle_method"))%></td>
		<td align="left"><%=getDBStr(rs.getString("irr"))%></td>
		<td align="left"><%=getDBStr(rs.getString("StandardIrr"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("approve_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("rent_start_date"))%></td>
		
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("equip_amt"))%></td>
	    <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("lease_money"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("yqz_lease_money"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("fact_fund_pay"))%></td>
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
