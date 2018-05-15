<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改罚息利率</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="fxll_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
	<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
		<tr>
		  <td id="cwTopTitLeft"></td>
		  <td id="cwTopTitTxt">罚息利率</td>
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
        <td id="cwCellTopTitTxt">修改罚息利率</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
	<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
		  <tr>
			<td>&nbsp;</td>
		  </tr>
	</table>
</div>
<!-- end cwCellTop -->
<div id="cwCellContent">

<%

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select contract_overdue_interest.*,v_dw_contract.target_name from contract_overdue_interest left join v_dw_contract on contract_overdue_interest.contract_id=v_dw_contract.contract_id where contract_overdue_interest.id=" + czid; 
	ResultSet rs = db.executeQuery(sqlstr); 


	String target_name = "";
	String contract_id = "";
	String pena_rate_type = "";
	String pena_rate = "";
	String ratestartdate = "";
	String rateenddate = "";


	if ( rs.next() ) {
		target_name = getDBStr( rs.getString("target_name") );
		contract_id = getDBStr( rs.getString("contract_id") );
		pena_rate_type = getDBStr( rs.getString("pena_rate_type") );
		pena_rate = getDBDecStr(rs.getBigDecimal("pena_rate",6)).toString();
		ratestartdate = getDBDateStr( rs.getString("ratestartdate") );
		rateenddate = getDBDateStr( rs.getString("rateenddate") );
	}
	rs.close(); 
	db.close();
%>
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%= czid %>">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
	<th scope="row">合同编号</th>
    <td><input type="text" name="contract_id" readonly Require="ture" value="<%=contract_id%>" size=20><input type="hidden" name="contract_id_data" value="<%=target_name%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','合同编号','v_dw_contract','target_name','contract_id','target_name','target_name','asc','form1.contract_id_data','form1.contract_id');"><span class="biTian">*</span></td>
  </tr>
  <tr>
      <th scope="row">罚息利率类型</th>
      <td><select name="pena_rate_type">
        <script>w(mSetOpt('<%=pena_rate_type%>',"固定|浮动"));</script>
        </select>
      <span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>罚息利率</th>
    <td><input name="pena_rate" type="text" size="10" maxB="60" Require="ture" value="<%=pena_rate%>">%%<span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>利率起始日期</th>
    <td><input name="ratestartdate" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture" value="<%=ratestartdate%>"><img  onClick="openCalendar(ratestartdate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th>利率结束日期</th>
    <td><input name="rateenddate" type="text" size="10" readonly maxlength="10" dataType="Date" Require="ture" value="<%=rateenddate%>"><img  onClick="openCalendar(rateenddate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>
</table>


<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->

</div>
<!-- end cwCell -->

<div id="cwToolbar" >
<input class="btn" name="submit" value="保存" type="submit">
<input class="btn" name="btnClose" value="取消" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="重置" type="reset">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>


