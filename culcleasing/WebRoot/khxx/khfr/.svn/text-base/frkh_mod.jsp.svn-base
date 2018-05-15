<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>

<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改个人客户(法人)信息 - 客户信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
	<script src="../../js/calend.js"></script>
</head>

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



<%
String czid = getStr( request.getParameter("czid") );
	String custId = getStr( request.getParameter("custId") );
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator)from vi_cust_info where cust_id='"+custId+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
    String cust_id="";
	String cust_name="";
	String cust_ename="";
	String cust_byname="";
	String cust_type="";
	String cust_type2="";
	String industry_type="";
	String industry_Level1="";
	String industry_Level2="";
	String industry_Level3="";
	String industry_level4="";
	String country="";
	String province="";
	String city="";
	String memo="";
	String id_card_no="";
	String legal_representative="";
	String reg_addr="";
	String office_addr="";
	String post_code="";
	String mail_addr="";
	String phone="";
	String linkman="";
	String creator="";
	String imp_exp_flag="";
	String listed_corp_flag="";
	String land_tax_number="";
	String national_tax_number="";
	String scale="";
	String e_mail="";
	String ownership="";
	String mobile_number="";
	String cable_addr="";
	String org_code="";
	String license_number="";
	String loan_number="";
        String loan_number_pwd="";
	String biz_scope_primary="";
	String web_site="";
	String fax_number="";
	String biz_scope_secondary="";
	String reg_capital="";
	String reg_type="";
	String license_exp_date="";
	String estab_date="";
	String creator_dept="";
	String info_flag="";
	String modify_date="";
	String create_date="";
	String area="";
	String region="";
	String modificator="";
	String provinceName="";
	String reg_money="";
	String assets="";
	String parent_company="";
		String lbdldata = "";
		String lbxldata = "";
		String hymldata = "";
		String hydldata = "";
		String hyzldata = "";
		String hyxldata = "";
		String gjdata = "";
		String qydata = "";
		String sfdata = "";
		String csdata = "";
		String djr="";
		//类别 id
		String lbdl="";
		String lbxl="";
		//行业所属类
		
		String hyml="";
		String hydl="";
		String hyzl="";
		String hyxl="";
		//国家 区域 省份 城市
		String gj="";
		String qy="";
		String sf="";
		String cs="";
		String cust_no_type="";
	if(rs.next()){
	
	
	//类别大小类
	//lbdldata=getDBStr(rs.getString("cust_type"));
	//lbxldata=getDBStr(rs.getString("cust_type2"));
	lbdldata=getDBStr(rs.getString("lbdlmc"));
	lbxldata=getDBStr(rs.getString("lbxlmc"));
	lbdl=getDBStr(rs.getString("cust_type"));
	lbxl=getDBStr(rs.getString("cust_type2"));
	//客户门类 大类 中类 小类
	hymldata=getDBStr(rs.getString("hymlmc"));
	hydldata=getDBStr(rs.getString("hydlmc"));
	hyzldata=getDBStr(rs.getString("hyzlmc"));
	hyxldata=getDBStr(rs.getString("hyxlmc"));
    hyml=getDBStr(rs.getString("industry_level1"));
    hydl=getDBStr(rs.getString("industry_level2"));
    hyzl=getDBStr(rs.getString("industry_level3"));
    hyxl=getDBStr(rs.getString("industry_level4"));
	//国家 区域 省份 城市
	gjdata=getDBStr(rs.getString("gjmc"));
	qydata=getDBStr(rs.getString("qymc"));
	sfdata=getDBStr(rs.getString("sfmc"));
	csdata=getDBStr(rs.getString("csmc"));
	gj=getDBStr(rs.getString("country"));
	qy=getDBStr(rs.getString("area"));
	sf=getDBStr(rs.getString("province"));
	cs=getDBStr(rs.getString("city"));
	parent_company=getDBStr(rs.getString("parent_company"));
		cust_id=getDBStr(rs.getString("cust_id"));
		cust_name=getDBStr(rs.getString("cust_name"));
		cust_ename=getDBStr(rs.getString("cust_ename"));
		cust_byname=getDBStr(rs.getString("cust_byname"));
		city=getDBStr(rs.getString("city"));
		memo=getDBStr(rs.getString("memo"));
		cust_type=getDBStr(rs.getString("cust_type"));
		cust_type2=getDBStr(rs.getString("cust_type2"));
		industry_type=getDBStr(rs.getString("industry_type"));
		industry_Level1=getDBStr(rs.getString("industry_Level1"));
		industry_Level2=getDBStr(rs.getString("industry_Level2"));
		industry_Level3=getDBStr(rs.getString("industry_Level3"));
		industry_level4=getDBStr(rs.getString("industry_level4"));
		country=getDBStr(rs.getString("country"));
		area=getDBStr(rs.getString("area"));
		region=getDBStr(rs.getString("region"));
		id_card_no=getDBStr(rs.getString("id_card_no"));
		legal_representative=getDBStr(rs.getString("legal_representative"));
		reg_addr=getDBStr(rs.getString("reg_addr"));
		office_addr=getDBStr(rs.getString("office_addr"));
		post_code=getDBStr(rs.getString("post_code"));
		mail_addr=getDBStr(rs.getString("mail_addr"));
		phone=getDBStr(rs.getString("phone"));
		linkman=getDBStr(rs.getString("linkman"));
		cust_byname=getDBStr(rs.getString("cust_byname"));
		province=getDBStr(rs.getString("province"));
		mobile_number=getDBStr(rs.getString("mobile_number"));
		fax_number=getDBStr(rs.getString("fax_number"));
	    cable_addr=getDBStr(rs.getString("cable_addr"));
		web_site=getDBStr(rs.getString("web_site"));
		ownership=getDBStr(rs.getString("ownership"));
		e_mail=getDBStr(rs.getString("e_mail"));
	    scale=getDBStr(rs.getString("scale"));
	    org_code=getDBStr(rs.getString("org_code"));
	    biz_scope_primary=getDBStr(rs.getString("biz_scope_primary"));
	   	loan_number=getDBStr(rs.getString("loan_number"));
                loan_number_pwd=getDBStr(rs.getString("loan_number_pwd"));
	   	license_number=getDBStr(rs.getString("license_number"));
	   	biz_scope_secondary=getDBStr(rs.getString("biz_scope_secondary"));
		reg_capital=getDBStr(rs.getString("reg_capital"));
	    license_exp_date=getDBStr(rs.getString("license_exp_date"));
		reg_type=getDBStr(rs.getString("reg_type"));
		estab_date=getDBStr(rs.getString("estab_date"));
		national_tax_number=getDBStr(rs.getString("national_tax_number"));
	    land_tax_number=getDBStr(rs.getString("land_tax_number"));
	    listed_corp_flag=getDBStr(rs.getString("listed_corp_flag"));
	    imp_exp_flag=getDBStr(rs.getString("imp_exp_flag"));
	   	creator=getDBStr(rs.getString("dengjiren"));
	   	creator_dept=getDBStr(rs.getString("creator_dept"));
	   	info_flag=getDBStr(rs.getString("info_flag"));
	   	cust_no_type=getDBStr(rs.getString("cust_no_type"));
	   	
	   	create_date=getDBStr(rs.getString("create_date"));
	   	modify_date=getDBStr(rs.getString("modify_date"));
	   	modificator=getDBStr(rs.getString("xiugairen"));
	   	modificator=getDBStr(rs.getString("modificator"));
	   	
	   	//djr=getDBStr(rs.getString("creator"));
	//   if ((djr==null) || (djr.equals("")))
		//{
		//	djr="无记录";
		//}
	}
	rs.close(); 
	String sql="select * from dbo.base_department where id='"+cust_id+"'";
	ResultSet rs1 = db.executeQuery(sql);
	String dept_name="";
	if(rs1.next()){
	dept_name=getDBStr(rs1.getString("dept_name"));
	}
	System.out.println(dept_name+"12");
	rs1.close(); 
	db.close();
