<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>每日日报</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<form action="diarylog.jsp" name="dataNav" onSubmit="return goPage()">
<%

countSql = "select count(id) as amount from SYS_diary_log where 1=1 "+wherestr;

%>
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		项目进程日报表</td>
	</tr>
</table>

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		<td  width="50%">
		</td>

		<!-- 翻页控制开始 -->
		<td align="right" width="40%">
		<%@ include file="../../public/pageSplit.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>主题</th>
		<th>提交人</th>
		<th>来源</th>
		<th>提交时间</th>
      </tr>
      <tbody id="data">
<%
//sqlstr = "select * from SYS_diary_log order by create_date desc";

sqlstr = "select top "+ intPageSize +" * from SYS_diary_log where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from SYS_diary_log where 1=1 "+wherestr+" order by id desc ) "+wherestr ;
sqlstr +=" order by id desc ";

String source = "";
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
	source=getDBStr( rs.getString("source"));
%>
      <tr>
		<td align="center">
		<%
		if(source.equals("项目进程日报")){
		 %>
		<a target="_blank" href="main.jsp?loadtime=<%=getDBDateStr( rs.getString("create_date")) %>"><%=getDBStr( rs.getString("title")) %></a>
		<%} else{%>
		<a target="_blank" href="diarylog_nb.jsp?loadtime=<%=getDBDateStr( rs.getString("create_date")) %>"><%=getDBStr( rs.getString("title")) %></a>
		<%
		}
		 %>
		</td>
		<td align="center"><%=getDBStr( rs.getString("subperson")) %></td>
		<td align="center"><%=getDBStr( rs.getString("source")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("create_date")) %></td>		
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
