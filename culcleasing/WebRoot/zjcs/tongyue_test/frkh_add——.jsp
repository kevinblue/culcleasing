<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 客户信息管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/calend.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="../../js-t/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="../js-t/js/publicEvent.js"></SCRIPT>
<script language="javascript">
 dict_list("nbhydata","hapindustry","","name");
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
	var org_code=document.form1.org_code.value;
	var returnvalue="1";
	if(org_code!=""){
		var xmlHttp = GetXmlHttpObject();
		var url = "khcode_check.jsp?stype=2&code="+org_code;
	  	xmlHttp.open("POST",url,false);
	  	xmlHttp.send(null);
	  	var vDiv = document.createElement("DIV");
	   	vDiv.innerHTML = xmlHttp.responseText 
		returnvalue=vDiv.innerText;		
	}
	if(returnvalue!="1"){
		alert(returnvalue);
		document.getElementsByName("org_code").item(0).select();
		//.focus();
	}
}
function namecheck(){
  var cust_name=document.form1.cust_name.value;
  var returnvalue="5";
  if(cust_name!=""){
  	var xmlHttp = GetXmlHttpObject();
		var url = "khname_check.jsp?stype=6&cust_name="+cust_name;
	  	xmlHttp.open("POST",url,false);
	  	xmlHttp.send(null);
	  	var vDiv = document.createElement("DIV");
	   	vDiv.innerHTML = xmlHttp.responseText 
		returnvalue=vDiv.innerText;	
  }
  if(returnvalue!="5"){
		alert(returnvalue);
		document.getElementsByName("cust_name").item(0).select();
		//.focus();
	}
}

function cardcheck(){
var id_card_no=document.form1.id_card_no.value;
  var returnvalue="3";
  if(id_card_no!=""){
  	var xmlHttp = GetXmlHttpObject();
		var url = "khcard_check.jsp?stype=4&id_card_no="+id_card_no;
	  	xmlHttp.open("POST",url,false);
	  	xmlHttp.send(null);
	  	var vDiv = document.createElement("DIV");
	   	vDiv.innerHTML = xmlHttp.responseText 
		returnvalue=vDiv.innerText;	
  }
  if(returnvalue!="3"){
		alert(returnvalue);
		document.getElementsByName("id_card_no").item(0).select();
		//.focus();
	}
}

function checkdata(obj)
{
    
    if (!checkNumber(document.getElementById("national_tax_number"),"国税登记号")) return false;
    if (!checkNumber(document.getElementById("land_tax_number"),"地税登记号")) return false;
    if (!checkNumber(document.getElementById("reg_number"),"登记注册号")) return false; 
  
}

function checkNumber(obj,objname)
{

   re=/^[A-Za-z0-9]+$/
   code=trim(obj.value);
   if (code!="")
   {
       r = code.match(re);   
       if (r == null) {
	   alert(objname+"应只包含字母和数字!");
           obj.select();
           return false;
       }
   }   
   return true;     
}

