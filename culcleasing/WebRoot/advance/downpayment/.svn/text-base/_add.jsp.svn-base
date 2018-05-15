<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>首付款管理 - DownpaymentList</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="/tenwa/js/publicEvent.js"></script>
<script src="/dict/js/js_dictionary.js"></script>


</head>
<body onLoad="fun_winMax();">
<form name="form1" method="post" action="downpayment_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
首付款管理 &gt; DownpaymentList
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
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
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
    <td>机编号</td>
    <td><input name="equip_sn" type="text"  size="20" maxB="50" readonly Require="true"><input type="hidden" name="contract_id"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','机编号',  'downpayment_view','equip_sn','contract_id|device_type|cust_name|leas_mode|stock_place|sale_name|peroid_payment|factmoney|fact_info|equals|insurance_flag|insurance|csa_cost|VouchNo','equip_sn','','','form1.equip_sn','form1.contract_id|form1.device_type|form1.cust_name|form1.leas_mode|form1.stock_place|form1.sale_name|form1.peroid_payment|form1.factmoney|form1.fact_info|form1.equals|form1.insurance_flag|form1.insurance|form1.csa_cost|form1.VouchNo');">
	<span class="biTian">*</span></td>
    <td>机型</td>
    <td><input name="device_type" type="text" size="20" maxB="50" readonly></td>
    <td>客户名称</td>
    <td><input name="cust_name" type="text" size="20" maxB="50"  readonly> </td>
   </tr>
   <tr>
    <td>融资模式</td>
    <td><input name="leas_mode" type="text" size="20" maxB="50" readonly></td>
    <td>库存</td>
    <td><input name="stock_place" type="text" size="20" maxB="50" readonly></td>
    <td>分公司</td>
    <td><input name="sale_name" type="text" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>初期首付总额</td>
    <td><input name="peroid_payment" type="text" size="20" maxB="50" readonly></td>
    <td>实收金额</td>
    <td><input name="factmoney" type="text" size="20" maxB="50" readonly ></td>
    <td>实收情况</td>
    <td><input name="fact_info" type="text" size="20" maxB="500" readonly></td>
  </tr>
  <tr>
    <td>首付差额</td>
    <td><input name="equals"  type="text" size="15" maxlength="10" readonly>
    <td>是否保险融资</td>
    <td><input name="insurance_flag" type="text" size="20" maxB="50" readonly></td>
    <td>保险金额</td>
    <td><input name="insurance" type="text" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>CSA</td>
    <td><input name="csa_cost"  type="text" size="15" maxlength="10" readonly>
     <td>VouchNo</td>
    <td><input name="VouchNo" type="text" size="20" maxB="50" readonly></td>
    <td></td>
    <td></td>
    
  </tr>
   <tr>
    <td>备注</td>
    <td colspan="3"><textarea name="remark" cols="20" rows="5" maxb="100" style="width:536px"></textarea></td><td></td><td></td>
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
