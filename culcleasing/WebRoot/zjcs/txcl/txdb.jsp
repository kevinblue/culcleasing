<%@ page contentType="text/html; charset=gbk" language="java"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣǰ��Ա�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td id="cwTopTitLeft"></td>
        <td id="cwTopTitTxt">��Ϣǰ��Ա�</td>
        <td id="cwTopTitRight"></td>
    </tr>
</table>
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
<%
	String proj_id = getStr(request.getParameter("proj_id"));
	String txid = getStr(request.getParameter("txid"));
	
	String sqlstr;
	ResultSet rs;
	
	String start_date="";
	String rent_list_start="";
	String adjust_amt="";
	
	sqlstr="select base_adjust_interest.start_date,adjust_interest_proj.rent_list_start,adjust_interest_proj.adjust_amt from adjust_interest_proj left join base_adjust_interest on adjust_interest_proj.adjust_id=base_adjust_interest.id where adjust_interest_proj.adjust_id='"+txid+"' and adjust_interest_proj.proj_id='"+proj_id+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		start_date=getDBDateStr(rs.getString("start_date"));
		rent_list_start=getDBStr(rs.getString("rent_list_start"));
		adjust_amt=getDBStr(rs.getString("adjust_amt"));
	}rs.close();
%>

    <form name="list">
	<table align="center" width="100%">
	  <tr><td colspan="2">
		<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
			<tr height="2%">
			  <td width="50%">��Ϣ���ڣ�<%=start_date%></td>
			  <td>��Ϣ��ʼ�ڴΣ�<%=rent_list_start%></td>
		  </tr>
		  <tr height="2%">
			  <td><a href="tx_record.jsp?proj_id=<%=proj_id%>" target="_blank">��Ϣ��¼</a></td>
			  <td>������<%=adjust_amt%></td>
		  </tr>
		  <tr height="2%">
			  <td>��Ϣǰ�����ƻ�</td>
			  <td>��Ϣ�󳥻��ƻ�</td>
		  </tr>
		</table>
		</td>
	  </tr>		
      <tr>
		  <td width="50%"><table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">

				 <tr class="cwDLHead">
					<th>�ڴ�</th>
					<th>�Ƿ����</th>
					<th>�ƻ�����</th>
					<th>����</th>
					<th>���</th>
					<th>����</th>
					<th>��Ϣ</th>
				  </tr>
				  
				  <%
				  	sqlstr="select * from fund_rent_adjust_interest_his where adjust_id='"+txid+"' and proj_id='"+proj_id+"' and adjust_flag='ǰ' and modify_reason='��Ϣ' order by rent_list";	  
				  	rs = db.executeQuery(sqlstr);
				  	while (rs.next()) {
				  				  %>
				  <tr class="cwDLRow" >
					<td><%=getDBStr(rs.getString("rent_list"))%></td>
					<td align="left"><%=getDBStr(rs.getString("plan_status")).equals("0")?"δ����":"�Ѻ���"%></td>
					<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
					<td align="left"><%=rs.getBigDecimal("year_rate", 6).toString()%></td>
					<td align="left"><%=rs.getBigDecimal("rent", 2).toString()%></td>
					<td align="left"><%=rs.getBigDecimal("corpus", 2).toString()%></td>
					<td align="left"><%=rs.getBigDecimal("interest", 2).toString()%></td>
				  </tr>
				  <%
				  	}
				  	sqlstr="select * from fund_rent_adjust_interest_his where adjust_id='"+txid+"' and proj_id='"+proj_id+"' and adjust_flag='��' and modify_reason='��Ϣ' order by rent_list";	    
				  	rs = db.executeQuery(sqlstr);
				  %>
			  </table>
		  </td>

		  <td width="50%">
		  	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>�ڴ�</th>
					<th>�Ƿ����</th>
					<th>�ƻ�����</th>
					<th>����</th>
					<th>���</th>
					<th>����</th>
					<th>��Ϣ</th>
				  </tr>
				  <%
				  	while (rs.next()) {
				  %>
				  
				  <tr class="cwDLRow" >
					<td><%=getDBStr(rs.getString("rent_list"))%></td>
					<td align="left"><%=getDBStr(rs.getString("plan_status")).equals("0")?"δ����":"�Ѻ���"%></td>
					<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
					<td align="left"><%=rs.getBigDecimal("year_rate", 6).toString()%></td>
					<td align="left"><%=rs.getBigDecimal("rent", 2).toString()%></td>
					<td align="left"><%=rs.getBigDecimal("corpus", 2).toString()%></td>
					<td align="left"><%=rs.getBigDecimal("interest", 2).toString()%></td>
				  </tr>
				  <%
				  	}
				  	db.close();
				  %>
			  </table>

		  </td>
		
      </tr>
	  
    </table>
</form>
</div>
</body>
</html>
