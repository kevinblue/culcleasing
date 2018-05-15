<%@ page contentType="text/html; charset=gbk" language="java" %>

<%
//判断代理商还是租赁公司
String filterAgent = "";
String loginBmbh = "";//登录用户的部门编号
sqlstr="select bmbh from jb_yhxx where id='"+ dqczy +"'";
//sqlstr="select id,bmbh from jb_yhxx where id=''";
//执行查询
rs = db.executeQuery(sqlstr);
if (rs.next()){
	loginBmbh = rs.getString("bmbh");
	try{
		Integer.parseInt(loginBmbh);
	}catch(Exception e){//代理商
		filterAgent ="  and agent_id = '"+ loginBmbh +"' ";
	}
	if( "".equals(loginBmbh) ){//租赁物公司部门编号为数字或""
		filterAgent = "";
	}
}else {//错误操作
	System.out.println("++++权限丢失++++");
	//response.sendRedirect("/stleasing/public/relogin.jsp"); 
	//response.sendRedirect("http://test.strongflc.com/names.nsf?logout");
	//return;
%>
	<script language="javascript">
	window.parent.parent.location.replace("http://online.strongflc.com/names.nsf?logout");
	</script> 
<%
}
%>
