<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基本信息管理 - 部门经营指标</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

</head>
<body onload="fun_winMax();">
<form name="form1" method="post" action="depttarget_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("depttarget-depttarget-add",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
基本信息管理 &gt; 部门经营指标
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
    <td>指标年份</td>
    <td><select name="target_year" Require="true"><script>w(mSetOpt("",'2000|2001|2002|2003|2004|2005|2006|2007|2008|2009|2010|2011|2012|2013|2014|2015|2016|2017|2018|2019|2020|2021|2022|2023|2024|2025|2026|2027|2028|2029|2030'));</script></select>
	<span class="biTian">*</span></td>
    <td>部门</td>
    <td><input name="bmmc" type="text" size="20" readonly Require="true"><input type="hidden" name="dept_id"> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','部门选择','jb_gsbm','bmmc','id','bmmc','bmmc','asc','form1.bmmc','form1.dept_id');">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>1月份计划完成设备金额指标</td>
    <td><input name="target_1_asset" type="text" size="20" dataType="Money"></td>
    <td>1月份计划完成本金指标</td>
    <td><input name="target_1_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>2月份计划完成设备金额指标</td>
    <td><input name="target_2_asset" type="text" size="20" dataType="Money"></td>
    <td>2月份计划完成本金指标</td>
    <td><input name="target_2_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>3月份计划完成设备金额指标</td>
    <td><input name="target_3_asset" type="text" size="20" dataType="Money"></td>
    <td>3月份计划完成本金指标</td>
    <td><input name="target_3_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>4月份计划完成设备金额指标</td>
    <td><input name="target_4_asset" type="text" size="20" dataType="Money"></td>
    <td>4月份计划完成本金指标</td>
    <td><input name="target_4_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>5月份计划完成设备金额指标</td>
    <td><input name="target_5_asset" type="text" size="20" dataType="Money"></td>
    <td>5月份计划完成本金指标</td>
    <td><input name="target_5_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>6月份计划完成设备金额指标</td>
    <td><input name="target_6_asset" type="text" size="20" dataType="Money"></td>
    <td>6月份计划完成本金指标</td>
    <td><input name="target_6_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>7月份计划完成设备金额指标</td>
    <td><input name="target_7_asset" type="text" size="20" dataType="Money"></td>
    <td>7月份计划完成本金指标</td>
    <td><input name="target_7_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>8月份计划完成设备金额指标</td>
    <td><input name="target_8_asset" type="text" size="20" dataType="Money"></td>
    <td>8月份计划完成本金指标</td>
    <td><input name="target_8_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>9月份计划完成设备金额指标</td>
    <td><input name="target_9_asset" type="text" size="20" dataType="Money"></td>
    <td>9月份计划完成本金指标</td>
    <td><input name="target_9_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>10月份计划完成设备金额指标</td>
    <td><input name="target_10_asset" type="text" size="20" dataType="Money"></td>
    <td>10月份计划完成本金指标</td>
    <td><input name="target_10_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>11月份计划完成设备金额指标</td>
    <td><input name="target_11_asset" type="text" size="20" dataType="Money"></td>
    <td>11月份计划完成本金指标</td>
    <td><input name="target_11_corpus" type="text" size="20" dataType="Money"></td>
  </tr>
  <tr>
    <td>12月份计划完成设备金额指标</td>
    <td><input name="target_12_asset" type="text" size="20" dataType="Money"></td>
    <td>12月份计划完成本金指标</td>
    <td><input name="target_12_corpus" type="text" size="20" dataType="Money"></td>
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
ShowTabN(0);
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
//function autoResize()
//{try{document.all["UserBody"].style.height=UserBody.document.body.scrollHeight}catch(e){}}
</script>
</form>

<!-- end cwMain -->
</body>
</html>
