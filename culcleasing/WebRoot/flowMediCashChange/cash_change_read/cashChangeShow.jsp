<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Ԥ���ֽ������ǰ��Ա�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<table border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;margin-left: 10px;">
    <tr>
        <td style="color:#E46344;font-size: 16px;font-weight: bold">Ԥ���ֽ������ǰ��Ա�</td>
    </tr>
</table>
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;"  id="mydiv">

<% 
    String contract_id = getStr(request.getParameter("contract_id"));//��ͬ���
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����
%>

<form name="list">
	<table align="center" width="100%">
	  <tr><td colspan="2">
		<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
		  
		  <tr height="2%">
			  <td width="50%">���ǰ</td>
			  <td width="50%">�����</td>
		  </tr>
		</table>
		</td>
	  </tr>		
	  
      <tr>
	  <!-- $$$$$$$$$$$$$$- ���ǰ�����ƻ� -$$$$$$$$$$$$$$ -->
	  <td width="50%" valign="top">
		  <table border="0" style="border-collapse:collapse;overflow: auto;" align="left" cellpadding="2" 
		  	cellspacing="1" width="100%" 
		  	class="maintab_content_table">
				 <tr class="cwDLHead">
					 <th>����</th>
					 <th>�·�</th>
					 <th>������</th>
				     <th>������</th>
				  </tr>
				  <tbody id="data">
				  <%
					sqlstr = "select * from fund_cash_medi_yc_con_temp where contract_id='"+contract_id+"' and remark='Ԥ���ֽ����޶�ǰ' and doc_id='"+doc_id+"'";
					rs = db.executeQuery(sqlstr);
					int i=1;
					while(rs.next()) {
				  %>
				  <tr>
					<td nowrap align="center"><%=i %></td>
					<td align="center"><%=getDBStr(rs.getString("yc_month"))%></td>
			      	<td nowrap align="center"><%=getDBDateStr(rs.getString("yc_hire_date"))%></td>
					<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("cash_money")),"#,##0.00")%></td>		
				  </tr>
				  <%i++;
				  }
				  
				  	rs.close();
				  %>
				  </tbody>
			  </table>
		  </td>
		
		  <!-- $$$$$$$$$$$$$$- ����󳥻��ƻ� -$$$$$$$$$$$$$$ -->
		  <td width="50%" valign="top">
		  	<table border="0" style="border-collapse:collapse;overflow: auto;" align="center" 
		  		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>����</th>
					 <th>�·�</th>
					 <th>������</th>
				     <th>������</th>
					<!-- 
					<th>״̬</th>
					-->
					
				  </tr>
				  <tbody id="data">
				  <%
				  ResultSet rs1=null;
				  String sqlstr1="";
					sqlstr1 = "select * from fund_cash_medi_yc_con_temp ";
					sqlstr1 += " where contract_id='"+contract_id+"' and remark='Ԥ���ֽ����޶���' and doc_id='"+doc_id+"'";
					rs1= db.executeQuery(sqlstr1);
					int j=1;
				  	while (rs1.next()) {
				  %>
				  <tr>
					<td nowrap align="center"><%=j %></td>
					<td align="center"><%=getDBStr(rs1.getString("yc_month"))%></td>
			      	<td nowrap align="center"><%=getDBDateStr(rs1.getString("yc_hire_date"))%></td>
					<td nowrap align="center"><%=formatNumberStr(getDBStr(rs1.getString("cash_money")),"#,##0.00")%></td>
				  </tr>
				  <%
				  j++;
				  	}
				  	
				  	db.close();
				  %>
				  </tbody>
			  </table>
		  </td>
      </tr>
    </table>
</form>
</div>
</body>
<script type="text/javascript">
function updData(){
	window.open("cash_upload.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&type=yc");
}

</script>
</html>
