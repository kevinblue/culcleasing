<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户名片信息明细 - 客户信息管理(个人)</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String custId = getStr( request.getParameter("custId") );
	System.out.print(custId+"14");
	//String cust_id=getStr(request.getParameter("custId"));
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator),base_department.dept_name,match,match_card_no,match_tel,matchPhone from vi_cust_ewlp_info left join cust_mate on vi_cust_ewlp_info.cust_id=cust_mate.cust_id  left join base_department on vi_cust_ewlp_info.creator_dept=base_department.id where vi_cust_ewlp_info.cust_id='" + custId + "'"; 

	ResultSet rs = db.executeQuery(sqlstr); 
	
	String	cust_name = "";//客户名称 *
	String	cust_ename = "";//客户英文名
	String	sex = "";//客户性别
	String nation="";
	String	id_card_no = "";//证件号码 *
	String	brith_date = "";//出生年月
    String	lbdldata = "";
	String	lbxldata = "";
	String	industry_type = "";
	String	industry_level1 = "";
	String	industry_level2 = "";
	String	industry_level3 = "";
	String	industry_level4 = "";
	String	country = "";
	String	area = "";
	String	province = "";
	String	city = "";
	String  region="";
	String	domicile_place = "";
	String	work_add = "";
	String	home_add = "";
	String	mail_addr = "";
	String	post_code = "";
	String  phone = "";
	String	mobile_number = "";
	String	fax_number = "";
	String	cable_addr = "";
	String	e_mail = "";
	String  web_site = "";
	String	marital_status = "";
	String	imp_social_relation = "";
	String	criminal_record = "";
	String	bad_hobby = "";
	String	education = "";
	String school = "";
	String major = "";
	String express_linkman = "";
	String biz_scope = "";
	String	memo = "";
	String info_flag="";
	String	creator = "";
	String	dept_name = "";
	String	create_date = "";
	String  modificator = "";
	String	modify_date = "";
	//String	quality = "";
	String	hyxldata = "";
	String	hydldata = "";
	String	hyzldata = "";
	String	hymldata = "";
	String	nbhydata = "";
	String	gjdata = "";
	String	sfdata = "";
	String	csdata = "";
	String	qxdata = "";
	String creator_dept ="";
	String parent_company="";
	String license_number="";
	String cust_no_type="";
	//配偶信息
	String match="";
	String match_card_no="";
	String matchPhone="";
	String match_tel="";
	
	if ( rs.next() ) {
		match = getDBStr( rs.getString("match") );
		match_card_no = getDBStr( rs.getString("match_card_no") );
		matchPhone = getDBStr( rs.getString("matchPhone") );
		match_tel = getDBStr( rs.getString("match_tel") );
		cust_name = getDBStr( rs.getString("cust_name") );
		 parent_company=getDBStr( rs.getString("parent_company") );
		 license_number=getDBStr( rs.getString("license_number") );
		
		cust_ename = getDBStr( rs.getString("cust_ename") );
		sex = getDBStr( rs.getString("sex") );
		nation = getDBStr( rs.getString("nation") );
		id_card_no = getDBStr( rs.getString("id_card_no") );
		brith_date = getDBDateStr( rs.getString("brith_date") );
		
		//行业
		//quality = getDBStr( rs.getString("quality") );
		hydldata = getDBStr( rs.getString("hydlmc") );
		hyzldata = getDBStr( rs.getString("hyzlmc") );
		hyxldata = getDBStr( rs.getString("hyxlmc") );
		hymldata = getDBStr( rs.getString("hymlmc") );
		
		
		
		//国家、省份、城市
		gjdata = getDBStr( rs.getString("gjmc") );
		qxdata = getDBStr( rs.getString("qymc") );
		sfdata = getDBStr( rs.getString("sfmc") );
		csdata = getDBStr( rs.getString("csmc") );
	
		//大小类
		lbdldata = getDBStr( rs.getString("lbdlmc") );
		lbxldata = getDBStr( rs.getString("lbxlmc") );
		
		
		domicile_place = getDBStr( rs.getString("domicile_place") );
		work_add = getDBStr( rs.getString("work_add") );
		home_add = getDBStr( rs.getString("home_add") );
		mail_addr = getDBStr( rs.getString("mail_addr") );
		post_code = getDBStr( rs.getString("post_code") );
		phone = getDBStr( rs.getString("phone") );
		mobile_number = getDBStr( rs.getString("mobile_number") );
		fax_number = getDBStr( rs.getString("fax_number") );
		cable_addr = getDBStr( rs.getString("cable_addr") );
		e_mail = getDBStr( rs.getString("e_mail") );
		web_site = getDBStr( rs.getString("web_site") );
		marital_status=getDBStr( rs.getString("marital_status") );
		imp_social_relation=getDBStr( rs.getString("imp_social_relation") );
		criminal_record=getDBStr( rs.getString("criminal_record") );
		bad_hobby=getDBStr( rs.getString("bad_hobby") );
		education=getDBStr( rs.getString("education") );
		school=getDBStr( rs.getString("school") );
		major=getDBStr( rs.getString("major") );
		express_linkman=getDBStr( rs.getString("express_linkman") );
		biz_scope=getDBStr( rs.getString("biz_scope") );
		memo=getDBStr( rs.getString("memo") );
		
		System.out.println("memo="+memo);
		industry_type=getDBStr(rs.getString("industry_type"));
	 info_flag=getDBStr( rs.getString("info_flag") );
	 creator =getDBStr( rs.getString("dengjiren") );
	 	 creator_dept = getDBStr( rs.getString("creator_dept") );
	 //dept_name = getDBStr( rs.getString("dept_name") );
	 create_date=getDBStr( rs.getString("create_date") );
	 modificator=getDBStr( rs.getString("xiugairen") );
     modify_date=getDBStr( rs.getString("modify_date") );
     cust_no_type=getDBStr( rs.getString("cust_no_type") );
   
     
	}
	//rs.close(); 
	String sql="select dept_name from dbo.base_department where id='"+creator_dept+"'";
	
	//ResultSet 
	rs = db.executeQuery(sql);
	System.out.println("rs");
	//String dept_name="";
	if(rs.next()){
	dept_name=getDBStr(rs.getString("dept_name"));
	
	}
	System.out.println(dept_name+"12&&");
	
	rs.close(); 
	db.close();
