<%@ page contentType="text/html; charset=gbk" language="java" %>

<%
//判断session是否丢失
if( dqczy!=null && !"".equals(dqczy) ){
	//判断代理商还是租赁公司
	String filterAgent = "";
	String loginBmbh = "";//登录用户的部门编号
	sqlstr="select bmbh from jb_yhxx where id='"+ dqczy +"'";
	//执行查询
	rs = db.executeQuery(sqlstr);
	if (rs.next()){
		loginBmbh = rs.getString("bmbh");
		try{
			Integer.parseInt(loginBmbh);
		}catch(Exception e){//代理商
			filterAgent ="  and bmbh = '"+ loginBmbh +"' ";
		}
		if( "".equals(loginBmbh) ){//租赁物公司部门编号为数字或""
			filterAgent = "";
		}
	}else {//错误操作
		System.out.println("++++权限丢失++++");
	}
}else{%>
	<script language="javascript">
	window.parent.parent.location.replace("http://online.strongflc.com/names.nsf?logout");
	</script> 
<%
}
%>