%>


<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_frkh_mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>

<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="frkh_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 修改个人客户(法人)信息
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td scope="row" nowrap class="text">
	    	
<BUTTON class="btn_2" name="btnSave" value="提交" type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
  <script language="javascript">
ShowTabN(0);
</script></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>
<!--
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="custId" value="<%=custId  %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
  <td scope="row" nowrap class="text">客户编号：</td>
    <td scope="row" nowrap class="text"><input class="text" name="cust_id" type="text" readonly value="<%=custId%>"/></td>
  <td scope="row" nowrap class="text">客户名称：</td>
    <td scope="row" nowrap class="text"><input class="text" name="cust_name" type="text" value="<%=cust_name %>" Require="true" readonly>
		<span class="biTian">*</span>
	</td>
	  <td scope="row" nowrap class="text">英文名称：</td>
    <td ><input class="text" name=cust_ename type="text" readonly value="<%=cust_ename %>"></td>
  </tr>
  
 <tr>
  <td scope="row" nowrap class="text">客户简称：</td>
    <td scope="row" nowrap class="text"><input class="text" name="cust_byname" type="text" value="<%=cust_byname %>" >
		
	</td>
<td scope="row" nowrap>客户类别大类：</td>
    <td scope="row" nowrap class="text">
    	<input class="text" name="lbdldata" readonly Require="true" value="<%=lbdldata%>"  maxB="100"/>
    	<input type="hidden" name="lbdlmc" value="<%=cust_type%>"  value="<%=lbdl%>"/> 
    	<img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','客户类别大类','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.lbdlmc');">
		<span class="biTian">*</span>
	</td>
	  	<td scope="row" nowrap class="text">客户类别小类：</td>
    <td scope="row" nowrap class="text"><input class="text" type="text"  name="lbxldata" readonly Require="true" maxB="100" value="<%=lbxldata%>">
    <input type="hidden" name="lbxlmc"  value="<%=lbxl%>"/> 
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.lbdlmc','客户类别大类','ssdl','string','客户类别小类','kh_lbxl','lbxlmc','id','lbxlmc','lbxlmc','asc','form1.lbxldata','form1.lbxlmc');">
	<span class="biTian">*</span></td>
