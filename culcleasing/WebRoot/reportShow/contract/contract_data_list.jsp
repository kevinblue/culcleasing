<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="ebank_data_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		网银挂账 &gt; 网银数据明细</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = "";

//外参数传递过来
String up_id = getStr( request.getParameter("up_id") );
//本页查询参数
String client_name = getStr( request.getParameter("client_name") );
String status = getStr( request.getParameter("status") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );


if ( up_id!=null && !up_id.equals("") ) {
	wherestr += " and up_id = '" + up_id + "'";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {
	wherestr = wherestr + " and " + searchFld + " like '%" + searchKey + "%'";
}
if ( client_name!=null && !client_name.equals("") ) {
	wherestr += " and client_name like '%" + client_name + "%'";
}
if ( status!=null && !status.equals("") ) {
	wherestr += " and status ='" + status + "'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),upload_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),upload_date,21)<='"+end_date+"' ";
}

countSql = "select count(ebdata_id) as amount from fund_ebank_data where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>付款人:&nbsp;<input name="client_name"  type="text" size="15" value="<%=client_name %>"></td>

<td nowrap>
&nbsp;按&nbsp;
<select name="searchFld">
<script type="text/javascript">
w(mSetOpt("<%= searchFld %>","|网银编号|付款账号|收款账号",
"|fund_ebank_data.ebdata_id|fund_ebank_data.client_acc_number|fund_ebank_data.own_acc_number"));
</script>
</select>&nbsp;查询<input name="searchKey" accesskey="s" type="text" size="15" value="<%=searchKey %>">
</td>

<td>
状态:&nbsp;
<select name="status">
  <script type="text/javascript">
   	w(mSetOpt('<%=status %>',"|有效|无效","|0|1"));
  </script>
</select>
</td>

<td>上传日期:&nbsp;
<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;至&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>
<input type="button" value="查询" onclick="dataNav.submit();">
<input type="hidden" name="up_id" value="<%=up_id %>">
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
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td><a href="#" accesskey="m" onclick="dataHander('mod','ebank_mod.jsp?czid=',dataNav.itemselect);">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" >修改</a></td>
	    </tr>
	</table>
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
	    <th width="1%"></th>
		<th>网银编号</th>
		
        <th>到账银行</th>
        <th>到账账号</th>
        <th>付款账号</th>
        
        <th>付款客户</th>
        <th>到账金额类型</th>
        <th>到帐时间</th>
        
        <th>到帐金额</th>
        <th>已使用金额</th>
        <th>可核销金额</th>
        
        <th>摘要</th>
        <th>状态</th>
        <th>上传时间</th>
        <th>租赁相关标志</th>
      </tr>
      <tbody id="data">
<%
String col_str="ebdata_id,up_id,own_bank,own_account,own_acc_number,client_bank,client_account,client_acc_number,client_name,money_type,";
col_str += "fact_money,fact_date,used_money,left_money,sn,status,business_flag,summary,upload_date";

sqlstr = "select top "+ intPageSize +" "+col_str+" from fund_ebank_data where ebdata_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" ebdata_id from fund_ebank_data where 1=1 "+wherestr+" order by ebdata_id,upload_date desc ) "+wherestr ;
sqlstr += " order by ebdata_id,upload_date desc ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("ebdata_id") ) %>"></td>
		<td align="left"><%=getDBStr( rs.getString("ebdata_id")) %></td>	
		
		<td align="center"><%=getDBStr( rs.getString("own_bank")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("own_acc_number")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("client_acc_number")) %></td>	
		
		<td align="center"><%=getDBStr( rs.getString("client_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("money_type")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("fact_date")) %></td>	
		
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("fact_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("used_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("left_money" )) %></td>	

		
		<td align="left"><%= getDBStr( rs.getString("summary")) %></td>	
		<!-- 状态，0表示未核销 1核销完 -->
		<td align="left"><%= "0".equals(rs.getString("status"))?"有效":"无效" %></td>	
		<td align="left"><%= getDBDateStr( rs.getString("upload_date")) %></td>	
		<!-- 租赁相关标志，0表示有关 1没关 -->
		<td align="left"><%= "0".equals(rs.getString("business_flag"))?"有关":"没关" %></td>	
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
