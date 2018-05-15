<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同后期管理 - 解约</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

</head>
<body onload="public_onload(0);">
<form name="form1" method="post" target="_blank" action="aheadbreak_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	
<%
	String sqlstr;
	ResultSet rs;
	String contract_id = getStr( request.getParameter("contract_id") );
	String doc_id = getStr( request.getParameter("doc_id") );
	String dqczy = (String) session.getAttribute("czyid");
	String curr_date = getSystemDate(0);
	
	String applicant="";
	String applicant_name="";
	String apply_date="";
	String rent_interval="";
	String pay_day="";
	String contract_amt="";
	String first_payment="";
	String lease_money="";
	String received_caution_money="";
	//String received_handling_charge="";
	//String received_return="";
	String received_insurance="";
	String received_list="";
	String received_rent="";
	//String received_amt="";
	String undue_list="";
	String undue_rent="";
	String overdue_list="";
	String overdue_rent="";
	String overdue_penalty="";
	String nominalprice="";
	String risk_exposure="";
	
	sqlstr="select xm from jb_yhxx where id='"+dqczy+"'";
	//System.out.println("sqlstr==========================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		applicant=dqczy;
		applicant_name=getDBStr(rs.getString("xm"));
	}rs.close();
	apply_date=curr_date;
	
	sqlstr="select contract_ahead_break.contract_id, contract_ahead_break.applicant, jb_yhxx.xm as applicant_name, contract_ahead_break.apply_date, contract_ahead_break.rent_interval, contract_ahead_break.pay_day, contract_ahead_break.contract_amt, contract_ahead_break.first_payment, contract_ahead_break.lease_money, contract_ahead_break.received_caution_money, contract_ahead_break.nominalprice, contract_ahead_break.received_list, contract_ahead_break.received_rent, contract_ahead_break.undue_list, contract_ahead_break.undue_rent, contract_ahead_break.overdue_list, contract_ahead_break.overdue_rent, contract_ahead_break.overdue_penalty, contract_ahead_break.received_insurance, contract_ahead_break.risk_exposure, contract_ahead_break.billing_manager, contract_ahead_break.billing_date, contract_ahead_break.effective_date, contract_ahead_break.agree_amt, contract_ahead_break.difference_amt, contract_ahead_break.difference_memo, contract_ahead_break.price_factor_name1, contract_ahead_break.price_factor1, contract_ahead_break.price_factor_name2, contract_ahead_break.price_factor2, contract_ahead_break.price_factor_name3, contract_ahead_break.price_factor3, contract_ahead_break.price_factor_name4, contract_ahead_break.price_factor4, contract_ahead_break.price_factor_name5, contract_ahead_break.price_factor5, contract_ahead_break.price_factor_name6, contract_ahead_break.price_factor6, contract_ahead_break.price_factor_name7, contract_ahead_break.price_factor7, contract_ahead_break.price_factor_name8, contract_ahead_break.price_factor8 from contract_ahead_break left join jb_yhxx on contract_ahead_break.applicant=jb_yhxx.id where contract_ahead_break.doc_id='"+doc_id+"'";
	//System.out.println("sqlstr==========================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		applicant=getDBStr(rs.getString("applicant"));
		applicant_name=getDBStr(rs.getString("applicant_name"));
		apply_date=getDBDateStr(rs.getString("apply_date"));
		
		rent_interval=getDBStr( rs.getString("rent_interval"));
		contract_amt=formatNumberStr(getDBStr( rs.getString("contract_amt")),"#,##0.00");
		pay_day=getDBStr(rs.getString("pay_day"));
		first_payment=formatNumberStr(getDBStr( rs.getString("first_payment")),"#,##0.00");
		lease_money=formatNumberStr(getDBStr( rs.getString("lease_money")),"#,##0.00");
		received_caution_money=formatNumberStr(getDBStr( rs.getString("received_caution_money")),"#,##0.00");
		nominalprice=formatNumberStr(getDBStr( rs.getString("nominalprice")),"#,##0.00");
		received_list=getDBStr( rs.getString("received_list"));
		received_rent=formatNumberStr(getDBStr( rs.getString("received_rent")),"#,##0.00");
		undue_list=getDBStr( rs.getString("undue_list"));
		undue_rent=formatNumberStr(getDBStr( rs.getString("undue_rent")),"#,##0.00");
		overdue_list=getDBStr( rs.getString("overdue_list"));
		overdue_rent=formatNumberStr(getDBStr( rs.getString("overdue_rent")),"#,##0.00");
		overdue_penalty=formatNumberStr(getDBStr( rs.getString("overdue_penalty")),"#,##0.00");
		risk_exposure=formatNumberStr(getDBStr( rs.getString("risk_exposure")),"#,##0.00");
		received_insurance=formatNumberStr(getDBStr( rs.getString("received_insurance")),"#,##0.00");
		
	}rs.close();
	db.close();
	
 %>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<!-- 
