<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>删除客户名片信息信息 - 客户信息管理(个人)</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>


<%
String dqczy=(String) session.getAttribute("czyid");

if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_zrrkh_del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>

<body onLoad="public_onload();fun_winMax();">
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
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/btn_delete.gif" align="absmiddle" border="0">删除</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">删除</td>
  
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
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">

<%
//dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
	dqczy="无认证";
}
int canmod=0;
    String custId = getStr( request.getParameter("custId") );
    System.out.println("++++"+custId);
		String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator),match,match_card_no,match_tel,matchPhone from vi_cust_ewlp_info left join cust_mate on vi_cust_ewlp_info.cust_id=cust_mate.cust_id  where vi_cust_ewlp_info.cust_id='" + custId + "'";
	//String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_ewlp_info where cust_id='" + custId + "'"; 
	ResultSet rs = db.executeQuery(sqlstr); 
	  System.out.println("++++"+sqlstr);
	  
	String	cust_name = "";//客户名称 *
	String	cust_ename = "";//客户英文名
	String	sex = "";//客户性别
	String nation="";
	String	id_card_no = "";//证件号码 *
	String	brith_date = "";//出生年月
    String	cust_type = "";
	String	cust_type2 = "";
	String	industry_type = "";
	//客户类别
	String lbdlmc="";
	String lbxlmc="";
	//国家 区域 省份 城市
	String gjmc="";
	String qymc="";
	String sfmc="";
	String csmc="";
	//门类 大类 中类 小类
	String hymlmc="";
	String hydlmc="";
	String hyzlmc="";
	String hyxlmc="";
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
	//发票管理
	String match="";
	String match_card_no="";
	String match_tel="";
	String matchPhone="";
	
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
	String	creator_dept = "";
	String	create_date = "";
	String  modificator = "";
	String	modify_date = "";

	if ( rs.next() ) {
		match = getDBStr( rs.getString("match") );
		match_card_no = getDBStr( rs.getString("match_card_no") );
		match_tel = getDBStr( rs.getString("match_tel") );
		matchPhone = getDBStr( rs.getString("matchPhone") );
		
		cust_name = getDBStr( rs.getString("cust_name") );
		cust_ename = getDBStr( rs.getString("cust_ename") );
		sex = getDBStr( rs.getString("sex") );
		nation = getDBStr( rs.getString("nation") );
		id_card_no = getDBStr( rs.getString("id_card_no") );
		brith_date = getDBDateStr( rs.getString("brith_date") );
		
		lbdlmc = getDBStr( rs.getString("lbdlmc") );
		lbxlmc = getDBStr( rs.getString("lbxlmc") );
		gjmc = getDBStr( rs.getString("gjmc") );
		qymc = getDBStr( rs.getString("qymc") );
		sfmc = getDBStr( rs.getString("sfmc") );
		csmc = getDBStr( rs.getString("csmc") );
		hymlmc = getDBStr( rs.getString("hymlmc") );
		hydlmc = getDBStr( rs.getString("hydlmc") );
		hyzlmc = getDBStr( rs.getString("hyzlmc") );
		hyxlmc = getDBStr( rs.getString("hyxlmc") );
		
		cust_type = getDBStr( rs.getString("cust_type") );
		cust_type2 = getDBStr( rs.getString("cust_type2") );
		industry_type = getDBStr( rs.getString("industry_type") );
		industry_level1 = getDBStr( rs.getString("industry_level1") );
		industry_level2 = getDBStr( rs.getString("industry_level2") );
		industry_level3 = getDBStr( rs.getString("industry_level3") );
		industry_level4 = getDBStr( rs.getString("industry_level4") );
		country = getDBStr( rs.getString("country") );
		area = getDBStr( rs.getString("area") );
		city = getDBStr( rs.getString("city") );
		region = getDBStr( rs.getString("region") );
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
	 info_flag=getDBStr( rs.getString("info_flag") );
	 creator =getDBStr( rs.getString("dengjiren") );
	 creator_dept = getDBStr( rs.getString("creator_dept") );
	 create_date=getDBStr( rs.getString("create_date") );
	 modificator=getDBStr( rs.getString("xiugairen") );
     modify_date=getDBStr( rs.getString("modify_date") );

	}
	rs.close(); 
		String sql="select * from dbo.base_department where id='"+creator_dept+"'";
	ResultSet rs1 = db.executeQuery(sql);
	String dept_name="";
	if(rs1.next()){
	dept_name=getDBStr(rs1.getString("dept_name"));
	}
	System.out.println(dept_name+"12");
	rs1.close(); 
	db.close();
