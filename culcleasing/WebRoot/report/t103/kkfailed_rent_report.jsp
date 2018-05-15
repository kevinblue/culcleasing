<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>租金管理 - 扣款未成功明细表</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<!-- 租赁公司、代理商的判断 -->
<%@ include file="../../public/pageRight.jsp"%>
<!-- 租赁公司、代理商的判断 -->

<body onload="public_onload(0);">
<form action="kkfailed_rent_report.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="excel_name" value="kkfailed_rent">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			租金管理 &gt; 扣款未成功明细表
		</td>
	</tr>
</table><!--标题结束-->
<%
wherestr=" and 1=1 ";

String curr_date = getSystemDate(0);
String dld_name = getStr(request.getParameter("dld_name"));
String zzs = getStr(request.getParameter("zzs"));
String cust_name = getStr(request.getParameter("cust_name"));
String prod_id = getStr(request.getParameter("prod_id"));
String proj_id = getStr(request.getParameter("proj_id"));
String equip_sn = getStr(request.getParameter("equip_sn"));
String zj_status = getStr(request.getParameter("zj_status"));
String hx_status = getStr(request.getParameter("hx_status"));
String fee_type = getStr(request.getParameter("fee_type"));
String bank = getStr(request.getParameter("bank"));
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and dld like '%"+dld_name+"%'";
}
if(zzs!=null && !"".equals(zzs)){
	wherestr+=" and manufacturer = '"+zzs+"'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+=" and khmc like '%"+cust_name+"%'";
}
if(proj_id!=null && !"".equals(proj_id)){
	wherestr+=" and proj_id like '%"+proj_id+"%'";
}
if(prod_id!=null && !"".equals(prod_id)){
	wherestr+=" and prod_id = '"+prod_id+"'";
}
if(equip_sn!=null && !"".equals(equip_sn)){
	wherestr+=" and equip_sn like '%"+equip_sn+"%'";
}
if(zj_status!=null && !"".equals(zj_status)){
	wherestr+=" and status = '"+zj_status+"'";
}
if(fee_type!=null && !"".equals(fee_type)){
	wherestr+=" and fee_type = '"+fee_type+"'";
}
if(bank!=null && !"".equals(bank)){
	wherestr+=" and bank = '"+bank+"'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+end_date+"' ";
}
 
countSql = "select count(*) as amount from vi_report_kkfailed_rent where 1=1 "+filterAgent+wherestr;

//导出类型1
String exesqlstr1 = "select qymc 区域,dld 代理商,proj_id 项目编号,khmc 客户名称,cust_id 客户编号,card_id 身份证,method 规则付款, ";
exesqlstr1 += " prod_id 租赁物类型,manufacturer 制造商,model_id 机型,equip_sn 出厂编号,";
exesqlstr1 += " fee_type 款项内容,rent_list 期次,plan_date 应收日期,";
exesqlstr1 += " costmoney 应收金额,modify_date 扣款日期,fail_reason 未成功原因,";
exesqlstr1 += " overdue_reason 逾期原因,overdue_description 逾期说明,";
exesqlstr1 += " detail_description 详细描述 from vi_report_kkfailed_rent where item_id in ";

//导出类型2--数据导出
String exesqlstr2 = "select qymc 区域,dld 代理商,proj_id 项目编号,khmc 客户名称,cust_id 客户编号,card_id 身份证,method 规则付款, ";
exesqlstr2 += " prod_id 租赁物类型,manufacturer 制造商,model_id 机型,equip_sn 出厂编号,";
exesqlstr2 += " fee_type 款项内容,rent_list 期次,plan_date 应收日期,";
exesqlstr2 += " costmoney 应收金额,modify_date 扣款日期,fail_reason 未成功原因,";
exesqlstr2 += " overdue_reason 逾期原因,overdue_description 逾期说明,";
exesqlstr2 += " detail_description 详细描述 from vi_report_kkfailed_rent where 1=1 "+filterAgent+wherestr+" order by dld,proj_id,rent_list";

%>	
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>代理商</td>
<td><input name="dld_name" type="text" size="11" value="<%=dld_name %>"></td>
<td>项目编号</td>
<td><input name="proj_id" type="text" size="11" value="<%=proj_id %>"></td>
<td>租赁物类型</td>
<td><select name="prod_id" style="width:88px;">
     <script>w(mSetOpt('<%=prod_id%>',"<%=prod_id_str %>"));</script>
     </select>
</td>

<td>应收日期</td>
<td><input name="start_date" type="text" size="9" readonly dataType="Date" value="<%=start_date %>">
<img onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>&nbsp;&nbsp;至&nbsp;</td>
<td><input name="end_date" type="text" size="9" readonly dataType="Date" value="<%=end_date %>">
<img onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>开户银行</td>
<td><select name="prod_id" style="width:90px;">
    <script>w(mSetOpt('<%=bank%>',"<%=bank_str%>"));</script>
     </select></td>

