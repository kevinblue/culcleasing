<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金测算</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>


</head>
<body style="overflow:auto;">

<form name="form1" method="post" target="_black" action="condition_sc.jsp" onSubmit="return Validator.Validate(this,3);">


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<%
	
	String doc_id = getStr(request.getParameter("doc_id"));
	String contract_id = getStr(request.getParameter("contract_id"));
	String model = getStr(request.getParameter("model"));
	
	ResultSet rs;
	String sqlstr="";
	String wherestr=" where 1=1";
	
	String insurer_value="";
	String insurer_str="";
	sqlstr="select * from ifelc_conf_dictionary where parentid='insurance'";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		insurer_value+=getDBStr(rs.getString("name"))+"|";
		insurer_str+=getDBStr(rs.getString("title"))+"|";
	}rs.close();
	if(insurer_value.length()>0){
		insurer_value=insurer_value.substring(0,insurer_value.length()-1);
		insurer_str=insurer_str.substring(0,insurer_str.length()-1);
	}
	
	
	//csa_fees="100";
	
	String equip_amt="";
	String lease_amt="";
	String first_payment_ratio="";
	String first_payment="";
	String lease_money="";
	String insurer="";
	String insurance="";
	String insurance_flag="";
	String lsh_insurance="";
	String cust_insurance="";
	String csa_flag="";
	String csa_financing="";
	String csa_cost="";
	String machine_price="";
	String gps_flag="";
	String gps_cost="";
	String income_number_year="";
	String start_date="";
	String income_number="";
	String lease_term="";
	String income_day="";
	String year_rate="";
	String per_rent="";
	String supervision_fee="";
	String handling_charge="";
	String caution_money="";
	String return_amt="";
	String tax="";
	String commision="";
	String nominalprice="";
	String pena_rate="";
	String irr="";
	String peroid_payment="";
	String begin_payment="";
	String csa_hours="";
	String period_type="";
	
	String insurer_name="";
	
	//判断临时表中有没有数据则取before表中的数据
	int i_count=0;
	sqlstr="select count(*) as i_count from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	//System.out.println("sqlstr11111==============="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		i_count=rs.getInt("i_count");
	}rs.close();
	if(i_count>0){
		sqlstr="select contract_condition_temp.*,ifelc_conf_dictionary.title as insurer_name from contract_condition_temp left join ifelc_conf_dictionary on contract_condition_temp.insurer=ifelc_conf_dictionary.name where contract_condition_temp.contract_id='"+contract_id+"' and contract_condition_temp.measure_id='"+doc_id+"'";
	}else{
		sqlstr="select contract_condition.*,ifelc_conf_dictionary.title as insurer_name from contract_condition left join ifelc_conf_dictionary on contract_condition.insurer=ifelc_conf_dictionary.name where contract_condition.contract_id='"+contract_id+"'";
	}
	
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		equip_amt=formatNumberDoubleTwo(getDBStr(rs.getString("equip_amt")));
		lease_amt=formatNumberDoubleTwo(getDBStr(rs.getString("lease_amt")));
		first_payment_ratio=formatNumberDoubleTwo(getDBStr(rs.getString("first_payment_ratio")));
		first_payment=formatNumberDoubleTwo(getDBStr(rs.getString("first_payment")));
		lease_money=formatNumberDoubleTwo(getDBStr(rs.getString("lease_money")));
		insurer_name=getDBStr(rs.getString("insurer_name"));
		insurance=formatNumberDoubleTwo(getDBStr(rs.getString("insurance")));
		insurance_flag=getDBStr(rs.getString("insurance_flag"));
		lsh_insurance=formatNumberDoubleTwo(getDBStr(rs.getString("lsh_insurance")));
		cust_insurance=formatNumberDoubleTwo(getDBStr(rs.getString("cust_insurance")));
		csa_flag=getDBStr(rs.getString("csa_flag"));
		csa_financing=getDBStr(rs.getString("csa_financing"));
		csa_cost=formatNumberDoubleTwo(getDBStr(rs.getString("csa_cost")));
		machine_price=formatNumberDoubleTwo(getDBStr(rs.getString("machine_price")));
		gps_flag=getDBStr(rs.getString("gps_flag"));
		gps_cost=formatNumberDoubleTwo(getDBStr(rs.getString("gps_cost")));
		income_number_year=getDBStr(rs.getString("income_number_year"));
		start_date=getDBDateStr(rs.getString("start_date"));
		income_number=getDBStr(rs.getString("income_number"));
		lease_term=getDBStr(rs.getString("lease_term"));
		income_day=getDBStr(rs.getString("income_day"));
		year_rate=formatNumberDoubleTwo(getDBStr(rs.getString("year_rate")));
		//per_rent=formatNumberDoubleTwo(getDBStr(rs.getString("000000")));
		supervision_fee=formatNumberDoubleTwo(getDBStr(rs.getString("supervision_fee")));
		handling_charge=formatNumberDoubleTwo(getDBStr(rs.getString("handling_charge")));
		caution_money=formatNumberDoubleTwo(getDBStr(rs.getString("caution_money")));
		return_amt=formatNumberDoubleTwo(getDBStr(rs.getString("return_amt")));
		tax=formatNumberDoubleTwo(getDBStr(rs.getString("tax")));
		commision=formatNumberDoubleTwo(getDBStr(rs.getString("commision")));
		nominalprice=formatNumberDoubleTwo(getDBStr(rs.getString("nominalprice")));
		pena_rate=formatNumberDoubleTwo(getDBStr(rs.getString("pena_rate")));
		irr=formatNumberDoubleTwo(getDBStr(rs.getString("irr")));
		peroid_payment=formatNumberDoubleTwo(getDBStr(rs.getString("peroid_payment")));
		begin_payment=formatNumberDoubleTwo(getDBStr(rs.getString("begin_payment")));
		csa_hours=getDBStr(rs.getString("csa_hours"));
		period_type=getDBStr(rs.getString("period_type"));
	}rs.close();
	
	//判断临时表中有没有数据则取before表中的数据
	i_count=0;
	sqlstr="select count(*) as i_count from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	//System.out.println("sqlstr11111==============="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		i_count=rs.getInt("i_count");
	}rs.close();
	if(i_count>0){
		sqlstr="select rent as per_rent from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and rent_list=1";
	}else{
		sqlstr="select rent as per_rent from fund_rent_plan_before where contract_id='"+contract_id+"' and rent_list=1";
	}
	
	
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		per_rent=formatNumberDoubleTwo(getDBStr(rs.getString("per_rent")));
	}rs.close();
	
	db.close();
 %>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