function checkORG(obj){

  var financecode=trim(obj.value);
   var fir_value, sec_value;
   var w_i = new Array(8);
   var c_i = new Array(8);
   var j, s = 0;
   var c, i;

   var code = financecode;

   if (code.length<1) {
     alert("请输入组织机构代码!");
     obj.select();
       return false;
   }

   if (code == "00000000-0") {
     alert("组织机构代码错误!");
     obj.select();
       return false;
   }

   re = /[A-Z0-9]{8}-[A-Z0-9]/;    
   r = code.match(re);   
   if (r == null) {
	 alert("组织机构代码错误!");
     obj.select();
     return false;
   }        

	   w_i[0] = 3;
	   w_i[1] = 7;
	   w_i[2] = 9;
	   w_i[3] = 10;
	   w_i[4] = 5;
	   w_i[5] = 8;
	   w_i[6] = 4;
	   w_i[7] = 2;

	   if (financecode.charAt(8) != '-') {
	   alert("组织机构代码错误!");
		 obj.select();
		   return false;
	   }

	   for (i = 0; i < 10; i++) {
		   c = financecode.charAt(i);
		   if (c <= 'z' && c >= 'a') {
		   alert("组织机构代码错误!");
		 obj.select();
			   return false;
		   }
	   }


	   fir_value = financecode.charCodeAt(0);
	   sec_value = financecode.charCodeAt(1);

	   if (fir_value >= 'A'.charCodeAt(0) && fir_value <= 'Z'.charCodeAt(0)) {
		   c_i[0] = fir_value + 32 - 87;
	   } else {
			if (fir_value >= '0'.charCodeAt(0) && fir_value <= '9'.charCodeAt(0)) {
			c_i[0] = fir_value - '0'.charCodeAt(0);
			} else {
					alert("组织机构代码错误!");
		 obj.select();
			return false;
			}
	   }

	   s = s + w_i[0] * c_i[0];

	   if (sec_value >= 'A'.charCodeAt(0) && sec_value <= 'Z'.charCodeAt(0)) {
		   c_i[1] = sec_value + 32 - 87;
	   } else if (sec_value >= '0'.charCodeAt(0) && sec_value <= '9'.charCodeAt(0)) {
		   c_i[1] = sec_value - '0'.charCodeAt(0);
	   } else {
	   alert("组织机构代码错误!");
		 obj.select();
		   return false;
	   }

	   s = s + w_i[1] * c_i[1];
	   for (j = 2; j < 8; j++) {
		   if (financecode.charAt(j) < '0' || financecode.charAt(j) > '9') {
		   alert("组织机构代码错误!");
		 obj.select();
			   return false;
		   }
		   c_i[j] = financecode.charCodeAt(j) - '0'.charCodeAt(0);
		   s = s + w_i[j] * c_i[j];
	   }

	   c = 11 - (s % 11);

	   if (!((financecode.charAt(9) == 'X' && c == 10) ||
			 (c == 11 && financecode.charAt(9) == '0') || (c == financecode.charCodeAt(9) - '0'.charCodeAt(0)))) {

			  alert("组织机构代码错误!");
			   obj.select();
				return false;
	   }
   

   return true;
}

function checkDKK(obj) {
  var financecode=trim(obj.value);

   var code = financecode;

   if (code.length<1) {
     alert("请输入贷款卡编码!");
     obj.select();
       return false;
   }

   if (code.match(/[A-Z0-9]{16}/) == null) {
      alert("贷款卡编码错误!");
      obj.select();
       return false;
   }

   var w_i = new Array(14);
   var c_i = new Array(14);
   var j, s = 0;
   var checkid = 0;
   var c, i;

    w_i[0] = 1;
    w_i[1] = 3;
    w_i[2] = 5;
    w_i[3] = 7;
    w_i[4] = 11;
    w_i[5] = 2;
    w_i[6] = 13;
    w_i[7] = 1;
    w_i[8] = 1;
    w_i[9] = 17;
    w_i[10] = 19;
    w_i[11] = 97;
    w_i[12] = 23;
    w_i[13] = 29;


   for (j = 0; j < 14; j++) {
       if ( financecode.charAt(j) >= '0' && financecode.charAt(j) <= '9') {
          c_i[j] = financecode.charCodeAt(j) - '0'.charCodeAt(0);
       }
       else if ( financecode.charAt(j) >= 'A' && financecode.charAt(j) <= 'Z') {
       c_i[j] = financecode.charCodeAt(j) - 'A'.charCodeAt(0) + 10;
       }
       else{
           alert("贷款卡编码错误!");
           obj.select();
           return false;
       }
      s = s + w_i[j] * c_i[j];
   }

   c = 1 + (s % 97);
   checkid = ( financecode.charCodeAt(14) - '0'.charCodeAt(0) ) * 10 + financecode.charCodeAt(15) - '0'.charCodeAt(0);
   if ( c != checkid ) {
         alert("贷款卡编码错误!");
        obj.select();
        return false;
   }
   return true;
}
</script>

