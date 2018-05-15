<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 保险赔款确认</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("insurance-claims-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>


<body onLoad="fun_winMax();">
<form name="form1" method="post" action="claims_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保险管理 &gt; 保险赔款确认
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">维护信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
	String czid = getStr( request.getParameter("czid") );
String sqlstr = "select distinct claims_id,claims.contract_id,claims.equip_sn,views.insurer,dbo.fk_getname(views.sale_id) sale_id ,claims.claims_date,claims.claims_name,claims.claims_money,claims.repair_delaydate,claims.repair_delaymoney,claims.financing_delaydate,claims.financing_delaymoney,views.leas_mode operation_way from insurance_claims claims left join  contract_view views on views.contract_id = claims.contract_id where claims.claims_id = '"+czid+"'";
	ResultSet rs = db.executeQuery(sqlstr); 
	String	claims_id = "";
	String	equip_sn = "";
	String	contract_id = "";
	String	insurer = "";
	String	sale_id = "";
	String	claims_date = "";
	String	claims_money = "";
	String	claims_name = "";
	String	repair_delaydate = "";
	String	repair_delaymoney = "";
	String	financing_delaydate = "";
	String	financing_delaymoney = "";
	String	operation_way = "";
if ( rs.next() ) {
		claims_id = getDBStr( rs.getString("claims_id") );
		equip_sn = getDBStr( rs.getString("equip_sn") );
		contract_id = getDBStr( rs.getString("contract_id") );
		insurer = getDBStr( rs.getString("insurer") );
		sale_id = getDBStr( rs.getString("sale_id") );
		claims_date = getDBDateStr( rs.getString("claims_date") );
		claims_money = getMoneyStr( rs.getString("claims_money") );
		claims_name = getDBStr( rs.getString("claims_name") );
		repair_delaydate = getDBDateStr( rs.getString("repair_delaydate") );
		repair_delaymoney = getMoneyStr( rs.getString("repair_delaymoney") );
		financing_delaydate = getDBDateStr( rs.getString("financing_delaydate") );
		financing_delaymoney = getMoneyStr( rs.getString("financing_delaymoney") );
		operation_way = getDBStr( rs.getString("operation_way") );
	}
	rs.close(); 
	db.close();
%>

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>机编号</td>
    <td><input name="equip_sn" type="text" size="20" maxb="50" require="true" readonly value="<%= equip_sn %>"></td>
    <td>分公司</td>
    <td><input name="sale_id" type="text" size="20" maxB="50" readonly value="<%= sale_id %>"></td>
     <td>保险公司</td>
    <td><input name="insurer" type="text" size="20" maxb="50" readonly  value="<%= insurer %>"></td>    
     </tr>
     <tr>
     <td>日期</td>
    <td><input name="claims_date" type="text" size="15" maxlength=	"10" dataType="Date" readonly value="<%= claims_date %>"> <img  onClick="openCalendar(claims_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
     <td>姓名</td>
    <td><input name="claims_name" type="text" size="20" maxB="50" value="<%= claims_name %>"></td>
   
    <td>赔款金额</td>
    <td><input name="claims_money" type="text" size="20"  maxB="50"  dataType="Money" value="<%= claims_money %>"></td>
     </tr>
    <tr>
    <td>确认维修欠款时间</td>
    <td><input name="repair_delaydate" type="text"  size="15"  maxlength=	"10" dataType="Date" readonly value="<%= repair_delaydate %>"> <img  onClick="openCalendar(repair_delaydate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
    <td>确认维修欠款金额</td>
    <td><input name="repair_delaymoney" type="text" size="20" maxB="50" dataType="Money" value="<%= repair_delaymoney %>"></td>
    <td>融资或分期欠款时间</td>
    <td><input name="financing_delaydate" type="text" size="15" maxlength="10" dataType="Date" readonly value="<%= financing_delaydate %>"> <img  onClick="openCalendar(financing_delaydate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
     </tr>
     <tr>
     <td>融资或分期欠款金额</td>
    <td><input name="financing_delaymoney" type="text" size="20"  maxB="50" dataType="Money" value="<%= financing_delaymoney %>"></td>
     <td>操作方式</td>
    <td><input name="operation_way" type="text" size="20" maxB="50"  readonly value="<%= operation_way %>"></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
     </tr>
</table>
</div>
</div>
<script language="javascript">
function delaydate(){
	var s_date = document.getElementById("special_date");
	var e_date = document.getElementById("out_time");
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
<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

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
ss