</td></tr> 
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:380px;overflow:auto;">
<div id="TD_tab_0">
<input name="doc_id" type="hidden" value="<%=doc_id %>"/>
<input name="model" type="hidden" value="<%=model %>"/>
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<th>合同编号</th>
    <td><%=contract_id %></td>
    <th>项目间隔</th>
    <td><%=income_number_year.equals("1")?"月付":income_number_year.equals("3")?"季付":income_number_year.equals("6")?"半年付":income_number_year.equals("12")?"年付":"" %></td>
	<th>期数</th>
    <td><%=income_number %></td>
  </tr>
  <tr>
  	<th>租赁期限</th>
    <td><%=lease_term %></td>
  	<th>整机价格</th>
    <td><%=formatNumberStr(machine_price,"#,##0.00") %></td>
    <th>是否安装GPS</th>
    <td><%=gps_flag %></td>
    
  	
  </tr>
  <tr>
  	<th>GPS费用(此金额可并入整机价格)</th>
    <td><%=formatNumberStr(gps_cost,"#,##0.00") %></td>
    <th>保险公司</th>
    <td><%=insurer_name %></td>
	<th>保险费</th>
    <td><%=formatNumberStr(insurance,"#,##0.00") %></td>
    
  </tr>
  <tr>
  	<th>保险费是否融资</th>
    <td><%=insurance_flag %></td>
	<th>利星行支付的保险费</th>
    <td><%=formatNumberStr(lsh_insurance,"#,##0.00") %></td>
	<th>客户承担的保险费</th>
    <td><%=formatNumberStr(cust_insurance,"#,##0.00") %></td>
    
  </tr>
  <tr>
  	<th>是否购买CSA</th>
    <td><%=csa_flag %></td>
    <th>CSA是否融资</th>
    <td><%=csa_financing %></td>
	<th>CSA客户服务协议</th>
    <td><%=csa_hours %>小时<%=formatNumberStr(csa_cost,"#,##0.00") %>元</td>
	
  </tr>
  
  <tr>
	<th>租赁物总价</th>
    <td><%=formatNumberStr(equip_amt,"#,##0.00") %></td>
    <th>融资总额</th>
    <td><%=formatNumberStr(lease_amt,"#,##0.00") %></td>
    <th>首付比例</th>
    <td><%=first_payment_ratio %>%</td>
	
    
  </tr>
  <tr>
  	<th>首付款</th>
    <td><%=formatNumberStr(first_payment,"#,##0.00") %></td>
    <th>净融资额</th>
    <td><%=formatNumberStr(lease_money,"#,##0.00") %></td>
	<th>预计起租日期</th>
    <td><%=start_date %></td>
    
  </tr>
  <tr>
    <th>租金支付日期</th>
    <td><%=income_day %></td>
    <th>名义利率</th>
    <td><%=year_rate %>%</td>
    <th>每期租金</th>
    <td><%=formatNumberStr(per_rent,"#,##0.00") %></td>
  </tr>
  <tr>
    <th>管理费</th>
    <td><%=formatNumberStr(supervision_fee,"#,##0.00") %></td>
    <th>手续费</th>
    <td><%=formatNumberStr(handling_charge,"#,##0.00") %></td>
    <th>租赁保证金</th>
    <td><%=formatNumberStr(caution_money,"#,##0.00") %></td>
  </tr>
  <tr>
    <th>厂商返利</th>
    <td><%=formatNumberStr(return_amt,"#,##0.00") %></td>
    <th>税金</th>
    <td><%=formatNumberStr(tax,"#,##0.00") %></td>
    <th>佣金</th>
    <td><%=formatNumberStr(commision,"#,##0.00") %></td>
  </tr>
  <tr>
    <th>押金（名义货价）</th>
    <td><%=formatNumberStr(nominalprice,"#,##0.00") %></td>
    <th>逾期罚息率</th>
    <td><%=pena_rate %>%%</td>
    <th>实际利率</th>
    <td><%=irr %>%</td>
  </tr>
  <tr>
    <th>向融资公司支付的期初付款</th>
    <td><%=formatNumberStr(peroid_payment,"#,##0.00") %></td>
    <th>应收期初付款</th>
    <td><%=formatNumberStr(begin_payment,"#,##0.00") %></td>
    <th>期末起初</th>
    <td><%=period_type.equals("0")?"期末":period_type.equals("1")?"期初":"" %></td>
  </tr>
  
</table>



</div>
</div>
</form>


</body>
</html>