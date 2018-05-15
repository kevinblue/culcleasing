<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ɾ����Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="fxll_save.jsp">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >��Ϣ����</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->

<div id="cwCell">
<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">ɾ����Ϣ����</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td></td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select contract_overdue_interest.*,v_dw_contract.target_name from contract_overdue_interest left join v_dw_contract on contract_overdue_interest.contract_id=v_dw_contract.contract_id where contract_overdue_interest.id=" + czid; 
	ResultSet rs = db.executeQuery(sqlstr); 


	
	String contract_id = "";
	String pena_rate_type = "";
	String pena_rate = "";
	String ratestartdate = "";
	String rateenddate = "";


	if ( rs.next() ) {
		contract_id = getDBStr( rs.getString("contract_id") );
		pena_rate_type = getDBStr( rs.getString("pena_rate_type") );
		pena_rate = getDBDecStr(rs.getBigDecimal("pena_rate",6)).toString();
		ratestartdate = getDBDateStr( rs.getString("ratestartdate") );
		rateenddate = getDBDateStr( rs.getString("rateenddate") );
	}
	rs.close(); 
	db.close();
%>

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%= czid %>">

<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">��ͬ���</th>
    <td class="cwDDValue"><%= contract_id %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">��Ϣ��������</th>
    <td class="cwDDValue"><%= pena_rate_type %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">��Ϣ����</th>
    <td class="cwDDValue"><%= pena_rate %>%%</td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">������ʼ����</th>
    <td class="cwDDValue"><%= ratestartdate %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">���ʽ�������</th>
    <td class="cwDDValue"><%= rateenddate %></td>
  </tr>
  
</table>

<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
<div id="cwToolbar">
<input class="btn" name="submit" value="ɾ��" type="submit"  onClick="return(confirm('ȷ��ɾ����?'))">
<input class="btn" name="btnClose" value="�ر�" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>
