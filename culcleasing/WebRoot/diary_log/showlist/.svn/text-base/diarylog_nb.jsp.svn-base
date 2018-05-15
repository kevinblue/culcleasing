<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>没有南北编码的记录明细</title>
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

<form action="diarylog_nb.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<!--标题结束-->

<%
String loadtime=getStr(request.getParameter("loadtime"));
LogWriter.logDebug(request,"我需要的loadtime2:"+loadtime);

wherestr += " and datediff(dd,create_date,'"+loadtime+"')=0 ";//显示当天数据

countSql = "select count(id) as amount from SYS_diary_log_nb where 1=1"+wherestr;


//导出类型2--数据导出
String expsqlstr = "select log_type 缺失类型,log_title 项目名称,log_name 名称,log_ex_name 缺少对象 from SYS_diary_log_nb where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<!--可折叠查询结束-->

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
      	<td align="left" width="10%">
		<!--操作按钮开始-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="DiaryLog">
		<input name="loadtime" type="hidden" value="<%=loadtime %>">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','diarylog_nb.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
	    <!--操作按钮结束-->
	   </td>

        <td align="right" width="80%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--翻页控制结束-->
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>缺失类型</th>
		<th>项目名称</th>
		<th>名称</th>	
		<th>缺少对象</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from SYS_diary_log_nb where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from SYS_diary_log_nb where 1=1 "+wherestr+" order by id desc ) "+wherestr ;
sqlstr += " order by id desc ";
LogWriter.logDebug(request,"我需要的sqlstr4:"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td><%=getDBStr(rs.getString("log_type")) %></td>
		<td><%=getDBStr(rs.getString("log_title")) %></td>
		<td><%=getDBStr(rs.getString("log_name")) %></td>
		<td><%=getDBStr(rs.getString("log_ex_name")) %></td>
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
