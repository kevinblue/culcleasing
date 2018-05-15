<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>个人客户(法人)明细 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	//带*号的为必填选需要进行验证
	String czid = getStr( request.getParameter("cust_id") );//客户编号
	String sqlstr = "select * from vi_cust_info where cust_id='" + czid + "'"; //SQL查询语句
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String	cust_name = "";//客户名称 *
	String	org_code = "";//组织结构代码 
	String	hydldata = "";//客户所属行业大类
	String	hyxldata = "";//客户所属行业小类 
	String	biz_method = "";//经营方式
	String	biz_scope_primary = "";//经营范围（主营）
	String	biz_scope= "";//产品/服务（兼营）
	String	reg_number = "";//登记注册号（营业执照号） *
	String	estab_date = "";//成立日期 *
	String	reg_capital = "";//注册资本
	String	reg_capital_cur_name = "";//注册资本币种
	String	fact_capital = "";//实收资本
	String	mailing_addr = "";//准确邮寄地址 *
	String	company_addr = "";//公司地址 *
	String	post_code = "";//邮编 *
	String cust_mesage="";
	String mobile_number="";
	if ( rs.next() ) {
		cust_name = getDBStr( rs.getString("cust_name") );
		org_code = getDBStr( rs.getString("org_code") );
		biz_method = getDBStr( rs.getString("biz_method") );
		biz_scope_primary = getDBStr( rs.getString("biz_scope_primary") );
		biz_scope = getDBStr( rs.getString("biz_scope") );
		estab_date = getDBDateStr( rs.getString("estab_date") );
		reg_number = getDBStr( rs.getString("reg_number") );
		reg_capital = getDBStr( rs.getString("reg_capital") );		
		reg_capital_cur_name = getDBStr( rs.getString("reg_capital_cur_name") );
		fact_capital = getDBStr( rs.getString("fact_capital") );		
		mailing_addr = getDBStr( rs.getString("mailing_addr") );
		company_addr = getDBStr( rs.getString("company_addr") );
		post_code = getDBStr( rs.getString("post_code") );
		hydldata = getDBStr( rs.getString("hydlmc") );
		hyxldata = getDBStr( rs.getString("hyxlmc") );
		cust_mesage = getDBStr( rs.getString("cust_mesage") );
		mobile_number = getDBStr( rs.getString("mobile_number") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="khmpxx_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户(法人)信息明细
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
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
    <td scope="row" nowrap width="30%"><%= cust_name %></td>
    <td >组织机构代码：</td>
    <td><%= org_code %></td>
  </tr>
    <tr>
	<td >手机：</td>
	<td><%= mobile_number %></td>
	<td ></td>
	<td></td>
  </tr>
  <tr>
	<td >客户所属行业大类：</td>
	<td><%= hydldata %></td>
	<td >客户所属行业小类：</td>
	<td><%= hyxldata %></td>
  </tr>
  <tr>
    <td >经营范围：</td>
    <td><%= biz_scope_primary %></td>
    <td >产品/服务：</td>
    <td><%= biz_scope %></td>
  </tr>
  <tr>
    <td >登记注册号(营业执照号)：</td>
    <td><%= reg_number %></td>
    <td >成立日期</td>
    <td><%= estab_date %></td>
  </tr>
  <tr>
    <td >经营年限：</td>
    <%int year_t=getDateDiffMonth(estab_date,getSystemDate(0))/12;
	String year=year_t+"";
	%>
    <td><%= formatNumberDoubleTwo(year) %></td>
    <td >注册资本：</td>
    <td><%= reg_capital %></td>
  </tr>
  <tr>
    <td >注册资本币种：</td>
    <td><%= reg_capital_cur_name %></td>
    <td >实收资本：</td>
    <td><%= fact_capital %></td>
  </tr>
  <tr>
    <td >邮编：</td>
    <td><%= post_code %></td>
    <td >准确邮寄地址</td>
    <td><%= mailing_addr %></td>
  </tr>
    <tr>
    <td >公司地址</td>
    <td><%= company_addr %></td>
    <td >承租人情况</td>
    <td><%= cust_mesage %></td>
  </tr>
</table>
</div>
</div>
</center></td></tr></table></div>
<!--添加结束-->
</body>
</html>
