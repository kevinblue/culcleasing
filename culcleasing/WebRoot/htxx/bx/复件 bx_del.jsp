<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理 - 保险管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
    String id = getStr( request.getParameter("id") );
	//String cust_id = getStr( request.getParameter("custId") );
	String sqlstr = "select * from contract_insurance where id='"+id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
	//String cust_id="";//客户名称\省份
    String contract_id="";
	String colleaction_date="";
	String insurance_type="";
	String payments="";
	String pay_date="";
	String buy_insuranceself="";
	String period_insurance="";
	String insurance_id="";
	String insurance_my="";
	if(rs.next()){
		//cust_id=getDBStr(rs.getString("cust_id"));
		contract_id=getDBStr(rs.getString("contract_id"));
		insurance_my=getDBStr(rs.getString("insurance_my"));
		insurance_id=getDBStr(rs.getString("insurance_id"));
		buy_insuranceself=getDBStr(rs.getString("buy_insuranceself"));
		period_insurance=getDBStr(rs.getString("period_insurance"));
		colleaction_date=getDBStr(rs.getString("colleaction_date"));
	    insurance_type=getDBStr(rs.getString("insurance_type"));
	    pay_date=getDBStr(rs.getString("pay_date"));
	    payments=getDBStr(rs.getString("payments"));
	
	}
	rs.close(); 
	db.close();
%>
<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="bx_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保险管理 &gt; 保险删除
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
	    	
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/btn_delete.gif" align="absmiddle" border="0">删除</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">删除</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
  <script language="javascript">
ShowTabN(0);
</script></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">




<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%= id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
	  <tr>
	  <td scope="row">合同编号：</td>
	    <td><%=contract_id %></td>
	      <td scope="row">是否我司代买保险：</td>
	     
	    <td><%=insurance_my %></td>
	  </tr>
	 
	  
	 
	   <tr>
	      <td>保险期限：</td>
	    <td><%=period_insurance %></td>
	   <td>我司收取日期：</td>
	    <td><%=getDBDateStr(colleaction_date) %></td>
	    </tr>
	      <tr>
	       <td>险种：</td>
	    <td><%=insurance_type %></td>
	    <td>支付保险公司日期：</td>
	    <td><%=getDBDateStr(pay_date)%></td>
	  </tr>
	 
	    
	    <tr>
	    <td>支付金额：</td>
	    <td><%=payments %></td>
	     <td>保险单号：</td>
	    <td><%=insurance_id %></td>
	  </tr>
	
</table>
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








</form>

<!-- end cwMain -->
</body>
</html>