<script>
function isValidOrgCode(){
		
		var orgCode = form1.org_code.value;
		var resultSet;
		if (orgCode.length<10){
		 resultSet = false;
		}

	for (i = 0; (i < 10); i++) {
   var aa = orgCode.charCodeAt(i);

			if (i != 8) {
				
				if (aa < 48) {
						resultSet = false;
				} else if ((aa > 57) && (aa < 65)) {
						resultSet = false;
				} else if ((aa > 90) && (aa < 97)) {
						resultSet = false;
				} else if ((aa > 122)) {
						resultSet = false;
				}
			} else {
			
				if (aa != 45) {
						resultSet = false;
				}else{resultSet = true};
				
			}
		}
	return resultSet;
		}
//去空格
trim = function(/*String*/ str){
	str = str.replace(/^\s+/, '');
	for(var i = str.length - 1; i > 0; i--){
		if(/\S/.test(str.charAt(i))){
			str = str.substring(0, i + 1);
			break;
		}
	}
	return str;	// String
}
//规范性
getNormalize = function (s){
	return s != '0000000-0'
			&& /^[0-9A-Z]{2}[0-9]{6}-[0-9X]$/.test(trim(s))
}
//合法性验证规则
getCodeResult = function (s){
				var w_i = [3,7,9,10,5,8,4,2];
				cr = 0 ;
				for(i=0;i<8;i++){
					ct = s.charCodeAt(i);
					cr += (ct < 58 ? (ct - 48) : (ct - 55)) * w_i[i]
				}
				cr = 11 - cr % 11;
				return s.charCodeAt(9) == 88 && cr == 10
						|| cr == 11 && s.charCodeAt(9) == 48
						|| cr == s.charCodeAt(9) - 48;
			}
//合法性
function getValidity(s){
	return getNormalize(s) && getCodeResult(s);
}

function CheckOrgCode(){
	if(!getValidity(document.getElementById("org_code").value))
	if(isValidOrgCode()==false)
	{
	alert("组织机构代码证不符合规范");
	form1.org_code.focus();
	return false;}
	}
</script>


</head>
<body onLoad="public_onload();fun_winMax();" class="linetype">
<!--
<form name="form1" method="post" action="frkh_save.jsp"  onSubmit="return Validator.Validate(this,3);">
-->

<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 新增客户信息(法人)
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="提交" onclick="CheckOrgCode()" type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>
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
 </table>

   <script language="javascript">
ShowTabN(0);
</script>
</td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>
<!--
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
-->
<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">

<input type="hidden" name="savetype" value="add">
<table border="1" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
  <tr>
	<td nowrap class="text">客户名称：</td>
	<td nowrap class="text"><input class="text" id="cust_name" name="cust_name" type="text"   value=""  maxB="40" Require="true" onBlur="namecheck()">
             <span class="biTian">*</span></td>
  <td nowrap class="text">英文名称：</td>
	<td nowrap class="text"><input class="text" id="cust_ename" name="cust_ename" type="text"  value="" dataType="English" maxB="20"></td>
	<td nowrap class="text">客户简称：</td>
	<td nowrap class="text"><input class="text" id="cust_byname" name="cust_byname" type="text"   value="" maxB="15"></td>
	</tr>
	
	<tr>
	<td nowrap class="text">内部行业：</td>
	
 <td nowrap class="text"><select name="industry_type" Require="true" ></select>
<script language="javascript" class="text">dict_list("industry_type","industry_type","","title");</script>
<span class="biTian">*</span>
 </td>
  <td nowrap class="text"> 客户类别大类：</td>
    <td nowrap class="text"><input class="text" type="text" name="cust_type" readonly Require="ture"  >
    <input type="hidden" name="lbdlmc" onPropertychange="form1.cust_type2.value='';form1.lbxlmc.value='';" />
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','客户类别大类','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.cust_type','form1.lbdlmc');">
	<span class="biTian">*</span></td>
    <td nowrap class="text">客户类别小类：</td>
    <td nowrap class="text"><input class="text" type="text"  name="cust_type2" readonly Require="ture" />
    <input type="hidden" name="lbxlmc" onPropertychange="" />
     <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.lbdlmc','客户类别大类','ssdl','string','客户类别小类','kh_lbxl','lbxlmc','id','lbxlmc','lbxlmc','asc','form1.cust_type2','form1.lbxlmc');">
	<span class="biTian">*</span></td>
