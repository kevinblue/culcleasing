<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改帐户资金收支明细 - 资金信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1"  method="post" action="yemx_save.jsp" onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">资金信息管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">


<%
String sqlstr;
ResultSet rs;
String czy=(String) session.getAttribute("czyid");//取得操作员ID
if ((czy==null) || (czy.equals(""))) czy="0";
//czy="AFEE-6A6CWE";//资金管理部张惠华
sqlstr="select bmbh from jb_gsbm where bmmc=(select bmmc from v_yhxx where id='"+czy+"')";
String bmid="";//部门id
rs=db.executeQuery(sqlstr);
if (rs.next()) bmid=rs.getString("bmbh");
if ((bmid==null) || (bmid.equals(""))) bmid="0";
if (!bmid.equals("12"))//不是资金部
{
%>
				<script>
              if(opener==null){
               	opener=true;
              	opener.alert("你没有权限!");
              }else{
              	alert("你没有权限");
              }
              window.close();
				</script>
<%}%>


<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">修改帐户资金收支明细表</td>
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
String czid=getStr(request.getParameter("czid"));

sqlstr = "SELECT * from v_zh_xjyemx where id='"+czid+"'";
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{

%>
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=getDBStr(rs.getString("id"))%>">
<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
  <tr>
    <th scope="row">帐户</th>
	<td><select name="zh"><script>w(mSetOpt('<%=getDBStr(rs.getString("zh"))%>',"<%=getDBStr(rs.getString("zh"))%>"));</script></select></td>
  </tr>


  <tr>
    <th scope="row">帐户名称</th>
	<td><select name="zhmc"><script>w(mSetOpt('<%=getDBStr(rs.getString("zhmc"))%>',"<%=getDBStr(rs.getString("zhmc"))%>"));
  </script></select></td>
  </tr>
  <tr>
    <th scope="row">收支方式 </th>
    <td><select name="szfs"><script>w(mSetOpt('<%=getDBStr(rs.getString("szfs"))%>',"收款|付款"));</script></select>
	  </td>
  </tr>
<tr>
    <th scope="row">记录录入日期</th>
    <td><input name="jlrq" type="text" size="10" maxlength="10"  dataType="Date" readonly value="<%=getDBDateStr(rs.getString("jlrq"))%>" Require="true"><img  onClick="openCalendar(jlrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"> <span class="biTian">*</span></td>
  </tr>

  <tr>
    <th scope="row">金额(人民币)</th>
    <td><input name="jebb" type="text" size="13" maxlength="13" dataType="Money" value="<%=(BigDecimal)getDBDecStr(rs.getBigDecimal("jebb",2))%>"></td>
  </tr>

    <tr>
    <th scope="row">预金额(外币)</th>
    <td><input name="jewb" type="text" size="13" maxlength="13" dataType="Money" value="<%=(BigDecimal)getDBDecStr(rs.getBigDecimal("jewb",2))%>"></td>
  </tr>
  <tr>
    <th scope="row">收付款人</th>
    <td><textarea name="memo"  type="text" size="13" maxlength="13"><%=getDBStr(rs.getString("memo"))%></textarea> 
	</td>
  </tr>
 <tr>
    <th scope="row">备注</th>
    <td><textarea name="memo2" ><%=getDBStr(rs.getString("memo2"))%></textarea>
        </td>
  </tr>

  <tr>
    <th class="cwDDLabel" scope="row">录入时间</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("lrsj"))%></td>
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


