<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同后期管理 - 费用处理</title>
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
<form name="form1" method="post" target="_blank" action="noNormalEndFeeHl_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	
<%
    int hl_flag=1;
	String sqlstr;
	ResultSet rs;
	String contract_id = getStr( request.getParameter("contract_id") );
	String type = getStr( request.getParameter("type") );
	
	String default_standard="0";
	String default_rate="0";
	String premature_corpus="0";
	String agree_premature_corpus="0";
	String break_handling_charge="0";
	String agree_handling_charge="0";
	String nominalprice="0";
	String agree_nominalprice="0";
	String overdue_corpus="0";
	String agree_overdue_corpus="0";
	String overdue_interest="0";
	String agree_overdue_interest="0";
	String overdue_penalty="0";
	String agree_overdue_penalty="0";
	String period_interest="0";
	String agree_period_interest="0";
	String remain_caution_money="0";
	String agree_exempt_amt="0";
	String obligation_total="0";
	String agree_obligation_total="0";
	
	
	String cap_rem_corpus="0";
	String cap_rem_rent="0";
	String next_period_interest="0";
	String a_value="0";
	
	sqlstr="select contract_abnormal_end.* from contract_abnormal_end where contract_id='"+contract_id+"' and process_mode='"+type+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		default_standard=getDBStr( rs.getString("default_standard") );
		default_rate=getDBDecStr(rs.getBigDecimal("default_rate",6)).toString();if(default_rate.equals("")){default_rate="0";}
		premature_corpus=getDBDecStr(rs.getBigDecimal("premature_corpus",2)).toString();if(premature_corpus.equals("")){premature_corpus="0";}
		agree_premature_corpus=getDBDecStr(rs.getBigDecimal("agree_premature_corpus",2)).toString();if(agree_premature_corpus.equals("")){agree_premature_corpus="0";}
		break_handling_charge=getDBDecStr(rs.getBigDecimal("break_handling_charge",2)).toString();if(break_handling_charge.equals("")){break_handling_charge="0";}
		agree_handling_charge=getDBDecStr(rs.getBigDecimal("agree_handling_charge",2)).toString();if(agree_handling_charge.equals("")){agree_handling_charge="0";}
		nominalprice=getDBDecStr(rs.getBigDecimal("nominalprice",2)).toString();if(nominalprice.equals("")){nominalprice="0";}
		agree_nominalprice=getDBDecStr(rs.getBigDecimal("agree_nominalprice",2)).toString();if(agree_nominalprice.equals("")){agree_nominalprice="0";}
		overdue_corpus=getDBDecStr(rs.getBigDecimal("overdue_corpus",2)).toString();if(overdue_corpus.equals("")){overdue_corpus="0";}
		agree_overdue_corpus=getDBDecStr(rs.getBigDecimal("agree_overdue_corpus",2)).toString();if(agree_overdue_corpus.equals("")){agree_overdue_corpus="0";}
		overdue_interest=getDBDecStr(rs.getBigDecimal("overdue_interest",2)).toString();if(overdue_interest.equals("")){overdue_interest="0";}
		agree_overdue_interest=getDBDecStr(rs.getBigDecimal("agree_overdue_interest",2)).toString();if(agree_overdue_interest.equals("")){agree_overdue_interest="0";}
		overdue_penalty=getDBDecStr(rs.getBigDecimal("overdue_penalty",2)).toString();if(overdue_penalty.equals("")){overdue_penalty="0";}
		agree_overdue_penalty=getDBDecStr(rs.getBigDecimal("agree_overdue_penalty",2)).toString();if(agree_overdue_penalty.equals("")){agree_overdue_penalty="0";}
		period_interest=getDBDecStr(rs.getBigDecimal("period_interest",2)).toString();if(period_interest.equals("")){period_interest="0";}
		agree_period_interest=getDBDecStr(rs.getBigDecimal("agree_period_interest",2)).toString();if(agree_period_interest.equals("")){agree_period_interest="0";}
		remain_caution_money=getDBDecStr(rs.getBigDecimal("remain_caution_money",2)).toString();if(remain_caution_money.equals("")){remain_caution_money="0";}
		agree_exempt_amt=getDBDecStr(rs.getBigDecimal("agree_exempt_amt",2)).toString();if(agree_exempt_amt.equals("")){agree_exempt_amt="0";}
		obligation_total=getDBDecStr(rs.getBigDecimal("obligation_total",2)).toString();if(obligation_total.equals("")){obligation_total="0";}
		agree_obligation_total=getDBDecStr(rs.getBigDecimal("agree_obligation_total",2)).toString();if(agree_obligation_total.equals("")){agree_obligation_total="0";}
	}else{
		hl_flag=0;
	}
	rs.close();
	//System.out.println("sqlstr==========================================000000000000000000000");
	
	if((Double.parseDouble(obligation_total)==0) && (hl_flag==1)){
		sqlstr="select (select isnull(sum(corpus),0) from fund_rent_plan where contract_id=vi_contract_info.contract_id and plan_date>=dateadd(day,1,convert(varchar(10),getDate(),121))) as cap_fuCorpus, isnull(contract_condition.nominalprice,0) as cap_nominalprice, dbo.bb_getBadCapital('1970-01-01',convert(varchar(10),getDate(),121),vi_contract_info.contract_id) as cap_overdue_corpus, dbo.bb_getBadInterest('1970-01-01',convert(varchar(10),getDate(),121),vi_contract_info.contract_id) as cap_overdue_interest, dbo.bb_getPunishInterest('1970-01-01',convert(varchar(10),getDate(),121),vi_contract_info.contract_id) as cap_overdue_penalty, (select isnull(sum(fact_money),0) from fund_fund_charge where contract_id=vi_contract_info.contract_id and fee_type='108' and item_method='收款') -(select isnull(sum(fact_money),0) from fund_fund_charge where contract_id=vi_contract_info.contract_id and fee_type='108' and item_method='付款') as cap_remain_caution_money,dbo.bb_getRemRent('1970-01-01',convert(varchar(10),getDate(),121),vi_contract_info.contract_id) as cap_rem_rent,dbo.bb_getRemCapital('1970-01-01',convert(varchar(10),getDate(),121),vi_contract_info.contract_id) as cap_rem_corpus from vi_contract_info left join contract_condition on vi_contract_info.contract_id=contract_condition.contract_id where vi_contract_info.contract_id='"+contract_id+"'";
		//System.out.println("sqlstr=========================================="+sqlstr);
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			premature_corpus=getDBDecStr(rs.getBigDecimal("cap_fuCorpus",2)).toString();
			nominalprice=getDBDecStr(rs.getBigDecimal("cap_nominalprice",2)).toString();
			overdue_corpus=getDBDecStr(rs.getBigDecimal("cap_overdue_corpus",2)).toString();
			overdue_interest=getDBDecStr(rs.getBigDecimal("cap_overdue_interest",2)).toString();
			overdue_penalty=getDBDecStr(rs.getBigDecimal("cap_overdue_penalty",2)).toString();
			remain_caution_money=getDBDecStr(rs.getBigDecimal("cap_remain_caution_money",2)).toString();
			cap_rem_rent=getDBDecStr(rs.getBigDecimal("cap_rem_rent",2)).toString();
			cap_rem_corpus=getDBDecStr(rs.getBigDecimal("cap_rem_corpus",2)).toString();
		}rs.close();
		
		
		if(default_standard.equals("1")){
			break_handling_charge=formatNumberStr(String.valueOf(Double.parseDouble(cap_rem_rent)*Double.parseDouble(default_rate)/100),"###0.00");
		}else{
			break_handling_charge=formatNumberStr(String.valueOf(Double.parseDouble(cap_rem_corpus)*Double.parseDouble(default_rate)/100),"###0.00");
		}
		
		sqlstr="select top 1 isnull(interest,0) as interest from fund_rent_plan where contract_id='"+contract_id+"' and plan_date>convert(varchar(10),getDate(),121) order by plan_date";
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			next_period_interest=getDBStr( rs.getString("interest") );
		}rs.close();
		
		sqlstr="select top 1 "+next_period_interest+"*datediff(day,fund_rent_plan.plan_date,contract_abnormal_end.appoint_date)*isnull(contract_condition.year_rate,0)/12/30/1000 as period_interest from fund_rent_plan left join contract_condition on fund_rent_plan.contract_id=contract_condition.contract_id left join contract_abnormal_end on fund_rent_plan.contract_id=contract_abnormal_end.contract_id where fund_rent_plan.plan_date<=convert(varchar(10),getDate(),121) and fund_rent_plan.contract_id='"+contract_id+"' order by fund_rent_plan.plan_date desc";
		//System.out.println("sqlstr==================================================="+sqlstr);
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			period_interest=getDBDecStr(rs.getBigDecimal("period_interest",2)).toString();
		}rs.close();
		
		a_value=formatNumberStr(String.valueOf(Double.parseDouble(premature_corpus)+Double.parseDouble(break_handling_charge)+Double.parseDouble(nominalprice)+Double.parseDouble(period_interest)+Double.parseDouble(overdue_corpus)+Double.parseDouble(overdue_interest)+Double.parseDouble(overdue_penalty)),"###0.00");
		obligation_total=formatNumberStr(String.valueOf(Double.parseDouble(a_value)-Double.parseDouble(remain_caution_money)),"###0.00");
		agree_exempt_amt="0";
		agree_obligation_total=obligation_total;
		
		agree_premature_corpus=premature_corpus;
		agree_handling_charge=break_handling_charge;
		agree_nominalprice=nominalprice;
		agree_period_interest=period_interest;
		agree_overdue_corpus=overdue_corpus;
		agree_overdue_interest=overdue_interest;
		agree_overdue_penalty=overdue_penalty;
		
	}
	
	a_value=formatNumberStr(String.valueOf(Double.parseDouble(premature_corpus)+Double.parseDouble(break_handling_charge)+Double.parseDouble(nominalprice)+Double.parseDouble(period_interest)+Double.parseDouble(overdue_corpus)+Double.parseDouble(overdue_interest)+Double.parseDouble(overdue_penalty)),"###0.00");
	
	db.close();
	
 %>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<!--
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
合同后期管理 &gt; 费用处理
</td>
</tr>
 -->
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<!--
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	

