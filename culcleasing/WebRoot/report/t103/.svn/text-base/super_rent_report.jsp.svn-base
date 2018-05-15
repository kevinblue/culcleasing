<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>项目台帐-租金超级表</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script type="text/javascript" src="../../js/jquery.js"></script>
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
<form action="super_rent_report.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" id="choiceType" name="choiceType">
<input type="hidden" id="sqldata" name="sqldata"><!-- sqldata主键 -->

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0"
	height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			项目台帐&gt; 租金超级表
		</td>
	</tr>
</table><!--标题结束-->
<%
ResultSet rs1 = null;
wherestr=" and 1=1 ";

String curr_date = getSystemDate(0);
String dld_name = getStr(request.getParameter("dld_name"));
String zzs = getStr(request.getParameter("zzs"));
String cust_name = getStr(request.getParameter("cust_name"));
String prod_id = getStr(request.getParameter("prod_id"));
String proj_id = getStr(request.getParameter("proj_id"));
String equip_sn = getStr(request.getParameter("equip_sn"));
String is_method = getStr(request.getParameter("is_method"));
String proj_state = getStr(request.getParameter("proj_state"));

String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));


if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and dld like '%"+dld_name+"%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+=" and khmc like '%"+cust_name+"%'";
}
if(proj_id!=null && !"".equals(proj_id)){
	wherestr+=" and proj_id like '%"+proj_id+"%'";
}
if(zzs!=null && !"".equals(zzs)){
	wherestr+=" and manufacturer = '"+zzs+"'";
}
if(prod_id!=null && !"".equals(prod_id)){
	wherestr+=" and prod_id = '"+prod_id+"'";
}
if(equip_sn!=null && !"".equals(equip_sn)){
	wherestr+=" and equip_sn like '%"+equip_sn+"%'";
}
if(is_method!=null && !"".equals(is_method)){
	wherestr+=" and method ='"+is_method+"' ";
}
if(proj_state!=null && !"".equals(proj_state)){
	wherestr+=" and status_name = '"+proj_state+"'";
}

if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),proj_qzconfirm_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),proj_qzconfirm_date,21)<='"+end_date+"' ";
}
 
countSql = "select count(id) as amount from vi_proj_simple_detail_info where 1=1 "+filterAgent+wherestr;

//导出sql
String datasqlstr = filterAgent+wherestr;

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
<td><select name="prod_id" style="width:90px;">
     <script>w(mSetOpt('<%=prod_id%>',"<%=prod_id_str %>"));</script>
     </select>
</td>

<td>起租确认日</td>
<td> <input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>&nbsp;至</td>
<td>
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td><input type="button" onclick="dataNav.submit()" value="查询"></td>
</tr>

<tr>
<td>制造商</td>
<td>
<select name="zzs" style="width:90px;">
 <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
</select>
</td>
<td>客户名称</td>
<td><input name="cust_name" type="text" size="11" value="<%=cust_name %>"></td>
<td>出厂&nbsp;&nbsp;编号</td>
<td><input name="equip_sn" type="text" size="11" value="<%=equip_sn %>"></td>

<td>规则&nbsp;&nbsp;付款</td>
<td>
<select name="is_method" style="width:100px;">
 <script>w(mSetOpt('<%=is_method %>',"|规则|不规则"));</script>
</select>
</td>
<td>项目状态</td>
<td>
<select name="proj_state" style="width:100px;">
     <script>w(mSetOpt('<%=proj_state%>',"<%=proj_state_str %>"));</script>
</select>
</td>
<td><input type="button" onclick="clearQuery()" value="清空"></td>
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
				<input type="hidden" name="datasqlstr" value="<%=datasqlstr %>"> 
				<BUTTON class="btn_2"  type="button" onclick="return validata_report_data_exp('super_rent_export_save.jsp','super_rent_report.jsp');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
				</td>
				<!--
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp()">
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
		</table><!--操作按钮结束-->
		</td>

		<td align="right" width="90%">
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	 
		</td>
	</tr>