<BUTTON class="btn_2" name="btnSave" value="计算"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">计算</button>

<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
 -->
    	
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
<!--  
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
-->
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:330px;overflow:auto;">

<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="contract_id" value="<%= contract_id %>">
<input type="hidden" name="doc_id" value="<%= doc_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">

  <tr>
    <td>申请人</td>
    <td><%=applicant_name %><input name="applicant" type="hidden" value="<%= applicant %>"></td>

    <td>申请日期</td>
    <td><input name="apply_date" accesskey="s" type="text" size="10" readonly value="<%=apply_date%>" require="true"></td>
   
  </tr>
  <tr>
    <td>租金间隔</td>
    <td><input name="rent_interval" type="text" size="20" value="<%=rent_interval%>" readonly></td>
    <td>支付日</td>
    <td><input name="pay_day" type="text" size="20" value="<%=pay_day%>" readonly></td>
  </tr>
  <tr>
    <td>合同总金额</td>
    <td><input name="contract_amt" type="text" size="20" value="<%=contract_amt%>" readonly></td>
    <td>首付款</td>
    <td><input name="first_payment" type="text" size="20" value="<%=first_payment%>" readonly></td>
  </tr>
  <tr>
    <td>租赁本金</td>
    <td><input name="lease_money" type="text" size="20" value="<%=lease_money%>" readonly></td>
    <td>已收保证金</td>
    <td><input name="received_caution_money" type="text" size="20" value="<%=received_caution_money%>" readonly></td>
  </tr>
  <tr>
    <td>已收保险费</td>
    <td><input name="received_insurance" type="text" size="20" value="<%=received_insurance%>" readonly></td>
    <td>已支付期数</td>
    <td><input name="received_list" type="text" size="20" value="<%=received_list%>" readonly></td>
  </tr>
  <tr>
    <td>已支付租金</td>
    <td><input name="received_rent" type="text" size="20" value="<%=received_rent%>" readonly></td>
    <td>名义留购价</td>
    <td><input name="nominalprice" type="text" size="20" value="<%=nominalprice%>" readonly></td>
  </tr>
  <tr>
    <td>未到期期数</td>
    <td><input name="undue_list" type="text" size="20" value="<%=undue_list%>" readonly></td>
    <td>未到期租金</td>
    <td><input name="undue_rent" type="text" size="20" value="<%=undue_rent%>" readonly></td>
  </tr>
  <tr>
    <td>逾期期数</td>
    <td><input name="overdue_list" type="text" size="20" value="<%=overdue_list%>" readonly></td>
    <td>逾期租金</td>
    <td><input name="overdue_rent" type="text" size="20" value="<%=overdue_rent%>" readonly></td>
  </tr>
  <tr>
    <td>逾期罚息</td>
    <td><input name="overdue_penalty" type="text" size="20" value="<%=overdue_penalty%>" readonly></td>
    <td>风险敞口</td>
    <td><input name="risk_exposure" type="text" size="20" value="<%=risk_exposure%>" readonly></td>
  </tr>
  <tr>
    
    
  </tr>
  
</table>
<!-- 
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
<tr bgcolor="#8DB2E3"><td>费用处理</td></tr>
<tr>
<td><iframe frameborder="0" width="100%" height="500px" src="./aheadincomeHl.jsp?contract_id=<%=contract_id%>"></iframe></td>
</tr>
</table>
-->
</div>

<div id="TD_tab_1" style="display:none;">

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

</form>

<!-- end cwMain -->
</body>
</html>
