<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_khzrxx_mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户名片信息 - 客户信息管理(个人)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<%
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
	
	String category_level1="";
	String industry_level1 = "";
	String industry_level2 = "";
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
		
	 category_level1=getDBStr( rs.getString("cust_type") );
	 industry_level1 =getDBStr( rs.getString("industry_level1") );
	 industry_level2 = getDBStr( rs.getString("industry_level2") );
	 country=getDBStr( rs.getString("country") );
	 province=getDBStr( rs.getString("province") );
	 city=getDBStr( rs.getString("city") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="khzrxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
个人客户信息管理 &gt; 修改客户名片信息
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>客户名称</td>
    <td><input name="cust_name" readonly  value="<%=cust_name%>" type="text" size="40" maxB="100"  Require="true" >
	<span class="biTian">*</span></td>

    <td>英文名称</td>
    <td><input name="cust_ename" value="<%=cust_ename%>" type="text" size="40" maxB="100" dataType="English"></td>
  </tr>
  <tr>
    <td>证件类型：</td>
    <td><select name="certificate" ><script>w(mSetOpt('<%=certificate%>',"|身份证|护照"));</script></select></td>
    <td>证件号码：</td>
    <td><input name="certificate_no" readonly  value="<%=certificate_no%>" type="text" size="20" maxB="40" dataType="IdCard"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>出生年月：</td>
    <td><input name="birthday" value="<%=birthday%>" type="text" size="15" readonly maxB="10" Require="true" dataType="Date"> <img  onClick="openCalendar(birthday);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>

    <td>婚姻状况：</td>
    <td><select name="is_marriage" ><script>w(mSetOpt('<%=is_marriage%>',"|已婚|未婚|离异|丧偶"));</script></select></td>
  </tr>
  <tr>
    <td>性别：</td>
    <td><select name="sex" ><script>w(mSetOpt('<%=sex%>',"|男|女"));</script></select></td>
    <td>学历：</td>
    <td><select name="education" ><script>w(mSetOpt('<%=education%>',"|本科以下|本科|博士|硕士"));</script></select></td>
  </tr>
  <tr>
  <td>户口所在地：</td>
    <td><input name="reg_per_addr" value="<%=reg_per_addr%>" type="text" size="40" maxB="400" Require="true"><span class="biTian">*</span>
      <span class="biTian">*</span></td>
    <td>住宅电话：</td>
    <td><input name="home_phone"  type="text" size="20" maxB="40" dataType="Phone" value="<%=home_phone%>" ></td>
  </tr>
  <tr>
  <td>单位名称:</td><td><input name="unit_name" type="text" size="20" maxB="100" value="<%=unit_name%>" ></td>
  
  <td>单位职务：</td>
    <td><input name="headship" type="text" size="20" maxB="100" value="<%=headship%>" ></td>  
  </tr>
   <tr><td >单位地址：</td>
    <td><input name="work_addr"  type="text" size="40" maxB="400" value="<%=work_addr%>" ></td>
    <td>办公室电话：</td><td><input name="off_phone" type="text" size="20" maxb="40" dataType="Phone" value="<%=off_phone%>" ></td></tr>
  <tr>
  <td height="19">营业执照号：</td>
    <td><input name="reg_number"  type="text" size="20" maxb="40" value="<%=reg_number%>" ></td>
  <td >营业执照到期日期:</td>
    <td><input name="license_exp_date" value="<%=license_exp_date%>" type="text" size="15" readonly maxb="10" dataType="Date">
      <img  onClick="openCalendar(license_exp_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
 <tr>
    <td>工商年检到期日:</td>
    <td><input name="annual_due_date"  value="<%=annual_due_date%>" type="text" size="15" readonly maxb="10" dataType="Date">
      <img onClick="openCalendar(annual_due_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>紧急联系人：</td>
    <td><input name="eme_contacts" value="<%=eme_contacts%>" type="text" size="20" maxb="40"></td>
  </tr>
  <tr>
    <td>客户类别:</td>
    <td><input type="text" value="<%=lbdldata%>" name="lbdldata" readonly Require="ture"><input type="hidden" value="<%=category_level1%>" name="category_level1" onPropertychange="form1.industry_level1.value='';form1.industry_level2.value='';form1.hyxldata.value='';form1.hydldata.value='';"> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','客户类别','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.category_level1');">
	<span class="biTian">*</span></td>
    <td>手机:</td>
    <td><input type="text" name="mobile_number" value="<%=mobile_number%>"  Require="ture" datetype="MobileEXT"><span class="biTian">*</span></td>
  </tr>
     <tr>
   		<td>客户所属行业大类:</td>
    	<td><input name="hydldata" type="text" size="20" value="<%=hydldata%>" readonly><input type="hidden"  value="<%=industry_level1%>" name="industry_level1" onPropertychange=""> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','客户类别','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.category_level1');">
	  	</td>
   		<td>客户所属行业小类:</td>
    	<td><input name="hyxldata" value="<%=hyxldata%>" type="text" size="20" readonly>
    	<input name="industry_level2" type="hidden"  value="<%=industry_level2%>"  onPropertychange=""><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onclick="OpenDataWindow('form1.industry_level1','客户所属行业大类','substring(hyxlbh,2,2)','string','行业大类','kh_hyxl_gb','hyxlmc','hyxlbh','hyxlmc','hyxlmc','asc','form1.hyxldata','form1.industry_level2');">
	  	</td>
 	</tr>
  <tr>
  <td >邮寄地址：</td>
    <td><input name="mail_addr" value="<%=mail_addr%>"  type="text" size="40" maxB="400"  Require="ture">
      <span class="biTian">*</span></td>
    <td >邮编：</td>
    <td><input name="post_code" value="<%=post_code%>" type="text" size="20" maxb="40" dataType="Zip" Require="ture">
      <span class="biTian">*</span></td>
  </tr>
  <tr>
  <td >传真：</td>
    <td><input name="fax_number" value="<%=fax_number%>" type="text" size="40" maxB="40"></td>
    <td >E-mail地址：</td>
    <td><input name="e_mail" value="<%=e_mail%>" type="text" size="20" maxB="40"   dataType="Email"></td>
  </tr>
  <tr>
    <td >住宅住址：</td>
    <td><input name="home_addr" value="<%=home_addr%>"  type="text" size="40" maxB="400"></td>
    <td >网址：</td>
    <td><input name="web_site" value="<%=web_site%>" type="text" size="20" maxb="40" dataType="Url"></td>
  </tr>
  <tr>
    <td >国家:</td>
    <td><input type="text" name="gjdata" value="<%=gjdata%>" readonly Require="ture">
      <input type="hidden" name="country" value="<%=country%>"   onpropertychange="form1.sfdata.value='';form1.province.value='';form1.csdata.value='';form1.city.value='';">
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjdata','form1.country');"> <span class="biTian">*</span></td>
    <td>省份:</td>
    <td><input type="text" name="sfdata" value="<%=sfdata%>" readonly Require="ture">
      <input type="hidden" name="province" value="<%=province%>"  onpropertychange="form1.csdata.value='';form1.city.value='';">
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.country','国家','','','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.province');"> <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>城市:</td>
    <td><input type="text" name="csdata" value="<%=csdata%>" readonly Require="ture">
      <input type="hidden" name="city" value="<%=city%>" >
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.province','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.city');"> <span class="biTian">*</span></td>
	<td>区/县:</td>
    <td><input type="text" name="qxdata" value="<%= qxdata %>" require="ture" maxb="100">
      <span class="biTian">*</span></td>
    </tr>
  <tr>
    <td>经营范围:</td>
    <td><textarea name="biz_scope" cols="40" rows="4" maxB="1000"><%=biz_scope%></textarea></td>
  
    <td>备注</td>
    <td><textarea name="memo" cols="40" rows="4" maxB="1000"><%=memo%></textarea></td> 
  </tr>

</table>
</div>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

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
</form>

<!-- end cwMain -->
</body>
</html>
