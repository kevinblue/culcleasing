<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
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
String dqczy = (String) session.getAttribute("czyid");
String stype = getStr( request.getParameter("savetype") );

//获取参数
String proj_id;
String raiser;
String dutier;
String raiser_date;
String operation_dept;
String flow;
String idea;
String check_man;
proj_id = getStr( request.getParameter("proj_id") );
raiser = getStr( request.getParameter("raiser") );
dutier=getStr( request.getParameter("dutier") );
raiser_date = getStr( request.getParameter("raiser_date") );
operation_dept = getStr( request.getParameter("operation_dept") );
flow = getStr( request.getParameter("flow") );
idea = getStr( request.getParameter("idea") );
check_man=getStr( request.getParameter("check_man") );

System.out.println("测试check——man"+check_man);
String sqlstr;
String datestr = getSystemDate(0); //获取系统时间
int flag = 0;
String msg = "";
if(!check_man.equals("") && check_man!=null){
	ResultSet rs=null;
	String sqlStr="SELECT * FROM dbo.v_base_user_group WHERE group_name ='公司领导审批' and user_id='"+dqczy+"'";
	rs=db.executeQuery(sqlStr);
	System.out.print("测试"+sqlStr);
	if(rs.next()){
		if ( stype.equals("add") ){        //添加操作
			//insert
			sqlstr = "insert into opinion_execution(proj_id,raiser,dutier,raiser_date,idea,check_man,operation_dept,flow,status,creator,create_date,modificator,modify_date)";
			sqlstr += " values('"+proj_id+"','"+raiser+"','"+dutier+"','"+raiser_date+"','"+idea+"','"+check_man+"','"+operation_dept+"','"+flow+"',0,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
			System.out.println("我要的sql"+sqlstr);
			flag = db.executeUpdate(sqlstr);
			
			String sqlLog = LogWriter.getSqlIntoDB(request, "其他功能", "意见执行监控", "新增项目："+proj_id+" 意见，提出人："+raiser, sqlstr);
			db.executeUpdate(sqlLog);
			db.close();
			
			msg = "新增项目执行意见";
		}else if ("mod".equals(stype)){//修改
			String kid =  getStr( request.getParameter("kid") );
			
			sqlstr = "update opinion_execution set raiser='"+raiser+"',dutier='"+dutier+"',raiser_date='"+raiser_date+"',operation_dept='"+operation_dept+"',flow='"+flow+"',idea='"+idea+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+kid+"'";
			flag = db.executeUpdate(sqlstr);
			System.out.println("我要的sql"+sqlstr);
			String sqlLog = LogWriter.getSqlIntoDB(request, "其他功能", "意见执行监控", "修改项目意见，id号为："+kid, sqlstr);
			db.executeUpdate(sqlLog);
			db.close();
			
			msg = "修改项目执行意见";
		}
	}else{
		msg = "抱歉，您没有权限填写意见核实人员！";
	}
}else{
	if ( stype.equals("add") ){        //添加操作
			//insert
			sqlstr = "insert into opinion_execution(proj_id,raiser,dutier,raiser_date,idea,operation_dept,flow,status,creator,create_date,modificator,modify_date)";
			sqlstr += " values('"+proj_id+"','"+raiser+"','"+dutier+"','"+raiser_date+"','"+idea+"','"+operation_dept+"','"+flow+"',0,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"')";
			System.out.println("我要的sql"+sqlstr);
			flag = db.executeUpdate(sqlstr);
			
			String sqlLog = LogWriter.getSqlIntoDB(request, "其他功能", "意见执行监控", "新增项目："+proj_id+" 意见，提出人："+raiser, sqlstr);
			db.executeUpdate(sqlLog);
			db.close();
			
			msg = "新增项目执行意见";
		}else if ("mod".equals(stype)){//修改
			String kid =  getStr( request.getParameter("kid") );
			
			sqlstr = "update opinion_execution set raiser='"+raiser+"',dutier='"+dutier+"',raiser_date='"+raiser_date+"',operation_dept='"+operation_dept+"',flow='"+flow+"',idea='"+idea+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+kid+"'";
			flag = db.executeUpdate(sqlstr);
			System.out.println("我要的sql"+sqlstr);
			String sqlLog = LogWriter.getSqlIntoDB(request, "其他功能", "意见执行监控", "修改项目意见，id号为："+kid, sqlstr);
			db.executeUpdate(sqlLog);
			db.close();
			
			msg = "修改项目执行意见";
		}
}
if ("suc".equals(stype)){//完成
	String kid =  getStr( request.getParameter("kid") );
	String result =  getStr( request.getParameter("result") );
	String end_time =  getStr( request.getParameter("end_time") );
	String remark =  getStr( request.getParameter("remark") );
	
	sqlstr = "update opinion_execution set status=1,result='"+result+"',end_time='"+end_time+"',remark='"+remark+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+kid+"'";
	flag = db.executeUpdate(sqlstr);
	System.out.println("我要的sql"+sqlstr);
	String sqlLog = LogWriter.getSqlIntoDB(request, "其他功能", "意见执行监控", "项目意见完成，id号为："+kid, sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "完成项目执行意见";
}else if("del".equals(stype)){//删除意见
	String item_id = getStr( request.getParameter("item_id") );

	sqlstr = "delete from opinion_execution where id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "其他功能", "意见执行监控", "删除项目意见，id号为："+item_id, sqlstr);
	System.out.println("我要的sql"+sqlstr);
	db.executeUpdate(sqlLog);
	db.close();
	
	msg = "删除项目执行意见";
}
	System.out.print(flag);
if(flag>0){
%>
	<script type="text/javascript">
		window.alert("<%=msg %>");
		//window.location.reload();
		window.location.replace("opinion_detail.jsp?proj_id=<%=proj_id %>");
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.alert("<%=msg %>");
		//window.location.reload();
		window.location.replace("opinion_detail.jsp?proj_id=<%=proj_id %>");
	</script>
<%} %>
</BODY>
</HTML>
