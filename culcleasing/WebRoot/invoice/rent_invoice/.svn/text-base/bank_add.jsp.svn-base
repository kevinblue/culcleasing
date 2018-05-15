<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>融资报表 - 修改银行</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<%
String contract_id = getStr( request.getParameter("contract_id") );
sqlstr = "select project_name,bank_str from vi_fina_detail where contract_id='" + contract_id+"'"; 
rs = db.executeQuery(sqlstr); 

String project_name = "";
String bank = "";

if ( rs.next() ) {
	project_name = getDBStr( rs.getString("project_name") );
	bank = getDBStr( rs.getString("bank_str") );
}

rs.close();

%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">融资报表&gt; 修改银行</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="bank_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">项目名称:</td>
    <td scope="row">
		<%=project_name %>
   	</td>
    <td scope="row">银行:</td>
	<td scope="row"><input name="bank" type="text" value="<%=bank %>" size="100" Require="true""><span class="biTian">*</span></td>
	
  </tr>
  
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>


</html>

<%if(null != db){db.close();}%>