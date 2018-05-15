<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>系统意见 - 系统意见库</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body>


<form name="form1" enctype="multipart/form-data"  method="post" action="xtwt_save.jsp" onSubmit="return Validator.Validate(this,3);">



<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
系统意见库管理 &gt; 新增系统意见
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
<img src="../../images/btn_close.gif" align="absmiddle" border="0">关闭</button>

    	
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
 </table>
  <script language="javascript">
ShowTabN(0);
</script> 
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwCellTop -->




<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<!--
<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">
-->
<input type="hidden" value="add" name="savetype">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">


  <tr>
    <td scope="row" nowrap>模块：</td>
    <td><select class="text" name="model" Require="true" ></select>
<script language="javascript" class="text">dict_list("model","SysModel","","title");</script><span class="biTian">*</span></td>
  <td scope="row" nowrap>功能：</td>
    <td>
    	<select class="text" name="action" Require="true" ></select>
<script language="javascript" class="text">dict_list("action","SysAction","","title");</script><span class="biTian">*</span>
    	</td>
  </tr>
    <tr>
    <td scope="row" nowrap>优先程度：</td>
    <td><select class="text" name="degree" ><script>w(mSetOpt("","|高|中|低"));</script></select><span class="biTian">*</span></td>
  <td scope="row" nowrap>类型：</td>
    <td>
    	<select class="text" name="type" ><script>w(mSetOpt("","|功能错误|优化建议|性能问题"));</script></select>
    	</td>
  </tr>
  <tr>
  	
  	
  
    <td >问题描述：</td>
<td scope="row" >
    <textarea class="text" name="describe"  maxB="300" rows="15"></textarea></td>
    <td>备注：</td>
  	<td>
  	<textarea class="text" name="remark"  maxB="300" rows="15"></textarea>
  	</td>
  </tr>
  <tr>
    <td scope="row">附件：</td>
    <td><!-- 上传组件 -->
	<!--
<input type="button" onclick="insRow('tabUpFile')" value="增加上传数"  name="addFileNum" >
-->
<table id="tabUpFile" border="0" cellpadding="0" cellspacing="0"></table><script>insRow('tabUpFile')</script>
<!-- End 上传组件 --><span class="biTian">允许上传的文件类型.zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt</span></td>
  </tr>
</table>


</div>

</div>

    </form>

<!-- end cwMain -->
</body>
</html>
