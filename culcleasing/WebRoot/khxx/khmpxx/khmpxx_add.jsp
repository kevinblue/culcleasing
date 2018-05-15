<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script language="javascript">

function checkdata(obj)
{
    if (!checkNumber(document.getElementById("national_tax_number"),"国税登记号")) return false;
    if (!checkNumber(document.getElementById("land_tax_number"),"地税登记号")) return false;
    if (!checkNumber(document.getElementById("reg_number"),"登记注册号")) return false;
    if(document.getElementById("org_code").value!=""){
	   if (!checkORG(document.getElementById("org_code"))) return false;
		//if (!searchOrg(document.getElementById("org_code").value,document.getElementById("cust_name").value)) return false;
    }
	if (!checkDKK(document.getElementById("loan_number"))) return false;
	if (!checkPhone()) return false;
    return Validator.Validate(obj,3);
  
}
function checkPhone(){
	if(document.forms[0].phone.value==''){
		if(document.forms[0].mobile_number.value==''){
			alert("手机、电话必须填一个");
			return false;
		}
	}
	return true;
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

   if (code.length>1) {
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
	   
	}	
   
   return true;
}
</script>
</head>
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_khmpxx_add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="khmpxx_save.jsp"  onSubmit="return checkdata(this);">
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

<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>客户名称</td>
    <td><input name="cust_name" type="text" size="40" maxB="100"  Require="true">
	<span class="biTian">*</span></td>

    <td>英文名称</td>
    <td><input name="cust_ename" type="text" size="40" maxB="100" dataType="English"></td>
  </tr>
  <tr>
    <td>客户别名</td>
    <td><input name="cust_oname" type="text" size="40" maxB="40" ></td>

    <td>股份关系</td>
    <td><input name="stock" type="text" size="40" maxB="40" ></td>
  </tr>
  <tr>
    <td>组织机构代码</td>
    <td><input name="org_code" type="text" Require="true" size="40" maxB="40" onBlur="codecheck()"><span class="biTian">*</span></td>

  <td>内部行业分类</td>
    <td><select name="nbhydata" Require="true"></select><span class="biTian">*</span>
	  </td>
  </tr>
  <tr>
   		<td>客户类别</td>
    <td><input type="text" name="lbdldata" readonly Require="ture"><input type="hidden" name="category_level1" onPropertychange=""> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','客户类别','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.category_level1');">
	<span class="biTian">*</span></td>
    <td >&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
     <tr>
   		<td>客户所属行业大类</td>
    	<td><input name="hydldata" type="text" size="20" readonly>
    	<input name="industry_level1" type="hidden"  onPropertychange="form1.industry_level2.value='';form1.hyxldata.value='';"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onclick="OpenDataWindow('','','','','行业大类','kh_hydl_gb','hydlmc','hydlbh','hydlmc','hydlmc','asc','form1.hydldata','form1.industry_level1');">
	  	</td>

   		<td>客户所属行业小类</td>
    	<td><input name="hyxldata" type="text" size="20" readonly>
    	<input name="industry_level2" type="hidden"  onPropertychange=""><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onclick="OpenDataWindow('form1.industry_level1','客户所属行业大类','substring(hyxlbh,2,2)','string','行业大类','kh_hyxl_gb','hyxlmc','hyxlbh','hyxlmc','hyxlmc','asc','form1.hyxldata','form1.industry_level2');">
	  	</td>
 	</tr>
  <tr>
    <td>手机</td>
    <td><input name="mobile_number" type="text" size="20" maxb="40" dataType="MobileEXT">
      <span class="biTian">*</span>(手机和电话只要必填其中一项)</td>
    <td>电话</td><td><input name="phone" type="text" size="20" maxb="40" dataType="Phone" >
        <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>邮编</td>
    <td><input name="post_code" type="text" size="20" minb="6" maxb="6" require="true" dataType="Zip">
      <span class="biTian">*</span></td>

    <td>准确邮寄地址</td>
    <td><input name="mailing_addr" size="40" maxb="400" require="true">
      <span class="biTian">*</span></td>
  </tr>
    <tr>
    <td >注册地址</td>
    <td><input name="reg_addr" size="40" maxb="400" require="true">
      <span class="biTian">*</span></td>
    <td>公司地址</td>
    <td><input name="company_addr" size="40" maxB="400" require="true"><span class="biTian">*</span></td>
  </tr>

  <tr>

    <td>国家</td>
    <td><input type="text" name="gjdata" value="中华人民共和国" readonly require="ture">
      <input type="hidden" name="country" value="CHN"  onpropertychange="form1.sfdata.value='';form1.province.value='';form1.csdata.value='';form1.city.value='';">
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjdata','form1.country');"> <span class="biTian">*</span></td>
	<td>省份</td>
    <td><input type="text" name="sfdata" readonly require="ture">
      <input type="hidden" name="province" value="" onpropertychange="form1.csdata.value='';form1.city.value='';">
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.country','国家','','','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.province');"> <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>城市</td>
    <td><input type="text" name="csdata" readonly require="ture">
      <input type="hidden" name="city" value="" >
      <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.province','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.city');"> <span class="biTian">*</span></td>

    <td>区/县</td>
    <td><input type="text" name="county" require="ture" maxb="100">
      <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>上市公司标志</td>
    <td><select name="listed_corp_flag" require="true">
      <script>w(mSetOpt('否',"否|是"));</script>
    </select>
      <span class="biTian">*</span></td>
    <td>进出口权标志</td>
    <td><select name="imp_exp_flag">
      <script>w(mSetOpt('否',"否|是"));</script>
    </select></td>
  </tr>
  <tr>
      <td>登记注册号(营业执照号)</td>
      <td><input name="reg_number" type="text" require="true" size="20" maxb="40">
        <span class="biTian">*</span></td>

      <td>成立日期</td>
      <td><input name="estab_date" type="text" require="true" size="15" readonly maxlength="10" dataType="Date">
        <img  onClick="openCalendar(estab_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>

  <tr>

    <td>营业执照到期日期</td>
    <td><input name="license_exp_date" type="text" size="15" readonly maxlength="10" dataType="Date">
      <img  onClick="openCalendar(license_exp_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
	<td>工商年检到期日</td>
    <td><input name="annual_due_date" type="text"  size="15" readonly maxlength="10" dataType="Date">
      <img  onClick="openCalendar(annual_due_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
    <td>法人代表</td>
    <td><input name="legal_representative" type="text" size="20" maxb="40"></td>
    <td>法人代表身份证号</td>
    <td><input name="id_card_no" type="text" size="20" maxb="40" dataType="IdCard"></td>
  </tr>
    <tr>
    <td>单位职务</td>
    <td><input name="position" type="text" size="40" maxb="40" ></td>

    <td>贷款证号码</td>
    <td><input name="loan_number" type="text" size="20" maxb="40"></td>
  </tr>

  <tr>
    <td>国税登记号</td>
    <td><input name="national_tax_number" type="text" size="20" maxB="40"></td>

    <td>地税登记号</td>
    <td><input name="land_tax_number" type="text" size="20" maxB="40"></td>
  </tr>
    <tr>
    <td>企业性质</td>
    <td><input name="quality" type="text" size="20" maxB="40"></td>
	<td>企业规模（定级）</td>
    <td><input name="scale_name" type="text" size="20" maxB="40"></td>
  </tr>

  <tr>
    <td>注册资本</td>
    <td><input name="reg_capital" type="text" size="20" dataType="Money"></td>

	<td>注册资本币种</td>
    <td>
	<select name="reg_capital_cur_name" value="人民币">
	  <option value="人民币">人民币</option>
	  <option value="美元">美元</option>
	</select>
	</td>
  </tr>
  <tr>
  <td>实收资本</td>
    <td><input name="fact_capital" type="text" size="20" dataType="Money"></td>

	<td>实收资金币种</td>
    <td>
	<select name="fact_capital_cur_name" value="人民币">
     <option value="人民币">人民币</option>
	  <option value="美元">美元</option>
      </select>
	</td>
  </tr>
  <tr>
    <td>网址</td>
    <td><input name="web_site" type="text" size="20" maxb="100" dataType="Url"></td>
    <td>电挂</td>
    <td><input name="cable_addr" type="text" size="20" maxB="40"></td>
  </tr>
  
   <tr>
    <td>传真</td>
    <td><input name="fax_number" type="text" size="20" maxB="40"></td>
    <td>税号</td>
    <td><input name="tax_number" type="text" size="20" maxB="40"></td>
  </tr>
  <tr>
    <td>承租人信息</td>
    <td><textarea name="cust_mesage" cols="40" rows="3" maxb="400"></textarea></td>

    <td>经营方式</td>
    <td><textarea name="biz_method" cols="40" rows="3" maxb="200"></textarea></td>
  </tr>
  <tr>
    <td>经营范围(主营)</td>
    <td><textarea name="biz_scope_primary" cols="40" rows="4" maxb="400"></textarea></td>
<td>经营范围(兼营)</td>
      <td><textarea name="biz_scope_secondary" cols="40" rows="4" maxb="400"></textarea></td>
  </tr>
  <tr>
    <td>产品和服务</td>
    <td><textarea name="biz_scope" cols="40" rows="3" maxB="400"></textarea></td>
<td>备注</td>
      <td><textarea name="memo" cols="40" rows="3" maxb="1000"></textarea></td>
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
<script language="javascript">

</script>
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
</script>
</form>

<!-- end cwMain -->
</body>
</html>
