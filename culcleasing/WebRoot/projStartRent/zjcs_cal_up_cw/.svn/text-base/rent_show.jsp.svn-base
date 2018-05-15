<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金偿还计划 - 明细列表</title>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">	
//提交时
function validate_sub() {
	var val = $("input[name='invoice_is']:checked").val();
	var time=$("input[name='invoice_date']").val();
	if(val=="否" && time!=""){
		alert("是否开具为否，不能填写开票日期！");
		return flase;
	}else{
		//$("form[name='form1']").attr("action","rent_save.jsp");
		document.form1.submit();
	}
}
</script>
</head>

<% 
    String contract_id = getStr(request.getParameter("contract_id"));//合同编号
    String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
%>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<body onLoad="">
<form name="form1" method="post" action="rent_save.jsp">	
<input type="hidden" value="<%=begin_id%>" name ="begin_id">

<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
 
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->

<%
//获取回笼日期
String hireDate = "";
String invoice_is="";
String invoice_date="";
String drawing_is = "";
sqlstr = " Select hire_date from fund_rent_tool where begin_id='"+begin_id+"'";

rs = db.executeQuery(sqlstr);
if(rs.next()){
	hireDate = getDBDateStr(rs.getString("hire_date"));
}
ResultSet rs1=null;
String sqlstr1="select * from invoice_rent_detail where begin_id='"+begin_id+"' and rent_list=1";
rs1 = db.executeQuery(sqlstr1);
while(rs1.next()){
	invoice_is =rs1.getString("invoice_is");
	invoice_date =getDBDateStr(rs1.getString("invoice_date"));
	System.out.println("aaaaaaaa"+invoice_is);
}
rs1.close();
ResultSet rs2 = null;
String sqlstr2 ="select count(*) as drawing_is from invoice_draw_detail where begin_id='"+begin_id+"' and rent_list=1 and draw_flag=1";
rs2 = db1.executeQuery(sqlstr2);
if(rs2.next()){
	drawing_is = rs2.getString("drawing_is");
}
rs2.close();
db1.close();
db.close();
%>

<b>回笼日期</b>
<input name="hire_date" type="text" value="<%=hireDate %>" size="13" maxlength="20"  Require="true" readonly="readonly"/>
<img style="cursor:pointer;" onClick="openCalendar(hire_date);return false" 
src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">

&nbsp;&nbsp;&nbsp;&nbsp;		
<input type="button" value="核销第一期租金" onclick="hireFirstRent()">
是否开具：
<%if(invoice_is.equals("是")){ %>
<input type="radio" name="invoice_is" id="invoice_is" value="是"  checked="checked">是
<input type="radio" name="invoice_is" id="invoice_is" value="否" >否
<%}else{%>
<input type="radio" name="invoice_is" id="invoice_is" value="是" >是
<input type="radio" name="invoice_is" id="invoice_is" value="否"  checked="checked">否
<%}%>
&nbsp;&nbsp;|&nbsp;&nbsp;是否领取：
<%if(drawing_is.equals("1")){ %>
<input type="radio" name="drawing_is" id="drawing_is" value="1"  checked="checked">是
<input type="radio" name="drawing_is" id="drawing_is" value="0" >否
<%}else{%>
<input type="radio" name="drawing_is" id="drawing_is" value="1" >是
<input type="radio" name="drawing_is" id="drawing_is" value="0"  checked="checked">否
<input type="hidden" name="drawing_doc_id" value="<%=doc_id %>"> 
<%}%>
<span class="biTian">*</span>
首期开票日：
<input name="invoice_date" id="invoice_date" type="text" value="<%=invoice_date %>" 
size="13" maxlength="20"  Require="true" readonly="readonly" style="width: 100"/>
<img onClick="openCalendar(invoice_date);return false" style="cursor:pointer; " 
src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
<span class="biTian">*</span>
		
<input type="button" value="确定" onclick="return validate_sub();"></td>
<script type="text/javascript">
//资金冲抵第一期租金的核销操作
function hireFirstRent(){
	var hireDate = $(":input[name='hire_date']").val();
	window.open("offFirstRent_save.jsp?contract_id=<%=contract_id %>&begin_id=<%=begin_id %>&doc_id=<%=doc_id %>&hireDate="+hireDate);
}

function submitForm(){
	alert("aaaa"+document.getElementById("invoice_is"));
	document.form1.submit();
}
</script>

 
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
  <td id="Form_s_tab_1" class="Form_tab" width=70 align=center onClick="chgTabSub()"  valign="middle" style="display: none;">&nbsp;现金流列表&nbsp;</td>
 </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
	<div id="TD_s_tab_0" style="display:none;">
		<iframe style="funny:expression(autoResize())" id="UserBody0" 
			frameborder="0" width="100%" src="rentplan_list_read.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>">
		</iframe>
	</div>
	<div id="TD_s_tab_1" style="display:none;"> 
		<iframe style="funny:expression(autoResize())" id="UserBody1" 
			frameborder="0" width="100%" src="rentcash_list_read.jsp?contract_id=<%=contract_id%>&begin_id=<%=begin_id %>&doc_id=<%=doc_id%>">
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
