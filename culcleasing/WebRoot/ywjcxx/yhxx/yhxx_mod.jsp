<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改银行信息 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="yhxx_save.jsp"  onSubmit="return chkForm(this);">


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
        <td id="cwCellTopTitTxt">修改银行信息</td>
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
String sqlstr;
String czid;
String yhmc;
String yhlx;
String yhdz;
String bz;
String gxrq;
String czy;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "SELECT V_yhxx.xm, jb_bankxx.* FROM jb_bankxx LEFT OUTER JOIN V_yhxx ON jb_bankxx.czy = V_yhxx.id where jb_bankxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
yhmc=getDBStr(rs.getString("yhmc"));
yhlx=getDBStr(rs.getString("yhlx"));
yhdz=getDBStr(rs.getString("yhdz"));
bz=getDBStr(rs.getString("bz"));
gxrq=getDBStr(rs.getString("gxrq"));
czy=getDBStr(rs.getString("xm"));
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">

<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th width="79" scope="row">银行名称</th>
    <td width="380">
<input name="yhmc" type="text" size="50" maxlength="50" label="银行名称" conttyp="" isopt="0" value="<%=yhmc%>"> <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
    <th scope="row">银行类型</th>
    <td>
	  <select name=yhlx>
<%
if (yhlx.indexOf("银行")>=0){
%>    
    <option selected="true">银行</option>
    <option>信托</option>
<%
}
else{
%>
    <option>银行</option>
    <option selected="true">信托</option>
<%
}
%>
      </select> <span class="biTian">*</span>
    </td>
  </tr>
  <tr>
    <th scope="row">银行地址</th>
    <td><textarea name="yhdz" ><%=yhdz%></textarea>
        </td>
  </tr>
  <tr>
    <th scope="row">备注</th>
    <td><textarea name="bz" ><%=bz%></textarea>
        </td>
  </tr>
  <tr>
    <th scope="row">更新日期</th>
    <td><%=getDBStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <th scope="row"> 操作员</th>
    <td><%=getDBStr(rs.getString("xm"))%></td>
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


