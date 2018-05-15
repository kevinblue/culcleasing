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

//-----------------判断重复--------------
String repeat_flag="0";
if ( stype.equals("add") ){ 
	sqlstr="select * from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="1";
	}rs.close();
}else if ( stype.equals("mod") ){ 
	sqlstr="select * from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"' and id<>'"+czid+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		repeat_flag="1";
	}rs.close();
}else{}
if(repeat_flag.equals("1")){
	%>
	<script>
		window.close();
		opener.alert("数据重复!");
		opener.location.reload();
	</script>
	<%
	return;
}

int flag=0;
String message="";
if ( stype.equals("add")){ 
	
	sqlstr="insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,creator,create_date) select '"+doc_id+"','"+curr_date+"','"+contract_id+"','"+rent_list+"','未回笼','"+plan_date+"',"+rent+","+corpus+","+year_rate+","+interest+",'"+dqczy+"','"+curr_date+"'";
	System.out.println("sqlstr0======================================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	sqlstr="update fund_rent_plan_temp set rent_overage=(select isnull(sum(rent),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),corpus_overage=(select isnull(sum(corpus),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(corpus),0)+isnull(sum(corpus_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),interest_overage=(select isnull(sum(interest),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(interest),0)+isnull(sum(interest_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),penalty=dbo.bb_getPunishInterest_item_tmp('1970-01-01',convert(varchar(10),getdate(),121),'"+doc_id+"','"+rent_list+"'),penalty_overage=dbo.bb_getPunishInterest_item_tmp('1970-01-01',convert(varchar(10),getdate(),121),'"+doc_id+"','"+rent_list+"')-(select isnull(sum(penalty),0)+isnull(sum(penalty_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"') where measure_id='"+doc_id+"' and rent_list='"+rent_list+"'";
	System.out.println("sqlstr1======================================"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	message="添加偿还计划";
}
if ( stype.equals("mod")){ 
		sqlstr="select measure_id from fund_rent_plan_temp where id='"+czid+"'";
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			doc_id=getDBStr( rs.getString("measure_id") );
		}rs.close();
		sqlstr="update fund_rent_plan_temp set rent_list="+rent_list+",plan_date='"+plan_date+"',rent="+rent+",corpus="+corpus+",year_rate="+year_rate+",interest="+interest+",modificator='"+dqczy+"',modify_date='"+curr_date+"' where id="+czid;
		System.out.println("sqlstr2======================================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
		sqlstr="update fund_rent_plan_temp set rent_overage=(select isnull(sum(rent),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),corpus_overage=(select isnull(sum(corpus),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(corpus),0)+isnull(sum(corpus_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),interest_overage=(select isnull(sum(interest),0) from fund_rent_plan_temp where measure_id='"+doc_id+"' and rent_list='"+rent_list+"')-(select isnull(sum(interest),0)+isnull(sum(interest_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'),penalty=dbo.bb_getPunishInterest_item_tmp('1970-01-01',convert(varchar(10),getdate(),121),'"+doc_id+"','"+rent_list+"'),penalty_overage=dbo.bb_getPunishInterest_item_tmp('1970-01-01',convert(varchar(10),getdate(),121),'"+doc_id+"','"+rent_list+"')-(select isnull(sum(penalty),0)+isnull(sum(penalty_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"') where measure_id='"+doc_id+"' and rent_list='"+rent_list+"'";
		System.out.println("sqlstr3======================================"+sqlstr);
		flag = db.executeUpdate(sqlstr);
	message="修改偿还计划";
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
	message="删除偿还计划";
}

//插入合同日程表(临时)
String min_date="";
String max_date="";
String end_rent_list="";
String first_fund_in="0";
String first_fund_out="0";
String end_fund_in="0";
String end_fund_out="0";

sqlstr="delete from fund_contract_plan_temp where measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
sqlstr="select substring(convert(varchar(10),min(plan_date),121),1,7) as min_date,substring(convert(varchar(10),max(plan_date),121),1,7) as max_date from fund_rent_plan_temp where measure_id='"+doc_id+"'";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	min_date=getDBStr(rs.getString("min_date"));
	max_date=getDBStr(rs.getString("max_date"));
}rs.close();
//期初/期末,日期,保证金,可抵扣保证金
String period_type="";
String start_date="";
String caution_money="0";
String caution_deduction_money="0";

sqlstr="select period_type,start_date,isnull(caution_money,0) as caution_money,isnull(caution_deduction_money,0) as caution_deduction_money from contract_condition where contract_id='"+contract_id+"'";
System.out.println("sqlstr2==========================================================="+sqlstr);
rs=db.executeQuery(sqlstr);
while(rs.next()){
	period_type=getDBStr(rs.getString("period_type"));
	start_date=getDBDateStr(rs.getString("start_date"));
	caution_money=getDBStr(rs.getString("caution_money"));
	caution_deduction_money=getDBStr(rs.getString("caution_deduction_money"));
}rs.close();

if(period_type.equals("0")){
	min_date=start_date.substring(0,7);
}
//保证金抵扣
String r_list="";


if(!min_date.equals("") && !max_date.equals("")){
	if(period_type.equals("0")){
		sqlstr="insert into fund_contract_plan_temp select '"+contract_id+"',row_number() over (order by b.plan_date), b.plan_date,b.rent,b.corpus,b.year_rate,b.interest,0,0,0,0, '"+dqczy+"','"+curr_date+"','"+dqczy+"','"+curr_date+"', '偿还计划修改','"+curr_date+"','"+dqczy+"','"+doc_id+"' from ( select a.contract_id, isnull(a.plan_date,xjll_months.months+'-01') as plan_date, a.rent,a.corpus,a.year_rate,a.interest from xjll_months left join ( select contract_id,plan_date,rent,corpus,year_rate,interest from fund_rent_plan_temp where fund_rent_plan_temp.measure_id='"+doc_id+"' union select '"+contract_id+"','"+start_date+"',0,0,0,0)a on xjll_months.months=substring(convert(varchar(10),a.plan_date,121),1,7) where xjll_months.months>='"+min_date+"' and xjll_months.months<='"+max_date+"' )b";
		System.out.println("sqlstr3============================================"+sqlstr);
	}else{
		sqlstr="insert into fund_contract_plan_temp select '"+contract_id+"',row_number() over (order by b.plan_date), b.plan_date,b.rent,b.corpus,b.year_rate,b.interest,0,0,0,0, '"+dqczy+"','"+curr_date+"','"+dqczy+"','"+curr_date+"', '偿还计划修改','"+curr_date+"','"+dqczy+"','"+doc_id+"' from ( select a.contract_id, isnull(a.plan_date,xjll_months.months+'-01') as plan_date, a.rent,a.corpus,a.year_rate,a.interest from xjll_months left join ( select * from fund_rent_plan_temp where fund_rent_plan_temp.measure_id='"+doc_id+"' )a on xjll_months.months=substring(convert(varchar(10),a.plan_date,121),1,7) where xjll_months.months>='"+min_date+"' and xjll_months.months<='"+max_date+"' )b";
		System.out.println("sqlstr4==========================================================="+sqlstr);
	}
	
	//System.out.println("sqlstr================================="+sqlstr);
	db.executeUpdate(sqlstr);
	sqlstr="select isnull(caution_money,0)+isnull(first_payment,0)+isnull(handling_charge,0)+isnull(return_amt,0)+isnull(supervision_fee,0) as first_fund_in,isnull(equip_amt,0)+isnull(insurance_lessor,0)+isnull(consulting_fee,0)+isnull(other_fee,0) as first_fund_out,isnull(nominalprice,0) as end_fund_in,"+caution_money+"-"+caution_deduction_money+" as end_fund_out from contract_condition where contract_id='"+contract_id+"'";
	System.out.println("sqlstr5==========================================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		first_fund_in=getDBStr(rs.getString("first_fund_in"));
		first_fund_out=getDBStr(rs.getString("first_fund_out"));
		end_fund_in=getDBStr(rs.getString("end_fund_in"));
		end_fund_out=getDBStr(rs.getString("end_fund_out"));
	}rs.close();
	//保证金抵扣到第几期
	sqlstr="select dbo.bb_getDeduListCT('"+doc_id+"') as r_list";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		r_list=getDBStr(rs.getString("r_list"));
	}rs.close();
	
	sqlstr="update fund_contract_plan_temp set caution_deduction=rent where measure_id='"+doc_id+"' and plan_list>'"+r_list+"'";
	System.out.println("sqlstr6================================================"+sqlstr);
	db.executeUpdate(sqlstr);
	
	sqlstr="update fund_contract_plan_temp set caution_deduction="+caution_deduction_money+"-(select isnull(sum(rent),0) from fund_contract_plan_temp where measure_id='"+doc_id+"' and plan_list>'"+r_list+"') where measure_id='"+doc_id+"' and plan_list='"+r_list+"'";
	System.out.println("sqlstr7================================================"+sqlstr);
	db.executeUpdate(sqlstr);
	
	
	sqlstr="update fund_contract_plan_temp set fund_in="+first_fund_in+",fund_out="+first_fund_out+" where measure_id='"+doc_id+"' and plan_list=1";
	System.out.println("sqlstr8================================================"+sqlstr);
	db.executeUpdate(sqlstr);
	
	sqlstr="update fund_contract_plan_temp set fund_in="+end_fund_in+",fund_out="+end_fund_out+" where measure_id='"+doc_id+"' and plan_list='"+r_list+"'";
	System.out.println("sqlstr9================================================"+sqlstr);
	db.executeUpdate(sqlstr);
	
	
	sqlstr="update fund_contract_plan_temp set net_flow=isnull(rent,0)+isnull(fund_in,0)-isnull(fund_out,0)-isnull(caution_deduction,0) where measure_id='"+doc_id+"'";
	System.out.println("sqlstr10================================================"+sqlstr);
	db.executeUpdate(sqlstr);
}

if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>失败!");
			opener.location.reload();
		</script>
<%}%>