<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险公司</title>
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

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->


<body onLoad="public_onload(0);">
<form action="insurance_company.jsp" name="dataNav">

<%
countSql = "select count(cust_id) as amount from cust_info where cust_name like '%保险%' ";

%>
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
     <td><a href="#" accesskey="n" onClick="dataHander('add','insurance_company_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle">新&nbsp;增</a>&nbsp;</td> 
    
      <td align="left" width="90%" rowspan="2"><!--操作按钮开始-->
  
        <!--操作按钮结束--></td>
        <td align="right" width="20%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--翻页控制结束-->
  
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%">保险公司编号</th>
	    <th>保险公司名称</th>
	    <th>简称</th>
	    <th>类型</th>
	    <th>南北编码</th>
      </tr>
      <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" "+col_str+" from cust_info where cust_name like '%保险%' and id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from cust_info where cust_name like '%保险%'  order by id,create_date desc ) " ;
sqlstr += " order by id,create_date desc ";

LogWriter.logDebug(request, "保险信息###"+sqlstr);

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
		<td align="center"><%=getDBStr( rs.getString("cust_id") ) %></td>
		
		<td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("cust_ename") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("cust_type") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("finance_code") ) %></td>
      </tr>
<%}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- 报表结束 -->

</form>
</body>
</html>
