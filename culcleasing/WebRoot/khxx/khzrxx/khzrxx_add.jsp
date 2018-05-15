<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
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
if (right.CheckRight("khxx_khzrxx_add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户名片信息 - 客户信息管理(个人)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="khzrxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
<script language="javascript"> 
function GetXmlHttpObject(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest)	{
		objXMLHttp = new XMLHttpRequest();
	}else if(window.ActiveXObject)	{
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return objXMLHttp;
}
function codecheck(){
	var certificate_no=document.form1.certificate_no.value;
	var returnvalue="1";
	if(certificate_no!=""){
		var xmlHttp = GetXmlHttpObject();
		var url = "khcode_check.jsp?stype=1&code="+certificate_no;
	  	xmlHttp.open("POST",url,false);
	  	xmlHttp.send(null);
	  	var vDiv = document.createElement("DIV");
	   	vDiv.innerHTML = xmlHttp.responseText 
		returnvalue=vDiv.innerText;		
	}
	if(returnvalue!="1"){
		alert(returnvalue);
		document.getElementsByName("certificate_no").item(0).select();
		//.focus();
	}
}
</script>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理(非法人) &gt; 新增客户名片信息
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
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>客户名称</td>
    <td><input name="cust_name" type="text" size="40" maxB="150"  Require="true"  >
	<span class="biTian">*</span></td>
    <td>英文名称</td>
    <td><input name="cust_ename" type="text" size="40" maxB="80" dataType="English"></td>
  </tr>
  <tr>
    <td>证件类型：</td>
    <td><select name="certificate" ><script>w(mSetOpt('身份证',"|身份证|护照"));</script></select></td>
    <td>证件号码：</td>
    <td><input name="certificate_no" type="text" size="20" maxB="20" maxlength="20" Require="true" dataType="IdCard" onBlur="codecheck()"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>出生年月：</td>
    <td><input name="birthday"  type="text" size="15" readonly  dataType="Date" Require="true" > <img  onClick="openCalendar(birthday);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
    <td>婚姻状况：</td>
    <td><select name="is_marriage" ><script>w(mSetOpt('未婚',"|已婚|未婚|离异|丧偶"));</script></select></td>
  </tr>
  <tr>
    <td>性别：</td>
    <td><select name="sex" ><script>w(mSetOpt('男',"|男|女"));</script></select></td>
    <td>学历：</td>
    <td><select name="education" ><script>w(mSetOpt('本科以下',"|本科以下|本科|博士|硕士"));</script></select></td>
  </tr>
  <tr>
  <td>户口所在地：</td>
    <td><input name="reg_per_addr"  type="text" size="40" maxB="400" Require="true"><span class="biTian">*</span></td>
    <td>住宅电话：</td>
    <td><input name="home_phone"  type="text" size="20" maxB="40" dataType="Phone"></td>
  </tr>
  <tr>
  <td>单位名称:</td><td><input name="unit_name" type="text" size="20" maxB="100"></td>
  
  <td>单位职务：</td>
    <td><input name="headship" type="text" size="20" maxB="100"></td>  
  </tr>
   <tr><td >单位地址：</td>
    <td><input name="work_addr"  type="text" size="40" maxB="400"></td>
    <td>办公室电话：</td><td><input name="off_phone" type="text" size="20" maxB="40" dataType="Phone"></td></tr>
  <tr>
  <td>营业执照号：</td>
    <td><input name="reg_number"  type="text" size="20" maxB="40"></td>
  <td >营业执照到期日期:</td>
    <td><input name="license_exp_date" type="text" size="15" readonly maxB="10" dataType="Date">
      <img  onClick="openCalendar(license_exp_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  
 <tr>
    <td>工商年检到期日:</td>
    <td><input name="annual_due_date" type="text" size="15" readonly maxb="10" dataType="Date">
      <img  onClick="openCalendar(annual_due_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>紧急联系人：</td>
    <td><input name="eme_contacts" type="text" size="20" maxb="40"></td>
  </tr>
  <tr>
    <td>客户类别:</td>
    <td><input type="text" name="lbdldata" readonly Require="ture"><input type="hidden" name="category_level1" > <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','客户类别','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.category_level1');">
	<span class="biTian">*</span></td>
    <td>手机:</td>
    <td><input type="text" name="mobile_number"  Require="ture" dataType="MobileEXT"><span class="biTian">*</span></td>
  </tr>
     <tr>
   		<td>客户所属行业大类</td>
    	<td><input name="hydldata" type="text" size="20" readonly>
    	<input name="industry_level1" type="hidden"  onPropertychange="form1.industry_level2.value='';form1.hyxldata.value='';"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onclick="OpenDataWindow('','','','','行业大类','kh_hydl_gb','hydlmc','hydlbh','hydlmc','hydlmc','asc','form1.hydldata','form1.industry_level1');">
	  	</td>
   		<td>客户所属行业小类:</td>
    	<td><input name="hyxldata" type="text" size="20" readonly>
    	<input name="industry_level2" type="hidden"  onPropertychange=""><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onclick="OpenDataWindow('form1.industry_level1','客户所属行业大类','substring(hyxlbh,2,2)','string','行业大类','kh_hyxl_gb','hyxlmc','hyxlbh','hyxlmc','hyxlmc','asc','form1.hyxldata','form1.industry_level2');">
	  	</td>
 	</tr>
  <tr>
  <td >邮寄地址：</td>
    <td><input name="mail_addr"  type="text" size="40" maxB="400"  Require="ture">
      <span class="biTian">*</span></td>
    <td >邮编：</td>
    <td><input name="post_code"  type="text" size="20" maxb="40" dataType="Zip"  Require="ture">
      <span class="biTian">*</span></td>
  </tr>
  <tr>
  <td >传真：</td>
    <td><input name="fax_number" type="text" size="20" maxB="40" ></td>
    <td >E-mail地址：</td>
    <td><input name="e_mail" type="text" size="20" maxB="40" dataType="Email"></td>
  </tr>
  <tr>
    <td >住宅住址：</td>
    <td><input name="home_addr"  type="text" size="40" maxb="400"></td>
    <td >网址：</td>
    <td><input name="web_site"  type="text" size="20" maxb="40" dataType="Url"></td>
  </tr>
  <tr>
    <td >国家:</td>
    <td><input type="text" name="gjdata"  value="中华人民共和国" readonly Require="ture">
      <input type="hidden" name="country" value="CHN"  onpropertychange="form1.sfdata.value='';form1.province.value='';form1.csdata.value='';form1.city.value='';">
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjdata','form1.country');"> <span class="biTian">*</span></td>
    <td>省份:</td>
    <td><input type="text" name="sfdata"  readonly Require="ture">
      <input type="hidden" name="province" value="" onpropertychange="form1.csdata.value='';form1.city.value='';">
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.country','国家','','','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.province');"> <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>城市:</td>
    <td><input type="text" name="csdata"  readonly Require="ture" >
      <input type="hidden" name="city" value="" >
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.province','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.city');"> <span class="biTian">*</span></td>
	<td>区/县:</td>
    <td><input name="qxdata" type="text" size="40" Require="ture" maxb="100">
      <span class="biTian">*</span></td>
    </tr>
    <tr>
    <td>经营范围:</td>
    <td><textarea name="biz_scope" cols="40" rows="4" maxB="1000"></textarea></td>
  
      <td>备注:</td>
    <td><textarea name="memo" cols="40" rows="4"  maxb="1000"></textarea></td> 
    </tr>
  <tr>
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

<!--控制选择卡和内置iframe的高度适应窗口-->
</form>

<!-- end cwMain -->
</body>
</html>
