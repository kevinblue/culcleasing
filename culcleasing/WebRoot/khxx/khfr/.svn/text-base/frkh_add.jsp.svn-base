<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>
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

<script type="text/javascript">   
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


function isValidOrgCode(){
		
		var orgCode = form1.org_code.value;
		var resultSet;
                if(orgCode.length=0){
                  resultSet=true;
                }
		if (orgCode.length<10 && orgCode.length>1){
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
if(isValidOrgCode()==true){
return true;
}
	}
</script>
<style type="text/css">
body {overflow:hidden;}
</style>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%
dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_frkh_add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>

<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="frkh_save.jsp" onclick="chk()" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 新增客户信息(法人)
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
	
<div style="width:100%;margin-left:12px;margin-right:12px">
<table align=center width=100% border="0" cellspacing="0" cellpadding="0">
<tr>
<td>
<!--操作按钮开始-->
<div style="height:30px;padding-top:5px;">
<table border="0" cellspacing="0" cellpadding="0" width=100%>    
<tr><td >	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
	

<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>
    </td></tr>
</table>
</div>
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
</div>
<center>

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
  <tr>
	<td nowrap class="text">客户名称：</td>
	<td nowrap class="text"><input class="text" id="cust_name" name="cust_name" type="text"   value=""  maxB="100" Require="true" onBlur="namecheck()">
             <span class="biTian">*</span></td>
  <td nowrap class="text">英文名称：</td>
	<td nowrap class="text"><input class="text" id="cust_ename" name="cust_ename" type="text"  value="" dataType="English" maxB="50"></td>
	<td nowrap class="text">客户简称：</td>
	<td nowrap class="text"><input class="text" id="cust_byname" name="cust_byname" type="text"   value="" maxB="15"></td>
	</tr>
	
	<tr>
	<td nowrap class="text">内部行业：</td>
	
 <td nowrap class="text"><select class="text" name="industry_type" Require="true" ></select>
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
	<td nowrap class="text"><input class="text" id="legal_representative" name="legal_representative" type="text" Require="true"  value="" maxB="30"><span class="biTian">*</span></td>
  </tr>		

   <tr>
   <td nowrap class="text">法人代表证件类型：</td>
   <td nowrap class="text"><select class="text" name="cust_no_type"><script>w(mSetOpt(" ","|身份证|警官证|毕业证|护照|签证"));</script></select></td>
   
   <td nowrap class="text">法人代表证件号码：</td>
	<td nowrap class="text"><input class="text" id="id_card_no" name="id_card_no" type="text"   value="" >
		
		</td>
   <td nowrap class="text">注册地址：</td>
	<td nowrap class="text"><input class="text" id="reg_addr" name="reg_addr" type="text"   value=""></td>

   </tr>
   
   <tr>
   <td nowrap class="text">邮编：</td>
	<td nowrap class="text"><input class="text" id="post_code" name="post_code" type="text"   value="" Require="true" minB="6" maxB="6" >	
	<span class="biTian">*</span></td>
   <td nowrap class="text">准确邮编地址：</td>
	<td nowrap class="text"><input class="text" id="mail_addr" name="mail_addr" type="text"   value="" Require="true">
	<span class="biTian">*</span></td>
	 <td nowrap class="text">联系人：</td>
	<td nowrap class="text"><input class="text" id="linkman" name="linkman" type="text"   value=""></td>
   </tr>
 
    <tr>
	<td nowrap class="text">电话：</td>
	<td nowrap class="text"><input class="text" id="phone" name="phone" type="text"   value=""  >
	</td>
   <td nowrap class="text">手机：</td>
	<td nowrap class="text"><input class="text" id="mobile_number" name="mobile_number" type="text"   value="" dataType="Number" maxB="11" minB="11">
	</td>
	<td nowrap class="text">传真：</td>
	<td nowrap class="text"><input class="text" id="fax_number" name="fax_number" type="text"   value=""></td>
   </tr>
   
   <tr>
   <td nowrap class="text">电挂：</td>
	<td nowrap class="text"><input class="text" id="cable_addr" name="cable_addr" type="text"  value=""></td>
	<td nowrap class="text">e_mail地址：</td>
	<td nowrap class="text"><input class="text" id="e_mail" name="e_mail" type="text"   value="" dataType="Email"></td>
	   <td nowrap class="text">网站：</td>
	<td nowrap class="text"><input class="text" id="web_site" name="web_site" type="text"   value="" maxB="30" dataType="Url"></td>
   </tr>
 
   <tr>
   	<td nowrap class="text">企业性质：</td>
	<td nowrap class="text"><input class="text" id="ownership" name="ownership" type="text"  value="" maxB="30"></td>
    <td>企业规模定级：</td>
	<td nowrap class="text"><input class="text" id="scale" name="scale" type="text"   value="" maxB="30"></td>
	<td nowrap class="text">组织机构代码：</td>
    <td nowrap class="text"><input class="text" name="org_code" type="text" minB="10" maxB="10" onchange="CheckOrgCode()" >
    </td>
   </tr>
   
   <tr>
													<td nowrap class="text">分公司:</td>
														<td nowrap class="text"><input class="text" id="parent_company" name=""parent_company"" type="text"   value="" maxB="50"></td>


	<td nowrap class="text">营业执照号：</td>
	<td nowrap class="text"><input class="text" id="license_number" name="license_number" type="text"   value=""></td>
   </tr>
   
   <tr>
   <td nowrap class="text">注册资金：</td>
	<td nowrap class="text"><input class="text" id="reg_capital" name="reg_capital" type="text"   value="" dataType="Money"></td>
    <td nowrap class="text">登记注册类型：</td>
	<td nowrap class="text">
	
	<select id="reg_type" name="reg_type" style="width:163px;">
     <script>w(mSetOpt('',"<%=regtype_name_str %>"));</script>
     </select>
	</td>
	<td nowrap class="text">成立日期：</td>
	<td nowrap class="text"><input class="text" id="estab_date" name="estab_date" type="text" readonly  value="">
	
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
													

</td>
   </tr>
   
    <tr>
    
	<td nowrap class="text">贷款证号码：</td>
	<td nowrap class="text"><input class="text" id="loan_number" name="loan_number" type="text"   value="" maxB="30"></td>
<td nowrap class="text">贷款证密码：</td>
	<td nowrap class="text"><input class="text" id="loan_number_pwd" name="loan_number_pwd" type="text"   value="" maxB="30"></td>

    <td nowrap class="text">信息状态：</td>
	<td nowrap class="text"><input class="text" id="info_flag" name="info_flag" type="text"   value="" maxB="30"></td>
	</tr>
	
	<tr>
<td nowrap class="text">进出口权标志：</td>
	<td scope="row" nowrap>
	<input name="imp_exp_flag" type="radio" value="否" checked="checked">
	否
	<input name="imp_exp_flag" type="radio" value="是">
	是
</td>
	<td nowrap class="text">营业执照到期日期：</td>
	<td nowrap class="text"><input class="text" id="license_exp_date" name="license_exp_date" type="text" readonly value="">
   <img onClick="openCalendar(license_exp_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
														</td> 
															<td nowrap class="text">公司地址：</td>
	<td nowrap class="text"><input class="text" id="office_addr" name="office_addr" type="text"   value=""></td>
												</tr>
	<tr>
	<td>经营范围(主营)：</td>
	<td nowrap><textarea class="text" id="biz_scope_primary" style="width:" name="biz_scope_primary" rows="5" value=""  maxB="500"></textarea></td>
	<td>经营范围(兼营)：</td>
	<td nowrap><textarea class="text" id="biz_scope_secondary" name="biz_scope_secondary" rows="5" value="" style="width:"  maxB="500"></textarea></td>
	<td>备注：</td>
	<td nowrap><textarea class="text" id="memo" name="memo" style="width:" rows="5" value=""  maxB="500"></textarea></td>
   </tr>
   
 
</table>
</div>
<script type="text/javascript">
	function chk(){

	if(form1.org_code.value!=""){CheckOrgCode(); }
	
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
<%if(null != db){db.close();}%>