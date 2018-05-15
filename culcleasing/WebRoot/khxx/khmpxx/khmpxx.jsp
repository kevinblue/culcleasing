<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>个人客户(法人)明细 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
 response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_khmpxx_list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<%
	//带*号的为必填选需要进行验证
	String czid = getStr( request.getParameter("czid") );//客户编号
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_info where cust_id='" + czid + "'"; //SQL查询语句
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String	cust_name = "";//客户名称 *
	String	cust_ename = "";//客户英文名
	String	cust_oname = "";//客户别名
	String	stock = "";//股份关系
	String	org_code = "";//组织结构代码 *
	String	nbhydata = "";//内部行业分类
	String	hydldata = "";//客户所属行业大类
	String	hyxldata = "";//客户所属行业小类 
	String	quality = "";//企业性质 *
	String	lbdldata = "";//客户类别 *
	String	scale_name = "";//企业规模（定级）
	String	biz_method = "";//经营方式
	String	biz_scope_primary = "";//经营范围（主营）
	String	biz_scope_secondary = "";//经营范围（兼营）
	String	legal_representative = "";//法人代表
	String	id_card_no = "";//法人代表身份证号
	String	gjdata = "";//国家 *
	String	sfdata = "";//省份 *
	String	csdata = "";//城市 *
	String	qxdata = "";//区县 *
	String	listed_corp_flag = "";//上市公司标志 *
	String	imp_exp_flag = "";//进出口权标志
	String	reg_number = "";//登记注册号（营业执照号） *
	String	estab_date = "";//成立日期 *
	String	license_exp_date = "";//营业执照到期日期 *
	String	annual_due_date = "";//工商年检到期日期 *
	String	national_tax_number = "";//国税登记号
	String	land_tax_number = "";//地税登记号
	String	reg_capital = "";//注册资本
	String	reg_capital_cur_name = "";//注册资本币种
	String	fact_capital = "";//实收资本
	String	fact_capital_cur_name = "";//实收资本币种
	String	loan_number = "";//贷款证号码
	String	phone = "";//电话 *
	String	mobile_number = "";//手机 *
	String	cable_addr = "";//电挂
	String	fax_number = "";//传真
	String	tax_number = "";//税号
	String	mailing_addr = "";//准确邮寄地址 *
	String	company_addr = "";//公司地址 *
	String	reg_addr = "";//注册地址 *
	String	web_site = "";//网址
	String	post_code = "";//邮编 *
	String	memo = "";//备注
	String	creator_dept = "";//部门名称
	String	creator = "";//登记人
	String	create_date = "";//登记时间
	String	modificator = "";//修改人
	String	modify_date = "";//修改时间
	String biz_scope="";
	String cust_mesage="";
	String position="";
	if ( rs.next() ) {
		position = getDBStr( rs.getString("position") );
		biz_scope = getDBStr( rs.getString("biz_scope") );
		cust_mesage = getDBStr( rs.getString("cust_mesage") );
		cust_oname = getDBStr( rs.getString("cust_oname") );
		stock = getDBStr( rs.getString("stock") );
		cust_name = getDBStr( rs.getString("cust_name") );
		cust_ename = getDBStr( rs.getString("cust_ename") );
		org_code = getDBStr( rs.getString("org_code") );
		biz_method = getDBStr( rs.getString("biz_method") );
		biz_scope_primary = getDBStr( rs.getString("biz_scope_primary") );
		biz_scope_secondary = getDBStr( rs.getString("biz_scope_secondary") );
		legal_representative = getDBStr( rs.getString("legal_representative") );
		id_card_no = getDBStr( rs.getString("id_card_no") );
		
		estab_date = getDBDateStr( rs.getString("estab_date") );
		listed_corp_flag = getDBStr( rs.getString("listed_corp_flag") );
		imp_exp_flag = getDBStr( rs.getString("imp_exp_flag") );
		reg_number = getDBStr( rs.getString("reg_number") );
		license_exp_date = getDBDateStr( rs.getString("license_exp_date") );
		annual_due_date = getDBDateStr( rs.getString("annual_due_date") );
		national_tax_number = getDBStr( rs.getString("national_tax_number") );
		
		land_tax_number = getDBStr( rs.getString("land_tax_number") );
		reg_capital = formatNumberStr( rs.getString("reg_capital"),"#,##0.00" );		
		reg_capital_cur_name = getDBStr( rs.getString("reg_capital_cur_name") );
		fact_capital = formatNumberStr( rs.getString("fact_capital") ,"#,##0.00");		
		fact_capital_cur_name = getDBStr( rs.getString("fact_capital_cur_name") );
		loan_number = getDBStr( rs.getString("loan_number") );
		mobile_number = getDBStr( rs.getString("mobile_number") );
		phone = getDBStr( rs.getString("phone") );
		mobile_number = getDBStr( rs.getString("mobile_number") );
		cable_addr = getDBStr( rs.getString("cable_addr") );
		fax_number = getDBStr( rs.getString("fax_number") );
		tax_number = getDBStr( rs.getString("tax_number") );
		mailing_addr = getDBStr( rs.getString("mailing_addr") );
		company_addr = getDBStr( rs.getString("company_addr") );
		reg_addr = getDBStr( rs.getString("reg_addr") );
		web_site = getDBStr( rs.getString("web_site") );
		post_code = getDBStr( rs.getString("post_code") );
		memo = getDBStr( rs.getString("memo") );
		//行业
		quality = getDBStr( rs.getString("quality") );
		hydldata = getDBStr( rs.getString("hydlmc") );
		hyxldata = getDBStr( rs.getString("hyxlmc") );
		lbdldata = getDBStr( rs.getString("lbdlmc") );
		nbhydata = getDBStr( rs.getString("nbhydata") );
		
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
		
		scale_name = getDBStr( rs.getString("scale_name") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="khmpxx_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户(法人)信息明细
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
		<td><a href="khmpxx_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a></td>
		<td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/sbtn_close.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
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
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="20%">客户名称：</td>
    <td scope="row" nowrap width="30%"><%= cust_name %></td>

    <td scope="row" nowrap width="20%">英文名称：</td>
    <td scope="row" nowrap width="30%"><%= cust_ename %></td>
  </tr>
  <tr>
    <td >客户别名:  </td>
    <td><%= cust_oname %></td>
    <td >股份关系:  </td>
    <td><%= stock %></td>
  </tr>
   <tr>
    <td >组织机构代码：</td>
    <td><%= org_code %></td>

    <td >内部行业分类：</td>
    <td><%=nbhydata%></td>
  </tr>
  <tr>
	<td >客户所属行业大类：</td>
	<td><%= hydldata %></td>
	<td >客户所属行业小类：</td>
	<td><%= hyxldata %></td>
  </tr>
  <tr>
	<td >客户类别：</td>
    <td><%= lbdldata %></td>
    <td >单位职务：</td>
    <td><%= position %></td>
  </tr>
  <tr>
    <td >企业性质：</td>
    <td><%= quality %></td>
    <td >企业规模（定级）：</td>
    <td><%= scale_name %></td>
  </tr>
  <tr>
    <td >经营方式：</td>
    <td><%= biz_method %></td>
    
  </tr>
  <tr>
    <td >经营范围(主营)：</td>
    <td><%= biz_scope_primary %></td>
    <td >经营范围(兼营)：</td>
    <td><%= biz_scope_secondary %></td>
  </tr>
  <tr>
    
    <td >法人代表：</td>
    <td><%= legal_representative %></td>
    <td >法人代表身份证号</td>
    <td><%= id_card_no %></td>
  </tr>

  <tr>
    <td >国家：</td>
    <td><%= gjdata %></td>
    <td >省份：</td>
    <td><%= sfdata %></td>
  </tr>
  <tr>
    <td >城市：</td>
    <td><%= csdata %></td>
    <td >区/县：</td>
    <td><%= qxdata %></td>
  </tr>
  <tr>
    <td >上市公司标志：</td>
    <td><%= listed_corp_flag %></td>
    <td >进出口权标志：</td>
    <td><%= imp_exp_flag %></td>
  </tr>
  <tr>
    
    <td >登记注册号(营业执照号)：</td>
    <td><%= reg_number %></td>
    <td >成立日期</td>
    <td><%= estab_date %></td>
  </tr>
  <tr>
    <td >营业执照到期日期：</td>
    <td><%= license_exp_date %></td>
    <td >工商年检到期日：</td>
    <td><%= annual_due_date %></td>
  </tr>
  <tr>
    <td >国税登记号：</td>
    <td><%= national_tax_number %></td>
    <td >地税登记号：</td>
    <td><%= land_tax_number %></td>
  </tr>
  <tr>
    <td >注册资本：</td>
    <td><%= reg_capital %></td>
    <td >注册资本币种：</td>
    <td><%= reg_capital_cur_name %></td>
  </tr>
  <tr>
    <td >实收资本：</td>
    <td><%= fact_capital %></td>
    <td >实收资本币种：</td>
    <td><%= fact_capital_cur_name %></td>
  </tr>
  <tr>
    <td >贷款证号码：</td>
    <td><%= loan_number %></td>
    <td >电话：</td>
    <td><%= phone %></td>
  </tr>
  <tr>
    <td >手机：</td>
    <td><%= mobile_number %></td>
    <td >电挂：</td>
    <td><%= cable_addr %></td>
  </tr>
   <tr>
    <td >传真</td>
    <td><%= fax_number %></td>
    <td >税号</td>
    <td><%= tax_number %></td>
  </tr>
  <tr>
    <td >准确邮寄地址</td>
    <td><%= mailing_addr %></td>
    <td >公司地址</td>
    <td><%= company_addr %></td>
  </tr>
  <tr>
    <td >注册地址：</td>
    <td><%= reg_addr %></td>
    <td ></td>
    <td></td>
  </tr>
  <tr>
    <td >邮编：</td>
    <td><%= post_code %></td>
    <td >网址：</td>
    <td><%=web_site %></td>
  </tr>
    <tr>
    <td >产品和服务：</td>
    <td><%= biz_scope %></td>
    <td >承租人信息：</td>
    <td><%=cust_mesage %></td>
  </tr>
  <tr>
    <td >备注：</td>
    <td><%= memo %></td>
   	 <td></td>
    <td></td>
  </tr>
  <tr>
    <td >登记人：</td>
    <td><%= creator %></td>
	<td >登记时间：</td>
    <td><%= create_date %></td>
  </tr>
  <tr>
    <td >修改人：</td>
    <td><%= modificator %></td>
    <td >修改时间：</td>
    <td><%= modify_date %></td>
  </tr>
</table>
<br>
<div style="text-align:left;width:98%">
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_s_tab_0" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">重要个人</td>
  <td id="Form_s_tab_1" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">银行账户</td>
  <td id="Form_s_tab_2" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">信用等级</td>
 </tr>
 </table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
<div id="TD_s_tab_0">
<iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" src="../khzygr/khzygr_list.jsp?cust_id=<%=czid%>" align="center"></iframe>
</div>
<div id="TD_s_tab_1" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody1" frameborder="0" width="100%" src="../khyhzh/khyhzh_list.jsp?cust_id=<%=czid%>"></iframe>
</div>
<div id="TD_s_tab_2"  style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody2" frameborder="0" width="100%" src="../khxydj/khxydj_list.jsp?cust_id=<%=czid%>"></iframe>
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
		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
		document.all["UserBody2"].style.height=UserBody2.document.body.scrollHeight
	}
	catch(e)
	{}
}
</script>
</form>
<!-- end cwMain -->
</body>
</html>