</tr>

<tr>
<td>制造商</td>
<td>
<select name="zzs" style="width:88px;">
 <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
</select>
</td>
<td>客户名称</td>
<td><input name="cust_name" type="text" size="11" value="<%=cust_name %>"></td>
<td>出厂&nbsp;&nbsp;编号</td>
<td><input name="equip_sn" type="text" size="11" value="<%=equip_sn %>"></td>

<td>资金状态</td>
<td>
<select name="zj_status" style="width:100px;">
 <script>w(mSetOpt('<%=zj_status%>',"|逾期|正常"));</script>
</select>
</td>
<td>款项内容</td>
<td>
<select name="fee_type" style="width:100px;">
 <script>w(mSetOpt('<%=fee_type %>',"|租金|违约金"));</script>
</select>
</td>
<td align="left"><input type="button" onclick="dataNav.submit()" value="查询"></td>
<td align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="clearQuery()" value="清空"></td>
</tr>

</table>
</fieldset>
</div><!-- 查询条件结束 -->


<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<input type="hidden" id="export_type1" value="<%=exesqlstr1%>">
				<input type="hidden" id="export_type2" value="<%=exesqlstr2%>">

				<input name="expsqlstr" type="hidden">
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_report_exp('../../func/exp_report.jsp','kkfailed_rent_report.jsp');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
				</td>
				<!-- 
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
					<input name="ck_all" style="border:none;" type="checkbox">&nbsp;页面全选
					<input name="data_ck_all" style="border:none;" type="checkbox">&nbsp;数据全选
				</td><!--操作按钮结束-->
			</tr>
		</table>
		<!--操作按钮结束-->
		</td>

		<td align="right" width="90%">
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>				

 
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th width="1%"></th> 						
        <th>序号</th>
		<th>区域</th>
		<th>代理商</th>
        <th>项目编号</th>
		<th>客户名称</th>
		<th>客户编号</th>
		<th>身份证</th>
		
		<th>规则付款</th>
		<th>租赁物类型</th>
		<th>制造商</th>
		<th>机型</th>
		<th>出厂编号</th>

		<th>款项内容</th>
		<th>期次</th>
		<th>扣款方式</th>
		<th>应收日期</th>
		<th>应收金额</th>

		<th>扣款日期</th>
		<th>未成功原因</th>

		<th>逾期原因</th>
		<th>逾期说明</th>
		<th>详细描述</th>
	</tr>
<tbody id="data">
<%	  
sqlstr = "select top "+ intPageSize +" * from vi_report_kkfailed_rent where 1=1 and item_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" item_id from vi_report_kkfailed_rent where 1=1 "+filterAgent+wherestr+" order by  dld,proj_id,rent_list,item_id ) "+filterAgent+wherestr ;
sqlstr +=" order by dld,proj_id,rent_list,item_id ";

rs = db.executeQuery(sqlstr);
String item_id = "";
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("item_id") );
%>
	<tr>
		<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
		<td align="center"><%=startIndex++ %></td>
        <td align="center"><%=getDBStr(rs.getString("qymc"))%></td>
        <td align="center"><%=getDBStr(rs.getString("dld"))%></td>
        <td align="center"><%=getDBStr(rs.getString("proj_id")) %></td>
        <td align="center"><%=getDBStr(rs.getString("khmc")) %></td>
		<td align="center"><%=getDBStr(rs.getString("cust_id")) %></td>
		<td align="center"><%=getDBStr(rs.getString("card_id")) %></td>

		<td align="center"><%=getDBStr(rs.getString("method"))%></td>
        <td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
		<td align="center"><%=getDBStr(rs.getString("manufacturer"))%></td>
        <td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
        <td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>

		<td align="center"><%=getDBStr(rs.getString("fee_type"))%></td>
        <td align="center"><%=getDBStr(rs.getString("rent_list")) %></td>
		<td align="center"><%=getDBStr(rs.getString("item_method"))%></td>
        <td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("costmoney")) %></td>

		<td align="center"><%=getDBDateStr(rs.getString("modify_date")) %></td>
		<td align="left"><%=getDBStr(rs.getString("fail_reason")) %></td>

		<td align="left"><%=getDBStr(rs.getString("overdue_reason")) %></td>		
		<td align="left"><%=getDBStr(rs.getString("overdue_description")) %></td>
		<td align="left"><%=getDBStr(rs.getString("detail_description")) %></td>
</tr>
<% }
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->
</form>
</body>
</html>

