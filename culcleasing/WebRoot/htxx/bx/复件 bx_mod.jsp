<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理 - 保险管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
	String id = getStr( request.getParameter("id") );
	String sqlstr = "select * from contract_insurance left join contract_info on contract_insurance.contract_id=contract_info.contract_id where id='"+id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
    String cust_id="";
	//String id="";
	
	String colleaction_date="";
	String insurance_type="";
	String payments="";
	String pay_date="";
	String buy_insuranceself="";
	String period_insurance="";
	String insurance_id="";
	String contract_id="";
	String insurance_my="";
	if(rs.next()){
	 insurance_my=getDBStr(rs.getString("insurance_my"));
	    contract_id=getDBStr(rs.getString("contract_id"));
	    insurance_id=getDBStr(rs.getString("insurance_id"));
		buy_insuranceself=getDBStr(rs.getString("buy_insuranceself"));
		period_insurance=getDBStr(rs.getString("period_insurance"));
		colleaction_date=getDBStr(rs.getString("colleaction_date"));
	    insurance_type=getDBStr(rs.getString("insurance_type"));
	    System.out.println("insurance_type=**"+insurance_type);
	    pay_date=getDBStr(rs.getString("pay_date"));
	    payments=getDBStr(rs.getString("payments"));
		
	}
	rs.close(); 
	db.close();
%>


<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="bx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
资产管理&gt; 保险修改
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
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
 <script language="javascript">
ShowTabN(0);
</script>
</td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=id  %>">
<input type="hidden" name="insurance_type" value="<%=insurance_type  %>">
<input type="hidden" name="period_insurance" value="<%=period_insurance  %>">
<input type="hidden" name="pay_date" value="<%=pay_date  %>">

<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td scope="row" width="130px">合同编号：</td>
    <td><input class="text" name="contract_id" type="text" size="30" readonly value="<%=contract_id %>"></td>
     <td width="130px">是否我司购买保险：</td>
    <td>
    <input name="insurance_my" type="radio" value="是" checked="checked">
												是
													<input name="insurance_my" type="radio" value="否">
											否
    </td>
   </tr>
   
   <tr>
    <td>保险期限:</td>
	<td><input class="text" name="period_insurance" type="text" size="30"  value="<%=period_insurance %>" Require="true" dataType="Number"><span class="biTian">*</span></td>
   
  <td width="130px">我司收取保险日期：</td>
    <td><input class="text" name="colleaction_date" type="text" size="30"  value="<%=getDBDateStr(colleaction_date) %>" readonly>
    <img onClick="openCalendar(colleaction_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle">
    </td>
 </tr>
 
	<tr>
    <td>险种:</td>
	<td><input class="text" name="insurance_type" type="text" size="30"  value="<%=insurance_type %>"><span class="biTian">*</span></td>
	<td >支付保险公司日期:</td>
	<td><input class="text" name="pay_date" type="text" size="30" readonly value="<%=getDBDateStr(pay_date) %>" readonly Require="true">
		 <img onClick="openCalendar(pay_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle"><span class="biTian">*</span>
	</td>
	</tr>
  <tr>
  <td>支付金额:</td>
    <td><input class="text" name="payments" type="text" size="30" value="<%=formatNumberDoubleTwo(payments)%>" dataType="Money" Require="true"><span class="biTian">*</span>
		<span class="biTian">*</span>
	</td>    
	 <td width="130px">保险单号：</td>
    <td><input class="text" name="insurance_id" type="text" size="30"  value="<%=insurance_id %>" Require="true"><span class="biTian">*</span></td>
	
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

<!-- end cwMain -->
</body>
</html>