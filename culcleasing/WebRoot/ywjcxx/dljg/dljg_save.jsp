<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String datestr = getSystemDate(0); //获取系统时间

String czid = getStr( request.getParameter("czid") );

String stype = getStr( request.getParameter("savetype") );

String agent_number = getStr( request.getParameter("agent_number") );
String agent_name = getStr( request.getParameter("agent_name") );
String double_flag = "0";

String sqlstr;
ResultSet rs;
 

if ( stype.equals("add") ){        //添加操作
		sqlstr = "select * from base_agent where agent_number='" + agent_number + "'";
		rs = db.executeQuery(sqlstr); 
		while ( rs.next() ) {
			double_flag = "1";
		} rs.close();
		if ( double_flag.equals("1") ) {
%>
		<script>
			alert("费用类型编号重复，请检查!");
			window.history.back();
		</script>
<%			
			return;
		}
		sqlstr = "insert into base_agent ( agent_number ,agent_name ,creator ,create_date ,modificator ,modify_date ) values ('" + agent_number + "','" + agent_name  + "','" + dqczy + "','" + datestr + "','" + dqczy + "','" + datestr + "')";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 


	sqlstr = "insert into inter_basic_agent (Fnumber,Fname,Fused,Fupdated) values ('"+agent_number+"','"+agent_name+"',0,1)";
	db.executeUpdate(sqlstr); 


%>
		<script>
			window.close();
			opener.alert("添加成功!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("mod") ){      //修改操作
	sqlstr = "select * from base_agent where agent_number <> '" + czid + "'";
	rs = db.executeQuery(sqlstr); 
	while ( rs.next() ) {
		if ( agent_number.equals( rs.getString("agent_number") ) ) {
			double_flag = "1";
			rs.afterLast();
		}
	} rs.close();
	if ( double_flag.equals("1") ) {
%>
	<script>
		alert("费用类型编号重复，请检查!");
		window.history.back();
	</script>
<%			
		return;
	}
	sqlstr = "update base_agent set agent_number='" + agent_number + "',agent_name='" + agent_name + "',modificator='" + dqczy + "',modify_date='" + datestr + "' where agent_number='" + czid + "'";
	//System.out.println("sqlstrsqlstr=="+sqlstr);
	db.executeUpdate(sqlstr);

	String FAccoName_temp="";
	String FAccoNumber_temp="";

    sqlstr="select * from inter_basic_agent where Fnumber='"+czid+ "'";
	rs = db.executeQuery(sqlstr); 
	if ( rs.next() ) 
	{
		FAccoName_temp=getDBStr( rs.getString("Fname") );	
	}
	rs.close();	
	if (!FAccoName_temp.equals(agent_name))
	{
		sqlstr="update inter_basic_agent set Fname='"+agent_name+"',Fupdated=1 where Fnumber='"+czid+ "'";
		db.executeUpdate(sqlstr);
	}
%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	sqlstr = "delete from base_agent where agent_number='" + czid + "'";
	db.executeUpdate(sqlstr);
%>
	<script>
		window.close();
		opener.alert("删除成功!");
		opener.location.reload();
	</script>
<%			
}
db.close();
%>


</BODY>
</HTML>