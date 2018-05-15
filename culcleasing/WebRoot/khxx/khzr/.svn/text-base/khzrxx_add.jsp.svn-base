<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>客户名片信息 - 客户信息管理(个人)</title>
	
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/validator.js"></script>
	<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
	<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
	<script language="javascript" src="/dict/js/js_dictionary.js"></script>
	<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
	<script src="../../js/calend.js"></script>
</head>

<%
String dqczy=(String) session.getAttribute("czyid");

if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_zrrkh_add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
//所属公司
%>

<!-- <body onLoad="setDivHeight('divH',-55);fun_winMax();"> -->
<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="khzrxx_save.jsp"
	onSubmit="return Validator.Validate(this,3);">
		<style type="text/css">
body {
	overflow: hidden;
}
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
				<script type="text/javascript">
		function isConsort(){
			var consort=document.getElementsByName("marital_status");
			var index="是";
			for(var i=0;i<consort.length;i++){
				if(consort[i].checked==true){
					index=consort[i].value;
					break;
				}
			}
			if(index=="否"){
				document.getElementById("trConsort1").style.display="none";
				document.getElementById("trConsort2").style.display="none";
				document.getElementById("match").value="";
				document.getElementById("match_card_no").value="";
				document.getElementById("match_tel").value="";
				document.getElementById("matchPhone").value="";
			}else{
				document.getElementById("trConsort1").style.display="";
				document.getElementById("trConsort2").style.display="";
			}
		}
		//获取生日
		function findBrith(){
			var id_card_no=$("#id_card_no").val();
			var y=id_card_no.substring(6,10);
			var m=id_card_no.substring(10,12);
			var d=id_card_no.substring(12,14);
			var brith=y+"-"+m+"-"+d;
			$("#brith_date").val(brith);
		}
		function searchInfo(){
			var cardNo=$("#cardNo").val();
			$.ajax({
    			type: "POST",
    			url: "grkh_info.jsp",
    			data: "cardId="+cardNo,
    			dataType: "xml",
    			success:function(data){
    				var obj = $(data);
    				var error=obj.find("error").text();
    				if(error==""){
	    				$("#custId").val(obj.find("custId").text());
					    $("#custName").val(obj.find("custName").text());
				//	    $("#").val(obj.find("sex").text());
				//	    $("#").val(obj.find("maritalStatus").text());
					    $("#mobile_number").val(obj.find("mobile_number").text());
					    $("#phone").val(obj.find("phone").text());
					    $("#otherPhone").val(obj.find("otherPhone").text());
					    $("#homeAddress").val(obj.find("homeAddress").text());
					    $("#province").val(obj.find("province").text());
					    $("#provinceName").val(obj.find("provinceName").text());
					    $("#city").val(obj.find("city").text());
					    $("#mailAddress").val(obj.find("mailAddress").text());
					    $("#post_code").val(obj.find("post_code ").text());
					    $("#truster").val(obj.find("truster ").text());
					    $("#trusterTel").val(obj.find("trusterTel").text());
					    $("#trusterPhone").val(obj.find("trusterPhone").text());
					    $("#branch").val(obj.find("branch").text());
					    $("#memo").val(obj.find("memo").text());
					    $("#match").val(obj.find("match").text());
					    $("#matchCardNo").val(obj.find("matchCardNo").text());
					    $("#matchTel").val(obj.find("matchTel").text());
					    $("#matchPhone").val(obj.find("matchPhone").text());
					    $("#assets").val(obj.find("assets").text());
					    $("#savetype").val("mod");
    				}else{
    				    alert(error);
	    				$("#custId").val("");
					    $("#custName").val("");
					    $("#brithDate").val("");
					    $("#mobile_number").val("");
					    $("#phone").val("");
					    $("#otherPhone").val("");
					    $("#homeAddress").val("");
					    $("#province").val("");
					    $("#provinceName").val("");
					    $("#city").val("");
					    $("#mailAddress").val("");
					    $("#post_code").val("");
					    $("#truster").val("");
					    $("#trusterTel").val("");
					    $("#trusterPhone").val("");
					    $("#branch").val("");
					    $("#memo").val("");
					    $("#match").val("");
					    $("#matchCardNo").val("");
					    $("#matchTel").val("");
					    $("#matchPhone").val("");
					    $("#assets").val("");
					    $("#savetype").val("add");
				    }
    			}
    		});
		}
	</script>
				<script language="javascript">
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
				<table class="title_top" width=100% height=100% align=center
					cellspacing=0 border="0" cellpadding="0">
					<tr valign="top" class="tree_title_txt">
						<td class="tree_title_txt" height=26 valign="middle">
							客户信息管理 &gt; 新增客户信息(自然人)
						</td>
					</tr>
					<tr valign="top">
						<td align=center width=100% height=100%>
							<table align=center width=98% border="0" cellspacing="0"
								cellpadding="0" style="margin-top: 0px">
								<tr>
									<td scope="row" nowrap>
										<!--操作按钮开始-->
										<table border="0" cellspacing="0" cellpadding="0">
											<tr class="maintab_dh">
												<td nowrap>
													<BUTTON class="btn_2" name="btnSave" value="提交"
														type="submit">
														<img src="../../images/save.gif" align="absmiddle"
															border="0">
														提交生效
													</button>
													<BUTTON class="btn_2" name="btnReset" value="取消"
														onClick="window.close();">
														<img src="../../images/fdmo_37.gif" align="absmiddle"
															border="0">
														关闭
													</button>

												</td>
											</tr>
										</table>
										<!--操作按钮结束-->
									</td>
								</tr>
								<tr>
									<td height="1" bgcolor="#DFDFDF"></td>
								</tr>
								<tr>
									<td height="5"></td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td id="Form_tab_0" class="Form_tab" width=70 align=center
													onClick="chgTabN()" valign="middle">
													新 增
												</td>

												<td id="Form_tab_1" class="Form_tab" width=0 align=center
													onClick="chgTabN()" valign="middle"></td>
												<td id="Form_tab_2" class="Form_tab" width=0 align=center
													onClick="chgTabN()" valign="middle"></td>

											</tr>
										</table>
										 <script language="javascript">
