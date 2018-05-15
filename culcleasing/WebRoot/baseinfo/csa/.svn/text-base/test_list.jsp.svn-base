<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<%
/*
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
 // response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx-khmpxx-list",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");
*/%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户名片信息明细 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select * from vi_cust_ewlp_info where cust_id='" + czid + "'"; 
	ResultSet rs = db.executeQuery(sqlstr); 
	
	String	cust_name = "";//客户名称 *
	String	cust_ename = "";//客户英文名
	String	sex = "";//客户性别
	String	birthday = "";//出生年月
	String	is_marriage = "";//婚姻状况
	String	certificate = "";//证件类型
	String	certificate_no = "";//证件号码 *
	String	education = "";//学历
	String	reg_per_addr = "";//户口所在地
	String	work_addr = "";//单位地址
	String	headship = "";//单位职务
	String	off_phone = "";//办公室电话
	String	home_phone = "";//住宅电话 *
	String	mobile_number = "";//手  机 *
	String  home_addr="";
	String	mail_addr = "";
	String	post_code = "";
	String	eme_contacts = "";
	String	reg_number = "";
	String	license_exp_date = "";
	String  annual_due_date = "";
	String	hydldata = "";
	String	hyxldata = "";
	String	lbdldata = "";
	String	fax_number = "";
	String	e_mail = "";
	String  web_site = "";
	String	gjdata = "";
	String	sfdata = "";
	String	csdata = "";
	String	memo = "";
	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";
	String	creator_dept = "";
	String biz_scope="";
	String djr="";
	
	if ( rs.next() ) {
		cust_name = getDBStr( rs.getString("cust_name") );		
	}
	rs.close(); 
	db.close();
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
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
		<td><a href="khzrxx_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a></td>
	  	<td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/hg.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
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
    <td><%= cust_name %></td>
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
  <td id="Form_s_tab_3" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">下属公司</td>
 </tr>
 </table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
<div id="TD_s_tab_0" >
<iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" src="../khzygr/khzygr_list.jsp?cust_id=<%=czid%>" align="center"></iframe>
</div>
<div id="TD_s_tab_1" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody1" frameborder="0" width="100%" src="../khyhzh/khyhzh_list.jsp?cust_id=<%=czid%>"></iframe>
</div>
<div id="TD_s_tab_2" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody2" frameborder="0" width="100%" src="../khxydj/khxydj_list.jsp?cust_id=<%=czid%>"></iframe>
</div>
<div id="TD_s_tab_3" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody3" frameborder="0" width="100%" src="../khxsgs/khxsgs_list.jsp?cust_id=<%=czid%>"></iframe>
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