<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">确认</button>

<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

    	
  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="保存"> 保存</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="重置"> 重置</a>
    	
    	<input class="btn" name="btnSave" value="保存" type="submit">
    	<input class="btn" name="btnReset" value="重置" type="reset">
    	
    </td></tr>
</table>
-->
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


<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="contract_id" value="<%= contract_id %>">
<input type="hidden" name="a_value" value="<%= a_value %>">
<input type="hidden" name="remain_caution_money" value="<%= remain_caution_money %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>未到期本金</td>
    <td><input name="premature_corpus" type="text" size="10" value="<%=premature_corpus%>" readonly></td>
    <td>商定支付本金</td>
    <td><input name="agree_premature_corpus" type="text" size="10" value="<%=agree_premature_corpus%>" require="true" dataType="Money" onPropertyChange="sjjs();" readonly><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>违约手续费</td>
    <td><input name="break_handling_charge" type="text" size="10" value="<%=break_handling_charge%>" readonly></td>
    <td>商定违约手续费</td>
    <td><input name="agree_handling_charge" type="text" size="10" value="<%=agree_handling_charge%>" require="true" dataType="Money" onPropertyChange="sjjs();" readonly><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>名义货价</td>
    <td><input name="nominalprice" type="text" size="10" value="<%=nominalprice%>" readonly></td>
    <td>商定名义货价</td>
    <td><input name="agree_nominalprice" type="text" size="10" value="<%=agree_nominalprice%>" require="true" dataType="Money" onPropertyChange="sjjs();" readonly><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>期间利息</td>
    <td><input name="period_interest" type="text" size="10" value="<%=period_interest%>" readonly></td>
    <td>商定期间利息</td>
    <td><input name="agree_period_interest" type="text" size="10" value="<%=agree_period_interest%>" require="true" dataType="Money" onPropertyChange="sjjs();" readonly><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>逾期本金</td>
    <td><input name="overdue_corpus" type="text" size="10" value="<%=overdue_corpus%>" readonly></td>
    <td>商定逾期本金</td>
    <td><input name="agree_overdue_corpus" type="text" size="10" value="<%=agree_overdue_corpus%>" require="true" dataType="Money" onPropertyChange="sjjs();" readonly><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>逾期利息</td>
    <td><input name="overdue_interest" type="text" size="10" value="<%=overdue_interest%>" readonly></td>
    <td>商定逾期利息</td>
    <td><input name="agree_overdue_interest" type="text" size="10" value="<%=agree_overdue_interest%>" require="true" dataType="Money" onPropertyChange="sjjs();" readonly><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>逾期罚息</td>
    <td><input name="overdue_penalty" type="text" size="10" value="<%=overdue_penalty%>" readonly></td>
    <td>商定逾期罚息</td>
    <td><input name="agree_overdue_penalty" type="text" size="10" value="<%=agree_overdue_penalty%>" require="true" dataType="Money" onPropertyChange="sjjs();" readonly><span class="biTian">*</span></td>
  </tr>
  
  <tr>
    <td>剩余保证金</td>
    <td><input name="remain_caution_money" type="text" size="10" value="<%=remain_caution_money%>" readonly></td>
    <td>商免总额</td>
    <td><input name="agree_exempt_amt" type="text" size="10" value="<%=agree_exempt_amt%>" readonly></td>
  </tr>
   <tr>
    <td>合同债权总计</td>
    <td><input name="obligation_total" type="text" size="10" value="<%=obligation_total%>" readonly></td>
    <td>商定债权总计</td>
    <td><input name="agree_obligation_total" type="text" size="10" value="<%=agree_obligation_total%>" readonly></td>
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
</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%">&nbsp;</td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
function sjjs(){
	var a=document.getElementById("a_value").value;
	var b=document.getElementById("remain_caution_money").value;
	var c=document.getElementById("agree_premature_corpus").value*1+document.getElementById("agree_handling_charge").value*1+document.getElementById("agree_nominalprice").value*1+document.getElementById("agree_period_interest").value*1+document.getElementById("agree_overdue_corpus").value*1+document.getElementById("agree_overdue_interest").value*1+document.getElementById("agree_overdue_penalty").value*1;
	document.getElementById("agree_exempt_amt").value=forcepos(a*1-c,2);
	document.getElementById("agree_obligation_total").value=forcepos(c-b*1,2);
}
</script>
</form>

<!-- end cwMain -->
</body>
</html>