%>
<body onLoad="public_onload();fun_winMax();">
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
		<td><a href="khzrxx_mod.jsp?custId=<%= custId %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/btn_edit.gif" width="19" height="19" align="absmiddle" >修改&nbsp;&nbsp;</a></td>
	  	<td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/fdmo_37.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
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
 </table>
  <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="15%">客户名称：</td>
    <td  scope="row" nowrap width="15%"><%= cust_name %></td>
    <td scope="row" nowrap width="15%">英文名称：</td>
    <td  scope="row" nowrap width="15%"><%= cust_ename %></td>
     <td scope="row" nowrap width="15%">性别：</td>
    <td><%=sex%></td>
  </tr>
  
  <tr>
	 <td scope="row" nowrap width="15%">民族：</td>
    <td><%=nation%></td>
        <td scope="row" nowrap width="15%">证件类型：</td>
    <td><%=cust_no_type%></td>
    <td scope="row" nowrap width="15%">证件号码：</td>
    <td><%=id_card_no%></td>

  </tr>
  
   <tr>
<td scope="row" nowrap width="15%">客户所属行业门类：</td>
	<td><%= hymldata %></td>

    
  <td scope="row" nowrap width="15%">户口所在地：</td>
    <td><%= domicile_place %></td>
	 <td scope="row" nowrap width="15%">出生日期：</td>
    <td><%= brith_date %></td>
	

  </tr>
  
   <tr>
	
	<td scope="row" nowrap width="15%">客户所属行业大类：</td>
	<td><%= hydldata %></td>
