<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息记录</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<%
//获取参数
String begin_id = getStr(request.getParameter("begin_id"));
%>
<body onload="public_onload(0);">
<table border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;margin-left: 10px;">
    <tr>
        <td style="color:#E46344;font-size: 16px;font-weight: bold">调息前后对比</td>
    </tr>
</table>
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;"  id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
	class="maintab_content_table">
  <tr class="cwDLHead">
    <th>调息日期</th>
	<th>利率变动</th>
	<th>调息方式</th>
	<th>调息前后对比</th>
  </tr>

  <tbody id="data">
<%
	String sqlstr = "";
	ResultSet rs = null;

	sqlstr =" select faic.id,faic.begin_id,faic.adjust_type,('利率由：'+ cast(before_rate as varchar(20)) +";
	sqlstr+=" ' 调整为：'+cast(after_rate as varchar(20))) as rate_str,faic.adjust_id,fsi.start_date";
	sqlstr+="  from fund_adjust_interest_contract faic";
	sqlstr+="  left join fund_standard_interest fsi on faic.adjust_id=fsi.id where faic.begin_id='"+begin_id+"'";

	rs=db.executeQuery(sqlstr);
	while (rs.next()) {
%>
 	 <tr>
		   <td><%=getDBDateStr(rs.getString("start_date"))%></td>
		   <td><%=getDBStr(rs.getString("rate_str"))%></td>
		   <td><%=getDBStr(rs.getString("adjust_type"))%></td>
		   <td>
		  	 <a href="txdb.jsp?begin_id=<%=begin_id%>&txid=<%=getDBStr(rs.getString("adjust_id"))%>" target="_blank">
	      		查看
	        </a>
		   </td>
      </tr>
<%}
	rs.close();
	db.close();
%>
	</tbody>
</table>
</div>
</body>
</html>
