<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>提款手续费维护</title>
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

<form action="financing_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		融资管理&gt; 手续费维护</td>
	</tr>
</table>
<!--标题结束-->

<%
wherestr = " ";
//本页查询参数
String crediter = getStr( request.getParameter("crediter") );

if ( crediter!=null && !"".equals(crediter) ) {
	wherestr += " and crediter like '%" + crediter + "%'";
}

//暂不区分投保租赁物件数量

countSql = "select count(id) as amount from dbo.vi_financing_factorage_config where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>银行&nbsp;<input name="crediter"  type="text" size="15" value="<%=crediter %>">
<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','','银行名称','(select distinct crediter as crediter from financing_credit ) a ','crediter','','crediter','crediter','asc','dataNav.crediter','');">
</td>

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
		<th>提款银行</th>
		<th>提款编号</th>
		<th>提款金额</th>
		<th>提款日期</th>
		<th>提款结束日</th>
        <th>操作</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_financing_factorage_config where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_financing_factorage_config where 1=1 "+wherestr+" order by id) "+wherestr+" order by id" ;
System.out.println("aaa"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("crediter")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("drawings_id")) %></td>	
		<td align="center"><%=CurrencyUtil.convertFinance( rs.getString("drawings_money")) %></td>	
		<td align="left"><%=getDBDateStr( rs.getString("drawings_date")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("drawings_end_date")) %></td>	
      	<td align="center">
			<a href="financing_factorage_list.jsp?drawings_id=<%=getDBStr( rs.getString("drawings_id")) %>"  target="_blank">查看手续费</a>
		</td>
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
