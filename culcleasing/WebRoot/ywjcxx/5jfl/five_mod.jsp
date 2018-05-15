<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改提取比例分类</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 修改提取比例分类</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="five_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->
<div id="cwCellContent">
<%
String sqlstr;
String czid;
String fiveclass;
String scale;

ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = " SELECT * FROM base_extractscale where id='"+czid+"' ";  
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
	fiveclass=getDBStr(rs.getString("fiveclass"));
	scale=getDBStr(rs.getString("scale"));
	
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
	<tr>
	<td width="16%" scope="row">五级分类</td>
    <td >
		<select name="fiveclass" id="fiveclass" class="select_css">
			<option value="正常类">正常类</option>
			<option value="关注类">关注类</option>
			<option value="次级类">次级类</option>
			<option value="可疑类">可疑类</option>
			<option value="损失类">损失类</option>
	</select>

	</td>
</tr>

  <tr>
    <td scope="row">提取比例</td>
    <td><input name="scale" type="text" value="<%=getDBStr(rs.getString("scale"))%>"  label="提取比例" Require="true">%<span class="biTian">*</span></td>
  </tr>

</table>
<script>
	for(var i=0;i<document.getElementById("fiveclass").options.length;i++)
	{
			if(document.getElementById("fiveclass").options[i].value=='<%=fiveclass%>')
			{
				document.getElementById("fiveclass").options[i].selected=true;
				break;
			}
	}
</script>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td width=8 width="12">
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
%>
 <center>该条记录不存在!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>