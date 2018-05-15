<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String sqlstr;
ResultSet rs;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);

String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

String evidence_summary="";
String subject_number="";
String subject_name="";
String debit="";
String credit="";
String subject_opposite="";
String evidence_number="";

List l_ebdata_id = new ArrayList();
List l_summary = new ArrayList();
List l_fact_money = new ArrayList();
//List l_bank_subject = new ArrayList();
List l_acc_number = new ArrayList();
List l_contract = new ArrayList();
List l_cust_name = new ArrayList();
sqlstr="select fund_ebank_data.ebdata_id,fund_ebank_data.summary,isnull(fund_ebank_data.fact_money,0) as fact_money,fund_ebank_data.acc_number,fund_ebank_data.contract_id,fund_ebank_data.client_name as cust_name from fund_ebank_data where fund_ebank_data.status='有效' and isnull(fund_ebank_data.evidence_flag,'00000')<>'是'";
//System.out.println("sqlstr==========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
while(rs.next()){
	l_ebdata_id.add(getDBStr( rs.getString("ebdata_id") ));
	l_summary.add(getDBStr( rs.getString("summary") ));
	l_fact_money.add(getDBStr( rs.getString("fact_money") ));
	//l_bank_subject.add(getDBStr( rs.getString("bank_subject") ));
	l_acc_number.add(getDBStr( rs.getString("acc_number") ));
	l_contract.add(getDBStr( rs.getString("contract_id") ));
	l_cust_name.add(getDBStr( rs.getString("cust_name") ));
}rs.close();

for(int i=0;i<l_ebdata_id.size();i++){
//凭证号
	sqlstr="select dbo.evidenceNo_create() as evidence_number";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		evidence_number=getDBStr( rs.getString("evidence_number") );
	}rs.close();
	
	evidence_summary=l_ebdata_id.get(i).toString()+l_contract.get(i).toString()+l_cust_name.get(i).toString()+l_summary.get(i).toString();
	subject_number="";
	debit=l_fact_money.get(i).toString();
	credit="0";
	
	subject_name="";
	sqlstr="select * from inter_bank_subject where acc_number='"+l_acc_number.get(i).toString()+"'";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		subject_number=getDBStr( rs.getString("subject_number") );
		subject_name=getDBStr( rs.getString("subject_name") );
	}rs.close();
	
	subject_opposite="";
	sqlstr="select * from inter_fee_subject where feetype_number='055'";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		subject_opposite=getDBStr( rs.getString("subject_number") );
	}rs.close();
	
	
	sqlstr="insert into inter_evidence_info (create_date,evidence_type,evidence_number,invoice_number,evidence_summary,subject_number,debit,credit,happen_date,acc_set_number,accounting_unit,acc_year,acc_month,type_number,line_number,subject_name,client_abbr,vndr_addr,subject_opposite,process_name,status,exp_flag) values('"+curr_date+"','记','"+evidence_number+"',1,'"+evidence_summary+"','"+subject_number+"',"+debit+","+credit+",'"+curr_date+"','002','恒信金融租赁有限公司',"+curr_date.substring(0,4)+","+curr_date.substring(5,7)+",'8',1,'"+subject_name+"','其它','','"+subject_opposite+"','网银','有效','否')";
	//System.out.println("sqlstr1==========================================="+sqlstr);
	db.executeUpdate(sqlstr);
	
	//贷
	evidence_summary=l_ebdata_id.get(i).toString()+l_contract.get(i).toString()+l_cust_name.get(i).toString()+l_summary.get(i).toString();
	
	subject_number="";
	subject_name="";
	sqlstr="select * from inter_fee_subject where feetype_number='055'";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		subject_number=getDBStr( rs.getString("subject_number") );
		subject_name=getDBStr( rs.getString("subject_name") );
	}rs.close();
	
	debit="0";
	credit=l_fact_money.get(i).toString();
	subject_opposite="";
	sqlstr="select * from inter_bank_subject where acc_number='"+l_acc_number.get(i).toString()+"'";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		subject_opposite=getDBStr( rs.getString("subject_number") );
	}rs.close();
	
	
	sqlstr="insert into inter_evidence_info (create_date,evidence_type,evidence_number,invoice_number,evidence_summary,subject_number,debit,credit,happen_date,acc_set_number,accounting_unit,acc_year,acc_month,type_number,line_number,subject_name,client_abbr,vndr_addr,subject_opposite,process_name,status,exp_flag) values('"+curr_date+"','记','"+evidence_number+"',1,'"+evidence_summary+"','"+subject_number+"',"+debit+","+credit+",'"+curr_date+"','002','恒信金融租赁有限公司',"+curr_date.substring(0,4)+","+curr_date.substring(5,7)+",'8',2,'"+subject_name+"','','其它','"+subject_opposite+"','网银','有效','否')";
	//System.out.println("sqlstr2==========================================="+sqlstr);
	db.executeUpdate(sqlstr);
}

sqlstr="update fund_ebank_data set evidence_flag='是' where fund_ebank_data.status='有效' and isnull(fund_ebank_data.evidence_flag,'否')<>'是'";
//System.out.println("sqlstr==========================================="+sqlstr);
db.executeUpdate(sqlstr);
db.close();
%>
<script>
			window.close();
			opener.alert("成功!");
			opener.location.reload();
		</script>