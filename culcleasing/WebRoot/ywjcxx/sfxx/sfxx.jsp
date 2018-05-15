<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>区域维护 - 基础信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script language="javascript">
function selgroup()
{
		sel.cgroup_id.value=form1.credit_group_id.value;
		sel.cgroup_name.value=form1.credit_group_name.value;
		sel.submit();
}
</script>

</head>
<%
String czid;
czid=getStr(request.getParameter("czid"));
%>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 区域维护</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv"><!-- end cwCellTop -->
<form name="form1"  method="post" action="sfxx_save.jsp" onSubmit="return Validator.Validate(this,3);" target="_blank">
<!-- end cwCellTop -->

<input type="hidden" name="savetype" value="mod">

<%
String parentdept=getStr(request.getParameter("parentdept"));
String dept=getStr(request.getParameter("dept"));
String dept_id=getStr(request.getParameter("dept_id"));
System.out.println("aaaaaa"+dept);
String sqlstr;
ResultSet rs;
sqlstr = "select *,dbo.getusername(modificator) as modificatorg from base_department_respons where dept_id='"+dept_id+"'"; 

rs=db.executeQuery(sqlstr); 

String dept_name="";
String respon_provice_title="";
String respon_provice_id="";
String modify_date="";
String modificator="";

if ( rs.next() ) {
	dept_id= getDBStr(rs.getString("dept_id"));
	dept_name= getDBStr(rs.getString("dept_name"));
	respon_provice_title= getDBStr(rs.getString("respon_provice_title"));
	respon_provice_id= getDBStr(rs.getString("respon_provice_id"));
	modify_date=getDBDateStr(rs.getString("modify_date"));
	modificator=getDBStr(rs.getString("modificatorg"));
}

rs.close();
db.close();
%>
<input type="hidden" name="dept_name" value="<%=dept%>">
<input type="hidden" name="dept_id" value="<%=dept_id%>">
 <table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" height="30" class="cwDDLabel">父部门</td>
    <td width="84%" height="30" class="cwDDValue"><%=parentdept%></td>
  </tr>
    <tr>
    <td width="16%" height="30" class="cwDDLabel">大区</td>
    <td width="84%" height="30" class="cwDDValue"><%=dept%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">负责省份代码</td>
    <td height="30" class="cwDDValue"><%=respon_provice_id%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">负责省份名称</td>
    <td height="30" class="cwDDValue">
		 <textarea name="credit_group_name" style="width: 300px;" readonly><%=respon_provice_title %></textarea>
       <input type="hidden" name="credit_group_id" value="<%=respon_provice_id %>" size="30">
   	   <input type="button" value="选择" onclick="selgroup();">
	   <span class="biTian">*</span>
	</td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">最后更新日期</td>
    <td height="30" class="cwDDValue"><%=modify_date%></td>
  </tr>
  <tr>
    <td height="30" class="cwDDLabel" scope="row">操作员</td>
    <td height="30" class="cwDDValue"><%=modificator%></td>
  </tr>
  
</table>

<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->

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
</form>


<form name="sel" action="provice_sel.jsp" method="post" target="_blank">
<input type="hidden" name="cgroup_id">
<input type="hidden" name="cgroup_name">
</form>
<!-- end cwMain -->
</body>
</html>
