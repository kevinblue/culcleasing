<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同后期管理 - 提前还款</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

</head>
<body>
<form name="form1" method="post" target="_blank" action="aheadincome_save2.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	
<%
	String sqlstr;
	ResultSet rs;
	ResultSet rs1;
	String contract_id = getStr( request.getParameter("contract_id") );
	String doc_id = getStr( request.getParameter("doc_id") );
	String dqczy = (String) session.getAttribute("czyid");
	
	String billing_manager="";
	String billing_manager_name="";
	String billing_date="";
	String effective_date="";
	String caution_deduction_money="";
	String other_amt="";
	String rent_discount="";
	String ahead_amt="";
	
	String apply_date="";
	String discount_rate="";
	
	sqlstr="select contract_ahead_repayment.apply_date, contract_ahead_repayment.rent_interval, contract_ahead_repayment.billing_manager, jb_yhxx.xm as billing_manager_name, contract_ahead_repayment.billing_date, contract_ahead_repayment.effective_date, isnull(contract_ahead_repayment.caution_deduction_money,0) as caution_deduction_money, isnull(contract_ahead_repayment.other_amt,0) as other_amt, isnull(contract_ahead_repayment.rent_discount,0) as rent_discount, isnull(contract_ahead_repayment.ahead_amt,0) as ahead_amt from contract_ahead_repayment left join jb_yhxx on contract_ahead_repayment.billing_manager=jb_yhxx.id where contract_ahead_repayment.doc_id='"+doc_id+"'";
	//System.out.println("sqlstr==========================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		billing_manager=getDBStr( rs.getString("billing_manager"));
		billing_manager_name=getDBStr( rs.getString("billing_manager_name"));
		billing_date=getDBDateStr( rs.getString("billing_date"));
		effective_date=getDBDateStr( rs.getString("effective_date"));
		caution_deduction_money=formatNumberStr(getDBStr( rs.getString("caution_deduction_money") ),"#,##0.00");
		other_amt=formatNumberStr(getDBStr( rs.getString("other_amt") ),"#,##0.00");
		rent_discount=formatNumberStr(getDBStr( rs.getString("rent_discount") ),"#,##0.00");
		ahead_amt=formatNumberStr(getDBStr( rs.getString("ahead_amt") ),"#,##0.00");
		
		apply_date=getDBDateStr( rs.getString("apply_date"));
		//贴现率
		sqlstr="select top 1 isnull(discount_rate,0)/12/100*"+getDBStr( rs.getString("rent_interval"))+" as discount_rate from base_discount_rate order by start_date desc";
		rs1=db1.executeQuery(sqlstr);
		if(rs1.next()){
			discount_rate=getDBDateStr( rs1.getString("discount_rate") );
		}else{
			System.out.println("error is 贴现率不正确");
		}rs1.close();
		
	}rs.close();
	db.close();
	db1.close();
	
 %>

<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">

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

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:140px;overflow:auto;">

<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="contract_id" value="<%= contract_id %>">
<input type="hidden" name="doc_id" value="<%= doc_id %>">
<input type="hidden" name="discount_rate" value="<%= discount_rate %>">
<input type="hidden" name="apply_date" value="<%= apply_date %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">

  <tr>
    <td>结算经办人</td>
    <td colspan="3"><input name="billing_manager_name" type="text" size="20"  Require="true" readonly value="<%= billing_manager_name%>"></td>
    
  </tr>
  <tr>
    <td>结算日期</td>
    <td><input name="billing_date" accesskey="s" type="text" size="10" readonly value="<%=billing_date%>" Require="true"></td>
    <td>有效日</td>
    <td><input name="effective_date" accesskey="s" type="text" size="10" readonly value="<%=effective_date%>" Require="true"></td>
  </tr>
  <tr>
    <td>保证金抵扣金额</td>
    <td><input name="caution_deduction_money" type="text" size="20" value="<%=caution_deduction_money%>" dataType="Money" require="true" readonly></td>
    <td>其他（说明）</td>
    <td><input name="other_amt" type="text" size="20" value="<%=other_amt%>" dataType="Money" require="true" readonly></td>
  </tr>
  <tr>
    <td>未付租金折现</td>
    <td><input name="rent_discount" type="text" size="20" value="<%=rent_discount%>" readonly></td>
    <td>总计（提前留购价）</td>
    <td><input name="ahead_amt" type="text" size="20" value="<%=ahead_amt%>" readonly></td>
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