<td scope="row" nowrap width="15%">客户大类：</td>
	<td><%=lbdldata %></td>
	<td scope="row" nowrap width="15%">客户小类：</td>
	<td><%=lbxldata %></td>

	</tr>
	
	<tr>
	<td scope="row" nowrap width="15%">客户所属行业中类：</td>
	<td><%= hyzldata %></td>
    <td scope="row" nowrap width="15%">国家：</td>
    <td><%= gjdata %></td>
    <td scope="row" nowrap width="15%">区域：</td>
    <td><%= qxdata %></td>
    </tr>
    
    <tr>

    <td scope="row" nowrap width="15%">客户所属行业小类：</td>
	<td><%= hyxldata %></td>
    <td scope="row" nowrap width="15%">省份：</td>
    <td><%= sfdata %></td>
    <td scope="row" nowrap width="15%">城市：</td>
    <td><%= csdata %></td>
    </tr>
    
    <tr>
    <td scope="row" nowrap width="15%">单位地址：</td>
    <td><%= work_add %></td>
    <td scope="row" nowrap width="15%">住宅地址：</td>
    <td><%= home_add %></td>
    <td scope="row" nowrap width="15%">邮寄地址：</td>
    <td><%= mail_addr %></td>
    </tr>
    
    <tr>
	<td scope="row" nowrap width="15%">邮编：</td>
    <td><%= post_code %></td>
	  <td scope="row" nowrap width="15%">电话：</td>
    <td><%= phone %></td>
    <td scope="row" nowrap width="15%">手机：</td>
    <td><%= mobile_number %></td>
    </tr>
    
    <tr>
	<td scope="row" nowrap width="15%">传真：</td>
    <td><%= fax_number %></td>
    <td scope="row" nowrap width="15%">电挂：</td>
    <td><%= cable_addr %></td>
	<td scope="row" nowrap width="15%">E-mail地址：</td>
    <td><%= e_mail %></td>
    </tr>
    
    <tr>
	 <td scope="row" nowrap width="15%">网址：</td>
    <td><%=web_site %></td>
	<td scope="row" nowrap width="15%">E-婚姻状况</td>
    <td><%= marital_status %></td>
    <td scope="row" nowrap width="15%">配偶姓名：</td>
    <td><%=match %></td>
    </tr>
    
    <tr>
   <td scope="row" nowrap width="15%">配偶身份证号码：</td>
    <td><%=match_card_no %></td>
		  <td scope="row" nowrap width="15%">配偶手机：</td>
    <td><%=match_tel %></td>
 <td scope="row" nowrap width="15%">配偶固定电话：</td>
    <td><%=matchPhone %></td>
		</tr>
		
    <tr>

    <td scope="row" nowrap width="15%">有无犯罪记录：</td>
    <td><%= criminal_record %></td>
     <td scope="row" nowrap width="15%">不良嗜好：</td>
    <td><%= bad_hobby %></td>
	<td scope="row" nowrap width="15%">学历：</td>
    <td><%= education %></td>
    </tr>
    
    <tr>

	<td scope="row" nowrap width="15%">毕业学校：</td>
    <td><%= school %></td>
	<td scope="row" nowrap width="15%">专业：</td>
    <td><%= major %></td>
	<td scope="row" nowrap width="15%">紧急联系人：</td>
    <td><%= express_linkman %></td>
    </tr>
    
    <tr>

	<td scope="row" nowrap width="15%">信息状态：</td>
    <td><%= info_flag %></td>
	<td scope="row" nowrap width="15%">重要社会关系：</td>
    <td><%= imp_social_relation %></td>
</tr>

<tr>
<td scope="row" nowrap width="15%">所属公司：</td>
    <td><%= parent_company %></td>
	<td scope="row" nowrap width="15%">营业执照号：</td>
    <td><%= license_number %></td>
	<td scope="row" nowrap width="15%">内部行业：</td>
	<td><%= industry_type %></td>
</tr>

<tr>
	  <tr>
	   <td scope="row" nowrap width="15%">经营范围：</td>
    <td><textarea class="text" readonly><%= biz_scope %></textarea></td> 
  <td scope="row" nowrap width="15%">备注：</td>
    <td><textarea class="text" readonly><%= memo %></textarea></td>
  <td></td>
   <td></td>
    <td></td>
   <td></td>
  </tr>
  
</table>
<br>

<div style="text-align:left;width:98%">

<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_s_tab_0" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">重要个人</td>
  <td id="Form_s_tab_1" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">银行账户</td>
  <td id="Form_s_tab_2" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">信用等级</td>
  <td id="Form_s_tab_3" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">交往记录</td>
 </tr>
 </table>
 
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%">
<img height="1" width="1"></td></tr></table>
<div id="TD_s_tab_0" >
<iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" src="../khzygr/khzygr_list.jsp?cust_id=<%=custId%>" align="center"></iframe>
</div>

<div id="TD_s_tab_1" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody1" frameborder="0" width="100%" src="../khyhzh/khyhzh_list.jsp?cust_id=<%=custId%>"></iframe>
</div>

<div id="TD_s_tab_2" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody2" frameborder="0" width="100%" src="../khxydj/khxydj_list.jsp?cust_id=<%=custId%>"></iframe>
</div>

<div id="TD_s_tab_3" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody3" frameborder="0" width="100%" src="../khjwjl/khjwjl_list.jsp?cust_id=<%=custId%>"></iframe>
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
<script language="javascript">
ShowTabN(0);
ShowTabSub(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//内部Iframe高度自适应
function autoResize()
{
	try
	{
		document.all["UserBody0"].style.height=UserBody0.document.body.scrollHeight
		document.all["UserBody2"].style.height=UserBody2.document.body.scrollHeight
		document.all["UserBody3"].style.height=UserBody3.document.body.scrollHeight
		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
	}
	catch(e)
	{}
}
</script>
</form>
<!-- end cwMain -->
</body>
</html>
