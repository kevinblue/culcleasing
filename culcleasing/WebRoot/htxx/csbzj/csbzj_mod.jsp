<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>厂商保证金管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
	<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script type="text/javascript">
function makeValue(){
var total=0.00;
var caution_money = document.getElementsByName("caution_money")[0].value;
var equip_amt=document.getElementsByName("equip_amt")[0].value;
total=total+caution_money*equip_amt;
document.getElementById("min_payment").value=total;
//alert(total);
}

function makeV()
{
    var totals=0.00;
	var ensure_payment=parseFloat(document.getElementsByName("ensure_payment")[0].value);//初始金额
    var deposit_amount=parseFloat(document.getElementsByName("deposit_amount")[0].value);//汇入金额
	var deposit_export=parseFloat(document.getElementsByName("deposit_export")[0].value);//汇出金额
	//var margin_amount=document.getElementsByName("margin_amount")[0].value;//汇出金额
    totals=ensure_payment+deposit_amount-deposit_export;
	document.getElementsByName("margin_amount")[0].value=totals;//汇出金额
	//alert(totals);
}
</script>

</head>



<body >
<form name="form1" enctype="multipart/form-data" method="post" action="csbzj_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
厂商保证金管理&gt; 汇出汇入记录修改
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
	    	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修改信息</td>
  
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
<center>
<!--
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->
<%
String bid;
String sqlstr;

ResultSet rs;
bid=getStr(request.getParameter("bid"));
System.out.println("++++++++++++czid="+bid);

	sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from mproj_company where bid='"+bid+"' ";  

 rs = db.executeQuery(sqlstr);
	System.out.println("sqlstr#####***********####"+sqlstr);
String contract_id="";
String manuf_name="";
String margin_per="";
String vendor_payment="";
String min_payment="";
String ensure_payment="";
String margin_amount="";
String deposit_amount="";
String margin_time="";
String margin_reason="";
String deposit_export="";
String export_time="";
String export_reason="";
String attachment="";
String creator="";
String create_date="";
String modificator="";
String modify_date="";

	if(rs.next()){
	      
        //contract_id=getStr(request.getParameter("contract_id"));
		contract_id=getDBStr(rs.getString("contract_id"));
		manuf_name=getDBStr(rs.getString("manuf_name"));
	    margin_per=getDBStr(rs.getString("margin_per"));
	    min_payment=getDBStr(rs.getString("min_payment"));
		ensure_payment=getDBStr(rs.getString("ensure_payment"));
	    margin_amount=getDBStr(rs.getString("margin_amount"));
		deposit_amount=getDBStr(rs.getString("deposit_amount"));
		margin_time=getDBStr(rs.getString("margin_time"));
		margin_reason=getDBStr(rs.getString("margin_reason"));
	    deposit_export=getDBStr(rs.getString("deposit_export"));
        export_time=getDBStr(rs.getString("export_time"));
		export_reason=getDBStr(rs.getString("export_reason"));
	    attachment=getDBStr(rs.getString("attachment"));
        creator=getDBStr(request.getParameter("creator"));
        create_date=getDBStr(request.getParameter("create_date"));  
        modificator=getDBStr(request.getParameter("modificator"));
		System.out.println("attachment//////////////////////////////////////////"+attachment);
        modify_date=getDBStr(request.getParameter("modify_date"));  
	  
	
	
%>
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="uid" value="<%=bid  %>">

<input class="text" type="hidden" name="bid" value="<%=getDBStr(rs.getString("bid"))%>">


<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td scope="row">子合同编号：</td>

    <td><input class="text" name="contract_id" type="text" size="20"  value="<%=getDBStr(rs.getString("contract_id"))%>"  maxlength="50"  readonly></td>
   
 
   <td scope="row">厂商设备金额：</td>
   
	  <td><input class="text" name="vendor_payment" type="text" size="20"  value="<%=formatNumberStr(rs.getString("vendor_payment"),"#,##0.00")%>"  maxlength="50" dataType="Money" readonly></td>
     
 
  </tr>
  
   
    <tr>
    <td scope="row">保证金汇入金额：</td>
    <td><input class="text" name="deposit_amount" type="text" size="20"  value="<%=formatNumberStr(rs.getString("deposit_amount"),"#,##0.00")%>"  maxlength="50" dataType="Money"></td>
   
    <td scope="row">保证金汇出金额：</td>
    <td><input class="text" name="deposit_export" type="text" size="20" value="<%=formatNumberStr(rs.getString("deposit_export"),"#,##0.00")%>"   maxlength="50" dataType="Money"></td>
</tr>
	
  <tr>
   <td scope="row">保证金汇入时间：</td>
    <td>
        <input class="text" type="text" name=margin_time  Require="true" value="<%=getDBDateStr(rs.getString("margin_time"))%>" maxlength="40" readonly>
     <img  onClick="openCalendar(margin_time);return false" style="cursor:pointer; " src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
     <td scope="row">保证金汇出时间:</td>
  <td>
        <input class="text" type="text" name=export_time  Require="true" value="<%=getDBDateStr(rs.getString("export_time"))%>" maxlength="40" readonly>
     <img  onClick="openCalendar(export_time);return false" style="cursor:pointer; " src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
 
  </tr>
   <tr>
    <td scope="row">最低保证金金额：</td>
    <td><input class="text" name="min_payment" type="text" size="20"  value="<%=formatNumberStr(rs.getString("min_payment"),"#,##0.00")%>"  maxlength="50" dataType="Money" readonly></td>
<td scope="row">保证金比率:</td>
  
	   <td><input class="text" name="margin_per" type="text" size="20"  value="<%=formatNumberStr(rs.getString("margin_per"),"#,##0.00")%>"  maxlength="50" dataType="Money" readonly></td>
   </tr>
  <tr>
   <td>保证金汇入原因：</td>
   <td ><textarea class="text" name="margin_reason" rows="5"  value="<%=margin_reason%>" maxB="400"><%=margin_reason %></textarea></td>
   
     <td>保证金汇出原因：</td>
     <td ><textarea class="text" name="export_reason" rows="5"  value="<%=export_reason%>" maxB="400"><%=export_reason %></textarea></td>
  </tr>

 <tr>

 

    <td scope="row" nowrap>附件：</td>
	<%if(!attachment.equals("")){%>
    <td><%= attachment %><input type="submit" value="删除" onclick="form1.fj_del.value=1;"><input type="hidden" name="fj_del"></td>
	<%}else{%>
	<td><table id="tabUpFile" border="0" cellpadding="0" cellspacing="0"></table><script>insRow('tabUpFile')</script>
<!-- End 上传组件 --><span class="biTian">允许上传的文件类型.zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt</span></td>
<%}%>
  </tr>
</table>
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
</form>
<%
}
	rs.close(); 
	db.close();
 %>
<!-- end cwMain -->
</body>
</html>