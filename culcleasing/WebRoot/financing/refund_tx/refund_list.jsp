<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���ʻ���������Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="refund_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">���ʻ���������Ϣ</td>
  </tr>
</table>
<!--�������-->
<%
String crediter = getStr( request.getParameter("crediter") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));


if ( crediter!=null && !crediter.equals("") ) {
	wherestr += " and crediter like '%" + crediter + "%'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),refund_plan_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),refund_plan_date,21)<='"+end_date+"' ";
}

countSql = "select count(id) as amount from vi_fina_refund_execmod where 1=1 "+wherestr;

//��������2--���ݵ���
String expsqlstr = "select id ��ʶ�ֶ�,refund_list ����,crediter ���ŵ�λ,refund_plan_date ��������,refund_corpus �������,refund_interest ��Ϣ���,refund_money ��Ϣ�ϼ�,"+
 "refund_otherfee_money �������ý��,refund_otherfee_type �����������,refund_subtotal ���λ����ܼ�,remark ��ע from vi_fina_refund_execmod where 1=1"+wherestr;
 
%>
<!--���۵���ѯ��ʼ-->

<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>���ŵ�λ:&nbsp;<input name="crediter"  type="text" size="15" value="<%=crediter %>"></td>
<td>�ƻ�����:&nbsp;
<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;��&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>
<input type="button" value="��ѯ" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="���" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			<td>
			<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
			<input name="excel_name" type="hidden" value="refund_list_tx">
			
			<a href="#" accesskey="n" onclick="return validata_data_report('../../func/exp_report.jsp','refund_list.jsp');">
		    <img align="absmiddle"  src="../../images/action_down.gif" alt="����" align="absmiddle">��������ƻ�</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		
			<td>
			<a href="#" accesskey="n" onClick="uploadNewRefund()">
		    <img align="absmiddle"  src="../../images/action_up.gif" alt="����" align="absmiddle">�ϴ�����ƻ�</a></td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	<!-- ��ҳ���ƿ�ʼ -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--��ҳ���ƽ���-->	
	</td>		 	
 </tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>����</th>
     <th>���ŵ�λ</th>
     <th>��������</th>
     <th>�������</th>
     <th>��Ϣ���</th>
     <th>��Ϣ�ϼ�</th>
     <th>�������ý��</th>
     <th>�����������</th>
     <th>���λ����ܼ�</th>
     <th>��ע</th>
   </tr>
   <tbody id="data">
<%

String col_str="id,refund_list,crediter,refund_plan_date,refund_rate,refund_corpus";
col_str += ",refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,remark";

//sqlstr = "select top  top "+ intPageSize +" "+col_str+" from vi_fina_refund_execmod where 1=1"+wherestr;


sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_fina_refund_execmod where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_fina_refund_execmod where 1=1 "+wherestr+" order by id) "+wherestr ;
sqlstr +=" order by id ";
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("refund_list")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("crediter")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("refund_plan_date")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_corpus")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_interest")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_money")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_otherfee_money")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("refund_otherfee_type")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("refund_subtotal")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     </tr>
<%}
db.close();
%>     
	</tbody>
</table>
</div>
</div>
</form>
</body>

<script type="text/javascript">
//����ϴ�����ƻ�
function uploadNewRefund(){
	window.open("refund_upload.jsp");
}
</script>

</html>
