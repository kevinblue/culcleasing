<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<%

String dqczy=(String) session.getAttribute("czyid");

if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_khzrxx_del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>删除客户名片信息信息 - 客户信息管理(个人)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="khzrxx_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
个人客户信息管理 &gt; 删除客户名片信息信息
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
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">删除</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

	    	</td>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">删除</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
	dqczy="无认证";
}
String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_ewlp_info where cust_id='" + czid + "'"; 
	ResultSet rs = db.executeQuery(sqlstr); 
	
	String	cust_name = "";//客户名称 *
	String	cust_ename = "";//客户英文名
	String	sex = "";//客户性别
	String	birthday = "";//出生年月
	String	is_marriage = "";//婚姻状况
	String	certificate = "";//证件类型
	String	certificate_no = "";//证件号码 *
	String	education = "";//学历
	String	reg_per_addr = "";//户口所在地
	String	work_addr = "";//单位地址
	String	headship = "";//单位职务
	String	off_phone = "";//办公室电话
	String	home_phone = "";//住宅电话 *
	String	mobile_number = "";//手  机 *
	String  home_addr="";
	String	mail_addr = "";
	String	post_code = "";
	String	eme_contacts = "";
	String	reg_number = "";
	String	license_exp_date = "";
	String  annual_due_date = "";
	String	hydldata = "";
	String	hyxldata = "";
	String	lbdldata = "";
	String	fax_number = "";
	String	e_mail = "";
	String  web_site = "";
	String	gjdata = "";
	String	sfdata = "";
	String	csdata = "";
	String	qxdata = "";
	String	memo = "";
	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";
	String	creator_dept = "";
	String biz_scope="";
	
	String  industry_type = "";
	String	industry_level1 = "";
	String	industry_level2 = "";
	String	industry_level3 = "";
	String	category_level1 = "";
	String country="";
	String province="";
	String city="";
	String unit_name="";
	if ( rs.next() ) {
		unit_name = getDBStr( rs.getString("unit_name") );
		cust_name = getDBStr( rs.getString("cust_name") );
		cust_ename = getDBStr( rs.getString("cust_ename") );
		sex = getDBStr( rs.getString("sex") );
		reg_number = getDBStr( rs.getString("reg_number") );
		is_marriage = getDBStr( rs.getString("is_marriage") );
		birthday = getDBDateStr( rs.getString("birthday") );
		license_exp_date = getDBDateStr( rs.getString("license_exp_date") );
		annual_due_date = getDBDateStr( rs.getString("annual_due_date") );
		mobile_number = getDBStr( rs.getString("mobile_number") );
		fax_number = getDBStr( rs.getString("fax_number") );
		e_mail = getDBStr( rs.getString("e_mail") );
		web_site = getDBStr( rs.getString("web_site") );
		home_addr = getDBStr( rs.getString("home_addr") );
		post_code = getDBStr( rs.getString("post_code") );
		biz_scope = getDBStr( rs.getString("biz_scope") );
		memo = getDBStr( rs.getString("memo") );
		
		//行业
		hydldata = getDBStr( rs.getString("hydlmc") );
		hyxldata = getDBStr( rs.getString("hyxlmc") );
		lbdldata = getDBStr( rs.getString("lbdlmc") );
		//国家、省份、城市
		gjdata = getDBStr( rs.getString("gjmc") );
		sfdata = getDBStr( rs.getString("sfmc") );
		csdata = getDBStr( rs.getString("csmc") );
		qxdata = getDBStr( rs.getString("county") );

		creator = getDBStr( rs.getString("dengjiren") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("xiugairen") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
		creator_dept = getDBStr( rs.getString("creator_dept") );
		
		education=getDBStr( rs.getString("education") );
		reg_per_addr=getDBStr( rs.getString("reg_per_addr") );
		work_addr=getDBStr( rs.getString("work_addr") );
		headship=getDBStr( rs.getString("headship") );
		off_phone=getDBStr( rs.getString("off_phone") );
		home_phone=getDBStr( rs.getString("home_phone") );
		mail_addr=getDBStr( rs.getString("mail_addr") );
		eme_contacts=getDBStr( rs.getString("eme_contacts") );
		certificate_no=getDBStr( rs.getString("certificate_no") );
		certificate=getDBStr( rs.getString("certificate") );
	}
	rs.close(); 
	db.close();
%>


<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="25%">客户名称：</td>
    <td  scope="row" nowrap width="25%"><%= cust_name %></td>
    <td scope="row" nowrap width="25%">英文名称：</td>
    <td  scope="row" nowrap width="25%"><%= cust_ename %></td>
  </tr>
   <tr>
    <td scope="row" nowrap width="20%">证件类型：</td>
    <td><%= certificate %></td>
    <td scope="row" nowrap width="20%">证件号码：</td>
    <td><%=certificate_no%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">出生年月：</td>
    <td><%= birthday %></td>
    <td scope="row" nowrap width="20%">婚姻状况：</td>
    <td><%=is_marriage%></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">性别：</td>
    <td><%=sex%></td>
    <td scope="row" nowrap width="20%">学历：</td>
    <td><%=education%></td>
  </tr>
 <tr>
  <td scope="row" nowrap width="20%">户口所在地：</td>
    <td><%= reg_per_addr %></td>
    <td scope="row" nowrap width="20%">单位名称：</td>
    <td><%= unit_name %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">单位地址：</td>
    <td><%= work_addr %></td>
     <td scope="row" nowrap width="20%">单位职务：</td>
    <td><%= headship %></td>
   </tr>
  <tr>
   <td scope="row" nowrap width="20%">营业执照号：</td>
    <td><%= reg_number %></td>
  <td scope="row" nowrap width="20%">办公室电话：</td>
    <td><%= off_phone %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">营业执照到期日期：</td>
    <td><%= license_exp_date %></td>
    <td scope="row" nowrap width="20%">工商年检到期日：</td>
    <td><%= annual_due_date %></td>
  </tr>
  <tr>
	<td scope="row" nowrap width="20%">客户所属行业大类：</td>
	<td><%= hydldata %></td>
	<td scope="row" nowrap width="20%">客户所属行业小类：</td>
	<td><%= hyxldata %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">客户类别：</td>
    <td><%= lbdldata %></td>
    <td scope="row" nowrap width="20%">紧急联系人：</td>
    <td><%= eme_contacts %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">邮寄地址：</td>
    <td><%= mail_addr %></td>
    <td scope="row" nowrap width="20%">住宅电话：</td>
    <td><%= home_phone %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">传真：</td>
    <td><%= fax_number %></td>
   <td scope="row" nowrap width="20%">手机：</td>
    <td><%= mobile_number %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">网址：</td>
    <td><%=web_site %></td>
     <td scope="row" nowrap width="20%">E-mail地址：</td>
    <td><%= e_mail %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">邮编：</td>
    <td><%= post_code %></td>
    <td scope="row" nowrap width="20%">住宅住址：</td>
    <td><%= home_addr %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">国家：</td>
    <td><%= gjdata %></td>
    <td scope="row" nowrap width="20%">省份：</td>
    <td><%= sfdata %></td>
  </tr>
  <tr>
  <td scope="row" nowrap width="20%">城市：</td>
    <td><%= csdata %></td>
    <td >区/县：</td>
    <td><%= qxdata %></td>
    </tr>
  <tr>
  <td scope="row" nowrap width="20%">经营范围：</td>
    <td><%= biz_scope %></td>   
  
  <td scope="row" nowrap width="20%">备注：</td>
    <td><%= memo %></td>
    </tr>
  <tr>
  <!--
    <td scope="row" nowrap width="20%">部门名称：</td>
    <td><%= creator_dept %></td>
  -->
    <td scope="row" nowrap width="20%">登记人：</td>
    <td><%= creator %></td>
 <!--
    </tr>
  <tr>
  -->
    <td scope="row" nowrap width="20%">登记时间：</td>
    <td><%= create_date %></td>
  <tr>
  <td scope="row" nowrap width="20%">修改人：</td>
    <td><%= modificator %></td>
    
    <td scope="row" nowrap width="20%">修改时间：</td>
    <td><%= modify_date %></td><td></td><td></td>
  </tr>
</table>
</div>

</div>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->








</form>

<!-- end cwMain -->
</body>
</html>
