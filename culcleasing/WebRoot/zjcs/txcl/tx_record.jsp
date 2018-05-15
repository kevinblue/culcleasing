<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div>

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	  
      <tr class="cwDLHead">
		
	    <th>调息日期</th>
		<th>利率变动</th>
		<th>调整金额</th>
      </tr>

<%
	String proj_id = getStr(request.getParameter("proj_id"));

	String sqlstr;
	ResultSet rs;
	
	sqlstr="select base_adjust_interest.start_date,'利率由：'+convert(varchar(10),adjust_interest_proj.before_rate)+' 调整为：'+convert(varchar(10),adjust_interest_proj.after_rate) rate_str,adjust_interest_proj.adjust_amt from adjust_interest_proj left join base_adjust_interest on adjust_interest_proj.adjust_id=base_adjust_interest.id where adjust_interest_proj.proj_id='"+proj_id+"' and adjust_interest_proj.adjust_flag='是' order by base_adjust_interest.start_date";
	rs=db.executeQuery(sqlstr);
	while (rs.next()) {
		
	
%>
  <tr class="cwDLRow" >
		
		   <td><%=getDBDateStr(rs.getString("start_date"))%></td>
		   <td><%=getDBStr(rs.getString("rate_str"))%></td>
		   <td><%=getDBStr(rs.getString("adjust_amt"))%></td>
      </tr>
<%}
	rs.close();
	db.close();
%>

	 

    </table>



</div>
</body>
</html>