</tr>
<tr>
<td scope="row" nowrap>内部行业：</td>
    <td scope="row" nowrap class="text">
<select class="text" name="industry_type" Require="true" ></select>
<script language="javascript">dict_list("industry_type","industry_type","<%=industry_type %>","title");</script>
<span class="biTian">*</span>
 </td>

    <td scope="row" nowrap class="text">客户所属行业门类：</td>
    <td scope="row" nowrap class="text"><input class="text" name="hymldata" type="text"  readonly  Require="true" maxB="100" value="<%=hymldata%>">
   		<input name="hymlmc" type="hidden"  onPropertychange="form1.hydldata.value='';form1.hydlmc.value='';form1.hyzldata.value='';form1.hyzlmc.value='';form1.hyxldata.value='';form1.hyxlmc.value='';" value="<%=hyml%>"><img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer"
 		onclick="SpecialDataWindow('行业门类','kh_hyml_gb','hymlmc','hymlbh','hymlmc','stringfld','hymlbh','form1.hymldata','form1.hymlmc');">
 		<span class="biTian">*</span> </td>

 	<td scope="row" nowrap>客户所属行业大类：</td>
    	<td scope="row" nowrap><input class="text" name="hydldata" type="text"  readonly  Require="true" maxB="100" value="<%=hydldata%>">
    	<input name="hydlmc" type="hidden"  onPropertychange="form1.hyzldata.value='';form1.hyzlmc.value='';form1.hyxldata.value='';form1.hyxlmc.value='';"  value="<%=hydl%>"><img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hymlmc,'该行业大类所属门类','kh_hydl_gb','hydlmc','hydlbh','hymlbh','stringfld','hydlmc','form1.hydldata','form1.hydlmc');"> <span class="biTian">*</span></td>
