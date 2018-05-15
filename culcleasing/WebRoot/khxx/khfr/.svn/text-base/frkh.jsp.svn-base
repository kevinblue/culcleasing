<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%> 
<%@page import="dbconn.*"%> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common_simple.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>个人客户(法人)明细 - 客户信息管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<% 
   String dqczy = (String) session.getAttribute("czyid");
   String userId=(String) session.getAttribute("czyid");
	String custId = getStr( request.getParameter("custId"));
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_info where cust_id='"+custId+"'"; 
	
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
	String biz_scope_primary="";
	String web_site="";
	String fax_number="";
	String biz_scope_secondary="";
	String reg_capital="";
	String reg_type="";
	String license_exp_date="";
	String estab_date="";
	String info_flag="";

	String loan_number_pwd="";
	String area="";
	String region="";
	String provinceName="";
	String reg_money="";
	String assets="";
	//时间
	String	creator_dept = "";//部门名称
	
	String	creator = "";//登记人
	String	create_date = "";//登记时间
	String	modificator = "";//修改人
	String	modify_date = "";//修改时间

	//类别大小类
	String lbdlmc="";
	String lbxlmc="";
	//行业门类 大类 中类 小类
	String hymlmc="";
	String hydlmc="";
	String hyzlmc="";
	String hyxlmc="";
	//国家区域省份城市
	String gjmc="";
	String qymc="";
	String sfmc="";
	String csmc="";
	String cust_no_type="";
	String parent_company="";
	if(rs.next()){
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
	   	creator=getDBStr(rs.getString("creator"));
	   	creator_dept=getDBStr(rs.getString("creator_dept"));
	   	info_flag=getDBStr(rs.getString("info_flag"));
	   	create_date=getDBStr(rs.getString("create_date"));
	   	modify_date=getDBStr(rs.getString("modify_date"));
	   	
	   lbdlmc=getDBStr(rs.getString("lbdlmc"));
	   lbxlmc=getDBStr(rs.getString("lbxlmc"));
	   hymlmc=getDBStr(rs.getString("hymlmc"));
	   hydlmc=getDBStr(rs.getString("hydlmc"));
	    hyzlmc=getDBStr(rs.getString("hyzlmc"));
	   hyxlmc=getDBStr(rs.getString("hyxlmc"));
	   gjmc=getDBStr(rs.getString("gjmc"));
	   qymc=getDBStr(rs.getString("qymc"));
	   sfmc=getDBStr(rs.getString("sfmc"));
	   csmc=getDBStr(rs.getString("csmc"));
	   cust_no_type=getDBStr(rs.getString("cust_no_type"));
	   
		creator = getDBStr( rs.getString("dengjiren") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("xiugairen") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
		//creator_dept=getStr( request.getParameter("creator_deptname"));
		creator_dept = getDBStr( rs.getString("creator_dept") );
		System.out.println("creator_dept="+creator_dept);
	}
	rs.close(); 
	//db.close();
	String sql="select dept_name from dbo.base_department where id='"+creator_dept+"'";
	ResultSet rs1 = db.executeQuery(sql);
	String dept_name="";
	if(rs1.next()){
	dept_name=getDBStr(rs1.getString("dept_name"));
	}
	System.out.println(dept_name+"12");
	rs1.close(); 
	db.close();
%>

<body onLoad="">
<form name="form1" method="post" action="frkh_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>

<table  class="title_top" width=100%  align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
法人客户信息明细
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
	  	<td><a href="#" onClick="window.close();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/fdmo_37.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
		<td width="100" align="center">
			<a href="hyxx.jsp?cust_id=<%=cust_id %>&industry_type=<%=industry_type %>"  target="_blank">客户行业信息 </a>
		</td>
		<%-- 
		<td><a href="  http://192.168.0.13:9080/gaa/importExcel.do?method=init&custId=<%=cust_id%>&custName=<%=cust_name%>"  accesskey="m" title="导入(Alt+T)" class="fontcolor">
		<img src="../../images/btn_edit.gif" width="19" height="19" align="absmiddle" >导入&nbsp;&nbsp;</a></td>
		--%>
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

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">



	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	 <tr>
			<td colspan="6">
				<b style="font-size: 13px;">基本信息</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
	  <tr>
	    <td scope="row" nowrap width="15%">客户编号：</td>
	    <td scope="row" nowrap width="15%"><%=cust_id %></td>
	    <td scope="row" nowrap width="15%">客户名称：</td>
	    <td scope="row" nowrap width="15%"><%=cust_name %></td>
	    <td scope="row" nowrap width="15%">英文名称：</td>
	    <td scope="row" nowrap width="15%"><%=cust_ename %></td>
	  </tr>
	  
	   <tr>
	    <td scope="row" nowrap width="15%">客户简称：</td>
	    <td><%=cust_byname %></td>
		<td scope="row" nowrap width="15%">客户类别大类：</td>
	    <td><%=lbdlmc %></td>
	  
	    <td scope="row" nowrap width="15%">客户类别小类：</td>
	    <td><%=lbxlmc %></td>
	  </tr>
	  
	   <tr>
	   	<td scope="row" nowrap width="15%">内部行业：</td>
	    <td><%=industry_type %></td>
	    <td scope="row" nowrap width="15%">客户所属行业门类：</td>
	    <td><%=hymlmc %></td>
		<td scope="row" nowrap width="15%">客户所属行业大类：</td>
	    <td><%=hydlmc %></td>
	  </tr>
	   <tr>
	    <td scope="row" nowrap width="15%">户所属行业中类：</td>
	    <td><%=hyzlmc %></td>
		<td scope="row" nowrap width="15%">客户所属行业小类：</td>
	    <td><%=hyxlmc%></td>
	    <td scope="row" nowrap width="15%">国家：</td>
	    <td><%=gjmc %></td>
	  </tr>
	  
	   <tr>
	   	<td scope="row" nowrap width="15%">区域：</td>
	    <td><%=qymc %></td>
	    <td scope="row" nowrap width="15%">省份：</td>
	    <td><%=sfmc %></td>
		<td scope="row" nowrap width="15%">城市：</td>
	    <td><%=csmc %></td>
	  </tr>
	  
	   <tr>
	          <td nowrap class="text">法人代表证件类型：</td>
   <td nowrap class="text"><%=cust_no_type%></td>
		<td scope="row" nowrap width="15%">法定代表人：</td>
	    <td><%=legal_representative %></td>
	    <td scope="row" nowrap width="15%">法定代表人身份证号：</td>
	    <td><%=id_card_no %></td>

	  </tr>
	  <tr>
			<td colspan="8">
				<b style="font-size: 13px;">联系信息</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
	   <tr>
	   <tr>
	    <td scope="row" nowrap width="15%">公司地址：</td>
	    <td><%=office_addr %></td>
		<td scope="row" nowrap width="15%">准确邮编地址：</td>
	    <td><%=mail_addr %></td>
	    <td scope="row" nowrap width="15%">邮编：</td>
	    <td><%=post_code %></td>
	    
	      <tr>
		<td scope="row" nowrap width="15%">联系人：</td>
	    <td><%=linkman %></td>
	    <td scope="row" nowrap width="15%">电话：</td>
	    <td><%=phone %></td>
		<td scope="row" nowrap width="15%">手机：</td>
	    <td><%=mobile_number %></td>
	  </tr>
	  
	   <tr>
	    <td scope="row" nowrap width="15%">传真：</td>
	    <td><%=fax_number %></td>
		<td scope="row" nowrap width="15%">电挂：</td>
	    <td><%=cable_addr %></td>
	     <td scope="row" nowrap width="15%">网站：</td>
	    <td><%=web_site %></td>
	  </tr>
	   <tr>
			<td colspan="8">
				<b style="font-size: 13px;">资质信息</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
	 <tr>
		<td scope="row" nowrap width="15%">企业性质：</td>
	    <td><%=ownership %></td>
	    
	    <td scope="row" nowrap width="15%">企业规模定级：</td>
	    <td><%=scale %></td>
		<td scope="row" nowrap width="15%">组织机构代码：</td>
	    <td><%=org_code %></td>
	  </tr>
	  <tr>
			<td colspan="8">
				<b style="font-size: 13px;">其他信息</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
	   <tr>
	    <td scope="row" nowrap width="15%">贷款证号码：</td>
	    <td><%=loan_number %></td>
<td scope="row" nowrap width="15%">贷款证密码：</td>
	    <td><%=loan_number_pwd %></td>

	    <td scope="row" nowrap width="15%">e_mail地址：</td>
	    <td><%=e_mail %></td>
</tr>
	  
	   <tr>
		<td scope="row" nowrap width="15%">营业执照号：</td>
	    <td><%=license_number %></td>
	    <td scope="row" nowrap width="15%">营业执照到期日期：</td>
	    <td><%=getDBDateStr(license_exp_date) %></td>
		<td scope="row" nowrap width="15%">注册资金：</td>
	    <td><%= CurrencyUtil.convertFinance(reg_capital) %></td>
	  </tr>
	  
	   <tr>
	    <td scope="row" nowrap width="15%">登记注册类型：</td>
	    <td><%=reg_type %></td>
		<td scope="row" nowrap width="15%">成立日期：</td>
	    <td><%=getDBDateStr(estab_date) %></td>
	       <td  scope="row" nowrap width="15%">国税登记号：</td>
	    <td><%=national_tax_number %></td>
	  </tr>
	  
	   <tr>
		<td scope="row" nowrap width="15%">地税登记号：</td>
	    <td><%=land_tax_number %></td>
	    <td scope="row" nowrap width="15%">上市公司标志：</td>
	    <td><%=listed_corp_flag %></td>
		<td scope="row" nowrap width="15%">进出口权标志：</td>
	    <td><%=imp_exp_flag %></td>
	  </tr>
	  <tr>
	
		 <td scope="row" nowrap width="15%">注册地址：</td>
	    <td><%=reg_addr %></td>
  	  <td scope="row" nowrap class="text">分公司</td>
    <td scope="row" nowrap class="text"><%=parent_company %></td>
 <td scope="row" nowrap width="15%">信息状态：</td>
	    <td><%=info_flag %></td>
	  </tr>

	  <tr>
	  <td scope="row" nowrap width="15%">经营范围(主营)：</td>
<td class="text"><textarea class="text" readonly><%=biz_scope_primary %></textarea></td>
	 <td scope="row" nowrap width="15%">经营范围(兼营)：</td>
<td class="text"><textarea class="text" readonly><%=biz_scope_secondary %></textarea></td> 
	  
<td scope="row" nowrap width="15%">备注：</td>
<td class="text"><textarea class="text" readonly><%=memo %></textarea></td>
	  </tr>
	</table>
<br>
<div style="text-align:left;width:98%">
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_s_tab_0" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">重要个人</td>
  <td id="Form_s_tab_1" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">主要股东</td>
  <td id="Form_s_tab_2" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">下属公司</td>
  <td id="Form_s_tab_3" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">主要参股</td>
  <td id="Form_s_tab_4" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">银行账户</td>
  <td id="Form_s_tab_5" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">信用等级</td>
  <td id="Form_s_tab_6" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">交往记录</td>
  <td id="Form_s_tab_7" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">项目信息</td>
  <td id="Form_s_tab_8" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">财务报表</td>
 
 </tr>
 </table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
<div id="TD_s_tab_0" >
<iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" src="../khzygr/khzygr_list.jsp?cust_id=<%=custId%>" align="center"></iframe>
</div>
<div id="TD_s_tab_1" style="display:none;">
<iframe style="funny:expression(autoResize())" id="UserBody1" frameborder="0" width="100%" src="../frkhzygd/frkhzygd_list.jsp?cust_id=<%=custId%>"></iframe>
</div>
<div id="TD_s_tab_2" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody2" frameborder="0" width="100%" src="../khxsgs/khxsgs_list.jsp?cust_id=<%=custId%>"></iframe>
</div>
<div id="TD_s_tab_3" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody3" frameborder="0" width="100%" src="../frkhzycg/frkhzycg_list.jsp?cust_id=<%=custId%>"></iframe>
</div>
</div>
<div id="TD_s_tab_4" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody4" frameborder="0" width="100%"  src="../khyhzh/khyhzh_list.jsp?cust_id=<%=custId%>"></iframe>
</div>
<div id="TD_s_tab_5" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody5" frameborder="0" width="100%" src="../khxydj/khxydj_list.jsp?cust_id=<%=custId%>"></iframe>
</div>
<div id="TD_s_tab_6" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody6" frameborder="0" width="100%" src="../khjwjl/khjwjl_list.jsp?cust_id=<%=custId%>"></iframe>
</div>
<div id="TD_s_tab_7" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody7" frameborder="0" width="100%" src="../khxmxx/khxmxx_list.jsp?cust_id=<%=custId%>"></iframe>
</div> 
<div id="TD_s_tab_8" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody8" frameborder="0" width="100%" height="100%" src="../khcwbb/khcwbb_list.jsp?custId=<%=custId%>&userId=<%=userId%>"></iframe>
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
			document.all["UserBody4"].style.height=UserBody4.document.body.scrollHeight
		    document.all["UserBody5"].style.height=UserBody5.document.body.scrollHeight
		    document.all["UserBody6"].style.height=UserBody6.document.body.scrollHeight
		    document.all["UserBody7"].style.height=UserBody7.document.body.scrollHeight
		    document.all["UserBody8"].style.height=UserBody8.document.body.scrollHeight
		}
		catch(e)
		{
			//alert('#$%^%#$^$#exception');
		}
	}
</script>
</form>
<!-- end cwMain -->
</body>
</html>
