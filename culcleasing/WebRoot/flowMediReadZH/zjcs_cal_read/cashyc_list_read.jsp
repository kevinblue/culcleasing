<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Ԥ���ֽ����б�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
	String contract_id = getStr(request.getParameter("contract_id"));//��ͬ���
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����
	
	//�г��ֽ���
	sqlstr = " select * from fund_cash_medi_yc_con_temp";
	sqlstr +=" where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by id"; 
	System.out.println("��ͬ�ֽ��� -- sqlstr��ѯsql���==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
	if(rs.next()==false){
		String sqlstr1="INSERT INTO fund_cash_medi_yc_con_temp(doc_id,contract_id,yc_month,yc_hire_date,cash_money)"+
			"SELECT '"+doc_id+"',contract_id,yc_month,yc_hire_date,cash_money FROM fund_cash_medi_yc_con WHERE contract_id='"+contract_id+"'";
			db.executeUpdate(sqlstr1);
				System.out.println("ˢ���� "+sqlstr1);
	}
	rs = db.executeQuery(sqlstr);
%>

<body  onload="public_onload(0);">

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">


<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th>����</th>
	    <th>�·�</th>
		<th>������</th>
		<th>������</th>   
      </tr>
<%	  
	int i = 1;
	while(rs.next()) {
%>
      <tr>
		<td nowrap align="center"><%=i%></td>
		<td align="center"><%=getDBStr(rs.getString("yc_month"))%></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("yc_hire_date"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("cash_money")),"#,##0.00")%></td>		
      </tr>
<%
		i++;
	}
rs.close(); 
db.close();
%>
	 <tr>
	  	<td nowrap align="left" colspan="7">
	  	<font color="red">
	  		��ͬ���Ϊ:<%=contract_id%>&nbsp;|&nbsp;�ĵ����Ϊ:<%=doc_id%>&nbsp;
	  	</font>
	  	</td>
	 </tr>
   </table>
</div>
</div>

</body>
<script type="text/javascript">
function updData(){
	window.open("cash_upload.jsp?contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&type=yc");
}
</script>
</html>
