<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金偿还计划 - 明细列表</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript">
//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		var form1 = document.getElementById("rent");
		rent.action="rent_show_export.jsp";
  		form1.submit();
		rent.action="rent_show.jsp";
	}    
	return false;
}
</script>
</head>
<% 
    String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
%>


<body onLoad="">
<form name="rent" id="rent" method="post" action="rent_show.jsp" onSubmit="return checkdata(this);">	

<%
	String query_sql = "select rent_list,plan_date,rent,corpus,interest,corpus_overage from fund_rent_plan_proj_temp ";
	query_sql += " where proj_id='"+proj_id+"' and doc_id='"+doc_id+"' order by rent_list";
%>
<input type="hidden" value="<%=query_sql %>" name="query_sql">
<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
 
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
 <input type="button" value="导出租金计划" onclick="isExport()">
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
  <td id="Form_s_tab_0" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">&nbsp;租金偿还计划&nbsp;</td>
  <td id="Form_s_tab_1" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle">&nbsp;现金流列表&nbsp;</td>
 </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
	<div id="TD_s_tab_0" style="display:none;">
		<iframe style="funny:expression(autoResize())" id="UserBody0" 
			frameborder="0" width="100%" src="rentplan_list_read.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
	<div id="TD_s_tab_1" style="display:none;"> 
		<iframe style="funny:expression(autoResize())" id="UserBody1" 
			frameborder="0" width="100%" src="rentcash_list_read.jsp?proj_id=<%=proj_id%>&doc_id=<%=doc_id%>">
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
</div></div>
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