%>


<input type="hidden" name="savetype" value="del">
<input type="hidden" name="custId" value="<%=custId %>">
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
    <td scope="row" nowrap width="15%">证件号码：</td>
    <td><%=id_card_no%></td>
	 <td scope="row" nowrap width="15%">出生年月：</td>
    <td><%= brith_date %></td>
  </tr>
  
   <tr>
	<td scope="row" nowrap width="15%">客户大类：</td>
	<td><%= lbdlmc %></td>
	<td scope="row" nowrap width="15%">客户小类：</td>
	<td><%= lbxlmc %></td>
	<td scope="row" nowrap width="15%">内部行业：</td>
	<td><%= industry_type %></td>
  </tr>
  
   <tr>
   <td scope="row" nowrap width="15%">客户所属行业门类：</td>
	<td><%= hymlmc %></td>
	<td scope="row" nowrap width="15%">客户所属行业大类：</td>
	<td><%= hydlmc %></td>
	<td scope="row" nowrap width="15%">客户所属行业中类：</td>
	<td><%= hyzlmc %></td>
	</tr>
	
	<tr>
    <td scope="row" nowrap width="15%">客户所属行业小类：</td>
	<td><%= hyxlmc %></td>
    <td scope="row" nowrap width="15%">国家：</td>
    <td><%= gjmc %></td>
	<td scope="row" nowrap width="15%">区域：</td>
    <td><%= qymc %></td>
   
  </tr>
  <tr>
   <td scope="row" nowrap width="15%">省份：</td>
    <td><%= sfmc %></td>
    <td scope="row" nowrap width="15%">城市：</td>
    <td><%= csmc %></td>
  <td scope="row" nowrap width="15%">户口所在地：</td>
    <td><%= domicile_place %></td>
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
	  <td scope="row" nowrap width="15%">办公室电话：</td>
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
	<td scope="row" nowrap width="15%">E-婚姻状况：</td>
    <td><%= marital_status %></td>
    <td scope="row" nowrap width="15%">配偶名字：</td>
    <td><%= match %></td>
    </tr>
    
    <tr>
    <td scope="row" nowrap width="15%">配偶身份证号：</td>
    <td><%= match_card_no %></td>
    <td scope="row" nowrap width="15%">配偶手机：</td>
    <td><%= match_tel %></td>
     <td scope="row" nowrap width="15%">配偶住机：</td>
    <td><%= matchPhone %></td>
   
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
    	<td scope="row" nowrap width="15%">信息状态：</td>
    <td><%= info_flag %></td>
    </tr>
    
    <tr>
	<td scope="row" nowrap width="15%">登记人：</td>
    <td><%= creator %></td>
	<td scope="row" nowrap width="15%">登记人部门：</td>
    <td><%= dept_name %></td>
	<td scope="row" nowrap width="15%">登记时间：</td>
    <td><%= create_date %></td>
    </tr>
    
    <tr>
     <td scope="row" nowrap width="15%">重要社会关系：</td>
    <td><%= imp_social_relation %></td>
	<td scope="row" nowrap width="15%">更新人：</td>
    <td><%= modificator %></td>
	<td scope="row" nowrap width="15%">更新日期：</td>
    <td><%= modify_date %></td>
    <td></td>
     <td></td>
  </tr>
  
  <tr>
  <td scope="row" nowrap width="15%">备注：</td>
    <td><textarea class="text"><%= memo %></textarea></td>
     <td></td>
     <td></td>
      <td></td>
     <td></td>
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
