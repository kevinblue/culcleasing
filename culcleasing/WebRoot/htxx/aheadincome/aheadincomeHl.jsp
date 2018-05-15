<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ���ڹ��� - ���ô���</title>
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
	String sqlstr;
	ResultSet rs;
	String contract_id = getStr( request.getParameter("contract_id") );
	String type = getStr( request.getParameter("type") );
	
	List l_rent = new ArrayList();
	String discount_rate="";
	int m=1;
	String apply_date="";	//��������
	
	String rent_interval="";
	String pay_day="";
	String contract_amt="";
	String first_payment="";
	String lease_money="";
	String received_caution_money="";
	String received_handling_charge="";
	String received_return="";
	String received_insurance="";
	String received_list="";
	String received_rent="";
	String received_amt="";
	String undue_list="";
	String undue_rent="";
	String overdue_list="";
	String overdue_rent="";
	String overdue_penalty="";
	String nominalprice="";
	String risk_exposure="";
	String billing_manager="";
	String billing_manager_name="";
	String billing_date="";
	String effective_date="";
	String caution_deduction_money="";
	String other_amt="";
	String rent_discount="";
	String ahead_amt="";
	String agree_amt="";
	String difference_amt="";
	String difference_memo="";
	
	//������
	sqlstr="select top 1 isnull(discount_rate,0)/12/100 as discount_rate from base_discount_rate order by start_date desc";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		discount_rate=getDBDateStr( rs.getString("discount_rate") );
	}rs.close();
	
	sqlstr="select contract_ahead_repayment.apply_date,contract_ahead_repayment.rent_interval from contract_ahead_repayment where contract_ahead_repayment.contract_id='"+contract_id+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		apply_date=getDBDateStr( rs.getString("apply_date") );
		rent_interval=getDBStr( rs.getString("rent_interval") );
	}rs.close();
	
	if(!apply_date.equals("")){
		if(rent_interval.equals("")){
			//�������,�׸���,���ޱ���,����������
			sqlstr="select case when isnull(contract_condition.income_number,0)=0 then '' else 12/contract_condition.income_number end as rent_interval,isnull(contract_condition.first_payment,0) as first_payment,isnull(contract_condition.lease_money,0) as lease_money,isnull(contract_condition.nominalprice,0) as nominalprice from contract_condition where contract_condition.contract_id='"+contract_id+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				rent_interval=getDBStr( rs.getString("rent_interval"));
				first_payment=getDBDecStr(rs.getBigDecimal("first_payment",2)).toString();
				lease_money=getDBDecStr(rs.getBigDecimal("lease_money",2)).toString();
				nominalprice=getDBDecStr(rs.getBigDecimal("nominalprice",2)).toString();
			}rs.close();
			//֧����
			sqlstr="select substring(convert(varchar(10),min(fund_rent_plan.plan_date),121),9,10) as pay_day from fund_rent_plan where fund_rent_plan.contract_id='"+contract_id+"' and fund_rent_plan.plan_date>='"+apply_date+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				pay_day=getDBStr( rs.getString("pay_day"));
			}rs.close();
			//��ͬ�ܽ��
			sqlstr="select isnull(sum(fund_rent_plan.rent),0) as contract_amt from fund_rent_plan where fund_rent_plan.contract_id='"+contract_id+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				contract_amt=getDBDecStr(rs.getBigDecimal("contract_amt",2)).toString();
			}rs.close();
			//���ձ�֤��,����������,���շ���,���ձ��շ�
			sqlstr="select isnull(sum(case when fund_fund_charge.fee_type='108' then fund_fund_charge.fact_money else 0 end),0) as received_caution_money, isnull(sum(case when fund_fund_charge.fee_type='103' then fund_fund_charge.fact_money else 0 end),0) as received_handling_charge, isnull(sum(case when fund_fund_charge.fee_type='105' then fund_fund_charge.fact_money else 0 end),0) as received_return, isnull(sum(case when fund_fund_charge.fee_type='102' then fund_fund_charge.fact_money else 0 end),0) as received_insurance from fund_fund_charge where fund_fund_charge.contract_id='"+contract_id+"' and fund_fund_charge.fact_date<dateadd(day,1,'"+apply_date+"') and fund_fund_charge.item_method='�տ�'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				received_caution_money=getDBDecStr(rs.getBigDecimal("received_caution_money",2)).toString();
				received_handling_charge=getDBDecStr(rs.getBigDecimal("received_handling_charge",2)).toString();
				received_return=getDBDecStr(rs.getBigDecimal("received_return",2)).toString();
				received_insurance=getDBDecStr(rs.getBigDecimal("received_insurance",2)).toString();
			}rs.close();
			//��֧������,��������,�������,���ڷ�Ϣ,���ճ���
			sqlstr="select isnull(dbo.bb_hadRecNub('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as received_list,isnull(dbo.bb_getBadNub('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as overdue_list,isnull(dbo.bb_getBadRent('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as overdue_rent,isnull(dbo.bb_getPunishInterest('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as overdue_penalty,isnull(dbo.bb_getRemFxck('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as risk_exposure";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				received_list=getDBStr( rs.getString("received_list"));
				overdue_list=getDBStr( rs.getString("overdue_list"));
				overdue_rent=getDBDecStr(rs.getBigDecimal("overdue_rent",2)).toString();
				overdue_penalty=getDBDecStr(rs.getBigDecimal("overdue_penalty",2)).toString();
				risk_exposure=getDBDecStr(rs.getBigDecimal("risk_exposure",2)).toString();
			}rs.close();
			//��֧�����
			sqlstr="select isnull(sum(fund_rent_income.rent),0)+isnull(sum(fund_rent_income.rent_adjust),0) as received_rent from fund_rent_income where fund_rent_income.contract_id='"+contract_id+"' and fund_rent_income.hire_date<dateadd(day,1,'"+apply_date+"')";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				received_rent=getDBDecStr(rs.getBigDecimal("received_rent",2)).toString();
			}rs.close();
			//���ս��
			received_amt=String.valueOf(Double.parseDouble(received_caution_money)+Double.parseDouble(received_handling_charge)+Double.parseDouble(received_return)+Double.parseDouble(received_insurance)+Double.parseDouble(received_rent));
			//δ��������,δ�������
			sqlstr="select count(*) as undue_list,isnull(sum(fund_rent_plan.rent),0) as undue_rent from fund_rent_plan where fund_rent_plan.contract_id='"+contract_id+"' and fund_rent_plan.plan_date>'"+apply_date+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				undue_list=getDBStr( rs.getString("undue_list"));
				undue_rent=getDBDecStr(rs.getBigDecimal("undue_rent",2)).toString();
			}rs.close();
			//��֤��ֿ۽��,������˵����,δ���������
			caution_deduction_money="0";
			other_amt="0";
			rent_discount="0";
			if(!rent_interval.equals("")){
				sqlstr="select isnull(fund_rent_plan.rent,0) as rent from fund_rent_plan where fund_rent_plan.contract_id='"+contract_id+"' and fund_rent_plan.plan_date>'"+apply_date+"' order by fund_rent_plan.rent_list";
				rs=db.executeQuery(sqlstr);
				while(rs.next()){
					l_rent.add(getDBStr( rs.getString("rent")));
					rent_discount=String.valueOf(Double.parseDouble(rent_discount)+rs.getDouble("rent")/(1+Double.parseDouble(discount_rate)*m));
					m++;
				}rs.close();
			}
			//�ܼƣ���ǰ�����ۣ�,Э��������,������
			ahead_amt=rent_discount;
			agree_amt="0";
			difference_amt=rent_discount;
			
		}else{
			sqlstr="select contract_ahead_repayment.rent_interval,contract_ahead_repayment.pay_day,contract_ahead_repayment.contract_amt,contract_ahead_repayment.first_payment,contract_ahead_repayment.lease_money,contract_ahead_repayment.received_caution_money,contract_ahead_repayment.received_handling_charge,contract_ahead_repayment.received_return,contract_ahead_repayment.received_insurance,contract_ahead_repayment.received_list,contract_ahead_repayment.received_rent,contract_ahead_repayment.received_amt,contract_ahead_repayment.undue_list,contract_ahead_repayment.undue_rent,contract_ahead_repayment.overdue_list,contract_ahead_repayment.overdue_rent,contract_ahead_repayment.overdue_penalty,contract_ahead_repayment.nominalprice,contract_ahead_repayment.risk_exposure,contract_ahead_repayment.billing_manager,contract_ahead_repayment.billing_date,contract_ahead_repayment.effective_date,contract_ahead_repayment.caution_deduction_money,contract_ahead_repayment.other_amt,contract_ahead_repayment.rent_discount,contract_ahead_repayment.ahead_amt,contract_ahead_repayment.agree_amt,contract_ahead_repayment.difference_amt,contract_ahead_repayment.difference_memo,jb_yhxx.xm as billing_manager_name from contract_ahead_repayment left join jb_yhxx on contract_ahead_repayment.billing_manager=jb_yhxx.id where contract_ahead_repayment.contract_id='"+contract_id+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				rent_interval=getDBStr( rs.getString("rent_interval"));
				pay_day=getDBStr( rs.getString("pay_day"));
				contract_amt=getDBDecStr(rs.getBigDecimal("contract_amt",2)).toString();
				first_payment=getDBDecStr(rs.getBigDecimal("first_payment",2)).toString();
				lease_money=getDBDecStr(rs.getBigDecimal("lease_money",2)).toString();
				received_caution_money=getDBDecStr(rs.getBigDecimal("received_caution_money",2)).toString();
				received_handling_charge=getDBDecStr(rs.getBigDecimal("received_handling_charge",2)).toString();
				received_return=getDBDecStr(rs.getBigDecimal("received_return",2)).toString();
				received_insurance=getDBDecStr(rs.getBigDecimal("received_insurance",2)).toString();
				received_list=getDBStr( rs.getString("received_list"));
				received_rent=getDBDecStr(rs.getBigDecimal("received_rent",2)).toString();
				received_amt=getDBDecStr(rs.getBigDecimal("received_amt",2)).toString();
				undue_list=getDBStr( rs.getString("undue_list"));
				undue_rent=getDBDecStr(rs.getBigDecimal("undue_rent",2)).toString();
				overdue_list=getDBStr( rs.getString("overdue_list"));
				overdue_rent=getDBDecStr(rs.getBigDecimal("overdue_rent",2)).toString();
				overdue_penalty=getDBDecStr(rs.getBigDecimal("overdue_penalty",2)).toString();
				nominalprice=getDBDecStr(rs.getBigDecimal("nominalprice",2)).toString();
				risk_exposure=getDBDecStr(rs.getBigDecimal("risk_exposure",2)).toString();
				billing_manager=getDBStr( rs.getString("billing_manager"));
				billing_manager_name=getDBStr( rs.getString("billing_manager_name"));
				billing_date=getDBDateStr( rs.getString("billing_date"));
				effective_date=getDBDateStr( rs.getString("effective_date"));
				caution_deduction_money=getDBDecStr(rs.getBigDecimal("caution_deduction_money",2)).toString();
				other_amt=getDBDecStr(rs.getBigDecimal("other_amt",2)).toString();
				rent_discount=getDBDecStr(rs.getBigDecimal("rent_discount",2)).toString();
				ahead_amt=getDBDecStr(rs.getBigDecimal("ahead_amt",2)).toString();
				agree_amt=getDBDecStr(rs.getBigDecimal("agree_amt",2)).toString();
				difference_amt=getDBDecStr(rs.getBigDecimal("difference_amt",2)).toString();
				difference_memo=getDBStr( rs.getString("difference_memo"));
			}rs.close();
		}
	}
	
	db.close();
	
 %>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<!--
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ͬ���ڹ��� &gt; ���ô���
</td>
</tr>
 -->
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<!--
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	

