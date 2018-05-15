<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("insurance-info-add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 保险清单</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="/tenwa/js/publicEvent.js"></script>
<script src="/dict/js/js_dictionary.js"></script>


</head>
<body onLoad="fun_winMax();">
<form name="form1" method="post" action="insurance_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保险管理 &gt; 保险清单
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
<script>
function getenddate(){
	var num=document.getElementById('income_number').value;
	var insurance_date=document.form1.insurance_date.value;
	if(num==""||insurance_date==""){
		num=0;
		document.form1.insurance_enddate.value=insurance_date;
		return;
	}	
	var year= Math.ceil(num/12);
	var year_date=insurance_date.substring(0,4);
	year=parseInt(year)+parseInt(year_date);
	var insurance_enddate=year+'-'+insurance_date.substring(5,10);
	document.form1.insurance_enddate.value=insurance_enddate;
}
</script>

<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>机编号<input type="hidden" name="equip_sn_status" value="1"></td>
    <td><input name="equip_sn" type="text" size="20" maxB="50" readonly ><input type="hidden" name="contract_id" value=""><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.equip_sn_status','机编号状态','equip_sn_status','string','机编号','contract_view','equip_sn','contract_id|engine_code|insurance_enddate|cust_name|insurer|leas_mode|equip_amt|insurance|lsh_insurance|cust_insurance|insurance_flag|sale_name|income_number|insurance_date|insurance_type','equip_sn','equip_sn','ASC','form1.equip_sn','form1.contract_id|form1.engine_code|form1.insurance_enddate|form1.cust_name|form1.insurer|form1.operation_way|form1.equip_amt|form1.insurance|form1.lsh_insurance|form1.cust_insurance|form1.insurance_flag|form1.sale_name|form1.income_number|form1.insurance_date|form1.insurance_type');">
	<span class="biTian">*</span></td>
    <td>发动机号</td>
    <td><input name="engine_code" type="text" size="20" maxB="50" readonly ></td>
    <td>投保日期</td>
    <td><input name="insurance_date" type="text" size="20" maxB="50" readonly dataType="Date" onPropertychange="getenddate()"><img  onClick="openCalendar(insurance_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
    <td>保险公司</td>
    <td><input name="insurer" type="text" size="20" maxb="50" readonly></td>
    <td>客户名</td>
    <td><input name="cust_name" type="text" size="20" maxB="50" readonly></td>
    <td>保险终止日期</td>
    <td><input name="insurance_enddate" type="text" size="20" maxlength="10" maxb="50" readonly datatype="Date">
      <img  onClick="openCalendar(insurance_enddate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
    <td>分公司</td>
    <td><input name="sale_name" type="text" size="20" maxb="50" readonly></td>
    <td>操作方式</td>
    <td><input name="operation_way" type="text" size="20" maxB="50" readonly></td>
    <td>机价</td>
    <td><input name="equip_amt" type="text" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>期数</td>
    <td><input name="income_number" type="text" size="20" maxB="50" readonly></td>
    <td>保险费总额</td>
    <td><input name="insurance" type="text" size="20" maxB="50" readonly datetype="Money"></td>
    <td>利星行支付保险(LSH)</td>
    <td><input name="lsh_insurance" type="text" size="20" maxB="50" readonly datetype="Money"></td>
  </tr>
  <tr>
    <td>融资公司赠送保险(HS/CCI)</td>
    <td><input name="give_insurance" type="text" size="20" maxB="50" readonly datetype="Money"></td>
    <td>客户现金支付保险(客户)</td>
    <td><input name="cust_insurance" type="text" size="20" maxB="50" readonly datetype="Money"></td>
    <td>保险费是否融资</td>
    <td><input name="insurance_flag" type="text" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>险种</td>
    <td><input name="insurance_type" type="text" size="40" maxB="50" readonly></td>
    <td>保险单号</td>
    <td><input name="insurance_no" type="text" size="20" maxb="50"></td>
    <td>收保单日期</td>
    <td><input name="get_date" type="text" size="20" maxB="50" readonly dataType="Date"><img  onClick="openCalendar(get_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
    <td>保险账户</td>
    <td><input name="insurance_account" type="text" size="20" maxb="50" ></td>
    <td>付款单编号</td>
    <td><input name="pay_no" type="text" size="20" maxB="50"></td>
    <td>付保费日期</td>
    <td><input name="pay_date" type="text" size="20" maxb="50" readonly datatype="Date">
      <img  onClick="openCalendar(pay_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
    <td>是否有特殊情况</td>
    <td><input name="is_special" type="text" size="20" maxB="50"></td>
    <td>批单信息</td>
    <td><input name="check_info" type="text" size="20" maxB="50"></td>
    <td>索赔理赔日志</td>
    <td><textarea name="claims_note" rows="4" ></textarea></td>
  </tr>
  <tr>
    <td>退保对象</td>
    <td><input name="surrender_object" type="text" size="20" maxB="50"></td>
    <td>最终赔付金额</td>
    <td><input name="finallyclaims_money" type="text" size="20" maxB="50" dataType="Money"></td>
    <td>退保日志</td>
    <td><textarea name="surrender_note" rows="4" ></textarea></td>
  </tr>
  <tr>
    <td>退保金额</td>
    <td><input name="surrender_money" type="text" size="20" maxB="50" dataType="Money"></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>备注</td>
    <td colspan="3"><textarea name="note" rows="4" ></textarea></td>
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
