<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>
<%
String contract_id = getStr(request.getParameter("contract_id"));
String doc_id = getStr(request.getParameter("doc_id"));
String zfr_date = getStr(request.getParameter("zfr"));
String start_rent_list = getStr(request.getParameter("list"));
//本金假期月数
String month = "";
//剩余本金
String corpus = "";
//租赁年利率
String rate = "";
String sql = "";
int imonth = 0;
double dcorpus = 0;
double drate = 0;
double interest = 0;
sql = "select datediff(month,plan_date,'"+zfr_date+"') as diffmonth from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+start_rent_list;
System.out.println(sql);
ResultSet rsMonth = null;
rsMonth = db.executeQuery(sql);
if(rsMonth.next()){
	month = getDBStr(rsMonth.getString("diffmonth"));
}
if(month!=null&&!month.equals("")){
	imonth = Integer.parseInt(month);
}
rsMonth.close();
sql = "select sum(corpus) as corpus from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and rent_list>="+start_rent_list;
System.out.println(sql);
ResultSet rsSum = null;
rsSum = db.executeQuery(sql);
if(rsSum.next()){
	corpus = getDBStr(rsSum.getString("corpus"));
}
rsSum.close();
if(corpus!=null&&!corpus.equals("")){
	dcorpus = Double.parseDouble(corpus);
}
sql = "select year_rate from contract_condition where contract_id='"+contract_id+"'";
System.out.println(sql);
ResultSet rsRate = null;
rsRate = db.executeQuery(sql);
if(rsRate.next()){
	rate = getDBStr(rsRate.getString("year_rate"));
}
rsRate.close();
db.close();
if(rate!=null&&!rate.equals("")){
	drate = Double.parseDouble(rate);
}
System.out.println("dcorpus:"+dcorpus);
System.out.println("drate:"+drate);
System.out.println("imonth:"+imonth);
interest = dcorpus*drate*imonth/1200;
System.out.println("interest:"+interest);
 %>
<%=formatNumberDoubleTwo(interest)  %>