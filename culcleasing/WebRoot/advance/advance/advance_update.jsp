<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
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
if (right.CheckRight("advance-advance-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>首付款管理 - 垫付清单维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>



<body onLoad="fun_winMax();">
<form name="form1" method="post" action="advance_save.jsp" onSubmit="return Validator.Validate(this,3);">
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
String sqlstr = "select ad.id, views.equip_sn,views.contract_id,views.cust_name,dbo.fk_getname(views.sale_id) sale_id,ad.advance_amt,ad.special_flag,views.start_date,ad.special_date_number,ad.special_date,ad.income_total,(ad.advance_amt-ad.income_total) delay from fund_rent_advance ad left join contract_view views on views.contract_id = ad.contract_id where ad.id = '"+czid+"'";
	ResultSet rs = db.executeQuery(sqlstr); 
	String	id = "";
	String	equip_sn = "";
	String	contract_id = "";
	String	cust_name = "";
	String	sale_id = "";
	String	advance_amt = "";
	String	special_flag = "";
	String	start_date = "";
	String	special_date_number = "";
	String	special_date = "";
	String	income_total = "";
	String	delay = "";
if ( rs.next() ) {
		id = getDBStr( rs.getString("id") );
		equip_sn = getDBStr( rs.getString("equip_sn") );
		contract_id = getDBStr( rs.getString("contract_id") );
		cust_name = getDBStr( rs.getString("cust_name") );
		sale_id = getDBStr( rs.getString("sale_id") );
		advance_amt = formatNumberStr(getDBStr( rs.getString("advance_amt") ),"###0.00");
		special_flag = getDBStr( rs.getString("special_flag") );
		start_date = getDBDateStr( rs.getString("start_date") );
		special_date_number = getDBStr( rs.getString("special_date_number") );
		special_date = getDBDateStr( rs.getString("special_date") );
		income_total = formatNumberStr(getDBStr( rs.getString("income_total") ),"###0.00");
		delay = formatNumberStr(getDBStr( rs.getString("delay") ),"###0.00");
	}
	rs.close(); 
	db.close();
%>

<input type="hidden" name="id" value="<%= id %>">
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
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
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <!-- <td>序号</td>
    <td><input name="id" type="text" value="<%= id %>" size="20" maxB="50" readonly ></td> -->
    <td>机编号</td>
    <td><input name="equip_sn" type="text" value="<%= equip_sn %>" size="20" maxB="50" readonly ></td>
    <td>合同号</td>
    <td><input name="contract_id" type="text" value="<%= contract_id %>" size="20" maxB="50" readonly></td>

    <td>客户</td>
    <td><input name="cust_name" type="text" value="<%= cust_name %>" size="20" maxB="50" readonly></td>
   </tr>
   <tr>
    <td>分公司</td>
    <td><input name="sale_id" type="text" value="<%= sale_id %>" size="20" maxB="50" readonly></td>
    <td>垫资总额</td>
    <td><input name="advance_amt" type="text" value="<%= advance_amt %>" onChange="delays()" size="20" maxB="50" dataType="Money"></td>

    <td>是否有特批三要素</td>
    <td><input name="special_flag" type="text" value="<%= special_flag %>" size="20" maxB="50"></td>
  </tr>
  <tr>
    <td>放机日期</td>
    <td><input name="start_date" type="text" value="<%=start_date  %>" onPropertychange="getenddate()" size="20" maxB="50" readonly></td>
    <td>特批延期付款天数</td>
    <td><input name="special_date_number" type="text" value="<%= special_date_number %>" size="20" maxB="50" onPropertychange="getenddate()"></td>

    <td>最终还款期限</td>
    <td><input name="special_date" id="date_now"  type="text" value="<%= special_date %>" size="15" maxlength="10" dataType="Date" readonly> 
  </tr>
  <tr>
    <td>还款总额</td>
    <td><input name="income_total" type="text" onChange="delays()" value="<%= income_total %>" size="20" maxB="50" dataType="Money"></td>
    <td>差额</td>
    <td><input name="delay" type="text" value="<%= delay %>" size="20" maxB="50" readonly></</td> <td></td><td></td>
  </tr>
</table>
</div>
</div>
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