<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基本信息 - 操作权限认证方式</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript">
function selgroup()
{
	if (form1.credit_type_id.value.length==0)
	{
		alert("请您先选择认证方式!");
	}
	else
	{
		sel.ctype_id.value=form1.credit_type_id.value;
		sel.cgroup_id.value=form1.credit_group_id.value;
		sel.cgroup_name.value=form1.credit_group_name.value;
		sel.submit();
	}
}
</script>
</head>
<body onload="fun_winMax();">
<form name="form1" method="post" action="operatecredit_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
textarea {
height:200px;
width:600px;
border-style:solid;
border-color:#D5D5D5;
border-width: 1px;
}
</style>
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
基本信息 &gt; 操作权限认证方式
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
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>操作名称</td>
    <td><input name="operate_name" type="text" size="20" maxB="50" Require="true" readonly><input type="hidden" name="operate_id"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','操作信息','base_operate','operate_name','operate_id','operate_name','operate_name','asc','form1.operate_name','form1.operate_id');">
    <span class="biTian">*</span></td>
    <td>认证方式</td>
    <td><input name="credit_type_name" type="text" size="20" maxB="50" Require="true" readonly><input type="hidden" name="credit_type_id"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','认证方式','base_right_credit_type','credit_type_name','credit_type_id','credit_type_name','credit_type_name','asc','form1.credit_type_name','form1.credit_type_id');">
    <span class="biTian">*</span></td>
  </tr>
<tr>
   <td>被授权集合</td>
   <td colspan=3><textarea name="credit_group_name" cols=10,rows=80 readonly></textarea><input type="button" value="选择" onclick="selgroup();"><input type="hidden" name="credit_group_id" size="30"></td>

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
</script>
</form>
<form name="sel" action="group_sel.jsp" method="post" target="_blank">
<input type="text" name="ctype_id">
<input type="text" name="cgroup_id">
<input type="text" name="cgroup_name">
</form>

<!-- end cwMain -->
</body>
</html>
