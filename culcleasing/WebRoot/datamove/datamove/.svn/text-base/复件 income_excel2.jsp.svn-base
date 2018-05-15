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
String p_contract_id = getStr( request.getParameter("contract_id") );

String i_count="";
//如果合同号不在etemp_fund_rent中不做任何操作
sqlstr="select count(*) as i_count from etemp_fund_rent where contract_id='"+p_contract_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	i_count=getDBStr(rs.getString("i_count"));
}rs.close();
if(i_count.equals("0")){
	%>
	<script>
		window.close();
		opener.alert("该合同并不在可修改之列!");
		opener.location.reload();
	</script>
	<%
	db.close();
	db1.close();
	db2.close();
	db3.close();
	return;
}

List list = new ArrayList();
String contract_id="";
String rent="";
String fin_date="";
String hire_date="";
String balance_mode="";
String hire_list="";

String rent_list="";
String corpus_overage="";
String interest_overage="";

String instead_flag="";

//修改偿还计划剩余租金,剩余本金,剩余利息,状态
sqlstr="update fund_rent_plan set rent_overage=isnull(rent,0),corpus_overage=isnull(corpus,0),interest_overage=isnull(interest,0),plan_status='未回笼' where contract_id='"+p_contract_id+"'";
db.executeUpdate(sqlstr);
//删除回笼表中的相关数据
sqlstr="delete from fund_rent_income where contract_id='"+p_contract_id+"'";
db.executeUpdate(sqlstr);
//删除资金表中保证金抵扣租金的数据
sqlstr="delete from fund_fund_charge where contract_id='"+p_contract_id+"' and fee_type='108' and settle_method='BalanceWay8' and item_method ='退款'";
db.executeUpdate(sqlstr);

