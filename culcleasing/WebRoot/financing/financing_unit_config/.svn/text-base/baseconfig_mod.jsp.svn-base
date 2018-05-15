<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改授信单位 - 融资基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String priId = getStr( request.getParameter("czid") );
sqlstr = "Select financing_config_unit.*,dbo.GETUSERNAME(creator) as oper_name from financing_config_unit where id='"+priId+"'"; 

rs = db.executeQuery(sqlstr); 

String unit_code = "";
String unit_name = "";
String unit_property = "";
String oper_name = "";

if ( rs.next() ) {
	unit_code = getDBStr( rs.getString("unit_code") );
	unit_name = getDBStr( rs.getString("unit_name") );
	unit_property = getDBStr( rs.getString("unit_property") );
	oper_name = getDBStr( rs.getString("oper_name") );
}

rs.close();
db.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">融资基础信息管理&gt; 修改授信单位</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<form name="form1"  method="post" action="baseconfig_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="priId" value="<%=priId %>">
<div class="mydivtab" id="mydiv">


<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">授信单位英文简称</td>
    <td>
      <input name="unit_code" type="text" size="5" maxlength="20" value="<%=unit_code %>" Require="ture">
      <span class="biTian">*必须唯一</span>
	</td>
  </tr>
  <tr>
    <td scope="row">授信单位名称</td>
    <td><input name="unit_name" type="text"  value="<%=unit_name %>" Require="ture">
    	<span class="biTian">*</span></td>
  </tr>
  
  <tr>
    <td scope="row">授信机构属性</td>
    <td scope="row">
		<select style="width:120px" name="unit_property" id="unit_property" Require="true" label="授信机构属性"></select>
		<script language="javascript" class="text">
			dict_list("unit_property","crediter_type","<%=unit_property %>","title");
		</script>
<!-- 
    	<select name="unit_property" id="unit_property" style="width: 60px;" Require="true">
	        <script type="text/javascript">
		        w(mSetOpt('<%=unit_property %>',"银行|非银行|集团","银行|非银行|集团"));
	        </script>
        </select>
-->
    <span class="biTian">*</span></td>
  </tr>
  
  <tr>
    <td scope="row"> 操作员</td>
    <td><%=oper_name %></td>
  </tr>
</table>
<!-- end cwDataNav -->

<!-- end cwCellContent -->
</div>
<!-- end cwCell -->

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td>
<input name="btnReset" value="重置" type="reset" class="btn3_mouseout"></td>
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close()" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
</form>

</td></tr></table>
<!-- end cwMain -->

</body>
</html>