</table><!--副标题和操作区结束-->

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
		<th>身份证号</th>
		
		<th>租赁物类型</th>
		<th>制造商</th>
		<th>项目类型</th>
		<th>机型</th>
		<th>出厂编号</th>
		<th>数量</th>

		<th>申请日期</th>
		<th>信审批准日期</th>
		<th>签约日期</th>
		<th>验收日期</th>
		<th>起租确认日期</th>
		
		<th>租赁期限</th>
		<th>租赁到期日</th>
		<th>交付地</th>
		<th>交机日期</th>

		<th>是否放款</th>
		<th>计划放款日期</th>
		<th>实际放款日期</th>

        <th>租赁物购买价款</th>
        <th>融资租赁额</th>
		<th>租赁期限</th>
        <th>起租比例</th>
        <th>融资金额</th>

        <th>1起租租金</th>
		<th>2保证金</th>
		<th>3第一期租金</th>
		<th>4保险费</th>
		<th>5手续费</th>
		<th>6担保费</th>
		<th>7留购价款</th>
		<th>首期付款合计</th>

		<th>8DB保证金</th>
		<th>9管理服务费</th>
		<th>首付方式</th>
		<th>首期付款应收日</th>
		<th>首期付款实收日</th>

		<th>租金总额</th>
		<th>已还租期数</th>
		<th>已还租金</th>
		<th>剩余租金期数</th>
		<th>剩余租金</th>
		<th>剩余本金</th>
		<th>逾期租金</th>
		<th>逾期天数</th>

		<th>违约金合计</th>
		<th>已收违约金</th>
		<th>未收违约金</th>
		<th>违约金处理</th>
		<th>连续逾期</th>
		<th>累计逾期</th>
		<th>开户银行</th>
		<th>开户账号</th>
		<th>状态</th>
	</tr>
	<tbody id="data">
<%	  
sqlstr = "select top "+ intPageSize +" * from vi_proj_simple_detail_info where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_proj_simple_detail_info where 1=1 "+filterAgent+wherestr+" order by dld,id  ) "+filterAgent+wherestr;
sqlstr +=" order by dld,id ";

rs = db.executeQuery(sqlstr);
//=========变量定义区=======
String partSql = "";
//========================
String item_id = "";
String projId = "";
boolean sf_hx = false;//首付款是否核销
//==========
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("id") );
	projId = getDBStr( rs.getString("proj_id") );
