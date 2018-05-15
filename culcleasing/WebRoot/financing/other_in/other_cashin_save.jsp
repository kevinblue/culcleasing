<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
	</head>

	<BODY>
		<%
String dqczy = (String) session.getAttribute("czyid");//登陆人
String stype = getStr( request.getParameter("savetype") );//操作类型
System.out.println("传入类型"+stype);

//获取参数
String start_date=getStr( request.getParameter("start_date"));//起始日期
String end_date=getStr( request.getParameter("end_date"));//结束日期
String cash_money=getStr( request.getParameter("cash_money"));//流入金额
String remark=getStr( request.getParameter("remark") );//备注

String sqlstr;
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;
String msg = "";
if ( stype.equals("add") ){        //添加操作
	//insert
	sqlstr = "insert into dbo.financing_cash_flow(start_date,end_date,cash_money,remark,cash_flow_way,creator,create_date,modificator,modify_date)";
	sqlstr += " values('"+start_date+"','"+end_date+"','"+cash_money+"','"+remark+"','其他流入','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
	//System.out.println(sqlstr);
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "其他操作", "其他流入制定", "新增：录入人员："+dqczy, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "新增其他流入";
}else if("del".equals(stype)){//删除
	String id = getStr( request.getParameter("id") );
	System.out.println("传入id"+id);
	sqlstr = "delete from dbo.financing_cash_flow where id='"+id+"'";
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "其他操作", "其他流入制定", "删除，id号为："+id, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "删除";
}else if ("mod".equals(stype)){//修改
	String id =  getStr( request.getParameter("id") );
	
	sqlstr = "update dbo.financing_cash_flow set start_date='"+start_date+"',end_date='"+end_date+"',cash_money='"+cash_money+"',remark='"+remark+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+id+"'";
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "其他操作", "其他流入制定", "修改，id号为："+id, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "修改";
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
