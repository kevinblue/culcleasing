<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���ʻ���ƻ����ֻ��</title>
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

<%
//��ȡ����drawings_id,doc_id
String drawings_id = getStr( request.getParameter("drawings_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//ģ�⸳ֵ
if( drawings_id==null || "".equals(drawings_id) ){
	drawings_id = "120316SDBBG0303";
	doc_id = "95BFC1F97E54D891482579C3001F465822";
}
//1.�ж�temp������jsp
sqlstr="select * from financing_refund_plan_temp where doc_id='"+doc_id+"' and drawings_id='"+drawings_id+"'";
//2.û�������
rs=db.executeQuery(sqlstr);
if(rs.next()==false){
	sqlstr="Insert into financing_refund_plan_temp(doc_id,drawings_id,refund_list,refund_plan_date,";
	sqlstr+= " refund_rate,refund_corpus,refund_interest,refund_money,refund_otherfee_money,refund_otherfee_type,";
	sqlstr+= "refund_subtotal,refund_status,remark)";
	sqlstr+="select '"+doc_id+"',drawings_id,refund_list,refund_plan_date, refund_rate,refund_corpus,refund_interest,"+
		"refund_money,refund_otherfee_money,refund_otherfee_type,refund_subtotal,refund_status,remark from financing_refund_plan where drawings_id='"+drawings_id+"'";
		System.out.println("û�в���"+sqlstr);
		db.executeUpdate(sqlstr);
}


%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<form action="fund_exec_list.jsp" name="dataNav" onSubmit="return goPage()">
<!-- ����ƻ��ƶ� -->
<div style="margin-top: 10px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp; 
	����ƻ����&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="��ʾ/��������">				 
</div> 

<div id="refund_plan" style="margin-top: 10px;">
<!--������Ͳ�������ʼ-->

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
</form>
</body>

<script type="text/javascript">

//����ϴ�����ƻ�
function uploadNewRefund(){
	window.open("refund_upload.jsp?drawings_id=<%=drawings_id %>&doc_id=<%=doc_id %>");
}
</script>

</html>
