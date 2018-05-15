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
    String czid = getStr( request.getParameter("id") );
	//String cust_id = getStr( request.getParameter("custId") );
	String sqlstr = "select * from contract_insurance where id='"+czid+"'"; 
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
	String insured_amount="";
	
	String insurance_company="";
	String insured="";
  String b_insured="";
  String insurance_coverage="";
	String price_coverage="";
	String price_appraisal="";
	String assessment_company="";
  String production_date="";
	String total_insurance="";
	String deductible_accident="";
	String premium_rate="";
	String general_insurance="";
	String jurisdiction="";
	String beneficiaries="";
	String memo="";
	String attachment="";
	
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
	  insured_amount=getDBStr(rs.getString("insured_amount"));
	  
	  insurance_company=getDBStr(rs.getString("insurance_company"));
	  insured=getDBStr(rs.getString("insured"));
	  b_insured=getDBStr(rs.getString("b_insured"));
	  insurance_coverage=getDBStr(rs.getString("insurance_coverage"));
	  price_coverage=getDBStr(rs.getString("price_coverage"));
	  price_appraisal=getDBStr(rs.getString("price_appraisal"));
	  assessment_company=getDBStr(rs.getString("assessment_company"));
	  production_date=getDBStr(rs.getString("production_date"));
	  
	  total_insurance=getDBStr(rs.getString("total_insurance"));
	  deductible_accident=getDBStr(rs.getString("deductible_accident"));
	  premium_rate=getDBStr(rs.getString("premium_rate"));
	  general_insurance=getDBStr(rs.getString("general_insurance"));
	  jurisdiction=getDBStr(rs.getString("jurisdiction"));
	  beneficiaries=getDBStr(rs.getString("beneficiaries"));
	  memo=getDBStr(rs.getString("memo"));
	  attachment=getDBStr(rs.getString("attachment"));
	  
	  
	}
	rs.close(); 
	db.close();
%>
<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" enctype="multipart/form-data" method="post" action="bx_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保险管理 &gt; 保险删除
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
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


<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">




<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
	  <tr>
	  <td scope="row">合同编号：</td>
	    <td><%=contract_id %></td>
	      <td scope="row">是否我司代买保险：</td>
	     
	    <td><%=insurance_my %></td>
	  </tr>
	 
	   <tr>
	      <td>保险类型：</td>
	    <td><%=insurance_type %></td>
	   <td>保险公司：</td>
	    <td><%=insurance_company%></td> 
	    </tr>
	  
	  <tr>
	  	 <td>保险单号：</td>
	    <td><%=insurance_id %></td>
	  	 <td>投保人：</td>
	    <td><%=b_insured %></td>
	  	</tr>
	  	
	   <tr>
	  	 <td>被保险人：</td>
	    <td><%=insurance_id %></td>
	  	  <td>保险期限：</td>
	    <td><%=period_insurance %></td>
	  	</tr>
	  
	  <tr>
	  	 <td>保险项目：</td>
	    <td><%=insurance_coverage %></td>
	  	  <td>保险项目原价：</td>
	    <td><%=price_coverage %></td>
	  	</tr>
	  
	   <tr>
	  	 <td>保险项目评估价：</td>
	    <td><%=price_appraisal %></td>
	  	  <td>保险项目评估公司：</td>
	    <td><%=assessment_company %></td>
	  	</tr>
	  
	    <tr>
	  	 <td>保险项目生产日期：</td>
	    <td><%=getDBDateStr(production_date) %></td>
	  	  <td>保险金额：</td>
	   <td><%=payments %></td>
	  	</tr>
	  
	    <tr>
	  	 <td>总保险金额：</td>
	    <td><%=total_insurance %></td>
	  	  <td>每次事故免赔额 ：</td>
	   <td><%=deductible_accident %></td>
	  	</tr>
	  
	    <tr>
	  	 <td>保险费率：</td>
	    <td><%=premium_rate %></td>
	  	  <td>总保险费 ：</td>
	   <td><%=general_insurance %></td>
	  	</tr>
	   <tr>
	    
	   <td>付费日期：</td>
	    <td><%=getDBDateStr(pay_date) %></td>
	     <td>司法管辖 ：</td>
	   <td><%=jurisdiction %></td>
	    </tr>
	    
	 
	    
	<tr>
	<td>受益人：</td>
	    <td><%=beneficiaries %></td>
	    <td>备注：</td>
	    <td><%=memo %></td>
	</tr>
	
	<tr>
    <td scope="row">附件：</td>
    <td  name="fj_name"><%= attachment %></td>
   <td></td><td></td>
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