</tr>
<tr>
   		<td scope="row" nowrap>客户所属行业中类：</td>
    	<td scope="row" nowrap><input class="text" name="hyzldata" type="text"  readonly  Require="true" maxB="100" value="<%=hyzldata%>">
    	<input name="hyzlmc" type="hidden"  onPropertychange="form1.hyxldata.value='';form1.hyxlmc.value='';"  value="<%=hyzl%>">
    	<img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hydlmc,'该行业中类所属大类','kh_hyzl_gb','hyzlmc','hyzlbh','substring(hyzlbh,1,2)','stringfld','hyzlmc','form1.hyzldata','form1.hyzlmc');">
		<span class="biTian">*</span>
	  	</td>   		
 
     <td scope="row" nowrap class="text">客户所属行业小类：</td>
    	<td scope="row" nowrap><input class="text" name="hyxldata" type="text"  readonly  Require="true" maxB="100" value="<%=hyxldata%>"  >
    	<input name="hyxlmc" type="hidden"  onPropertychange="" value="<%=hyxl%>"><img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hyzlmc,'该行业小类所属中类','kh_hyxl_gb','hyxlmc','hyxlbh','substring(hyxlbh,2,3)','stringfld','hyxlmc','form1.hyxldata','form1.hyxlmc');">
		<span class="biTian">*</span>
	  	</td>

	<td scope="row" nowrap>国家：</td>
    <td scope="row" nowrap class="text"><input class="text" type="text"  name="gjdata" value="中华人民共和国" readonly Require="true" maxB="100" value="<%=gjdata%>"/>
    <input type="hidden" name="gjmc" value="CHN" onPropertychange="form1.qydata.value='';form1.area.value='';"  value="<%=gj%>"/>
   <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjdata','form1.gjmc');">
	<span class="biTian">*</span></td>
	</tr>
	
	<tr>
	<td scope="row" nowrap>区域：</td>
    <td scope="row" nowrap class="text"><input class="text" type="text"  name="qydata" readonly Require="true" maxB="100" value="<%=qydata%>"/>
    <input type="hidden" name="qymc" onPropertychange="form1.sfdata,form1.sfdata.value='';"  value="<%=qy%>"/> 
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','区域','jb_qyxx','qymc','qyid','qymc','qymc','asc','form1.qydata','form1.qymc');">
	<span class="biTian">*</span></td>
   <td scope="row" nowrap class="text">省份：</td>
    <td scope="row" nowrap class="text"><input class="text" type="text"  name="sfdata" readonly Require="true" maxB="100" value="<%=sfdata%>"/>
    <input type="hidden" name="sfmc" onPropertychange="form1.csdata.value='';form1.csmc.value='';"  value="<%=sf%>"/> 
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.qymc','区域','qyid','string','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.sfmc');">
	<span class="biTian">*</span></td>
    <td scope="row" nowrap class="text">城市：</td>
    <td scope="row" nowrap class="text"><input class="text" type="text"  name="csdata" readonly Require="true" maxB="100" value="<%=csdata%>"/>
    <input type="hidden" name="csmc" onPropertychange="form1.reg.value='';form1.region.value='';"  value="<%=cs%>"/> 
    <img src="../../images/fdmo_65.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.sfmc','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.csmc');">
	<span class="biTian">*</span>
	</td>
  </tr>	
  
  <tr>
  <td scope="row" nowrap class="text">法定代表人：</td>
    <td scope="row" nowrap class="text"><input class="text" name="legal_representative" type="text"  value="<%=legal_representative %>"></td>
       <td nowrap class="text">法人代表证件类型：</td>
   <td nowrap class="text"><select class="text" name="cust_no_type"><script>w(mSetOpt("<%=cust_no_type%>","|身份证|警官证|毕业证|护照|签证"));</script></select></td>
  <td scope="row" nowrap class="text">法定代表人证件号：</td>
    <td scope="row" nowrap class="text"><input class="text" name="id_card_no" type="text" value="<%=id_card_no %>" >
		
	</td>

  </tr>
  
  <tr>
  <td scope="row" nowrap class="text">公司地址:</td>
    <td scope="row" nowrap class="text"><input class="text" name="office_addr" type="text" value="<%=office_addr %>" >
	</td>
