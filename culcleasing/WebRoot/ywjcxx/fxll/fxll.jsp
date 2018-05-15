<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>罚息利率</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
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
<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >罚息利率</td>
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
         <td id="cwCellTopTitTxt">罚息利率</td>
         <td id="cwCellTopTitRight"></td>
       </tr>
    </table>
	
	<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
	   <tr>
		 <td></td>
		 <td><a href="fxll_mod.jsp?czid=<%=czid%>"  accesskey="m" title="修改(Alt+M)">
		      <img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a>
		  </td>
	   </tr>
	</table>
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">



<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">合同编号</th>
    <td class="cwDDValue"><%= contract_id %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">罚息利率类型</th>
    <td class="cwDDValue"><%= pena_rate_type %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">罚息利率</th>
    <td class="cwDDValue"><%= pena_rate %>%%</td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">利率起始日期</th>
    <td class="cwDDValue"><%= ratestartdate %></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row" nowrap width="20%">利率结束日期</th>
    <td class="cwDDValue"><%= rateenddate %></td>
  </tr>
</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
<div id="cwToolbar">
<input class="btn" name="btnClose" value="关闭" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
