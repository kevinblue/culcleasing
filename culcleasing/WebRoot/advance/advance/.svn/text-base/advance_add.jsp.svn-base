<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("advance-advance-add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>首付款管理 - 垫付清单维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="/tenwa/js/publicEvent.js"></script>
<script src="/dict/js/js_dictionary.js"></script>


</head>
<body onLoad="fun_winMax();">
<form name="form1" method="post" action="advance_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
首付款管理 &gt; 垫付清单维护
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
<script language="javascript">
function delaydate(){
	var s_date = document.getElementById("special_date");
	var e_date = document.getElementById("start_date");
	if(s_date.value<=e_date.value){
		document.getElementById("special_date_number").value = 0;
	}else {
		if(e_date.value == "" || s_date.value == ""){
			return;
		}else{
		var arrbeginDate= e_date.value.split("-");
		   Date1= new Date(arrbeginDate[1]+'-'+arrbeginDate[2]+'-'+arrbeginDate[0]);
		var arrendDate= s_date.value.split("-");
		   Date2= new Date(arrendDate[1]+'-'+arrendDate[2]+'-'+arrendDate[0]) 
		   iDays = parseInt(Math.abs(Date1- Date2)/1000/60/60/24)        //转换为天数 
		   document.getElementById("special_date_number").value = iDays ;
		}
	}
}
function delays(){
	var s_money = document.getElementById("advance_amt").value;
	var i_money = document.getElementById("income_total").value;
	if(s_money != null && s_money != null){
		document.getElementById("delay").value = parseFloat(s_money) - parseFloat(i_money);
		if(document.getElementById("delay").value<0){
			alert("还款总额大于垫支总额");
		}
	}
}
</script>
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
<script>
function getenddate(){
	var special_date_number=document.form1.special_date_number.value;
	if(special_date_number==""){
		special_date_number=0;
	}
	var start_date=document.form1.start_date.value;
	if(start_date==""){
		return;
	}
	start_date=start_date.replace('-','/');
	var d = new Date(start_date);
	var temp=d.valueOf()+special_date_number*24*60*60*1000;
	var newdate=new Date(temp);
	var temp_1 =newdate.getFullYear()+'-'+(newdate.getMonth()+1)+'-'+newdate.getDate();
	document.getElementById('date_now').value=temp_1;
}
</script>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <!-- <td>序号</td>
    <td><input name="id" type="text"  size="20" maxB="50" readonly ></td>
     -->
    <td>机编号</td>
    <td><input name="equip_sn" type="text" size="20" maxB="50" readonly></td>
    <td>合同号</td>
    <td><input name="contract_id" type="text" size="20" maxB="50" Require="true"> <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','合同号',  'contract_view','contract_id','equip_sn|cust_name|sale_name|start_date','contract_id','','','form1.contract_id','form1.equip_sn|form1.cust_name|form1.sale_id|form1.start_date');">
	<span class="biTian">*</span></td>


    <td>客户</td>   
    <td><input name="cust_name" type="text" size="20" maxB="50" readonly></td>
    </tr>
    <tr>
    <td>分公司</td>
    <td><input name="sale_id" type="text" size="20" maxB="50" readonly></td>
    <td>垫资总额</td>
    <td><input name="advance_amt" type="text" onChange="delays()" size="20" maxB="50" dataType="Money" value="0"></td>

    <td>是否有特批三要素</td>
    <td><input name="special_flag" type="text" size="20" maxB="50"></td>
    </tr>
    <tr>
    <td>放机日期</td>
    <td><input name="start_date" type="text" size="20" maxB="50" onPropertychange="getenddate()" readonly ></td>
    <td>特批延期付款天数</td>
    <td><input name="special_date_number" type="text" size="20" onPropertychange="getenddate()" maxB="50" ></td>

    <td>最终还款期限</td>
    <td><input name="special_date" id="date_now"  type="text" size="15" maxlength="10" dataType="Date"  readonly>
    </tr>
    <tr>
    <td>还款总额</td>
    <td><input name="income_total" type="text" onChange="delays()" size="20" maxB="50" dataType="Money" value="0"></td>
    <td>差额</td>
    <td><input name="delay" type="text" size="20" maxB="50" readonly></td>
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