ShowTabN(0);
</script>
									</td>
								</tr>
								<tr>
									<td class="tab_subline" width="100%" height="2"></td>
								</tr>
							</table>
							<center>
								
                                          
<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">
									
										<input type="hidden" name="savetype" value="add">
										<table border="0" cellspacing="0" cellpadding="0" width="96%"
											align="center" class="tab_table_title">
											<tr>
												<td scope="row" nowrap>
													客户名称：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="cust_name" type="text" Require="true" >
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap>
													英文名称：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="cust_ename" type="text" dataType="English">
												</td>
                                                                                                 <td scope="row" nowrap>
													性别：
												</td>
												<td scope="row" nowrap>
													<input name="sex" type="radio" value="男" checked="checked">
													男
													<input name="sex" type="radio" value="女">
													女
												
												</td>
												
											</tr>

											<tr>
											<td scope="row" nowrap>
													民族：
												</td>
												<td scope="row" nowrap>
												<input class="text" name="nation" type="text"  maxB="10">

												
												</td>
												
												
											<td scope="row" nowrap>
													证件类型：
												</td>
												
												  <td nowrap class="text"><select class="text" name="cust_no_type"><script>w(mSetOpt(" ","|身份证|警官证|毕业证|护照|签证"));</script></select></td>
											<td scope="row" nowrap>
													证件号码：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="id_card_no" type="text" Require="true"   />
													<span class="biTian">*</span>
												</td>
											
												</tr>
												<tr>
												<td scope="row" nowrap>
													客户所属行业门类：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="hymldata" type="text"  readonly
														Require="true" />
													<input name="hyml" type="hidden" size="3"
														onPropertychange="form1.hydldata.value='';form1.hydl.value='';form1.hyzldata.value='';form1.hyzl.value='';form1.hyxldata.value='';form1.hyxl.value='';" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onclick="SpecialDataWindow('行业门类','kh_hyml_gb','hymlmc','hymlbh','hymlmc','stringfld','hymlbh','form1.hymldata','form1.hyml');">
													<span class="biTian">*</span>
												</td>
											
												
 
												<td scope="row" nowrap>
													户口所在地：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="domicile_place" type="text" maxB="40">
												</td>
													<td scope="row" nowrap>
													出生日期：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="brith_date" type="text"  readonly/>
													 
													<img onClick="openCalendar(brith_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
														
													
													
												</td>
												</tr>
												<tr>
												<td scope="row" nowrap>
													客户所属行业大类：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="hydldata" type="text"  readonly
														Require="true" />
													<input name="hydl" type="hidden" size="5"
														onPropertychange="form1.hyzldata.value='';form1.hyzl.value='';form1.hyxldata.value='';form1.hyxl.value='';" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onclick="SimpleDataWindow(form1.hyml,'该行业大类所属门类','kh_hydl_gb','hydlmc','hydlbh','hymlbh','stringfld','hydlmc','form1.hydldata','form1.hydl');">
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap>
													客户类别大类：
												</td>
												<td scope="row" nowrap>
													<input class="text" type="text" name="lbdldata" readonly Require="true"
														 />
													<input type="hidden" name="cust_type"
														onPropertychange="form1.lbxldata.value='';form1.cust_type2.value='';" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onClick="OpenDataWindow('','','','','客户类别大类','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.cust_type');">
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap>
													客户类别小类：
												</td>
												<td scope="row" nowrap>
													<input class="text" type="text"  name="lbxldata" readonly
														Require="true" />
													<input type="hidden" name="cust_type2" onPropertychange="" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onClick="OpenDataWindow('form1.cust_type','客户类别大类','ssdl','string','客户类别小类','kh_lbxl','lbxlmc','id','lbxlmc','lbxlmc','asc','form1.lbxldata','form1.cust_type2');">
													<span class="biTian">*</span>
												</td>
											</tr>
											
											<tr>

												

												<td scope="row" nowrap>
													客户所属行业中类：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="hyzldata" type="text"  readonly
														Require="true" />
													<input name="hyzl" type="hidden" size="5"
														onPropertychange="form1.hyxldata.value='';form1.hyxl.value='';" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onclick="SimpleDataWindow(form1.hydl,'该行业中类所属大类','kh_hyzl_gb','hyzlmc','hyzlbh','substring(hyzlbh,1,2)','stringfld','hyzlmc','form1.hyzldata','form1.hyzl');">
													<span class="biTian">*</span>
												</td>