<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">ȷ��</button>

<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>

    	
  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="����"> ����</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="����"> ����</a>
    	
    	<input class="btn" name="btnSave" value="����" type="submit">
    	<input class="btn" name="btnReset" value="����" type="reset">
    	
    </td></tr>
</table>
-->
<!--������ť����-->
</td>
</tr>
<!--
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�� ��</td>
  
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
<input type="hidden" name="l_rent" value="<%= l_rent %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>�����</td>
    <td><input name="rent_interval" type="text" size="20" value="<%=rent_interval%>" readonly></td>
    <td>֧����</td>
    <td><input name="pay_day" type="text" size="20" value="<%=pay_day%>" readonly></td>
  </tr>
  <tr>
    <td>��ͬ�ܽ��</td>
    <td><input name="contract_amt" type="text" size="20" value="<%=contract_amt%>" readonly></td>
    <td>�׸���</td>
    <td><input name="first_payment" type="text" size="20" value="<%=first_payment%>" readonly></td>
  </tr>
  <tr>
    <td>���ޱ���</td>
    <td><input name="lease_money" type="text" size="20" value="<%=lease_money%>" readonly></td>
    <td>���ձ�֤��</td>
    <td><input name="received_caution_money" type="text" size="20" value="<%=received_caution_money%>" readonly></td>
  </tr>
  <tr>
    <td>����������</td>
    <td><input name="received_handling_charge" type="text" size="20" value="<%=received_handling_charge%>" readonly></td>
    <td>���շ���</td>
    <td><input name="received_return" type="text" size="20" value="<%=received_return%>" readonly></td>
  </tr>
  <tr>
    <td>���ձ��շ�</td>
    <td><input name="received_insurance" type="text" size="20" value="<%=received_insurance%>" readonly></td>
    <td>��֧������</td>
    <td><input name="received_list" type="text" size="20" value="<%=received_list%>" readonly></td>
  </tr>
  <tr>
    <td>��֧�����</td>
    <td><input name="received_rent" type="text" size="20" value="<%=received_rent%>" readonly></td>
    <td>���ս��</td>
    <td><input name="received_amt" type="text" size="20" value="<%=received_amt%>" readonly></td>
  </tr>
  <tr>
    <td>δ��������</td>
    <td><input name="undue_list" type="text" size="20" value="<%=undue_list%>" readonly></td>
    <td>δ�������</td>
    <td><input name="undue_rent" type="text" size="20" value="<%=undue_rent%>" readonly></td>
  </tr>
  <tr>
    <td>��������</td>
    <td><input name="overdue_list" type="text" size="20" value="<%=overdue_list%>" readonly></td>
    <td>�������</td>
    <td><input name="overdue_rent" type="text" size="20" value="<%=overdue_rent%>" readonly></td>
  </tr>
  <tr>
    <td>���ڷ�Ϣ</td>
    <td><input name="overdue_penalty" type="text" size="20" value="<%=overdue_penalty%>" readonly></td>
    <td>����������</td>
    <td><input name="nominalprice" type="text" size="20" value="<%=nominalprice%>" readonly></td>
  </tr>
  <tr>
    <td>���ճ���</td>
    <td><input name="risk_exposure" type="text" size="20" value="<%=risk_exposure%>" readonly></td>
    <td>���㾭����</td>
    <td><input name="billing_manager_name" type="text" size="20"  Require="true" readonly value="<%= billing_manager_name%>"><input type="hidden" name="billing_manager" value="<%= billing_manager%>"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','�û�����','jb_yhxx','xm','id','xm','xm','asc','form1.billing_manager_name','form1.billing_manager');">
    <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>��������</td>
    <td><input name="billing_date" accesskey="s" type="text" size="10" readonly value="<%=billing_date%>"><img src="../../images/tbtn_overtime.gif" widtd="20" height="19" border="0" align="absmiddle" style="cursor:pointer; "  onClick="openCalendar(billing_date);return false"><span class="biTian">*</span></td>
    <td>��Ч��</td>
    <td><input name="effective_date" accesskey="s" type="text" size="10" readonly value="<%=effective_date%>"><img src="../../images/tbtn_overtime.gif" widtd="20" height="19" border="0" align="absmiddle" style="cursor:pointer; "  onClick="openCalendar(effective_date);return false"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>��֤��ֿ۽��</td>
    <td><input name="caution_deduction_money" type="text" size="20" value="<%=caution_deduction_money%>" onPropertyChange="sjjs();"></td>
    <td>������˵����</td>
    <td><input name="other_amt" type="text" size="20" value="<%=other_amt%>"></td>
  </tr>
  <tr>
    <td>δ���������</td>
    <td><input name="rent_discount" type="text" size="20" value="<%=rent_discount%>" readonly></td>
    <td>�ܼƣ���ǰ�����ۣ�</td>
    <td><input name="ahead_amt" type="text" size="20" value="<%=ahead_amt%>" readonly></td>
  </tr>
  <tr>
    <td>Э��������</td>
    <td><input name="agree_amt" type="text" size="20" value="<%=agree_amt%>"></td>
    <td>������</td>
    <td><input name="difference_amt" type="text" size="20" value="<%=difference_amt%>" readonly></td>
  </tr>
  <tr>
    <td>����˵��</td>
    <td colspan="3"><textarea name="difference_memo" rows="4" maxB="1000"><%=difference_memo%></textarea></td>
  </tr>
  
</table>
</div>

<div id="TD_tab_1" style="display:none;"> 
  ѡ���е�����2
</div>
<div id="TD_tab_2" style="display:none;"> 
  ѡ���е�����3

ѡ���п��ܰ����������ݣ�

ע��HTMLBody������ѡ���е����ݣ������Ҫ�����ó����������

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
<!--��ӽ���-->

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->
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



