<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<%
/*
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
 // response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx-khmpxx-list",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");
*/%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户名片信息明细 - 客户信息管理(个人)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String czid = getStr( request.getParameter("cust_id") );
	String sqlstr = "select * from vi_cust_ewlp_info where cust_id='" + czid + "'"; 
	ResultSet rs = db.executeQuery(sqlstr); 
	String	cust_name = "";//客户名称 *
	String	is_marriage = "";//婚姻状况
	String	certificate_no = "";//证件号码 *
	String	reg_per_addr = "";//户口所在地
	String	home_phone = "";//住宅电话 *
	String	mobile_number = "";//手  机 *
	String	mail_addr = "";
	String	post_code = "";
	String	hydldata = "";
	String	hyxldata = "";
	String	birthday = "";
	
	if ( rs.next() ) {
		cust_name = getDBStr( rs.getString("cust_name") );
		is_marriage = getDBStr( rs.getString("is_marriage") );
		birthday = getDBDateStr( rs.getString("birthday") );
		home_phone = getDBStr( rs.getString("home_phone") );
		certificate_no = getDBStr( rs.getString("certificate_no") );
		reg_per_addr = getDBStr( rs.getString("reg_per_addr") );
		post_code = getDBStr( rs.getString("post_code") );
		mail_addr = getDBStr( rs.getString("mail_addr") );
		//行业
		hydldata = getDBStr( rs.getString("hydlmc") );
		hyxldata = getDBStr( rs.getString("hyxlmc") );		
		mobile_number = getDBStr( rs.getString("mobile_number") );	
	}
	rs.close(); 
	db.close();
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="khzrxx_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
个人客户信息明细
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	  	<td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/hg.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="20%">客户名称：</td>
    <td><%= cust_name %></td>
    <td scope="row" nowrap width="20%">证件号码：</td>
    <td><%=certificate_no%></td>
  </tr>
    <tr>
      <%int year_t=getDateDiffMonth(birthday,getSystemDate(0))/12;
	String year=year_t+"";
	%>
    <td scope="row" nowrap width="20%">年龄：</td>
    <td><%= formatNumberDoubleZero(year)%></td>
    <td>手机</td>
    <td><%=mobile_number %></td>
  </tr>

  <tr>
    <td scope="row" nowrap width="20%">出生年月：</td>
    <td><%= birthday %></td>

    <td scope="row" nowrap width="20%">婚姻状况：</td>
    <td><%=is_marriage%></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">户口所在地：</td>
    <td><%= reg_per_addr %></td>
  <td scope="row" nowrap width="20%">住宅电话：</td>
    <td><%= home_phone %></td>
  </tr>
  <tr>
	<td scope="row" nowrap width="20%">客户所属行业大类：</td>
	<td><%= hydldata %></td>
	<td scope="row" nowrap width="20%">客户所属行业小类：</td>
	<td><%= hyxldata %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">邮寄地址：</td>
    <td><%= mail_addr %></td>
    <td scope="row" nowrap width="20%">邮编：</td>
    <td><%= post_code %></td>
  </tr>
</table>
</div>

</div> 
</div>
</form>
<!-- end cwMain -->
</body>
</html>
