<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.bean.ConditionMediBean"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.service.ConditionMediService"%>
<%@ include file="../../func/common_simple.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>
<BODY>
<%
	//0.��������
	String user_id = (String)session.getAttribute("czyid");//��ǰ��½��
	String sysDate = getSystemDate(0);
	String saveType = getStr(request.getParameter("saveType")); //�������͡�insert��update
	
	//================1.��װConditionBean================
	//1.1==��ȡ����
	String doc_id = getStr(request.getParameter("doc_id")); //�ĵ���� measure_id
    String proj_id = getStr(request.getParameter("proj_id")); //��Ŀ���
    //1.1.1���������
	String equip_amt = getZeroStr(getStr(request.getParameter("equip_amt")));//������(�豸���)equip_amt
	String currency = getStr(request.getParameter("currency"));//��������
	String first_payment = getZeroStr(getStr(request.getParameter("first_payment")));//�׸���first_payment
	String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//���ޱ���lease_money

	String actual_fund = getZeroStr(getStr(request.getParameter("actual_fund")));//�����ʶ�actual_fund

	String caution_money = getZeroStr(getStr(request.getParameter("caution_money")));//���ޱ�֤��caution_money
	String handling_charge = getZeroStr(getStr(request.getParameter("handling_charge")));//�����ѣ������̣�handling_charge
	String nominalprice = getZeroStr(getStr(request.getParameter("nominalprice")));//��ĩ��ֵ(������������)nominalprice
	String return_amt = getZeroStr(getStr(request.getParameter("return_amt")));//���̷���return_amt
	String before_interest = getZeroStr(getStr(request.getParameter("before_interest")));//��ǰϢbefore_interest
	String before_interest_type = getZeroStr(getStr(request.getParameter("before_interest_type")));//��ǰϢ����-�Ƿ��㱾before_interest_type
	String other_income = getZeroStr(getStr(request.getParameter("other_income")));//��������other_income
	String other_expenditure = getZeroStr(getStr(request.getParameter("other_expenditure")));//����֧��other_expenditure
	String discount_rate = getZeroStr(getStr(request.getParameter("discount_rate")));//����Ϣdiscount_rate
	String rate_subsidy = getZeroStr(getStr(request.getParameter("rate_subsidy")));//��Ϣ����rate_subsidy
	String insure_type = getStr(request.getParameter("insure_type"));//Ͷ����ʽinsure_type
	String insure_money = getZeroStr(getStr(request.getParameter("insure_money")));//���ѽ��insure_money
	String management_fee = getStr(request.getParameter("management_fee"));//�����management_fee
	String consulting_fee_out = getZeroStr(getStr(request.getParameter("consulting_fee_out")));//��ѯ��֧��consulting_fee_out
	String consulting_fee_in = getZeroStr(getStr(request.getParameter("consulting_fee_in")));//��ѯ��֧��consulting_fee_in
	
	//1.1.2���������
	String income_number_year = getStr(request.getParameter("income_number_year"));//���ⷽʽincome_number_year
	String income_number = getZeroStr(getStr(request.getParameter("income_number")));//�������income_number
	String lease_term = getStr(request.getParameter("lease_term"));//��������(��)lease_term
	String income_day = getStr(request.getParameter("income_day"));//ÿ�³�����
	String start_date = getStr(request.getParameter("start_date"));//������start_date
	String rent_start_date = getStr(request.getParameter("start_date"));//Ԥ��������
	String free_defa_inter_day = getStr(request.getParameter("free_defa_inter_day"));//���ڿ�����free_defa_inter_day
	//1.1.3���ʲ���
	String pena_rate = getZeroStr(getStr(request.getParameter("pena_rate")));//��Ϣ����
	
	//1.1.4��������
	String manager_pay_type=getStr(request.getParameter("manager_pay_type"));//manager_pay_type
	String is_floor=getStr(request.getParameter("is_floor"));   //is_floor
	String floor_rent=getStr(request.getParameter("floor_rent")); //floor_rent
	String insure_pay_type=getStr(request.getParameter("insure_pay_type"));//insure_pay_type
	String actual_fund_ratio=getStr(request.getParameter("actual_fund_ratio"));
	String plan_bank_name =getStr(request.getParameter("plan_bank_name"));
	String plan_bank_no =getStr(request.getParameter("plan_bank_no"));
	
	//2012-3-12 Jaffe ��������
	String rate_float_type=getStr(request.getParameter("rate_float_type"));
	String rate_float_amt =getStr(request.getParameter("rate_float_amt"));
	String adjust_style =getStr(request.getParameter("adjust_style"));
	
	String into_batch=getStr(request.getParameter("into_batch"));
	String is_open =getStr(request.getParameter("is_open"));
	String settle_method =getStr(request.getParameter("settle_method"));
	String period_type =getStr(request.getParameter("period_type"));
	String year_rate =getStr(request.getParameter("year_rate"));
	System.out.println("��ȡ����������"+year_rate);
	//1.1.5��������
	String creator = user_id;//�Ǽ���
	String create_date = sysDate;//�Ǽ�ʱ��
    String modify_date = sysDate;//��������
	String modificator = user_id;//������

	//��ʼ���ڡ��������ڴ���
	SimpleDateFormat simpledate = new SimpleDateFormat("yyyy-MM-dd");
	String now_start_date = start_date.substring(0,8)+income_day;//���������պͳ����յ�����
	start_date = simpledate.format(simpledate.parse(now_start_date));
	Calendar startCale = Calendar.getInstance();
	startCale.setTime(simpledate.parse(now_start_date));
	startCale.add(Calendar.MONTH, ConvertUtil.parseInt(lease_term, 0));
		
	String end_date = simpledate.format(startCale.getTime());
	
	//1.2==�����������Ը�ֵ
	ConditionMediBean conditionMediBean = new ConditionMediBean(
	 doc_id,  proj_id,  equip_amt,currency,  lease_money,  first_payment,caution_money,  "",
	 actual_fund,  handling_charge,  management_fee,nominalprice,  return_amt,  rate_subsidy, before_interest, 
	 before_interest_type,discount_rate,  consulting_fee_out,consulting_fee_in,  other_income,
	 other_expenditure,  rent_start_date,  start_date,income_day, income_number,  income_number_year,
	 lease_term, pena_rate, free_defa_inter_day, insure_type,  insure_pay_type,  insure_money,
	 is_floor,  floor_rent,  manager_pay_type, creator,  create_date,  modify_date,modificator
	);
	conditionMediBean.setActual_fund_ratio(actual_fund_ratio);
	conditionMediBean.setPlan_bank_name(plan_bank_name);
	conditionMediBean.setPlan_bank_no(plan_bank_no);
	//2012-3-12 Jaffe ����
	conditionMediBean.setRate_float_type(rate_float_type);
	conditionMediBean.setRate_float_amt(rate_float_amt);
	conditionMediBean.setAdjust_style(adjust_style);
	conditionMediBean.setInto_batch(into_batch);
	conditionMediBean.setIs_open(is_open);
	conditionMediBean.setSettle_method(settle_method);
	conditionMediBean.setPeriod_type(period_type);
	conditionMediBean.setYear_rate(year_rate);
	
	LogWriter.logDebug(request, conditionMediBean.getProj_id()+"����֮ǰ��������תBean��������"+saveType);
	
	//================2.����ConditionBean?insert:update================
	int flag = 0;	
	flag = ConditionMediService.saveConditionBeanIntoTemp(conditionMediBean, saveType);

	//���в����ɹ���ת��ҳ����ʱδ����ȷ����δ�� ***********************************************************
	if(flag>0){
%>
    <script type="text/javascript">
		alert("������Ϣ����ɹ�!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
	}else{
%>
    <script type="text/javascript">
		alert("������Ϣ����ʧ��!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
	}
%>
