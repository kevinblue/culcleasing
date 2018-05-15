<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 合同设备维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

</head>
<body onload="fun_winMax();">
<form name="form1" method="post" action="htsb_save.jsp" onSubmit="return Validator.Validate(this,3);">
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
if (right.CheckRight("zjwjgl-htsb-add",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>
<%
	String contract_id=getStr( request.getParameter("czid") );
 %>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
合同信息 &gt; 合同设备维护
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
    <td>合同编号</td>
    <td><input name="contract_id" type="text" size="20"  Require="true" readonly value="<%=contract_id %>"></td>
    <td>租赁物件名称</td>
    <td><input name="eqip_name" type="text" size="20" maxB="300" Require="true">
    <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>品牌</td>
    <td><input name="brand" type="text" size="20" maxB="100"></td>
    <td>型号/规格</td>
    <td><input name="model" type="text" size="20" maxB="500"></td>
  </tr>
  <tr>
    <td>设备序列号</td>
    <td><input name="equip_sn" type="text" size="20" maxB="500"></td>
    <td>单价</td>
    <td><input name="equip_price" type="text" size="20" dataType="Money" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>数量</td>
    <td><input name="equip_num" type="text" size="20" dataType="Integer" Require="true"><span class="biTian">*</span></td>
	<td>总价</td>
    <td><input name="total_price" type="text" size="20" dataType="Money" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>生产厂商</td>
    <td><input name="manufacturer_name" type="text" size="40" readonly><input type="hidden" name="manufacturer"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','客户信息','vi_cust_all_info','cust_name','cust_id','cust_name','cust_name','asc','form1.manufacturer_name','form1.manufacturer');">
    </td>
    <td>销货单位</td>
    <td><input name="distributor_name" type="text" size="40" readonly><input type="hidden" name="distributor"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','客户信息','vi_cust_all_info','cust_name','cust_id','cust_name','cust_name','asc','form1.distributor_name','form1.distributor');">
    </td>
  </tr>
  <tr>
    <td>物件交付地</td>
    <td><input name="equip_delivery_place" type="text" size="40" maxB="300"></td>
    <td>设备设置地</td>
    <td><input name="equip_place" type="text" size="40" maxB="300"></td>
  </tr>
  <tr>
    <td>交付时间</td>
    <td><input name="equip_delivery_date" type="text" size="15" readonly maxlength="10" dataType="Date"> <img  onClick="openCalendar(equip_delivery_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td>质量保证期</td>
    <td><input name="shelf_life" type="text" size="15" readonly maxlength="10" dataType="Date"> <img  onClick="openCalendar(shelf_life);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
  </tr>
  <tr>
  	<td>物件状态</td>
    <td><select name="equip_status"></select>
	<script language="javascript">dict_list("equip_status","equip_status","","name");</script>
    </td>
    <td>状态日期</td>
    <td><input name="status_date" type="text" size="15" readonly maxlength="10" dataType="Date"> <img  onClick="openCalendar(status_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
  </tr>
  <tr>
  	<td>是否免税</td>
    <td colspan="3"><select name="tax_flag"><script>w(mSetOpt("",'完税|免税'));</script></select>
    </td>
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

<!-- end cwMain -->
</body>
</html>
<%db.close();%>