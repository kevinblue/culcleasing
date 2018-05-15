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
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
	//���ƻ�
	String contract_id = getStr( request.getParameter("contract_id") );
	String begin_id = getStr(request.getParameter("begin_id"));//��ͬ���
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����

	

	//��ѯ��𱾽���Ϣ�������ֱ���ܺ�
	String  count_rent = "";
	String  count_corpus = "";
	String  count_interest = "";
	
	String query_count = "";
	query_count = "select sum(rent) as count_rent,sum(corpus) as count_corpus,sum(interest) as count_interest from fund_rent_plan_temp where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	
	rs = db.executeQuery(query_count);
	if(rs.next()){
		count_rent = formatNumberDoubleTwo(getDBStr(rs.getString("count_rent")));
		count_corpus = formatNumberDoubleTwo(getDBStr(rs.getString("count_corpus")));
		count_interest = formatNumberDoubleTwo(getDBStr(rs.getString("count_interest")));
	}
	rs.close();
 %>
 
<body onload="public_onload(0);">

<form action="plan_bank_upsave.jsp" name="form1" onSubmit="return goPage()">
<input type="hidden" name="begin_id" value="<%=begin_id%>">
<input type="hidden" name="doc_id" value="<%=doc_id%>">
	<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
	<!--���۵���ѯ��ʼ-->
	<div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;�����޸�
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
	</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>��:&nbsp;<input name="start_list"  type="text" size="13" ></td>
	<td>��:&nbsp;<input name="end_list"  type="text" size="13" ></td>
	<td scope="row" id="bj_4">�ƻ��տ������˺��޸�Ϊ:</td>
    <td scope="row">
		    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly" style="width: 100">
		    <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  
			style="cursor:pointer" onclick="popUpWindow('plan_bank_info.jsp',250,350)" >
			
   </td>
		    <td scope="row" id="bj_3">�ƻ��տ�������޸�Ϊ:</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly" style="width: 100" >
   </td>
   <td>
	<input type="button" value="ȷ��" onclick="form1.submit();">
	&nbsp;&nbsp;
	<input type="button" value="���" onclick="clearQuery();" >
	</td>
	</tr>
	</table>
	</fieldset>
	</div>
	<!--���۵���ѯ����-->
	
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" 
	cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>����</th>
		<th>Ӧ������</th>
        <th>���</th>
        <th>����</th>
        <th>��Ϣ</th>
        <th>״̬</th>
        <th>�������</th>      
        <th>�ƻ��տ�����</th>      
        <th>�ƻ��տ��˺�</th>   
		<th>����</th>
      </tr>
<%	  
	//---��ѯ���ƻ�--
	sqlstr = "select id,rent_list,plan_date,rent,plan_status,corpus,interest,corpus_overage,plan_bank_name,plan_bank_no from fund_rent_plan_temp ";
	sqlstr += " where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' order by rent_list";
	LogWriter.logDebug(request, "���� - ���ƻ� -- sqlstr��ѯsql���==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
	while(rs.next()) {
%>
      <tr class="maintab_content_table_title">
		<td><%=CurrencyUtil.convertIntAmount(rs.getString("rent_list")) %></td> 
		<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("rent")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("corpus")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("interest")) %></td> 
		<td><%=getDBStr(rs.getString("plan_status")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("corpus_overage")) %></td> 
		<td><%=getDBStr(rs.getString("plan_bank_name")) %></td> 
		<td><%=getDBStr(rs.getString("plan_bank_no")) %></td> 
		<td>
		<%
		if(getDBStr(rs.getString("plan_status")).equals("δ����")){
		%><a href='fund_rentUpd.jsp?item_id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�</a>
		<%}else{%>
		�޲���
		<%}%>
		</td> 
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
</form>
</body>
</html>
