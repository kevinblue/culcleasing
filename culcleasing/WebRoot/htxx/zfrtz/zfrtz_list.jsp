<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>���ƻ����� - ֧���յ���</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/validator.js"></script>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
		<script language="javascript" src="/dict/js/js_dictionary.js"></script>
		<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
	</head>

	<body  onload="ForbidErrorKeydown();">
			<form name="form1" method="post" action="zfrtz_save.jsp" target="_blank"
				onSubmit="return checkdata(this);">
			<!--���⿪ʼ-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0" style="display:none"
				height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						���ƻ����� &gt; ֧���յ���
					</td>
				</tr>
			</table>
			<!--�������-->

			<!--������Ͳ�������ʼ-->

			<table border="0" width="100%" id="table8" cellspacing="0"
				cellpadding="0" style="margin-top:2px;">
				<tr class="maintab">
					<td align="left" width="1%">

<%
	String sqlstr;
	ResultSet rs;
	String wherestr = " where 1=1";
	String searchFld = getStr(request.getParameter("searchFld"));
	String searchKey = getStr(request.getParameter("searchKey"));
	String searchFld_tmp = "";
	

	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String start_list="";	//��ʼ����
	String payday_adjust="";	//֧��������
	String handling_charge="0";	//������
	String curr_date = getSystemDate(0);	//��֤��Ϣ
	String plan_status_str="";	//��֤��Ϣ
	String plan_date_str="";	//��֤��Ϣ
	String temp_flag="";	//��ʾtemp������û������
	
	//�����׽ṹ
	String data_flag="0";
	sqlstr="select * from contract_condition_temp where measure_id='"+doc_id+"'";
	System.out.println("sqlstr2=================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		data_flag="1";
	}rs.close();
	if(data_flag.equals("0")){
		sqlstr="insert into contract_condition_temp (contract_id, equip_amt, lease_money, lease_term, income_number_year, income_number, year_rate, rate_float_type, period_type, settle_method, income_day, start_date, accounting_start_date, first_date, second_date, first_payment_ratio, first_payment, first_payment_in_ratio, first_payment_in, caution_money_ratio, caution_money, lessee_caution_ratio, lessee_caution_money, vndr_caution_ratio, vndr_caution_money, sale_caution_ratio, sale_caution_money, caution_deduction_ratio, caution_deduction_money, handling_charge_ratio, handling_charge, return_ratio, return_amt, supervision_fee_ratio, supervision_fee, consulting_fee, other_fee, nominalprice, insurance_method, insurance_lessor, insurance_lessee, redressalk, pena_rate, total_amt, actual_fund, rough_earn, year_earn, irr, plan_irr, agree_penalty_days, measure_id, creator, create_date, modificator, modify_date) select contract_id, equip_amt, lease_money, lease_term, income_number_year, income_number, year_rate, rate_float_type, period_type, settle_method, income_day, start_date, accounting_start_date, first_date, second_date, first_payment_ratio, first_payment, first_payment_in_ratio, first_payment_in, caution_money_ratio, caution_money, lessee_caution_ratio, lessee_caution_money, vndr_caution_ratio, vndr_caution_money, sale_caution_ratio, sale_caution_money, caution_deduction_ratio, caution_deduction_money, handling_charge_ratio, handling_charge, return_ratio, return_amt, supervision_fee_ratio, supervision_fee, consulting_fee, other_fee, nominalprice, insurance_method, insurance_lessor, insurance_lessee, redressalk, pena_rate, total_amt, actual_fund, rough_earn, year_earn, irr, plan_irr, agree_penalty_days, '"+doc_id+"', creator, create_date, modificator, modify_date from contract_condition where contract_id='"+contract_id+"'";
		System.out.println("sqlstr3=================="+sqlstr);
		db.executeUpdate(sqlstr);
	}
	
	if(doc_id.equals("")){
		wherestr=" where 1=0";
	}else{
		wherestr+=" and fund_rent_plan_temp.measure_id='"+doc_id+"'";
	}
	sqlstr="select fund_rent_adjust.start_list,fund_rent_adjust.payday_adjust,isnull(fund_rent_adjust.handling_charge,0) as handling_charge from fund_rent_adjust where fund_rent_adjust.measure_id='"+doc_id+"'";
	System.out.println("sqlstr================================================"+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		start_list=getDBStr(rs.getString("start_list"));
		payday_adjust=getDBDateStr(rs.getString("payday_adjust"));
		handling_charge=formatNumberStr(getDBStr(rs.getString("handling_charge")),"#,##0.00");
	}rs.close();
	sqlstr="select plan_status,plan_date from fund_rent_plan where contract_id='"+contract_id+"' order by rent_list";
	rs=db.executeQuery(sqlstr);
	while (rs.next()) {
		temp_flag="0";
		plan_status_str=plan_status_str+getDBStr(rs.getString("plan_status"))+",";
		plan_date_str=plan_date_str+getDBDateStr(rs.getString("plan_date"))+",";
	
	}rs.close();
	if(plan_status_str.length()>0){
		plan_status_str=plan_status_str.substring(0,plan_status_str.length()-1);
		plan_date_str=plan_date_str.substring(0,plan_date_str.length()-1);
	}
	sqlstr = "select fund_rent_plan_temp.contract_id,fund_rent_plan_temp.rent_list,fund_rent_plan_temp.plan_status,fund_rent_plan_temp.plan_date,fund_rent_plan_temp.rent,fund_rent_plan_temp.corpus,fund_rent_plan_temp.year_rate,fund_rent_plan_temp.interest from fund_rent_plan_temp"+wherestr;
	
	//System.out.println("sqlstr======================================="+sqlstr);