<td scope="row" nowrap>
													国家：
												</td>
												<td scope="row" nowrap>
													<input class="text" type="text"  name="gjdata"
														value="中华人民共和国" readonly Require="true" />
													<input type="hidden" name="gj" value="CHN"
														onPropertychange="form1.area.value='';form1.area.value='';" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjdata','form1.gj');">
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap>
													区域：
												</td>
												<td scope="row" nowrap>
													<input class="text" type="text"  name="ar" readonly
														Require="true" />
													<input type="hidden" name="area"
														onPropertychange="form1.sfdata,form1.sfdata.value='';" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onClick="OpenDataWindow('','','','','区域','jb_qyxx','qymc','qyid','qymc','qymc','asc','form1.ar','form1.area');">
													<span class="biTian">*</span>
												</td>
												</tr>
												<tr>
												<td scope="row" nowrap>
													客户所属行业小类：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="hyxldata" type="text"  readonly
														Require="true" />
													<input name="hyxl" type="hidden" size="5"
														onPropertychange="" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onclick="SimpleDataWindow(form1.hyzl,'该行业小类所属中类','kh_hyxl_gb','hyxlmc','hyxlbh','substring(hyxlbh,2,3)','stringfld','hyxlmc','form1.hyxldata','form1.hyxl');">
													<span class="biTian">*</span>
												</td>
											
												
												
												<td scope="row" nowrap>
													省份：
												</td>
												<td scope="row" nowrap>
													<input class="text" type="text"  name="sfdata" readonly
														Require="true" />
													<input type="hidden" name="sf"
														onPropertychange="form1.csdata.value='';form1.cs.value='';" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onClick="OpenDataWindow('form1.area','区域','qyid','string','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.sf');">
													<span class="biTian">*</span>
												</td>
											
												<td scope="row" nowrap>
													城市：
												</td>
												<td scope="row" nowrap>
													<input class="text" type="text"  name="csdata" readonly
														Require="true">
													<input type="hidden" name="cs" onPropertychange="";">
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onClick="OpenDataWindow('form1.sf','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.cs');">
													<span class="biTian">*</span>
												</td>


											</tr>

											<tr>
												<td scope="row" nowrap>
													单位地址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="work_add" type="text" maxB="40">
												</td>

												<td scope="row" nowrap>
													住宅地址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="home_add" type="text" maxB="40" >
													
												</td>
												<td scope="row" nowrap>
													邮寄地址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="mail_addr" type="text" 
														 maxB="40">
													
												</td>
												
												
											</tr>

											<tr>
												<td scope="row" nowrap>
													邮编：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="post_code" type="text"  minB="6"
														maxB="6"  >
													
												</td>
												<td scope="row" nowrap>
													电话：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="phone" type="text">
													
												</td>
												<td scope="row" nowrap>
													手机：
												</td>
												<td scope="row" nowrap>
													<input class="text" type="text" name="mobile_number"  dataType="Mobile_T"  />
													
												</td>
											
												
											</tr>

											<tr>
												<td scope="row" nowrap>
													传真：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="fax_number" type="text" maxB="15">
												</td>
												<td scope="row" nowrap>
													电挂：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="cable_addr" type="text" value="">
												</td>
												<td scope="row" nowrap>
													email地址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="e_mail" type="text" dataType="Email">
												</td>
												</tr>
												<tr>
												
												<td scope="row" nowrap>
													网址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="web_site" type="text" value="" dataType="Url">
												</td>
												<td scope="row" nowrap>
													婚姻状况：
												</td>
												<td scope="row" nowrap>
													<input name="marital_status" type="radio" value="是"
														checked="checked"  onclick="isConsort()">
													已婚
													<input name="marital_status" type="radio" value="否"
														onclick="isConsort()">
													未婚
													
												</td>
												<td scope="row" nowrap>所属公司</td>
												<td scope="row" nowrap><input class="text" name="parent_company" type="text"></td>
											</tr>
											<tr id="trConsort1">
												<td >
													配偶姓名：
												</td>
												<td >
													<input class="text" id="match" name="match" type="text" >
													
												</td>
												<td >
													配偶人身份证号：
												</td>
												<td scope="row" nowrap>
													<input class="text" id="match_card_no" name="match_card_no" type="text" >

													
												</td>
												<td scope="row" nowrap>营业执照号</td>
												<td scope="row" nowrap><input class="text" id="license_number" name="license_number" type="text" value=""></td>
											</tr>
											<tr id="trConsort2">
												<td scope="row" nowrap>
													配偶人手机：
												</td>
												<td scope="row" nowrap>
													<input class="text" id="match_tel" name="match_tel" type="text"
														dataType="MobileEXT" >
														
												</td>
												<td scope="row" nowrap>
													配偶人固定电话：
												</td>
												<td scope="row" nowrap>
													<input class="text" id="matchPhone" name="matchPhone" type="text"
														 >
														
												</td>
													<td scope="row" nowrap>
													内部行业：
												</td>
												<td scope="row" nowrap><select class="text" name="industry_type" Require="true" ></select><span class="biTian">*</span>
