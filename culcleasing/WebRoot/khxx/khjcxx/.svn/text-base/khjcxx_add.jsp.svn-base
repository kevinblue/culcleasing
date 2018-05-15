<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增客户简称 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body>


<form name="form1" method="post" action="khjcxx_save.jsp" onSubmit="return Validator.Validate(this,3);">



<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 新增客户简称
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="保存"> 保存</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="重置"> 重置</a>
    	
    	<input class="btn" name="btnSave" value="保存" type="submit">
    	<input class="btn" name="btnReset" value="重置" type="reset">
    	-->
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">新 增</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwCellTop -->


<div id="myDiv" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" value="add" name="savetype">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <th scope="row">客户编号</th>
    <td><input name="cust_id" type="text" value="" maxB="20" Require="true" onblur="searchName(form1.cust_id.value,form1.cust_name.value,form1.short_name.value)"><span class="biTian">*</span></td>
    <th scope="row">客户名称</th>
    <td><input name="cust_name" type="text" value="" maxB="100" Require="true"  onblur="searchName(form1.cust_id.value,form1.cust_name.value,form1.short_name.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <th scope="row">客户简称</th>
    <td><input name="short_name" type="text" value="" maxB="50" Require="true" onblur="searchName(form1.cust_id.value,form1.cust_name.value,form1.short_name.value)"><span class="biTian">*</span></td>
    <th scope="row"></th>
    <td></td>
  </tr>
</table>


</div>

</div>

    </form>

<!-- end cwMain -->
</body>
</html>
<script language="javascript"> 
  var xmlHttp;
function GetXmlHttpObject(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest)	{
		objXMLHttp = new XMLHttpRequest();
	}else if(window.ActiveXObject)	{
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return objXMLHttp;
}
function searchName(varId,varName,varShort){
  	xmlHttp = GetXmlHttpObject();
	var url = "khjcxx_check.jsp?savetype=zz&cust_id="+varId+"&cust_name="+varName+"&short_name="+varShort;
  	//xmlHttp.onreadystatechange = stateChanged;	
  	xmlHttp.open("POST",url,false);
  	xmlHttp.send(null);
  	var vDiv = document.createElement("DIV");
   	vDiv.innerHTML = xmlHttp.responseText 
	var returnvalue=vDiv.innerText;
	if(returnvalue!=""){
		alert(returnvalue);
		return false;
	}
  	return true;  
}
</script>