</tr>

	<tr>
    <td nowrap class="text">客户所属行业门类：</td>
    <td nowrap class="text"><input class="text" name="industry_level1" type="text"  readonly  Require="true" />
   		<input name="hymlmc" type="hidden" size="3" onPropertychange="form1.industry_level2.value='';form1.hydlmc.value='';form1.industry_level2.value='';form1.hyzlmc.value='';form1.industry_level2.value='';form1.hyxlmc.value='';"/>
   		<img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer"
 		onclick="SpecialDataWindow('行业门类','kh_hyml_gb','hymlmc','hymlbh','hymlmc','stringfld','hymlbh','form1.industry_level1','form1.hymlmc');">
 		<span class="biTian">*</span> </td>
 		
 	<td nowrap class="text">客户所属行业大类：</td>
    	<td><input class="text" name="industry_level2" type="text"   readonly  Require="true" >
    	<input name="hydlmc" type="hidden" size="3"  onPropertychange="form1.industry_level3.value='';form1.hyzlmc.value='';form1.industry_level4.value='';form1.hyxlmc.value='';"/>
    	<img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hymlmc,'该行业大类所属门类','kh_hydl_gb','hydlmc','hydlbh','hymlbh','stringfld','hydlmc','form1.industry_level2','form1.hydlmc');"> <span class="biTian">*</span></td>
<td nowrap class="text">客户所属行业中类：</td>
    	<td><input class="text" name="industry_level3" type="text"   readonly  Require="true" >
    	<input name="hyzlmc" type="hidden" size="3" onPropertychange="form1.industry_level4.value='';form1.hyxlmc.value='';"/>
        <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hydlmc,'该行业中类所属大类','kh_hyzl_gb','hyzlmc','hyzlbh','substring(hyzlbh,1,2)','stringfld','hyzlmc','form1.industry_level3','form1.hyzlmc');">
		<span class="biTian">*</span>
	  	</td>   	
