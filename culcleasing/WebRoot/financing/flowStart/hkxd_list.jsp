<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����޶�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>
<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- �������� -->
<%@ include file="../../public/selectDataFina.jsp"%>
<!-- �������� -->


<%
String crediter = getStr( request.getParameter("crediter") );
String start_date = getStr( request.getParameter("start_date") );
String end_date = getStr( request.getParameter("end_date") );
String start_date1 = getStr( request.getParameter("start_date1") );
String end_date1 = getStr( request.getParameter("end_date1") );
String drawings_type = getStr( request.getParameter("drawings_type") );

if ( crediter!=null && !"".equals(crediter) ) {
	wherestr += " and crediter like '%" + crediter + "%'";
}
if ( start_date!=null && !start_date.equals("") ) {
	wherestr += " and convert(varchar(10),refund_plan_date,21)>='" + start_date+"'";
}
if ( end_date!=null && !end_date.equals("") ) {
	wherestr += " and convert(varchar(10),refund_plan_date,21)<='" + end_date+"'";
}
if ( start_date1!=null && !start_date1.equals("") ) {
	wherestr += " and convert(varchar(10),refund_fact_date,21)>='" + start_date1+"'";
}
if ( end_date1!=null && !end_date1.equals("") ) {
	wherestr += " and convert(varchar(10),refund_fact_date,21)<='" + end_date1+"'";
}
if ( drawings_type!=null && !"".equals(drawings_type) ) {
	wherestr += " and drawings_type like '%" + drawings_type + "%'";
}

countSql = "select count(fri.id) as amount from financing_refund_income fri"+
		   " LEFT JOIN financing_drawings fd ON fd.drawings_id=fri.drawings_id"+
		   " LEFT JOIN financing_credit fc ON fc.credit_id=fd.credit_id where 1=1 "+wherestr;

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<form action="hkxd_list.jsp" name="dataNav" onSubmit="return goPage()">
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">


<tr>
<td>���ŵ�λ:&nbsp;

<select name="crediter" id="crediter" style="width: 130px;">
	<script type="text/javascript">
		w(mSetOpt("<%=crediter %>","<%=unit_name_str %>","<%=unit_name_str %>"));
	</script>
</select>

</td>


<td>�ƻ���������:&nbsp;<input id="start_date" name="start_date" type="text" readonly Require="ture" value="<%=start_date %>" size="11">
	<img onClick="openCalendar(start_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
��:&nbsp;
 <input id="end_date" name="end_date" type="text" readonly Require="ture" value="<%=end_date %>" size="11">
	<img onClick="openCalendar(end_date);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
<td>

<td>
<input type="button" value="��ѯ" onclick="dataNav.submit();">
</td>
</tr>

<tr>
<td>��������:&nbsp;
<select name="drawings_type" id="drawings_type" style="width: 130px;">
	<script type="text/javascript">
		w(mSetOpt("<%=drawings_type %>","<%=loan_name_str %>","<%=loan_name_str %>"));
	</script>
</select>
</td>


<td>ʵ�ʻ�������:&nbsp;<input id="start_date1" name="start_date1" type="text" readonly Require="ture" value="<%=start_date1 %>" size="11">
	<img onClick="openCalendar(start_date1);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
��:&nbsp;
 <input id="end_date1" name="end_date1" type="text" readonly Require="ture" value="<%=end_date1 %>" size="11">
	<img onClick="openCalendar(end_date1);return false;" style="cursor:pointer; " 
	src="../../images/fdmo_63.gif" border="0" align="absmiddle">
<td>

<td>
<input type="button" value="���" onclick="clearQuery();" >
</td>

</tr>

</table>
</fieldset>
</div>
<div style="margin-top: 0px;">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    <td align="left" width="80%">
	<!--������ť��ʼ-->
	
	<!--������ť����-->
	</td>
		<!-- ��ҳ���� -->
		<td align="right">
		<%@ include file="../../public/pageSplit.jsp"%>
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>���</th>
     <th>���ŵ�λ</th>
     <th>��������</th>
     <th>�ƻ���������</th>
     <th>��������</th>
     <th>ʵ�ʻ�������</th>
     <th>����</th>
     <th>��Ϣ</th>
     <th>������</th>
     <th>��������</th>
     <th>������������</th>
     <th>����</th>
   </tr>
   <tbody id="data">
<%
int i=1;
sqlstr = "SELECT top "+ intPageSize +" fri.*,fc.crediter,fc.credit_type,fd.drawings_type FROM financing_refund_income fri "+
		"LEFT JOIN financing_drawings fd ON fd.drawings_id=fri.drawings_id"+
		" LEFT JOIN financing_credit fc ON fc.credit_id=fd.credit_id where fri.id not in "+
		"(select top "+ (intPage-1)*intPageSize +" fri.id from financing_refund_income fri where 1=1 "+wherestr+" order by fri.id)"+wherestr+" order by fri.id";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=i %></td>
     	<td align="center"><%=getDBStr(rs.getString("crediter")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("drawings_type")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("refund_plan_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("refund_rate")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("refund_fact_date")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("refund_corpus")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("refund_interest")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("refund_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("refund_otherfee_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("refund_otherfee_type")) %></td>
     	
     	<td align="center">
     	<a href='hkxd_upd.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�</a>
     	
     	</td>
     </tr>
<%
i++;
}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
</form>
</body>
</html>
<%if(null != db){db.close();}%>