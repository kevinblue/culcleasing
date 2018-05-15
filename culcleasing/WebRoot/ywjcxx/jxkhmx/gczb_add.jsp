<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>新增构成指标 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="gczb_save.jsp" onSubmit="return Validator.Validate(this,3);">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >基础信息管理</td>
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
        <td id="cwCellTopTitTxt">新增构成指标</td>
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

<%
String sqlstr;
String czid;
String assess_type="";
ResultSet rs;
czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
   czid="0";
}
sqlstr = "SELECT assess_type FROM perf_assessment_type where id="+czid; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
    assess_type=getDBStr(rs.getString("assess_type"));
}
rs.close();
db.close();
%>

<div id="cwCellContent" >

<input type="hidden" value="add" name="savetype">
<table width="487" height="184"  border="0" cellpadding="2" cellspacing="5" class="cwDataInput">
  <tr>
    <th scope="row">考核类别</th>
    <td><%=assess_type%><input name="type_id" type="hidden" value="<%=czid%>"></td>
  </tr>
  <tr>
    <th scope="row">序号</th>
    <td><input name="order_number" type="text" size="3" maxlength="3" dataType="Integer" Require="ture"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">构成指标</th>
    <td><textarea name="indicator_def"  Require="true" maxB="200" rows=5></textarea><span class="biTian">*</span></td>
  </tr>
    <tr>
    <th scope="row">权重</th>
    <td><input name="weighting" type="text" size="9" maxlength="9"  dataType="Integer" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">标准值</th>
    <td><input name="standard_value" type="text" size="40" maxB="20" dataType="Rate"></td>
  </tr>
  <tr>
    <th scope="row">标准值显示值</th>
    <td><input name="standard_value_disp" type="text" size="40" maxB="50"></td>
  </tr>
  <tr>
    <th scope="row">关系比率</th>
    <td><textarea name="ratio_relation" maxB="300" rows=5></textarea></td>
  </tr>
  <tr>
    <th scope="row">绝对限定条件</th>
    <td><textarea name="limitation" maxB="100" rows=3></textarea></td>
  </tr>
  <tr>
    <th scope="row">当前是否有效</th>
    <td>
        <select name="his_flag">
            <script>w(mSetOpt('',"是|否","0|1"));</script>
        </select>
    </td>
  </tr>
</table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<input class="btn" name="btnSave" value="保存" type="submit"> <input class="btn" name="btnClose" value="取消" type="button" onclick="window.close();"><input class="btn" name="btnReset" value="重置" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
</div>
<!-- end cwMain -->
</body>
</html>
