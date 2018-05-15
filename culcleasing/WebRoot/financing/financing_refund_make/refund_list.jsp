<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����ƻ��ƶ�</title>
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

<%
//��ȡ����drawings_id,doc_id
String drawings_id = getStr( request.getParameter("drawings_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//ģ�⸳ֵ
if( drawings_id==null || "".equals(drawings_id) ){
	drawings_id = "111011ICBC8808";
	doc_id = "03E883C7859B76C9482579290013EF48";
}

%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<!-- ����ƻ��ƶ� -->
<div style="margin-top: 10px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	����ƻ�&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="��ʾ/��������">				 
</div> 

<div id="refund_plan" style="margin-top: 10px;">
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="40%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td>
			    <!-- 
			    <BUTTON class="btn_2" type="button" onclick="addNewRefund();">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="����(Alt+N)">&nbsp;��������ƻ�</BUTTON>
			     -->
			    <BUTTON class="btn_2" type="button" onclick="autoRefundMake();">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="�Զ�(Alt+N)">&nbsp;�Զ����㻹��</BUTTON>
				&nbsp;&nbsp;&nbsp;
				<BUTTON class="btn_2" type="button" onclick="uploadNewRefund();">
				<img src="../../images/fdmo_23.gif" align="absmiddle" border="0" alt="�ϴ�(AltU)">&nbsp;�ϴ�����ƻ�</BUTTON>
			</td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	</td>		 	
	<!--��ҳ���ƽ���-->	
 </tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>����</th>
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
String col_str="refund_plan_id,refund_list,refund_plan_date,refund_rate,refund_corpus";
col_str += ",refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,remark";

sqlstr = "select "+col_str+" from financing_refund_plan_temp where drawings_id='"+drawings_id+"' and doc_id='"+doc_id+"' order by refund_list";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("refund_list")) %></td>
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
</div><!-- ��������ƻ�div -->

</body>

<script type="text/javascript">
//�����������ƻ�
function addNewRefund(){
	window.open("refund_add.jsp?drawings_id=<%=drawings_id %>&doc_id=<%=doc_id %>");
}
//����Զ�����ƻ�
function autoRefundMake(){
	window.open("refund_autoAdd.jsp?drawings_id=<%=drawings_id %>&doc_id=<%=doc_id %>");
}
//����ϴ�����ƻ�
function uploadNewRefund(){
	window.open("refund_upload.jsp?drawings_id=<%=drawings_id %>&doc_id=<%=doc_id %>");
}
</script>

</html>
