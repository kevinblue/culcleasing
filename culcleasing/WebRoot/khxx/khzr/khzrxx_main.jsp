<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
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
	String	marital_status = "";//婚姻状况
	String	id_card_no = "";//证件号码 *
	String	domicile_place = "";//户口所在地
	String  phone = "";//住宅电话 *
	String	mobile_number = "";//手  机 *
    String brith_date=" ";
	String	mail_addr = "";
	String	post_code = "";
	String	cust_type = "";
	String	cust_type2 = "";
	String	birthday = "";
	
	if ( rs.next() ) {
		cust_name = getDBStr( rs.getString("cust_name") );
		marital_status = getDBStr( rs.getString("marital_status") );
		birthday = getDBDateStr( rs.getString("birthday") );
		phone = getDBStr( rs.getString("phone") );
		id_card_no = getDBStr( rs.getString("id_card_no") );
		brith_date=getDBStr( rs.getString("brith_date") );
		domicile_place = getDBStr( rs.getString("domicile_place") );
		post_code = getDBStr( rs.getString("post_code") );
		mail_addr = getDBStr( rs.getString("mail_addr") );
		//行业
		cust_type = getDBStr( rs.getString("cust_type") );
		cust_type2 = getDBStr( rs.getString("cust_type2") );		
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
    <td scope="row" nowrap width="20%">英文名称：</td>
    <td><%=cust_ename%></td>
  </tr>
  
   <tr>
    <td scope="row" nowrap width="20%">性别：</td>
    <td><%= sex %></td>
    <td scope="row" nowrap width="20%">民族：</td>
    <td><%=nation%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">身份证号码：</td>
    <td><%= id_card_no %></td>
    <td scope="row" nowrap width="20%">出生日期：</td>
    <td><%=brith_date%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">客户类别大类：</td>
    <td><%= cust_type %></td>
    <td scope="row" nowrap width="20%">客户类别小类：</td>
    <td><%=cust_type2%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">客户所属行业门类：</td>
    <td><%= cust_name %></td>
    <td scope="row" nowrap width="20%">客户所属行业大类：</td>
    <td><%=industry_level2%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">客户所属行业中类：</td>
    <td><%= industry_level3 %></td>
    <td scope="row" nowrap width="20%">客户所属行业小类：</td>
    <td><%=industry_level4%></td>
  </tr>
    <td scope="row" nowrap width="20%">国家：</td>
    <td><%= country %></td>

    <td scope="row" nowrap width="20%">区域：</td>
    <td><%=area%></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">省份：</td>
    <td><%= province %></td>
  <td scope="row" nowrap width="20%">城市：</td>
    <td><%= city %></td>
  </tr>
  
  <tr>
	<td scope="row" nowrap width="20%">区县：</td>
	<td><%= region %></td>
	<td scope="row" nowrap width="20%">户口所在地：</td>
	<td><%= domicile_place %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">单位地址：</td>
    <td><%= work_add %></td>
    <td scope="row" nowrap width="20%">住宅地址：</td>
    <td><%= home_add %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">邮寄地址：</td>
    <td><%= mail_addr %></td>
    <td scope="row" nowrap width="20%">邮编：</td>
    <td><%= post_code %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">电话：</td>
    <td><%= phone %></td>
    <td scope="row" nowrap width="20%">手机：</td>
    <td><%= mobile_number %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">传真：</td>
    <td><%= fax_number %></td>
    <td scope="row" nowrap width="20%">电挂：</td>
    <td><%= cable_addr %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">E-mail地址：</td>
    <td><%= e_mail %></td>
    <td scope="row" nowrap width="20%">网址：</td>
    <td><%= web_site %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">婚姻状况：</td>
    <td><%= marital_status %></td>
    <td scope="row" nowrap width="20%">重要社会关系：</td>
    <td><%= imp_social_relation %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">有无犯罪记录：</td>
    <td><%= criminal_record %></td>
    <td scope="row" nowrap width="20%">不良嗜好：</td>
    <td><%= bad_hobby %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">学历：</td>
    <td><%= education %></td>
    <td scope="row" nowrap width="20%">毕业学校：</td>
    <td><%= school %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">专业：</td>
    <td><%= major %></td>
    <td scope="row" nowrap width="20%">紧急联系人：</td>
    <td><%= express_linkman %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">经营范围：</td>
    <td><%= biz_scope %></td>
    <td scope="row" nowrap width="20%">紧急联系人：</td>
    <td><%= express_linkman %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">备注：</td>
    <td><%= memo %></td>
    <td scope="row" nowrap width="20%">信息状态：</td>
    <td><%= info_flag %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">登记人：</td>
    <td><%= creator %></td>
    <td scope="row" nowrap width="20%">登记人部门：</td>
    <td><%= creator_dept %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">更新人：</td>
    <td><%= modificator %></td>
    <td scope="row" nowrap width="20%">更新日期：</td>
    <td><%= modify_date %></td>
  </tr>
</table>
</div>
</form>
<!-- end cwMain -->
</body>
</html>
