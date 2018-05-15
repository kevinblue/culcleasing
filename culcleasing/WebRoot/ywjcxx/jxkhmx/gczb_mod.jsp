<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改构成指标 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1"  method="post" action="gczb_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">基础信息管理</td>
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
        <td id="cwCellTopTitTxt">修改构成指标</td>
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
String czid;
String sqlstr;

ResultSet rs;
czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
   czid="0";
}


sqlstr = "SELECT perf_assessment_type.assess_type AS assess_type,perf_assessment_model.* FROM perf_assessment_model LEFT OUTER JOIN perf_assessment_type ";
sqlstr+=" ON perf_assessment_model.type_id = perf_assessment_type.id where perf_assessment_model.id="+czid; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="id" value="<%=getDBStr(rs.getString("id"))%>">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th scope="row">考核类别</th>
    <td><%=getDBStr(rs.getString("assess_type"))%><input name="type_id" type="hidden" value="<%=getDBStr(rs.getString("type_id"))%>"></td>
  </tr>
  <tr>
    <th scope="row">序号</th>
    <td><input name="order_number" type="text" size="3" maxlength="3" dataType="Integer" Require="ture" value="<%=getDBStr(rs.getString("order_number"))%>"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">构成指标</th>
    <td><textarea name="indicator_def"  Require="true" maxB="200" rows=5><%=getDBStr(rs.getString("indicator_def"))%></textarea><span class="biTian">*</span></td>
  </tr>
    <tr>
    <th scope="row">权重</th>
    <td><input name="weighting" type="text" size="9" maxlength="9"  dataType="Integer" Require="true" value="<%=getDBStr(rs.getString("weighting"))%>"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">标准值</th>
    <td><input name="standard_value" type="text" size="40" maxB="20" dataType="Rate" value="<%=getDBStr(rs.getString("standard_value"))%>"></td>
  </tr>
  <tr>
    <th scope="row">标准值显示值</th>
    <td><input name="standard_value_disp" type="text" size="40" maxB="50" value="<%=getDBStr(rs.getString("standard_value_disp"))%>"></td>
  </tr>
  <tr>
    <th scope="row">关系比率</th>
    <td><textarea name="ratio_relation" maxB="300" rows=5><%=getDBStr(rs.getString("ratio_relation"))%></textarea></td>
  </tr>
  <tr>
    <th scope="row">绝对限定条件</th>
    <td><textarea name="limitation" maxB="100" rows=3><%=getDBStr(rs.getString("limitation"))%></textarea></td>
  </tr>
  <tr>
    <th scope="row">当前是否有效</th>
    <td>
        <select name="his_flag">
            <script>w(mSetOpt('<%=getDBStr(rs.getString("his_flag"))%>',"是|否","0|1"));</script>
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
<input class="btn" name="submit" value="保存" type="submit">
<input class="btn" name="btnClose" value="取消" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="重置" type="reset">
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


