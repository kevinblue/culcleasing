<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//新增人
String czid = getStr( request.getParameter("czid") );//id
String systemDate = getSystemDate(0);

String sqlIds = getStr( request.getParameter("sqlIds") );//选择项

//收款单信息
String amt = getStr( request.getParameter("amt") );//收款金额
String amount = getStr( request.getParameter("amount") );//数量
String method = "11";//结算方式
	
String sqlstr="";
ResultSet rs = null;
int flag=0;
String message="";

String stype =  getStr( request.getParameter("savetype") );

if( "addEbankRent".equals(stype) ){//添加首付款
	//生成收款单号
	String glide_id="";
	sqlstr="select isnull(max(cast(no as int)),1)+1 as glide_id from GENERATE_NO where generate_type='网银租金收款'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		glide_id=getDBStr( rs.getString("glide_id") );
	}rs.close();
	sqlstr="insert into generate_no select '网银租金收款','"+systemDate+"','"+glide_id+"'";
	db.executeUpdate(sqlstr);
	glide_id = "EF"+systemDate+"-"+glide_id;
		
	//插入申请信息 - 网银资金收款
	sqlstr="insert into apply_info (glide_id,type,is_sub,flow_status,status,amt,amount,plan_date,pay_method,creator,create_date) ";
	sqlstr+="values(";
	sqlstr+="'"+glide_id+"','网银租金收款','未提交','未通过','未核销','"+amt+"','"+amount+"','"+systemDate+"',";
	sqlstr+="'"+method+"','"+dqczy+"','"+systemDate+"') ";
	LogWriter.logDebug(request, "新增收款单："+sqlstr);
	//执行语句
	flag += db.executeUpdate(sqlstr);

	//添加明细表记录
	sqlstr =" insert into apply_info_detail(plan_id,apply_id,contract_id,creator,create_date) ";
	sqlstr+=" select id,'"+glide_id+"',contract_id,'"+dqczy+"','"+systemDate+"' from vi_ebank_rent_hire ";
	sqlstr+=" where id in("+sqlIds+") ";
	flag += db.executeUpdate(sqlstr);
	//修改租金计划表flag字段值为2  -- 2表示网银租金
	sqlstr = "  Update fund_rent_plan set state=2 where cast(id as varchar(50)) in("+sqlIds+")";
	//sqlstr += " Update fund_penalty_plan set state=2 where uuid in("+sqlIds+")";
	flag += db.executeUpdate(sqlstr);
	
	//日志操作
	String sqlLog = LogWriter.getSqlIntoDB(request, "租金投放管理", "网银租金收款", dqczy+"用户进行网银租金收款，收款金额:"+amt+", 款项数量："+amount, sqlstr);
	db.executeUpdate(sqlLog);
	
	message="添加网银租金收款";
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
<%}
db.close();%>
</BODY>
</HTML>