<td scope="row" nowrap class="text">准确邮编地址：</td>
    <td scope="row" nowrap class="text"><input class="text" name="mail_addr" type="text"  value="<%=mail_addr %>"></td>
	 <td scope="row" nowrap class="text">邮编:</td>
    <td scope="row" nowrap class="text"><input class="text" name="post_code" type="text" value="<%=post_code %>" Require="ture" minB="6" maxB="6">
		<span class="biTian">*</span>
	</td>
  
  </tr>
  
  <tr>
  <td scope="row" nowrap class="text">联系人：</td>
    <td scope="row" nowrap class="text"><input class="text" name="linkman" type="text"  value="<%=linkman %>"></td>
  <td scope="row" nowrap class="text">电话：</td>
    <td scope="row" nowrap class="text"><input class="text" name="phone" type="text" value="<%=phone %>" >
		
	</td>
  <td scope="row" nowrap class="text">手机：</td>
    <td scope="row" nowrap class="text"><input class="text" name="mobile_number" type="text"  value="<%=mobile_number %>" dataType="Number" maxB="11" minB="11"></td>
  </tr>
  
  <tr>
   <td scope="row" nowrap class="text">传真：</td>
    <td scope="row" nowrap class="text"><input class="text" name="fax_number" type="text" value="<%=fax_number %>" >
	</td>
  <td scope="row" nowrap class="text">电挂：</td>
    <td scope="row" nowrap class="text"><input class="text" name="cable_addr" type="text"  value="<%=cable_addr %>"></td>
  <td scope="row" nowrap class="text">网站：</td>
    <td scope="row" nowrap class="text"><input class="text" name="web_site" type="text" value="<%=web_site %>" dataType="Url">
		
	</td>
  </tr>
  
  <tr>
  <td scope="row" nowrap class="text">企业性质：</td>
    <td scope="row" nowrap class="text"><input class="text" name="ownership" type="text" value="<%=ownership %>" >
	
	</td>
  <td scope="row" nowrap class="text">企业规模定级：</td>
    <td scope="row" nowrap class="text"><input class="text" name="scale" type="text"  value="<%=scale %>"></td>
   <td scope="row" nowrap class="text">组织机构代码：</td>
    <td scope="row" nowrap class="text"><input class="text" name="org_code" type="text"  value="<%=org_code %>" onclick="CheckOrgCode()" maxB="10" minB="10">
		
	</td>

  </tr>
  
  <tr>
  <td >贷款证号码：</td>
    <td scope="row" nowrap class="text"><input class="text" name="loan_number" type="text"  value="<%=loan_number %>"></td>