<script language="javascript">dict_list("industry_type","industry_type","","title");</script>
 </td>
											</tr>
											<tr>
											
												
													
												<td scope="row" nowrap>
													有无犯罪记录：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="criminal_record" type="text">

												</td>
												<td scope="row" nowrap>
													不良嗜好：
												</td>
												<td scope="row" nowrap>
													<select class="text" name="bad_hobby">
														<script>w(mSetOpt('无不良嗜好',"|无不良嗜好|酗酒|赌博|吸毒"));</script>
													</select>
												</td>
												
												<td scope="row" nowrap>
													学历:
												</td>
												<td scope="row" nowrap>
													<select class="text" name="education">
														<script>w(mSetOpt('本科以下',"|本科以下|本科|博士|硕士"));</script>
													</select>
												</td>
											</tr>
											
											<tr>
												
												
												<td scope="row" nowrap>
													毕业学校：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="school" type="text" maxB="100">
												</td>
											
												<td scope="row" nowrap>
													专业：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="major" type="text">
												</td>
												<td scope="row" nowrap>
													紧急联系人：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="express_linkman" type="text" maxB="40">

												</tr>
												<tr>
												<td scope="row" nowrap>
													信息状态：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="info_flag" type="text">
												</td>
											
												<td scope="row" nowrap>
													重要社会关系：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="imp_social_relation" type="text">

												</td>
												
											
											<tr>
													<td scope="row" nowrap>经营范围：
</td>
	    <td>
	   <textarea class="text" id="biz_scope" name="biz_scope"  value=""  maxB="500"></textarea></td>
												
												<td scope="row" nowrap>备注：
</td>
	    <td>
	   <textarea class="text" id="memo" name="memo"  value=""  maxB="500"></textarea></td>
	                                     
												<td scope="row" nowrap></td>
												<td scope="row" nowrap></td>
											</tr>
											
											
										</table>
									</div>

									<div id="TD_tab_1" style="display: none;">
										选择卡中的内容2
									</div>
									<div id="TD_tab_2" style="display: none;">
										选择卡中的内容3 选择卡中可能包含以下内容： 注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。
									</div>
							</center>
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
