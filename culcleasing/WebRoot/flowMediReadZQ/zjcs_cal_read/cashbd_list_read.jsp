<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����ֽ����б�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
	String proj_id = getStr(request.getParameter("proj_id"));//��Ŀ���
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����
	
	//�г��ֽ���
	sqlstr = " select * from fund_cash_medi_bd_temp";
	sqlstr +=" where proj_id='"+proj_id+"' and doc_id='"+doc_id+"' order by id"; 
	rs = db.executeQuery(sqlstr);
	if(rs.next()==false){
		String sqlstr1="INSERT INTO fund_cash_medi_bd_temp(doc_id,proj_id,bd_month,bd_hire_date,cash_money)"+
			"SELECT '"+doc_id+"',proj_id,bd_month,bd_hire_date,cash_money FROM fund_cash_medi_bd WHERE proj_id='"+proj_id+"'";
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
		<td align="center"><%=getDBStr(rs.getString("bd_month"))%></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("bd_hire_date"))%></td>
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
	  		��Ŀ���Ϊ:<%=proj_id%>&nbsp;|&nbsp;�ĵ����Ϊ:<%=doc_id%>&nbsp;
	  	</font>
	  	</td>
	 </tr>
   </table>
</div>
</div>

</body>
<script type="text/javascript">
function updData(){
	window.open("cash_upload.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>&type=bd");
}
</script>
</html>
