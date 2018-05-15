<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改公司内部账户 - 公司内部账户</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="gszh_save.jsp"  onSubmit="return chkForm(this);">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >公司内部账户</td>
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
        <td id="cwCellTopTitTxt">修改公司内部账户</td>
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
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "SELECT jb_nbzhxx.*, jb_bankxx.yhmc FROM jb_nbzhxx LEFT OUTER JOIN jb_bankxx ON jb_nbzhxx.yhid=jb_bankxx.id where jb_nbzhxx.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{

%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">

<table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">

<tr>
    <th class="cwDDLabel" scope="row">开户银行</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("yhmc"))%></td>
  </tr>
<tr>
    <th scope="row">帐户名称</th>
    <td><input name="zhmc" type="text" size="20" maxlength="20" maxB="20" value="<%=getDBStr(rs.getString("zhmc"))%>"></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">开户帐号</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("khzh"))%></td>
  </tr>
 
  <tr>
    <th>币种</th>
    <td><input name="zhbzdata" type="text" size="20" maxlength="20" readonly value="<%=getDBStr(rs.getString("zhbz"))%>"><input name="zhbz" type="hidden" value="<%=getDBStr(rs.getString("zhbz"))%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
 onclick="SpecialDataWindow('币种名称','jb_bzxx','bz','bz','bz','stringfld','id','form1.zhbzdata','form1.zhbz');">
	  </td>
  </tr>
 <tr>
    <th scope="row">帐户性质</th>
    <td><input name="zhxz" type="text" size="20" maxlength="20" maxB="20" value="<%=getDBStr(rs.getString("zhxz"))%>"></td>
  </tr>

   <tr>
    <th width="79" scope="row">帐户类型</th>
    <td width="316">
<input name="zhlxdata" type="text" value="<%=getDBStr(rs.getString("zhlx"))%>" size="30" readonly label="帐户类型" conttyp="" isopt="0"><input type="hidden" name="zhlx" value="<%=getDBStr(rs.getString("zhlx"))%>"><img src="../../images/sbtn_more.gif" alt="选" align="absmiddle" style="cursor:pointer"  onclick="SimpleDataWindow('','','v_yhlx','yhlx','yhlx','','','yhlx','form1.zhlxdata','form1.zhlx');"> <span class="biTian"></span>
</td>
  </tr>
   <tr>
    <th scope="row">网银地址</th>
    <td><input name="wydz" type="text" size="100" maxlength="100" maxB="100" value="<%=getDBStr(rs.getString("wydz"))%>"></td>
  </tr>
   <tr>
    <th scope="row">电话银行电话</th>
    <td><input name="dhyhdh" type="text" size="20" maxlength="20" maxB="20" value="<%=getDBStr(rs.getString("dhyhdh"))%>"></td>
  </tr>
   <tr>
    <th scope="row">电话银行登陆名</th>
    <td><input name="dhyhdl" type="text" size="50" maxlength="50" maxB="50" value="<%=getDBStr(rs.getString("dhyhdl"))%>"></td>
  </tr>
   <tr>
    <th scope="row">联系人</th>
    <td><input name="lxr" type="text" size="20" maxlength="20" maxB="20" value="<%=getDBStr(rs.getString("lxr"))%>"></td>
  </tr>
   <tr>
    <th scope="row">联系人电话</th>
    <td><input name="lxrdh" type="text" size="20" maxlength="20" maxB="20" value="<%=getDBStr(rs.getString("lxrdh"))%>"></td>
  </tr>
  
  <tr>
    <th scope="row">帐户状态</th>
    <td><select name="zhzt"><script>w(mSetOpt('<%=getDBStr(rs.getString("zhzt"))%>',"启用|销户"));</script></select>
	  </td>
  </tr>
  <tr >
    <th scope="row">额度开始日期</th>
    <td><input name="edqsrq" type="text" size="10" maxlength="10" label="" dataType="Date"  value="<%=getDBDateStr(rs.getString("edqsrq"))%>"><img  onClick="openCalendar(edqsrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"> </td>
  </tr>
  <tr >
    <th scope="row">额度结束日期</th>
    <td><input name="edzzrq" type="text" size="10" maxlength="10" label="" dataType="Date"  value="<%=getDBDateStr(rs.getString("edzzrq"))%>"><img  onClick="openCalendar(edzzrq);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"> </td>
  </tr>
  <tr>
    <th scope="row">授信金额</th>
        <%
        if (getDBDecStr(rs.getBigDecimal("sxed",2)).compareTo(new BigDecimal(0.00))==0)
        {
        %>
    <td><input name="sxed" type="text" size="13" maxlength="13" dataType="Money" value=""></td>
        <%
        }
        else
        { 
        %>
    <td><input name="sxed" type="text" size="13" maxlength="13" dataType="Money" value="<%=(BigDecimal)getDBDecStr(rs.getBigDecimal("sxed",2))%>"></td>
        <%
        }
        %> 
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