</tr>

	<tr>
     <td nowrap class="text">客户所属行业小类：</td>
    	<td><input class="text" name="industry_level4" type="text"   readonly  Require="true" />
    	<input name="hyxlmc" type="hidden" size="3" onPropertychange="" />
    	<img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hyzlmc,'该行业小类所属中类','kh_hyxl_gb','hyxlmc','hyxlbh','substring(hyxlbh,2,3)','stringfld','hyxlmc','form1.industry_level4','form1.hyxlmc');">
		<span class="biTian">*</span>
	  	</td>
	<td nowrap class="text">国家：</td>
    <td nowrap class="text"><input class="text" type="text"  name="country" value="中华人民共和国" readonly Require="true" >
    <input type="hidden" name="gjmc" value="CHN" onPropertychange="form1.qymc.value='';form1.qymc.value='';">
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.country','form1.gjmc');">
	<span class="biTian">*</span></td>
	 <td nowrap class="text">区域：</td>
    <td nowrap class="text"><input class="text" type="text"   name="area" readonly Require="true" />
    <input type="hidden" name="qymc" onPropertychange="form1.province.value='';form1.sfmc.value='';form1.city.value='';form1.csmc.value='';"/> 
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','区域','jb_qyxx','qymc','qyid','qymc','qymc','asc','form1.area','form1.qymc');">
	<span class="biTian">*</span></td>
    </tr>    
    
    <tr>
   <td>省份：</td>
    <td nowrap class="text"><input class="text" type="text"   name="province" readonly Require="true"/>
    <input type="hidden" name="sfmc" onPropertychange="form1.city.value='';form1.csmc.value='';"/> 
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" 
    onClick="OpenDataWindow('form1.qymc','区域','qyid','string','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.province','form1.sfmc');">
	<span class="biTian">*</span></td>
    <td nowrap class="text">城市：</td>
    <td nowrap class="text"><input class="text" type="text"  name="city" readonly Require="true" >
    <input type="hidden" name="csmc" value=""> 
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" 
    onClick="OpenDataWindow('form1.sfmc','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.city','form1.csmc');">
	<span class="biTian">*</span>
	</td>
		<td >法人代表：</td>
	<td nowrap class="text"><input class="text" id="legal_representative" name="legal_representative" type="text"   value="" maxB="30"></td>
  </tr>		

   <tr>
   <td nowrap class="text">法人代表身份证号：</td>
	<td nowrap class="text"><input class="text" id="id_card_no" name="id_card_no" type="text"   value="" Require="true" onBlur="cardcheck()" >
		<span class="biTian">*</span>
		</td>
   <td nowrap class="text">注册地址：</td>
	<td nowrap class="text"><input class="text" id="reg_addr" name="reg_addr" type="text"   value=""></td>
	<td nowrap class="text">公司地址：</td>
	<td nowrap class="text"><input class="text" id="office_addr" name="office_addr" type="text"   value=""></td>
   </tr>
   
   <tr>
   <td nowrap class="text">准确邮编地址：</td>
	<td nowrap class="text"><input class="text" id="mail_addr" name="mail_addr" type="text"   value="" Require="true">
	<span class="biTian">*</span></td>
	<td nowrap class="text">邮编：</td>
	<td nowrap class="text"><input class="text" id="post_code" name="post_code" type="text"   value="" Require="true" minB="6" maxB="6" dataType="Zip">	
	<span class="biTian">*</span></td>
	 <td nowrap class="text">联系人：</td>
	<td nowrap class="text"><input class="text" id="linkman" name="linkman" type="text"   value=""></td>
   </tr>
 
    <tr>
	<td nowrap class="text">电话：</td>
	<td nowrap class="text"><input class="text" id="phone" name="phone" type="text"   value=""  >
	</td>
   <td nowrap class="text">手机：</td>
	<td nowrap class="text"><input class="text" id="mobile_number" name="mobile_number" type="text"   value="" dataType="Mobile_T">
	</td>
	<td nowrap class="text">传真：</td>
	<td nowrap class="text"><input class="text" id="fax_number" name="fax_number" type="text"   value=""></td>
   </tr>
   
   <tr>
   <td nowrap class="text">电挂：</td>
	<td nowrap class="text"><input class="text" id="cable_addr" name="cable_addr" type="text"  value=""></td>
	<td nowrap class="text">e_mail地址：</td>
	<td nowrap class="text"><input class="text" id="e_mail" name="e_mail" type="text"   value="" dataType="Email "></td>
	   <td nowrap class="text">网站：</td>
	<td nowrap class="text"><input class="text" id="web_site" name="web_site" type="text"   value="" maxB="30" dataType="Url"></td>
   </tr>
 
   <tr>
   	<td nowrap class="text">企业性质：</td>
	<td nowrap class="text"><input class="text" id="ownership" name="ownership" type="text"  value="" maxB="30"></td>
   <td>企业规模定级：</td>
	<td nowrap class="text"><input class="text" id="scale" name="scale" type="text"   value="" maxB="30"></td>
	<td nowrap class="text">组织机构代码：</td>
    <td nowrap class="text"><input class="text" name="org_code" type="text" maxlength="10" maxB="10" Require="true" onchange="CheckOrgCode()" 
    onBlur="codecheck()">
    <span class="biTian">*</span></td>
   </tr>
   
   <tr>
	<td nowrap class="text">经营范围(主营)：</td>
	<td nowrap class="text"><input class="text" id="biz_scope_primary" name="biz_scope_primary" type="text"   value=""></td>
    <td nowrap class="text">经营范围(兼营)：</td>
	<td nowrap class="text"><input class="text" id="biz_scope_secondary" name="biz_scope_secondary" type="text"   value="" maxB="30"></td>
	<td nowrap class="text">营业执照号：</td>
	<td nowrap class="text"><input class="text" id="license_number" name="license_number" type="text"   value=""></td>
   </tr>
   
   <tr>
   <td nowrap class="text">注册资金：</td>
	<td nowrap class="text"><input class="text" id="reg_capital" name="reg_capital" type="text"   value="" dataType="Money"></td>
    <td nowrap class="text">登记注册类型：</td>
	<td nowrap class="text"><input class="text" id="reg_type" name="reg_type" type="text"   value=""></td>
	<td nowrap class="text">成立日期：</td>
	<td nowrap class="text"><input class="text" id="estab_date" name="estab_date" type="text"   value="">
	
													<img onClick="openCalendar(estab_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
														</td>
   </tr>
   
   <tr>
    <td nowrap class="text">国税登记号：</td>
	<td nowrap class="text"><input class="text" id="national_tax_number" name="national_tax_number" type="text" ></td>
	<td nowrap class="text">地税登记号：</td>
	<td nowrap class="text"><input class="text" id="land_tax_number" name="land_tax_number" type="text"   value=""></td>
	  <td nowrap class="text">上市公司标志：</td>
	  <td scope="row" nowrap>
													<input name="listed_corp_flag" type="radio" value="否" checked="checked">
													否
													<input name="listed_corp_flag" type="radio" value="是">
											是
													<span class="biTian">*</span>