%>



<!--������ť��ʼ-->
<input name="contract_id" type="hidden" value="<%=contract_id %>">
<input name="doc_id" type="hidden" value="<%=doc_id %>">
<table border="0" cellspacing="0" cellpadding="0">
	<tr class="maintab">
		<td nowrap>
		֧���ձ��Ϊ<input name="zfr_date" type="text" size="15" readonly maxlength="10" dataType="Date" Require="ture" value="<%=payday_adjust %>">
		<img  onClick="openCalendar(zfr_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">��
		,��ʼ����Ϊ��<input name="start_rent_list" type="text" size="5" dataType="Integer" Require="true" value="<%=start_list %>">��
		,������Ϊ<input name="handling_charge" type="text" size="10" Require="true" dataType="PMoney" value="<%= handling_charge %>">Ԫ
		<BUTTON class="btn_2" name="btnSave" value="����"  type="submit">
<img src="../../images/save.gif" align="absmiddle" border="0" >����</button>
		</td>
		
	</tr>
</table>
<!--������ť����-->
					</td>
					<td align="right" width="90%">


						<!--��ҳ���ƿ�ʼ-->
					</td>
				</tr>
			</table>

		<!--��ҳ���ƽ���-->






		<!--����ʼ-->

		<div
			style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"
			id="mydiv";>
				
				
				<table border="0" style="border-collapse:collapse;" align="center"
					cellpadding="2" cellspacing="1" width="100%"
					class="maintab_content_table">
					<tr class="maintab_content_table_title">
						<th>��ͬ���</th>
						<th>����</th>
						<th>�ƻ�״̬</th>
						<th>�и�����</th>
						<th>���</th>
						<th>����</th>
						<th>������</th>
						<th>��Ϣ</th>
					</tr>
					<%
					rs=db.executeQuery(sqlstr);
					while (rs.next()) {
						temp_flag="1";
					%>

					<tr>
						<td><%=getDBStr(rs.getString("contract_id"))%></td>
						<td><%=getDBStr(rs.getString("rent_list"))%></td>
						<td><%=getDBStr(rs.getString("plan_status"))%></td>
						<td><%=getDBDateStr(rs.getString("plan_date"))%></td>
						<td><%=formatNumberStr(getDBStr(rs.getString("rent")),"#,##0.00")%></td>
						<td><%=formatNumberStr(getDBStr(rs.getString("corpus")),"#,##0.00")%></td>
						<td><%=formatNumberStr(getDBStr(rs.getString("year_rate")),"#,##0.000000")%></td>
						<td><%=formatNumberStr(getDBStr(rs.getString("interest")),"#,##0.00")%></td>
					</tr>
					
					<%
					}rs.close();
					db.close();
					if(temp_flag.equals("1")){
					%>
					<tr>
						<td colspan="8"><a href="../ysss/tmp_blj_tzq_list.jsp?doc_id=<%= doc_id %>" target="_blank">�ճ̱�</a></td>
				      </tr>
					<%
					}if(temp_flag.equals("0")){
					%>
					<tr>
						<td colspan="8"><a href="../ysss/blj_tzq_list.jsp?contract_id=<%= contract_id %>" target="_blank">�ճ̱�</a></td>
				      </tr>
					<%
					}else{
						
					}
					%>
				</table>
		</div>
		<!--�������-->
		</form>
	</body>
</html>
<input type="hidden" name="plan_status_str" value="<%= plan_status_str %>">
<input type="hidden" name="plan_date_str" value="<%= plan_date_str %>">
<input type="hidden" name="curr_date" value="<%= curr_date %>">
<script language="javascript">

function checkdata(obj){
	var plan_status_str=document.getElementById("plan_status_str").value;
	var plan_date_str=document.getElementById("plan_date_str").value;
	var plan_status_arr=plan_status_str.split(",");
	var plan_date_arr=plan_date_str.split(",");
	
	var start_rent_list=document.getElementById("start_rent_list").value;
	var zfr_date=document.getElementById("zfr_date").value;
	if(start_rent_list=="" || zfr_date==""){
		return Validator.Validate(obj,3);
	}
	
	var curr_date=document.getElementById("curr_date").value;
	if(plan_date_arr[start_rent_list-1]<curr_date){
		alert("���ܵ����и������ڽ���֮ǰ�����");
		return false;
	}else if(plan_status_arr[start_rent_list-1]=="�ѻ���"){
		alert("��"+start_rent_list+"������ѻ�����");
		return false;
	}else if(zfr_date<curr_date){
		alert("֧���ղ��ܵ���������֮ǰ��");
		return false;
	}else if(Math.abs(datediff('day',plan_date_arr[start_rent_list-1],zfr_date))>15){
		alert("������Χ���ܳ���15�죡");
		return false;
	}else{
		return Validator.Validate(obj,3); 
	}
	
}
</script>
