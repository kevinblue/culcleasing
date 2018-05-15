<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金偿还计划 - 明细列表</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<% 
    String dqczy = (String) session.getAttribute("czyid");
   
    String proj_id = getStr(request.getParameter("proj_id")); //项目编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号  "FA6FFC6AC326B1CF4825772E0027A83E";//
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号 "2010-00002-002-175";//
%>

<body onLoad="">
<form name="form1" method="post" action="zics_div_list.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
 
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
 
<!--操作按钮结束-->
</td>
</tr>
<tr></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
 </tr>
 </table>

 </td></tr> 
<tr></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">

<div style="text-align:left;width:100%">
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_s_tab_0" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">&nbsp;合同租金偿还计划&nbsp;</td>
  <td id="Form_s_tab_1" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">&nbsp;合同现金流列表&nbsp;</td>
  <td id="Form_s_tab_2" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">&nbsp;会计租金偿还计划&nbsp;</td>
  <td id="Form_s_tab_3" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">&nbsp;会计现金流列表&nbsp;</td>
 </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
	<div id="TD_s_tab_0" style="display:none;">
		<iframe style="funny:expression(autoResize())" id="UserBody0" 
			frameborder="0" width="100%" 
			src="market_newrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>">
		</iframe>
	</div>
	<div id="TD_s_tab_1" style="display:none;"> 
		<iframe style="funny:expression(autoResize())" id="UserBody1" 
			frameborder="0" width="100%" 
			src="market_newrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>">
		</iframe>
	</div>
	<div id="TD_s_tab_2">
		<iframe style="funny:expression(autoResize())" id="UserBody2" 
			frameborder="0" width="100%" 
			src="market_newrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>" 
			align="center">
		</iframe>
	</div>
	<div id="TD_s_tab_3" style="display:none;"> 
		<iframe style="funny:expression(autoResize())" id="UserBody3" 
			frameborder="0" width="100%" 
			src="market_newrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>">
		</iframe>
	</div>
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
			//document.all["UserBody4"].style.height=UserBody4.document.body.scrollHeight
		    //document.all["UserBody5"].style.height=UserBody5.document.body.scrollHeight
		    //document.all["UserBody6"].style.height=UserBody6.document.body.scrollHeight
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
