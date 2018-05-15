<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );

String contract_str = getStr(request.getParameter("contract_str") );
String rent_str = getStr(request.getParameter("rent_str") );
String reason_str = getStr(request.getParameter("reason_str") );

String stype = getStr( request.getParameter("savetype") );
String systemDate = getSystemDate(0);



String sqlstr;
ResultSet rs;
int flag=0;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){        //添加操作
		String a[]=contract_str.split("#");
		String b[]=rent_str.split("#");
		String c[]=reason_str.split("#");
		for(int i=0;i<a.length;i++){
		String sql="select * from statistical_overdue where contract_id='"+a[i]+"' and rent_list='"+b[i]+"'";
		rs=db.executeQuery(sql); 
		if(rs.next()){
		sqlstr="update statistical_overdue set reason='"+c[i]+"', modificator='"+systemDate+"',modify_date='"+systemDate+"' where contract_id='"+a[i]+"' and rent_list='"+b[i]+"'";
		}else{
		sqlstr = "insert into statistical_overdue (contract_id,rent_list,reason,modificator,modify_date,creator,create_date) values ('" + a[i]+ "','" + b[i] + "','" + c[i] + "','"+systemDate+"','"+czid+"','"+systemDate+"','"+czid+"')";
			}
		System.out.println("sqlstrsqlstr=="+sqlstr);
		flag+=db.executeUpdate(sqlstr); 
		rs.close();
			
		}
}

%>
		<script>
        opener.window.location.href = "overdue.jsp";
		alert("修改成功!");
		this.close();  
		</script>

		<%	

db.close();
%>

		
</BODY>
</html>

