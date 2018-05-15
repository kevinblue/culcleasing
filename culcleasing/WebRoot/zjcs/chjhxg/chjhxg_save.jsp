<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="gcns" scope="page" class="com.service.GeneContractNetFlowService" />
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
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );

String	contract_id = getStr( request.getParameter("contract_id") );
String	rent_list = getStr( request.getParameter("rent_list") );
String	plan_date = getStr( request.getParameter("plan_date") );
String	rent = getStr( request.getParameter("rent") );
String	corpus = getStr( request.getParameter("corpus") );
String	year_rate = getStr( request.getParameter("year_rate") );
String	interest = getStr( request.getParameter("interest") );
String	doc_id = getStr( request.getParameter("doc_id") );
String	plan_status = getStr( request.getParameter("plan_status") );


//
if(stype.equals("mod") || stype.equals("add")){
	//System.out.println("��ȷ�����=����+��Ϣ"+(rnddouble(Double.parseDouble(corpus)+Double.parseDouble(interest),2)));
	if(rnddouble(Double.parseDouble(rent),2)!=(rnddouble(Double.parseDouble(corpus)+Double.parseDouble(interest),2))){
		%>
		<script>
			window.close();
			opener.alert("�޸�ʧ�ܣ���ȷ�����=����+��Ϣ!");
			opener.location.reload();
		</script>
		<%
		db.close();
		return;
	}
}

//�����޸Ĳ��ֻ����ĳ����ƻ�������𱾽���Ϣ������С���޸������Ѿ���������𱾽���Ϣ
String i_rent="";
String i_corpus="";
String i_interest="";

sqlstr="select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) as i_rent,isnull(sum(corpus),0)+isnull(sum(corpus_adjust),0) as i_corpus,isnull(sum(interest),0)+isnull(sum(interest_adjust),0) as i_interest from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	i_rent=getDBStr( rs.getString("i_rent") );
	i_corpus=getDBStr( rs.getString("i_corpus") );
	i_interest=getDBStr( rs.getString("i_interest") );
}rs.close();

if(stype.equals("mod") && (rnddouble(Double.parseDouble(rent),2)<rnddouble(Double.parseDouble(i_rent),2) || rnddouble(Double.parseDouble(corpus),2)<rnddouble(Double.parseDouble(i_corpus),2) || rnddouble(Double.parseDouble(interest),2)<rnddouble(Double.parseDouble(i_interest),2)) && (plan_status.equals("���ֻ���"))){
	%>
	<script>
		window.close();
		opener.alert("�޸�ʧ�ܣ����ڵ��ѻ���������Ԥ�޸ĵļƻ����!");
		opener.location.reload();
	</script>
	<%
	db.close();
	return;
}


//-----------------�ж��ظ�--------------
String repeat_flag="0";
if ( stype.equals("add") ){ 
	sqlstr="select * from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="1";
	}rs.close();
}else if ( stype.equals("mod") ){ 
	sqlstr="select measure_id from fund_rent_plan_temp where id='"+czid+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		doc_id=getDBStr( rs.getString("measure_id") );
	}rs.close();
	sqlstr="select * from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"' and id<>'"+czid+"'";
	System.out.println("sqlstr000======================================"+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="1";
	}rs.close();
}else{}
if(repeat_flag.equals("1")){
	%>
	<script>
		window.close();
		opener.alert("�����ظ�!");
		opener.location.reload();
	</script>
	<%
	db.close();
	return;
}
//-------------------�жϻ���------------------------
int flag=0;
String message="";
if ( stype.equals("add")){ 
	
	sqlstr="insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,creator,create_date) select '"+doc_id+"','"+curr_date+"','"+contract_id+"','"+rent_list+"','δ����','"+plan_date+"',"+rent+","+corpus+","+year_rate+","+interest+",'"+dqczy+"','"+curr_date+"'";
	System.out.println("sqlstr0======================================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	sqlstr="update fund_rent_plan_temp set rent_overage=(select isnull(sum(rent),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),corpus_overage=(select isnull(sum(corpus),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(corpus),0)+isnull(sum(corpus_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),interest_overage=(select isnull(sum(interest),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(interest),0)+isnull(sum(interest_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),penalty=dbo.bb_getPunishInterest_item_tmp('1970-01-01',convert(varchar(10),getdate(),121),'"+doc_id+"','"+rent_list+"'),penalty_overage=dbo.bb_getPunishInterest_item_tmp('1970-01-01',convert(varchar(10),getdate(),121),'"+doc_id+"','"+rent_list+"')-(select isnull(sum(penalty),0)+isnull(sum(penalty_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"') where measure_id='"+doc_id+"' and rent_list='"+rent_list+"'";
	System.out.println("sqlstr1======================================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	message="��ӳ����ƻ�";
}
if ( stype.equals("mod")){ 
		
		sqlstr="update fund_rent_plan_temp set rent_list="+rent_list+",plan_date='"+plan_date+"',rent="+rent+",corpus="+corpus+",year_rate="+year_rate+",interest="+interest+",modificator='"+dqczy+"',modify_date='"+curr_date+"' where id="+czid;
		System.out.println("sqlstr2======================================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
		sqlstr="update fund_rent_plan_temp set rent_overage=(select isnull(sum(rent),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),corpus_overage=(select isnull(sum(corpus),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(corpus),0)+isnull(sum(corpus_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),interest_overage=(select isnull(sum(interest),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(interest),0)+isnull(sum(interest_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),penalty=dbo.bb_getPunishInterest_item_tmp('1970-01-01',convert(varchar(10),getdate(),121),'"+doc_id+"','"+rent_list+"'),penalty_overage=dbo.bb_getPunishInterest_item_tmp('1970-01-01',convert(varchar(10),getdate(),121),'"+doc_id+"','"+rent_list+"')-(select isnull(sum(penalty),0)+isnull(sum(penalty_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"') where measure_id='"+doc_id+"' and rent_list='"+rent_list+"'";
		System.out.println("sqlstr3======================================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
	message="�޸ĳ����ƻ�";
}
if ( stype.equals("del") ){ 
	sqlstr="select measure_id,contract_id from fund_rent_plan_temp where id='"+czid+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		doc_id=getDBStr( rs.getString("measure_id") );
		contract_id=getDBStr( rs.getString("contract_id") );
	}rs.close();
	sqlstr="delete from fund_rent_plan_temp where  id="+czid;
	flag = db.executeUpdate(sqlstr);
	message="ɾ�������ƻ�";
}

//�����ͬ�ճ̱�(��ʱ)
gcns.GeneContractNetFlow(contract_id, doc_id, dqczy);

if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>�ɹ�!");
			opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>ʧ��!");
			opener.location.reload();
		</script>
<%}db.close();%>