
<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.util.CommonTool"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//自动生成保费资金计划
//===========================================
	

//获取参数
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String item1 = getStr( request.getParameter("item1") );//投保金额
String item2 = getStr( request.getParameter("item2") );//投保期限

String sqlstr="";
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
ResultSet rs = null;
 
//目前天安针对我司的医疗、教育、印刷传媒相关设备，投保一切险的“年费率”为a=0.02%  。
double aI = 0.0002;
//1.判断投保期限关系
int tbQx = Integer.parseInt(item2);
double bfM = 0d;
if( tbQx<12 ){//投保期限小于1年
	System.out.println(" 投保期限小于1年 ");
	//当一次性投保期限n<1年时，比如一个月，参照短期费率表，投保一个月“年费率的百分比”为10%，
	//则保险费计算如下，先计算M*(a*10%)/2，四舍五入小数点后保留两位结果为N，2*N为保费金额。
	double pa2 = 0d;
	switch( tbQx )
	{
	case 1: pa2 = 0.1;
	case 2: pa2 = 0.2;
	case 3: pa2 = 0.3;
	case 4: pa2 = 0.4;
	case 5: pa2 = 0.5;
	case 6: pa2 = 0.6;
	case 7: pa2 = 0.7;
	case 8: pa2 = 0.8;
	case 9: pa2 = 0.85;
	case 10: pa2 = 0.90;
	case 11: pa2 = 0.95;
	case 12: pa2 = 1;
	
	default: pa2 = 0.1;
	}
	
	bfM = MathExtend.parseDouble( MathExtend.divide( (MathExtend.multiply(item1, String.valueOf(aI * pa2) )), "2", 2 ) );
}else if( tbQx%12==0){//整年
	System.out.println(" 整年 ");
	//当一次性投保期限n为整年，比如n=1或2或3……，则保险费计算如下，
	//先计算M*(n*a)/2元，四舍五入小数点后保留两位结果为N，2*N为保费金额。
	bfM = MathExtend.parseDouble( MathExtend.divide( (MathExtend.multiply(item1, String.valueOf(aI * (tbQx/12)) )), "2", 2 ) );
	System.out.println((tbQx/12)+"cesuan sad"+MathExtend.multiply(item1, String.valueOf(0.0022 * (tbQx/12)) ));
	
}else{//非整年有余数
	System.out.println(" 非整年有余数 ");
	//当一次性投保期限不为整年且大于1年时，比如一次性投保期限为n年1个月，参照短期费率表，
	//则保险费计算如下，先计算M*(n+10%)*a /2，四舍五入小数点后保留两位结果为N，2*N为保费金额。
	double pa2 = 0d;
	switch( tbQx%12 )
	{
	case 1: pa2 = 0.1;
	case 2: pa2 = 0.2;
	case 3: pa2 = 0.3;
	case 4: pa2 = 0.4;
	case 5: pa2 = 0.5;
	case 6: pa2 = 0.6;
	case 7: pa2 = 0.7;
	case 8: pa2 = 0.8;
	case 9: pa2 = 0.85;
	case 10: pa2 = 0.90;
	case 11: pa2 = 0.95;
	case 12: pa2 = 1;
	
	default: pa2 = 0.1;
	}
	
	bfM = MathExtend.parseDouble( MathExtend.divide( (MathExtend.multiply(item1, String.valueOf(aI * ((tbQx/12) + pa2 )) )), "2", 2 ) );
}
System.out.println("金额："+bfM);
	
//获取基础参数
String cust_name = getStr( request.getParameter("cust_name") );

//获取资金计划数据参数
String id = "";
String pay_way = "付款";//款项方式
String fee_type = "26";//款项内容

//保费不做超过判断 2012-3-27 Jaffe
//2.1先查询出已经生产资金计划的金额
int fee_num = 0;
sqlstr = "select count(fee_num) as fee_num from contract_fund_fund_charge_plan_bxf_temp";
sqlstr+= " where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and fee_type='"+fee_type+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	fee_num = rs.getInt("fee_num");
}
rs.close();

String fee_name = "自付保险费"+fee_num;
String pay_obj = "0870060127"; //159 1032 2128
String pay_bank_name = "建行北京阜成路支行";
String pay_bank_no = "11001085400059611337";
String plan_bank_name = "";
String plan_bank_no = "";
String plan_date = datestr;
String currency = "currency_type1";
String plan_money = String.valueOf(bfM*2);
String pay_type = "01";
String fpnote = ".";

//2.2删除历史
sqlstr = "Delete from contract_fund_fund_charge_plan_bxf_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
//2.3插入资金计划
sqlstr = "insert into contract_fund_fund_charge_plan_bxf_temp(make_contract_id,payment_id,doc_id,contract_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,curr_plan_money,plan_money,currency,pay_obj,";
sqlstr+=" pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)";
// 付款 -- 设备款
sqlstr+=" select '"+id+"','"+CommonTool.getUUID()+"','"+doc_id+"','"+contract_id+"','"+pay_type+"','"+fee_type+"','"+fee_name+"','"+(fee_num+1)+"','"+plan_date+"','未核销','"+plan_money+"','"+plan_money+"','"+currency+"','"+pay_obj+"',";
sqlstr+="'"+pay_bank_name+"','"+pay_bank_no+"','"+plan_bank_name+"','"+plan_bank_no+"','"+pay_way+"','"+fpnote+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
flag = db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "插入新的资金计划款项名称：自动生成[保费资金付款] 款项金额："+plan_money+"___"+sqlstr);

String sqlLog = LogWriter.getSqlIntoDB(request, "付款保费资金计划制定", "自动生成资金计划", "插入新的资金计划款项名称：[保费资金付款]款项金额："+plan_money, sqlstr.substring(0,20));
db.executeUpdate(sqlLog);

db.close();

//3返回判断
if(flag>0){%>
<script type="text/javascript">
	opener.alert("资金计划 [保费资金] 生成成功!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>	
<%}else{
%>
<script type="text/javascript">
	opener.alert("资金计划  [保费资金]  生成失败!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}	
</script>
<%} %>
</BODY>
</HTML>