<td >贷款证密码：</td>
    <td scope="row" nowrap class="text"><input class="text" name="loan_number_pwd" type="text"  value="<%=loan_number_pwd %>"></td>

	
  <td scope="row" nowrap class="text">e_mail地址：</td>
    <td scope="row" nowrap class="text"><input class="text" name="e_mail" type="text"  value="<%=e_mail %>" dataType="Email"></td>
  </tr>
  
  <tr>

  <td scope="row" nowrap class="text">营业执照号：</td>
    <td scope="row" nowrap class="text"><input class="text" name="license_number" type="text" value="<%=license_number %>" >
	
	</td>
  <td scope="row" nowrap class="text">营业执照到期日期：</td>
    <td scope="row" nowrap class="text"><input class="text" name="license_exp_date" type="text" value="<%=getDBDateStr(license_exp_date) %>" readonly>
  <img onClick="openCalendar(license_exp_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
   </td>

  <td scope="row" nowrap class="text">注册资金：</td>
    <td scope="row" nowrap class="text"><input class="text" name="reg_capital" type="text" value="<%=formatNumberDoubleTwo(reg_capital)%>" dataType="Money">
		
	</td>
  </tr>
  
  <tr>
    <td scope="row" nowrap class="text">登记注册类型：</td>
	<td scope="row" nowrap><input class="text" name="reg_type" type="text"  value="<%=reg_type %>"></td>
	<td >成立日期：</td>
	<td scope="row" nowrap><input class="text" name="estab_date" type="text" value="<%=getDBDateStr(estab_date) %>" readonly>
	<img onClick="openCalendar(estab_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
	</td>

    <td scope="row" nowrap class="text">国税登记号：</td>
	<td scope="row" nowrap><input class="text" name="national_tax_number" type="text"  value="<%=national_tax_number %>"></td>
</tr>
<tr>
	<td scope="row" nowrap>地税登记号：</td>
	<td scope="row" nowrap><input class="text" name="land_tax_number" type="text"  value="<%=land_tax_number %>"></td>
<td scope="row" nowrap class="text">上市公司标志：</td>
  
	<td scope="row" nowrap>
	<%
    if(listed_corp_flag.equals("是")){
    %>
   		<input name="listed_corp_flag" type="radio" value="是" checked="checked">是
		<input name="listed_corp_flag" type="radio" value="否">否
    <%
    }else{%>
		<input name="listed_corp_flag" type="radio" value="是" >是
		<input name="listed_corp_flag" type="radio" value="否" checked="checked">否
    
     <%}%>
	</td>		
						
      <td scope="row" nowrap class="text">进出口权标志：</td>
      <td scope="row" nowrap>
      <%
      if(imp_exp_flag.equals("是")){ %>
		<input name="imp_exp_flag" type="radio" value="是" checked="checked">是
		<input name="imp_exp_flag" type="radio" value="否">否
       <%
       }else{%>
		<input name="imp_exp_flag" type="radio" value="是" >是
		<input name="imp_exp_flag" type="radio" value="否" checked="checked">否
        <%}%>
		</td>	
   </tr>
 <tr>
     <td scope="row" nowrap class="text">注册地址：</td>
    <td scope="row" nowrap class="text"><input class="text"  name="reg_addr" type="text"  value="<%=reg_addr %>"></td>
  	  <td scope="row" nowrap class="text">分公司</td>
    <td scope="row" nowrap class="text"><input class="text" name="parent_company" type="text" value="<%=parent_company %>" ></td>
     <td scope="row" nowrap class="text">信息状态：</td>
	<td scope="row" nowrap><input class="text" name="info_flag" type="text"  value="<%=info_flag %>"></td>
  </tr>

   <tr>
	<td scope="row" nowrap>经营范围(主营)：</td>
	<td scope="row" nowrap><textarea class="text" name="biz_scope_primary" rows="5"  value="<%=biz_scope_primary%>" maxB="300"><%=biz_scope_primary %></textarea></td>
	<td scope="row" nowrap>经营范围(兼营)：</td>
	<td scope="row" nowrap><textarea class="text" name="biz_scope_secondary" rows="5"  value="<%=biz_scope_secondary%>" maxB="300"><%=biz_scope_secondary %></textarea></td>
   <td scope="row" nowrap class="text">备注：</td>
	<td><textarea class="text" name="memo" rows="5"  value="<%=memo%>" maxB="300"><%=memo %></textarea></td>
   </tr>
</table>
</div>

</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right"></td></tr>
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