<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ - ��𳥻��ƻ�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
	String proj_id = getStr(request.getParameter("proj_id"));//��Ŀ���
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����
%>
 
<body  onload="public_onload(0);">
 <div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">

<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" 
    	cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>����</th>
		<th>Ӧ������</th>
        <th>���</th>
        <th>����</th>
        <th>��Ϣ</th>
        <th>�������</th>      
      </tr>
<%	  
	//---��ѯ���ƻ�--
	sqlstr = "select rent_list,plan_date,rent,corpus,interest,corpus_overage from fund_rent_plan_proj_bd_medi_temp ";
	sqlstr += " where proj_id='"+proj_id+"' and doc_id='"+doc_id+"' order by rent_list";
	System.out.println("ҽ�ƹ��� ��Ŀ ���ƻ� -- sqlstr��ѯsql���==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
	while(rs.next()) {
%>
      <tr class="maintab_content_table_title">
		<td><%=CurrencyUtil.convertIntAmount(rs.getString("rent_list")) %></td> 
		<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("rent")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("corpus")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("interest")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("corpus_overage")) %></td> 
      </tr>
<%
	}
db.close();
%>
 </table>
</div>
</div>

</body>
<script type="text/javascript">
function updData(){
	window.open("rentplan_list_read_upload.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>");
}
</script>
</html>
