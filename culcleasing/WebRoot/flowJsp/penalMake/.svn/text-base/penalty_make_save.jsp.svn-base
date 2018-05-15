<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="com.tenwa.culc.util.*"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
	</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
	<BODY>
		<%
	//String dqczy = (String) session.getAttribute("czyid");//登陆人
	String stype = getStr( request.getParameter("savetype") );//操作类型
	System.out.println("传入类型"+stype);
	
	//获取参数
	String uuid=CommonTool.getUUID();
	String contract_id=getStr( request.getParameter("contract_id"));//合同编号
	String project_id=getStr( request.getParameter("proj_id"));//项目编号
	String rent_list=getStr( request.getParameter("rent_list"));//期次
	String penalty_rent=getStr( request.getParameter("penalty_rent") );//逾期租金
	String penalty_rent_planDate=getStr( request.getParameter("penalty_rent_planDate") );//计收日期
	String penalty_rent_hireDate=getStr( request.getParameter("penalty_rent_hireDate") );//实收日期
	//String penalty_day_amount=getStr( request.getParameter("penalty_day_amount") );//天数
	String penalty=getStr( request.getParameter("penalty") );//罚息
	
	//String datestr = getSystemDate(0); //获取系统时间
	String amount="";
	sqlstr="select DATEDIFF(dd,'"+penalty_rent_planDate+"','"+penalty_rent_hireDate+"') as amount";
	System.out.println("test111=========="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		amount=rs.getString("amount");
	}
	System.out.println("test=========="+amount);
	int flag = 0;
	String msg = "";
	if ( stype.equals("add") ){        //添加操作
	sqlstr = "insert into fund_penalty_hy_plan_medi";
	sqlstr += " values('"+contract_id+"','"+project_id+"','"+rent_list+"',"+
	"'"+penalty_rent+"','"+penalty_rent_planDate+"','"+penalty_rent_hireDate+"','"+amount+"','"+penalty+"')";
	System.out.println(sqlstr);
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "租金管理", "罚息制定", "新增：录入人员："+dqczy, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "新增其他流入";
}

if(flag>0){
%>
<script type="text/javascript">
	opener.alert("<%=msg%>成功!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
		<%
			} else {
		%>
		<script type="text/javascript">
		opener.alert("<%=msg%>失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
		<%
			}
		%>
	</BODY>
</HTML>