</td>
   </tr>
   
    <tr>
    <td nowrap class="text">进出口权标志：</td>
	<td scope="row" nowrap>
													<input name="imp_exp_flag" type="radio" value="否" checked="checked">
													否
													<input name="imp_exp_flag" type="radio" value="是">
													是
													

</td>
    <td nowrap class="text">信息状态：</td>
	<td nowrap class="text"><input class="text" id="info_flag" name="info_flag" type="text"   value="" maxB="30"></td>
	<td nowrap class="text">贷款证号码：</td>
	<td nowrap class="text"><input class="text" id="loan_number" name="loan_number" type="text"   value="" maxB="30"></td>
	</tr>
	
	<tr>
	<td nowrap class="text">营业执照到期日期：</td>
	<td nowrap class="text"><input class="text" id="license_exp_date" name="license_exp_date" type="text"   value="">
   <img onClick="openCalendar(license_exp_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
														</td> 
														</tr>
			<tr>
	<td>备注：</td>
	<td colspan="20" nowrap><textarea class="text" id="memo" name="memo" rows="5" value=""  maxB="500"></textarea></td>
	<td></td>
	<td></td>
   </tr>
   
 
</table>
</div>

<script type="text/javascript">
	function searchInfo(){
		var cardNo=$("#org_code").val();
		$.ajax({
   			type: "POST",
   			url: "frkh_info.jsp",
   			data: "cardId="+cardNo,
   			dataType: "xml",
   			success:function(data){
   				var obj = $(data);
   				var error=obj.find("error").text();
   				if(error==""){
    				$("#custId").val(obj.find("custId").text());
				    $("#custName").val(obj.find("custName").text());
				    $("#licenseNo").val(obj.find("licenseNo").text());
				    $("#comTel").val(obj.find("comTel").text());
				    $("#legal").val(obj.find("legal").text());
				    $("#legalCardNo").val(obj.find("legalCardNo").text());
				    $("#legalTel").val(obj.find("legalTel").text());
				    $("#legalPhone").val(obj.find("legalPhone").text());
				    $("#province").val(obj.find("province").text());
				    $("#provinceName").val(obj.find("provinceName").text());
				    $("#city").val(obj.find("city").text());
				    $("#contact").val(obj.find("contact").text());
				    $("#contactCardNo").val(obj.find("contactCardNo").text());
				    $("#contactTel").val(obj.find("contactTel").text());
				    $("#contactPhone").val(obj.find("contactPhone").text());
					var branchval=obj.find("branch").text()
					$("#branch option[value='"+branchval+"']").attr("selected",true);

				    $("#assets").val(obj.find("assets").text());
				    $("#regMoney").val(obj.find("regMoney").text());
				    $("#savetype").val("add2");
   				}else{
   				    alert(error);
    				$("#custId").val("");
				    $("#custName").val("");
				    $("#licenseNo").val("");
				    $("#comTel").val("");
				    $("#legal").val("");
				    $("#legalCardNo").val("");
				    $("#legalTel").val("");
				    $("#legalPhone").val("");
				    $("#province").val("");
				    $("#provinceName").val("");
				    $("#city").val("");
				    $("#contact").val("");
				    $("#contactCardNo").val("");
				    $("#contactTel").val("");
				    $("#contactPhone").val("");
				    $("#branch").val("");    
				    $("#regMoney").val(""); 
				    $("#assets").val(""); 
				   $("#savetype").val("add");
			    }
   			}
   		});
	}
</script>
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
