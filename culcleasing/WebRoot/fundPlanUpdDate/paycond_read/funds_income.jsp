<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ���֧һ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">



</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);" style="overflow:auto;">

<%
String contract_id=getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String whereStr = "" ;

if ( contract_id!=null && !contract_id.equals("") ) {
	whereStr = " and contract_id = '" + contract_id + "'";
}


%>

<form action="funds_income.jsp" name="dataNav">

  <!--����ʼ-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  class="maintab_content_table" >
      <tr class="maintab_content_table_title">
        <th width="1%"></th>
	    <th>��������</th>
	    <th>�ڴ�</th>
     	<th>��������</th>
 		<th>���ʽ</th>
		<th>���㷽ʽ</th>
		<th>�ƻ���������</th>
	    <th>�ƻ�������</th>
	    <th>��/������</th>
     	<th>�ո�״̬</th>
 		<th>��ע</th>
      </tr>
      <tbody id="data">
<%
String col_str="*";
int i = 0;

sqlstr = "select * from vi_funds_income_table where 1=1"+ whereStr +"order by contract_id" ; 
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
i=i+1;
	%>

<%
%>
      <tr>
        <td align="center"><%=i%></td>
		<td align="center"><%=getDBStr(rs.getString("feetype_name"))%></td>
		<td align="center"><%=getDBStr(rs.getString("fee_num"))%></td>
        <td align="center"><%=getDBStr(rs.getString("fee_name"))%></td>
        <td align="center"><%=getDBStr(rs.getString("pay_way"))%></td>
		<td align="center"><%=getDBStr(rs.getString("pay_type_name"))%></td>
		<td align="center"><%=getDBStr(rs.getString("plan_date"))%></td>
		<td align="center"><%=getDBStr(rs.getString("plan_money"))%></td>
		<td align="center"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="center"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="center"><%=getDBStr(rs.getString("fpnote"))%></td>
      </tr>

<%
}

rs.close(); 
db.close();
%>


</tbody>


</table>
</div><!--�������-->
</form>
</body>
</html>
