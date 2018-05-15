<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>���ƻ����� - ����</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/validator.js"></script>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
		<script language="javascript" src="/dict/js/js_dictionary.js"></script>
		<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
	</head>

	<body  onload="setDivHeight('mydiv',-55)"
		style="border:1px solid #8DB2E3;">
			<form name="form1" method="post" action="overdue_term_save.jsp" target="_blank"
				onSubmit="return checkdata(this);">
			<!--���⿪ʼ-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0" style="display:none"
				height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						���ƻ����� &gt; ����
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
	String payday_delay="";	//��������
	String handling_charge="0";	//������
	String interest_handling_charge = "0";
	String curr_date = getSystemDate(0);	//��֤��Ϣ
	String plan_status_str="";	//��֤��Ϣ
	String plan_date_str="";	//��֤��Ϣ
	String temp_flag="";	//��ʾtemp������û������
	if(doc_id.equals("")){
		wherestr=" where 1=0";
	}else{
		wherestr+=" and fund_rent_plan_temp.measure_id='"+doc_id+"'";
	}
	
	sqlstr="select fund_rent_adjust.start_list,fund_rent_adjust.payday_delay,isnull(fund_rent_adjust.handling_charge,0) as handling_charge,interest_handling_charge from fund_rent_adjust where fund_rent_adjust.measure_id='"+doc_id+"'";
	System.out.println(sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		start_list=getDBStr(rs.getString("start_list"));
		payday_delay=getDBDateStr(rs.getString("payday_delay"));
		handling_charge=formatNumberStr(getDBStr(rs.getString("handling_charge")),"#,##0.00");
		interest_handling_charge=formatNumberStr(getDBStr(rs.getString("interest_handling_charge")),"#,##0.00");
	}rs.close();
	sqlstr="select plan_status,plan_date from fund_rent_plan where contract_id='"+contract_id+"' order by rent_list";
	System.out.println(sqlstr);
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
	System.out.println(sqlstr);
	//System.out.println("sqlstr=================="+sqlstr);
%>



<!--������ť��ʼ-->
<input name="contract_id" type="hidden" value="<%=contract_id %>">
<input name="doc_id" type="hidden" value="<%=doc_id %>">
<table border="0" cellspacing="0" cellpadding="0">
	<tr class="maintab">
		<td nowrap>
		���ڵ�<input name="zfr_date" type="text" size="15" readonly maxlength="10" dataType="Date" Require="true" value="<%= payday_delay %>"> 
		,��ʼ����Ϊ��<input name="start_rent_list" type="text" size="5" maxB="3" Require="true" value="<%= start_list %>" readonly>��
		,������Ϊ<input name="handling_charge" type="text" size="10" Require="true" value="<%= handling_charge %>" readonly>Ԫ
		 ��Ϣ������Ϊ<input name="interest_handling_charge" type="text" size="10" Require="true" dataType="PMoney" value="<%= interest_handling_charge %>">Ԫ
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
					System.out.println("1111111111111111111111");
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
						if(plan_status_str.length()>0){
						%>
					<tr>
						<td colspan="8"><a href="../ysss/tmp_blj_tzq_list.jsp?doc_id=<%= doc_id %>" target="_blank">�ճ̱�</a></td>
				      </tr>
					<%
							plan_status_str=plan_status_str.substring(0,plan_status_str.length()-1);
							plan_date_str=plan_date_str.substring(0,plan_date_str.length()-1);
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
	}else if(zfr_date<curr_date){
		alert("֧���ղ��ܵ���������֮ǰ��");
		return false;
	}else if(plan_status_arr[start_rent_list-1]=="�ѻ���"){
		alert("��"+start_rent_list+"������ѻ�����");
		return false;
	}else if(start_rent_list>1){
		if(zfr_date<=plan_date_arr[start_rent_list-2]){
			alert("���ܰѵ�"+start_rent_list+"�����֧���յ�������"+(start_rent_list-1)+"�����֧����֮ǰ��");
			return false;
		}
	}else{
		return Validator.Validate(obj,3); 
	}
	
}
</script>