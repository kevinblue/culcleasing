<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db3" scope="page" class="dbconn.Conn" /> 
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
ResultSet rs1;
ResultSet rs3;
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );

List list = new ArrayList();
String contract_id="";
String penalty="";
String hire_date="";
String balance_mode="";
String hire_list="";

String rent_list="";
String penalty_overage="";
sqlstr="select distinct contract_id from v_etemp_contract_penalty order by contract_id";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	list.add(getDBStr(rs.getString("contract_id")));
}rs.close();
for(int i=0;i<list.size();i++){
	contract_id=list.get(i).toString().trim();
	sqlstr="select penalty,hire_date,balance_mode from v_etemp_contract_penalty where contract_id='"+contract_id+"' order by hire_date";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		penalty=getDBStr(rs.getString("penalty"));
		hire_date=getDBDateStr(rs.getString("hire_date"));
		balance_mode=getDBStr(rs.getString("balance_mode"));
		sqlstr="select rent_list,penalty_overage from etemp_fund_rent_plan_pena where contract_id='"+contract_id+"' and (penalty_overage)>0 order by rent_list";
		rs1=db1.executeQuery(sqlstr);
		
		
		while(rs1.next()){
			rent_list=getDBStr(rs1.getString("rent_list"));
			penalty_overage=getDBStr(rs1.getString("penalty_overage"));
			
			hire_list="0";
			sqlstr="select isnull(max(hire_list),0) as hire_list as  from etemp_fund_rent2 where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'";
			rs3=db3.executeQuery(sqlstr);
			if(rs3.next()){
				hire_list=getDBStr(rs3.getString("hire_list"));
			}rs3.close();
			hire_list=String.valueOf(Integer.parseInt(hire_list)+1);
			
			if(rnddouble(Double.parseDouble(penalty),2)<=rnddouble(Double.parseDouble(penalty_overage),2)){
				sqlstr="insert into etemp_fund_rent2(contract_id,plan_list,hire_list,hire_date,rent,corpus,interest,penalty,balance_mode) select '"+contract_id+"',"+rent_list+","+hire_list+",'"+hire_date+"',0,0,0,"+penalty+",'"+balance_mode+"'";
				db2.executeUpdate(sqlstr);
				sqlstr="update etemp_fund_rent_plan_pena set penalty_overage="+String.valueOf(rnddouble(Double.parseDouble(penalty_overage)-Double.parseDouble(penalty),2))+" where contract_id='"+contract_id+"' and rent_list="+rent_list;
				//System.out.println("sqlstr1====================="+sqlstr);
				db2.executeUpdate(sqlstr);
				rs1.last();
			}else{
				sqlstr="insert into etemp_fund_rent2(contract_id,plan_list,hire_list,hire_date,rent,corpus,interest,penalty,balance_mode) select '"+contract_id+"',"+rent_list+","+hire_list+",'"+hire_date+"',0,0,0,"+penalty_overage+",'"+balance_mode+"'";
				db2.executeUpdate(sqlstr);
				sqlstr="update etemp_fund_rent_plan set interest_overage=0,corpus_overage=0 where contract_id='"+contract_id+"' and rent_list="+rent_list;
				//System.out.println("sqlstr3====================="+sqlstr);
				db2.executeUpdate(sqlstr);
				penalty=String.valueOf(rnddouble(Double.parseDouble(penalty)-Double.parseDouble(penalty_overage),2));
			}
			
		}rs1.close();
	}rs.close();
}
//sqlstr="update etemp_fund_rent_plan set rent_overage=isnull(corpus_overage,0)+isnull(interest_overage,0)";
//db.executeUpdate(sqlstr);
//sqlstr="update etemp_fund_rent_plan set plan_status=case when rent_overage=0 then '已回笼' when rent_overage<isnull(rent,0) then '部分回笼' else '未回笼' end";
//db.executeUpdate(sqlstr);
db3.close();
db2.close();
db1.close();
db.close();
%>