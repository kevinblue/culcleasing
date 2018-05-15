<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>调息管理－－项目列表</title>
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

<body onload="public_onload(0);">
<form action="tx_read.jsp" name="dataNav" onSubmit="return goPage()">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			调息管理&gt;项目列表
		</td>
	</tr>
</table>
<%
//取调息id
String czid=getStr(request.getParameter("czid"));

wherestr=" where tx.adjust_id='"+czid+"'";

String dld_name = getStr(request.getParameter("dld_name"));
String cust_name = getStr(request.getParameter("cust_name"));
String prod_id = getStr(request.getParameter("prod_id"));
String proj_id = getStr(request.getParameter("proj_id"));
String equip_sn = getStr(request.getParameter("equip_sn"));
String lease_term = getStr(request.getParameter("lease_term"));

String qzqr_start_date = getStr(request.getParameter("qzqr_start_date"));
String qzqr_end_date = getStr(request.getParameter("qzqr_end_date"));


if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and dl.khjc like '%"+dld_name+"%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+=" and v_cust.cust_name like '%"+cust_name+"%'";
}
if(proj_id!=null && !"".equals(proj_id)){
	wherestr+=" and tx.proj_id like '%"+proj_id+"%'";
}

if(prod_id!=null && !"".equals(prod_id)){
	wherestr+=" and proj.prod_id = '"+prod_id+"'";
}
if(equip_sn!=null && !"".equals(equip_sn)){
	wherestr+=" and equip_sn like '%"+equip_sn+"%'";
}
if(!lease_term.equals("")){
	wherestr+=" and lease_term = '"+lease_term+"'";
}
	
if(qzqr_start_date!=null && !"".equals(qzqr_start_date)){
	wherestr+=" and convert(varchar(10),adjust_date,21)>='"+qzqr_start_date+"' ";
}
if(qzqr_end_date!=null && !"".equals(qzqr_end_date)){
	wherestr+=" and convert(varchar(10),adjust_date,21)<='"+qzqr_end_date+"' ";
}

sqlstr = "select top 20 tx.id,tx.proj_id,v_cust.cust_name as khmc,pc.lease_term,aip.adjust_id,";
sqlstr+=" dl.khjc as dld,agent_id,proj.prod_id,model_id,equip_sn,p_equip.manufacturer,";
sqlstr+=" tx.left_rent,tx.left_interest,tx.left_corpus,tx.adjust_interest,tx.un_receive_amount,";
sqlstr+=" tx.adjust_date from proj_change_tx tx left join proj_info  proj on tx.proj_id=proj.proj_id";
sqlstr+=" left join vi_cust_all_info  v_cust on v_cust.cust_id=proj.cust_id";
sqlstr+=" left join (select proj_id,model_id,equip_sn,manufacturer ";
sqlstr+=" from proj_equip where id in( select min(id) from proj_equip group by proj_id)";
sqlstr+=" and proj_equip.proj_id=proj_id) p_equip on p_equip.proj_id=tx.proj_id";
sqlstr+=" left join dl_mpxx dl on dl.khbh=proj.agent_id left join adjust_interest_proj aip on tx.proj_id=aip.proj_id and aip.adjust_id=tx.adjust_id";
sqlstr+=" left join proj_condition pc on tx.proj_id=pc.proj_id "+wherestr;

%>	
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>代 理 商</td>
<td><input name="dld_name" type="text" size="11" value="<%=dld_name %>"></td>
<td>项目编号</td>
<td><input name="proj_id" type="text" size="11" value="<%=proj_id %>"></td>
<td>租赁物类型</td>
<td><select name="prod_id" style="width:110px;">
     <script>w(mSetOpt('<%=prod_id%>',"<%=prod_id_str %>"));</script>
     </select>
</td>
<td>租赁期限</td>
<td>
<input name="lease_term" type="text" size="12" value="<%=lease_term %>">
</td>

<td><input type="button" onclick="dataNav.submit()" value="查询"></td>
</tr>

<tr>
<td>客户名称</td>
<td><input name="cust_name" type="text" size="11" value="<%=cust_name %>"></td>
<td>出厂编号</td>
<td><input name="equip_sn" type="text" size="11" value="<%=equip_sn %>"></td>


<td>调息&nbsp;&nbsp;日期</td>
<td> <input name="qzqr_start_date" type="text" size="14" readonly dataType="Date" value="<%=qzqr_start_date %>">
<img  onClick="openCalendar(qzqr_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>&nbsp;至&nbsp;</td>
<td>
<input name="qzqr_end_date" type="text" size="12" readonly dataType="Date" value="<%=qzqr_end_date %>">
<img  onClick="openCalendar(qzqr_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
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
		</table><!--操作按钮结束-->
		</td>
		<td align="right" width="90%">
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
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
		<th>代理商编号</th>
		<th>代理商</th>
        <th>项目编号</th>
		<th>客户名称</th>
		<th>租赁物名称</th>
		<th>机型</th>
		<th>出厂编号</th>

		<th>租赁期限</th>
		<th>未收期限</th>
		<th>未收租金</th>
		<th>未收利息</th>
		<th>未收本金</th>
		<th>调整利息</th>
		<th>调息日期</th>
		<th></th>
	</tr>
<tbody id="data">
<%	  
int startIndex = (intPage-1)*intPageSize+1;
if ( intRowCount!=0) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
<tr>
	<td align="center"><%=startIndex++ %></td>
	<td align="center"><%=getDBStr(rs.getString("agent_id"))%></td>
	<td align="center"><%=getDBStr(rs.getString("dld"))%></td>
	<td align="center"><%=getDBStr(rs.getString("proj_id"))%></td>
	<td align="center"><%=getDBStr(rs.getString("khmc")) %></td>
	
	<!-- 租赁物信息 -->
	<td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>

	<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("lease_term")) %></td>
	<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("un_receive_amount")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("left_rent")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("left_interest"))%></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("left_corpus")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("adjust_interest")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("adjust_date")) %></td>
	<td align="center">
		<a href="txdb.jsp?proj_id=<%=getDBStr(rs.getString("proj_id"))%>&txid=<%=czid%>" target="_blank">
		租金对照</a>
	</td>
</tr>
<% }}
rs.close(); 
db.close();
%>  
</tbody></table>
</div><!--报表结束-->
</form>
</body>
</html>