%>
<tr>
	<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
	<td align="center"><%=startIndex++ %></td>
	<td align="center"><%=getDBStr(rs.getString("qy"))%></td>
	<td align="center"><%=getDBStr(rs.getString("dld"))%></td>
	<td align="center"><a href="http://online.strongflc.com/Eleasing/PMAgent.nsf/OSShowProjectInfo?openagent&proj_id=<%=projId %>" target="_blank"><%=getDBStr(rs.getString("proj_id")) %></a></td>
	<td align="center"><%=getDBStr(rs.getString("khmc")) %></td>
	<td align="center"><%=getDBStr(rs.getString("cust_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("card_id")) %></td>
	
	<!-- 租赁物信息 -->
	<td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("manufacturer"))%></td>
	<td align="center"><%=getDBStr(rs.getString("method")) %></td>
	<td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_amount"))%></td>

	<!-- 项目流程日期 -->
	<td align="center"><%=getDBDateStr(rs.getString("lx_date")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("proj_pz_date")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("proj_qy_date")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("check_date")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("proj_qzconfirm_date")) %></td>
	<td align="center">&gt;&gt;<%=getDBStr(rs.getString("lease_term")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("end_leasing_date")) %></td>
	
	<!-- 交付地、交机时间 -->
	<%
		//交付地、交机时间
		partSql = "select top 1 equip_delivery_place,equip_delivery_date from proj_equip where proj_id='"+projId+"'";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
	%>
	<td align="left"><%=getDBStr(rs1.getString("equip_delivery_place")) %></td>
	<td align="center"><%=getDBDateStr(rs1.getString("equip_delivery_date")) %></td>
	<% }else{ %>
	<td></td>
	<td></td>
	<% } rs1.close();%>
	
	<%
		//放款信息
		partSql = "select ffcp.proj_id,ffcp.plan_date,ffc.fact_date ";
		partSql += "from fund_fund_charge_plan ffcp ";
		partSql += "left join fund_fund_charge ffc ";
		partSql += "on ffcp.proj_id=ffc.proj_id and ffcp.funds_type=ffc.funds_type ";
		partSql += "and ffcp.funds_mode=ffc.funds_mode ";
		partSql += "where ffcp.funds_mode='付款' ";
		partSql += "and ffcp.funds_type='租赁物购买价款' and ffcp.proj_id='"+projId+"'";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
	%>
	<td align="center"><%=rs1.getString("fact_date")==null?"否":"是" %></td>
	<td align="center"><%=getDBDateStr(rs1.getString("plan_date")) %></td>
	<td align="center"><%=getDBDateStr(rs1.getString("fact_date"))%></td>
	<% } else{ %>
	<td></td>
	<td></td>
	<td></td>
	<% }rs1.close(); %>
	
	<!-- 项目金额 -->
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("equip_amt")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("lease_zl_money")) %></td>
	<td align="center"><%=getDBStr(rs.getString("lease_term")) %></td>
	<td align="center"><%=CurrencyUtil.convertFinance(rs.getDouble("head_ratio"))%></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("lease_money")) %></td>
	
	<!-- 资金计划 -->
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("head_amt")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("caution_money")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("every_rent")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("insurance_lessor")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("handling_charge")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("lessee_caution_money")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("nominalprice")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("first_payment")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("sale_caution_money")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("supervision_fee")) %></td>
    <td align="center"><%=getDBStr(rs.getString("first_paytype")) %></td>
    
    <%
		//首付款信息
		partSql = "select ffcp.proj_id,ffcp.plan_date,ffc.fact_date ";
		partSql += "from fund_fund_charge_plan ffcp ";
		partSql += "left join fund_fund_charge ffc ";
		partSql += "on ffcp.proj_id=ffc.proj_id and ffcp.funds_type=ffc.funds_type ";
		partSql += "and ffcp.funds_mode=ffc.funds_mode ";
		partSql += "where ffcp.funds_mode='收款' ";
		partSql += "and ffcp.funds_type='起租租金' and ffcp.proj_id='"+projId+"'";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			sf_hx=rs1.getString("fact_date")==null?false:true;
	%>
	<td align="center"><%=getDBDateStr(rs1.getString("plan_date")) %></td>
	<td align="center"><%=getDBDateStr(rs1.getString("fact_date")) %></td>
	<% } else{ %>
	<td></td>
	<td></td>
	<% }rs1.close(); %>
		
	<!-- 租金计划 -->
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("total_rent")) %></td>
	<td align="center"><%=getDBStr(rs.getInt("lease_term")-rs.getInt("un_received_amount")+"") %></td>
	<% if(sf_hx) { %>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("total_rent")-rs.getDouble("left_rent")) %></td>
	<% }else{ %> 
	<td align="right"><%=0.00 %></td>
	<%}%>
	<td align="center"><%=getDBStr(rs.getInt("un_received_amount")+"") %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("left_rent")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("left_corpus")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("overdue_sum")) %></td>

	<!-- 逾期租金 -->
	<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getInt("overdue_day")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("total_penalty")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("paid_penalty")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("total_penalty")-rs.getDouble("paid_penalty")) %></td>
	<%
	//违约金处理
	String penalty_deal = "";
	sqlstr = " select dbo.penalty_deal('"+projId+"') as deal";
	rs1 = db1.executeQuery(sqlstr);
	if(rs1.next()){
		penalty_deal = getDBStr( rs1.getString("deal") );
	}
	rs1.close();
	%>
	<td align="center"><%=penalty_deal %></td>

	<%
		//计算项目的连续逾期数量
		int ljyqAmount = 0;
		sqlstr = "select dbo.overdue_con_amount('"+projId+"') as r ";
		rs1 = db1.executeQuery(sqlstr);
		if(rs1.next()){
			ljyqAmount = rs1.getInt("r");
		}rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getInt("overdue_amount")) %></td>
	<td align="center"><%=CurrencyUtil.convertIntAmount(ljyqAmount) %></td>
	<td align="center"><%=getDBStr(rs.getString("bank")) %></td>
	<td align="center"><%=getDBStr(rs.getString("account")) %></td>
	<td align="center"><%=getDBStr(rs.getString("status_name")) %></td>
</tr>
<% }
rs.close(); 
db.close();
db1.close();
%>  
</tbody></table>
</div><!--报表结束-->
</form>
</body>
</html>