sqlstr="select distinct contract_id from etemp_fund_rent where contract_id='"+p_contract_id+"' order by contract_id";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	list.add(getDBStr(rs.getString("contract_id")));
}rs.close();
for(int i=0;i<list.size();i++){
	contract_id=list.get(i).toString().trim();
	sqlstr="select rent,fin_date,hire_date,balance_mode,instead_flag from etemp_fund_rent where contract_id='"+contract_id+"' order by hire_date";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		rent=getDBStr(rs.getString("rent"));
		hire_date=getDBDateStr(rs.getString("hire_date"));
		fin_date=getDBDateStr(rs.getString("fin_date"));
		balance_mode=getDBStr(rs.getString("balance_mode"));
		instead_flag=getDBStr(rs.getString("instead_flag"));
		if(balance_mode.equals("1")){
			balance_mode="BalanceWay8";
		}else{
			balance_mode="";
		}
		
		if(instead_flag.equals("1")){
			instead_flag="是";
		}else{
			instead_flag="否";
		}

		

		sqlstr="select rent_list,corpus_overage,interest_overage from fund_rent_plan where contract_id='"+contract_id+"' and (corpus_overage+interest_overage)>0 order by rent_list";
		rs1=db1.executeQuery(sqlstr);

		while(rs1.next()){
			
			rent_list=getDBStr(rs1.getString("rent_list"));
			interest_overage=getDBStr(rs1.getString("interest_overage"));
			corpus_overage=getDBStr(rs1.getString("corpus_overage"));

			hire_list="0";
			sqlstr="select isnull(max(hire_list),0) as hire_list  from fund_rent_income where contract_id='"+contract_id+"' and plan_list='"+rent_list+"'";
			rs3=db3.executeQuery(sqlstr);
			if(rs3.next()){
				hire_list=getDBStr(rs3.getString("hire_list"));
			}rs3.close();
			hire_list=String.valueOf(Integer.parseInt(hire_list)+1);

			System.out.println(Double.parseDouble(rent)-(Double.parseDouble(interest_overage)+Double.parseDouble(corpus_overage)));
			
			if(rnddouble(Double.parseDouble(rent),2)<=rnddouble(Double.parseDouble(interest_overage),2)){


				sqlstr="insert into fund_rent_income(contract_id,plan_list,hire_list,hire_date,accounting_date,rent,corpus,interest,balance_mode,instead_flag) select '"+contract_id+"',"+rent_list+","+hire_list+",'"+hire_date+"','"+fin_date+"',"+rent+",0,"+rent+",'"+balance_mode+"','"+instead_flag+"'";
				db2.executeUpdate(sqlstr);
				sqlstr="update fund_rent_plan set interest_overage="+String.valueOf(rnddouble(Double.parseDouble(interest_overage)-Double.parseDouble(rent),2))+" where contract_id='"+contract_id+"' and rent_list="+rent_list;
				//System.out.println("sqlstr1====================="+sqlstr);
				db2.executeUpdate(sqlstr);
				rs1.last();
			}else if(rnddouble(Double.parseDouble(rent),2)<=rnddouble((Double.parseDouble(interest_overage)+Double.parseDouble(corpus_overage)),2)){
				sqlstr="insert into fund_rent_income(contract_id,plan_list,hire_list,hire_date,accounting_date,rent,corpus,interest,balance_mode,instead_flag) select '"+contract_id+"',"+rent_list+","+hire_list+",'"+hire_date+"','"+fin_date+"',"+rent+","+String.valueOf(rnddouble(Double.parseDouble(rent)-Double.parseDouble(interest_overage),2))+","+interest_overage+",'"+balance_mode+"','"+instead_flag+"'";
				db2.executeUpdate(sqlstr);
				sqlstr="update fund_rent_plan set interest_overage=0,corpus_overage="+String.valueOf(rnddouble(Double.parseDouble(corpus_overage)+Double.parseDouble(interest_overage)-Double.parseDouble(rent),2))+" where contract_id='"+contract_id+"' and rent_list="+rent_list;
				//System.out.println("sqlstr2====================="+sqlstr);
				db2.executeUpdate(sqlstr);
				rs1.last();
			}else{
				sqlstr="insert into fund_rent_income(contract_id,plan_list,hire_list,hire_date,accounting_date,rent,corpus,interest,balance_mode,instead_flag) select '"+contract_id+"',"+rent_list+","+hire_list+",'"+hire_date+"','"+fin_date+"',"+String.valueOf(rnddouble(Double.parseDouble(corpus_overage)+Double.parseDouble(interest_overage),2))+","+corpus_overage+","+interest_overage+",'"+balance_mode+"','"+instead_flag+"'";
				db2.executeUpdate(sqlstr);
				sqlstr="update fund_rent_plan set interest_overage=0,corpus_overage=0 where contract_id='"+contract_id+"' and rent_list="+rent_list;
				//System.out.println("sqlstr3====================="+sqlstr);
				db2.executeUpdate(sqlstr);
				rent=String.valueOf(rnddouble(Double.parseDouble(rent)-Double.parseDouble(corpus_overage)-Double.parseDouble(interest_overage),2));
			}
		}rs1.close();
	}rs.close();
}
//修改代付金额
sqlstr="update fund_rent_income set instead_amt=rent where contract_id='"+p_contract_id+"' and instead_flag='是'";
db.executeUpdate(sqlstr);

sqlstr="update fund_rent_income set accounting_date=NULL where contract_id='"+p_contract_id+"' and accounting_date='1900-01-01'";
db.executeUpdate(sqlstr);
sqlstr="update fund_rent_plan set rent_overage=isnull(corpus_overage,0)+isnull(interest_overage,0) where contract_id='"+p_contract_id+"'";
db.executeUpdate(sqlstr);
sqlstr="update fund_rent_plan set plan_status=case when rent_overage=0 then '已回笼' when rent_overage<isnull(rent,0) then '部分回笼' else '未回笼' end where contract_id='"+p_contract_id+"'";
db.executeUpdate(sqlstr);
//插入资金表中相关保证金抵扣租金数据
sqlstr="insert into fund_fund_charge(contract_id,fee_type,settle_method,fact_date,fact_money,currency,accounting_date,item_method) select contract_id,'108','BalanceWay8',hire_date,rent,'Currency1',accounting_date,'退款' from fund_rent_income where contract_id='"+p_contract_id+"' and balance_mode='BalanceWay8'";
db.executeUpdate(sqlstr);


db3.close();
db2.close();
db1.close();
db.close();
%>
<script>
		window.close();
		opener.alert("已经生成了新的回笼，请确认!");
		opener.location.reload();
	</script>