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
	String contract_id = getStr(request.getParameter("contract_id"));//��ͬ���
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����

	//��ѯ��𱾽���Ϣ�������ֱ���ܺ�
	String  count_rent = "";
	String  count_corpus = "";
	String  count_interest = "";
	
	String query_count = "";
	query_count = "select sum(rent) as count_rent,sum(corpus) as count_corpus,sum(interest) as count_interest from fund_rent_plan_contract_temp  where  contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
	
	rs = db.executeQuery(query_count);
	if(rs.next()){
		count_rent = formatNumberDoubleTwo(getDBStr(rs.getString("count_rent")));
		count_corpus = formatNumberDoubleTwo(getDBStr(rs.getString("count_corpus")));
		count_interest = formatNumberDoubleTwo(getDBStr(rs.getString("count_interest")));
	}
	rs.close();
 %>
 
<body  onload="public_onload(0);">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
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
	sqlstr = "select rent_list,plan_date,rent,corpus,interest,corpus_overage from fund_rent_plan_contract_temp ";
	sqlstr += " where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by rent_list";
	System.out.println("���ƻ� -- sqlstr��ѯsql���==>> "+sqlstr);
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
	<tr class="maintab_content_table_title" > 
		<td colspan="">&nbsp;</td>
		<td colspan="">&nbsp;</td>
		<td colspan="">�ϼ�:<%=formatNumberStr( count_rent,"#,##0.00") %></td>
		<td colspan="">�ϼ�:<%=formatNumberStr( count_corpus,"#,##0.00") %></td>
		<td colspan="">�ϼ�:<%=formatNumberStr( count_interest,"#,##0.00") %></td>
		<td colspan="">&nbsp;</td>
	</tr>
   </table>
</div>
</div>

</body>
</html>