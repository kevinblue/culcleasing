<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );

//��ȡ����
String contract_id = getStr( request.getParameter("contract_id") );
String begin_id = getStr( request.getParameter("begin_id") );
String start_list = getStr( request.getParameter("start_list") );
String delay_month = getStr( request.getParameter("delay_month") );

String sqlstr;
String datestr = getSystemDate(0); //��ȡϵͳʱ��
int flag = 0;
String msg = "";
String delay_id="0";
ResultSet rs;
	//insert �Ӻ���Ϣ��¼��
	sqlstr = "insert into contract_delay_info(contract_id,begin_id,start_list,delay_month,creator,create_date)";
	sqlstr += " values('"+contract_id+"','"+begin_id+"','"+start_list+"','"+delay_month+"','"+dqczy+"','"+datestr+"')";
	//System.out.println(sqlstr);
	flag = db.executeUpdate(sqlstr);
	//�����idֵ
	sqlstr = "select max(id) id from contract_delay_info where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' ";
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
	delay_id = rs.getString("id");
	}
	rs.close();
	//���ƻ�������ʷ��
	sqlstr = "insert into fund_rent_plan_his " ;
	sqlstr += "(doc_id,measure_date,contract_id,begin_id,rent_list,plan_date,pena_plan_date," ;
						sqlstr += "curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," ;
						sqlstr += "interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," ;
						sqlstr += "plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," ;
						sqlstr += "create_date,modificator,modify_date,delay_id,status) select " ;
						sqlstr += " doc_id,getdate(),contract_id,begin_id,rent_list,plan_date,pena_plan_date," ;
						sqlstr += "curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," ;
						sqlstr += "interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," ;
						sqlstr += "plan_bank_name,plan_bank_no,mod_stuff,mod_status,'�Ӻ�',creator,create_date," ;
						sqlstr += "modificator,modify_date,'"+delay_id+"','ǰ' from fund_rent_plan where " ;
						sqlstr += "contract_id='" +contract_id+"' and begin_id='"+begin_id+"' ";
	flag = db.executeUpdate(sqlstr);
						
	//update �޸�fund_rent_planΪ�Ӻ�ƻ�
	sqlstr = "update fund_rent_plan set plan_date=dateadd(mm,"+delay_month+",plan_date) where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' and rent_list>'"+start_list+"'";
	System.out.println("sqlstr====================="+sqlstr);
	flag = db.executeUpdate(sqlstr);
	//�ӳٺ�����ƻ����뵽��ʷ����
	sqlstr = "insert into fund_rent_plan_his " ;
	sqlstr += "(doc_id,measure_date,contract_id,begin_id,rent_list,plan_date,pena_plan_date," ;
						sqlstr += "curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," ;
						sqlstr += "interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," ;
						sqlstr += "plan_bank_name,plan_bank_no,mod_stuff,mod_status,mod_reason,creator," ;
						sqlstr += "create_date,modificator,modify_date,delay_id,status) select " ;
						sqlstr += " doc_id,getdate(),contract_id,begin_id,rent_list,plan_date,pena_plan_date," ;
						sqlstr += "curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage," ;
						sqlstr += "interest_overage,curr_penalty,penalty,penalty_overage,plan_status,pena_status," ;
						sqlstr += "plan_bank_name,plan_bank_no,mod_stuff,mod_status,'�Ӻ�',creator,create_date," ;
						sqlstr += "modificator,modify_date,'"+delay_id+"','��' from fund_rent_plan where " ;
						sqlstr += "contract_id='" +contract_id+"' and begin_id='"+begin_id+"' ";
	flag = db.executeUpdate(sqlstr);					
	db.close();
	
	msg = "��𻹿��Ӻ�";

if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>�ɹ�!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>ʧ��!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
