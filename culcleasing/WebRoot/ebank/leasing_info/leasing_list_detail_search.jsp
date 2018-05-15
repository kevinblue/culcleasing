<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>租赁公司收款列表(首付款)</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>
	<script src="../../js/calend.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
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

<body  onload="public_onload(0);">
<form action="leasing_list_detail_search.jsp" name="dataNav" onSubmit="return goPage()">
<%
wherestr=" and 1=1 ";
		
String dls = getStr( request.getParameter("dls") );
String xmbh = getStr( request.getParameter("xmbh") );
String khmc = getStr( request.getParameter("khmc") );
String zzs = getStr( request.getParameter("zzs") );
String zlwlx = getStr( request.getParameter("zlwlx") );
String equip_sn = getStr( request.getParameter("equip_sn") );

String yf_date_start = getStr( request.getParameter("yf_date_start") );
String yf_date_end = getStr( request.getParameter("yf_date_end") );

String dz_date_start = getStr( request.getParameter("dz_date_start") );
String dz_date_end = getStr( request.getParameter("dz_date_end") );
	
if ( !dls.equals("") ) {
	wherestr = wherestr + " and dld like '%" + dls + "%'";
}
if ( !xmbh.equals("") ) {
	wherestr = wherestr + " and proj_id  like '%" + xmbh + "%'";
}
if ( !khmc.equals("") ) {
	wherestr = wherestr + " and khmc like '%" + khmc + "%'";
}
if ( !zzs.equals("") ) {
	wherestr = wherestr + " and manufacturer ='" + zzs + "'";
}
if ( !zlwlx.equals("") ) {
	wherestr = wherestr + " and prod_id = '" + zlwlx + "'";
}
if ( !equip_sn.equals("") ) {
	wherestr = wherestr + " and equip_sn = '" + equip_sn + "'";
}

if(yf_date_start!=null&&!yf_date_start.equals("")){
	wherestr+=" and convert(varchar(10),sfk_plan_date,21)>='"+yf_date_start+"' ";
}
if(yf_date_end!=null&&!yf_date_end.equals("")){
	wherestr+=" and convert(varchar(10),sfk_plan_date,21)<='"+yf_date_end+"' ";
}
if(dz_date_start!=null&&!dz_date_start.equals("")){
	wherestr+=" and convert(varchar(10),sfk_fact_date,21)>='"+dz_date_start+"' ";
}
if(dz_date_end!=null&&!dz_date_end.equals("")){
	wherestr+=" and convert(varchar(10),sfk_fact_date,21)<='"+dz_date_end+"' ";
}

countSql = "select count(id) as amount from vi_zjfwy_detail where sfk_fact_date is not null "+wherestr+filterAgent;

%>		
			
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
   <tr>
	<td>代理商:<input name="dls" type="text" size="10" value="<%=dls %>" /></td>
	<td>项目&nbsp;&nbsp;编号: <input name="xmbh" type="text" size="10" value="<%=xmbh %>" /></td>
	<td>客户名称:&nbsp;<input name="khmc" type="text" size="10" value="<%=khmc %>"></td>
	<td>计划日期:
	<input name="yf_date_start" type="text"  size="10"   value="<%=yf_date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(yf_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="yf_date_end" type="text"  size="10"   value="<%=yf_date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(yf_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	 </td>
	 <td>
	 <input type="button" value="查询" onclick="dataNav.submit();"> 
	 </td>
   </tr>

   <tr>
	<td>制造商:<select name="zzs" style="width:80px;">
     <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
     </select>
	<td>租赁物类型:
	<select name="zlwlx" style="width:80px;">
     <script>w(mSetOpt('<%=zlwlx%>',"<%=prod_id_str%>"));</script>
     </select>
	 </td>
	<td>出厂编号:&nbsp;<input name="equip_sn" type="text" size="10" value="<%=equip_sn %>"></td>
	<td>到账日期:
	<input name="dz_date_start" type="text"  size="10"   value="<%=dz_date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(dz_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="dz_date_end" type="text"  size="10"   value="<%=dz_date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(dz_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td>
	 <input type="button" value="清空" onclick="clearQuery();">
	</td>
	</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
	<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		租赁公司收款列表（首期付款）
	</td>
	</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
			<!--操作按钮开始-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr class="maintab">
				</tr>
			</table>
			<!--操作按钮结束-->
		</td>
		<td align="right" width="90%">
		<!-- 翻页开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:100%" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
class="maintab_content_table">
	<tr class="maintab_content_table_title">							
      	 <th>项目编号</th>
		 <th>客户名称</th>
		 
		 <th>租赁物类型</th>
		 <th>制造商</th>
		 <th>机型</th>
		 <th>出厂编号</th>
		 <th>租赁物购买价款</th>
			 
		 <th>1起租租金</th>
		 <th>2保证金</th>
		 <th>3第一期租金</th>
		 <th>4保险费</th>
		 <th>5手续费</th>
		 <th>6担保费</th>
		 <th>7留购价款</th>
		 <th>首期付款合计</th>
		 <th>计划日期</th>
		 <th>到帐日期</th>
		 <th>付款单号</th>
	</tr>
<tbody id="data">
<%	  
//===变量定义==
String partSql = "";
ResultSet rs1 = null;
String vocher_id = "";//付款单号
//===========
String col_str="id,proj_id,khmc,dld,prod_id,model_id,equip_sn,manufacturer,equip_amt,qzzj,bzj,dyqzj,bxf,";
col_str+="dbf,sxf,lgjk,sfk_plan_date,sfk_fact_date,first_total_money,first_paytype,proj_status";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_zjfwy_detail where sfk_fact_date is not null and id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_zjfwy_detail where sfk_fact_date is not null "+wherestr+filterAgent+ " order by dld,id ) "+filterAgent+wherestr ;
sqlstr +=" order by dld,id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
	<tr>
       <td align="center"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="center"><%=getDBStr(rs.getString("khmc")) %></td>

		<td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
		<td align="center"><%=getDBStr(rs.getString("manufacturer")) %></td>
		<td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
		<td align="left"><%=getDBStr(rs.getString("equip_sn")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("equip_amt")) %></td>
	
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("qzzj")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("bzj")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("dyqzj")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("bxf")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("sxf")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("dbf")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("lgjk")) %></td>
	
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("first_total_money")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("sfk_plan_date")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("sfk_fact_date")) %></td>
		<%
		//付款单号
		partSql = "select voucher_id from vi_sfk_voucher where proj_id='"+rs.getString("proj_id")+"'";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			vocher_id = rs1.getString("voucher_id");
		}rs1.close();
		%>
		<td align="center"><%=getDBStr(vocher_id) %></td>
	</tr>
<% }
rs.close(); 
db.close();
%>
	</tbody>	
</table>
</div>
<!--报表结束-->
</form>		
</body>
</html>

