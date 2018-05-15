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
String plan_id=getStr(request.getParameter("plan_id"));
System.out.println("plan_id^^^^^^^^^^^^^^^^^^^^^"+plan_id);
System.out.println("czid&&&&&&&&&&&&&&&&&&&&&&"+czid);

String factoring = getStr(request.getParameter("factoring") );
String factoring_pringcipal = getStr(request.getParameter("factoring_pringcipal") );
String factoring_rantal=getStr(request.getParameter("factoring_rantal"));
String factoring_date=getStr(request.getParameter("factoring_date"));
String stype = getStr( request.getParameter("savetype") );
String systemDate = getSystemDate(0);


String contract_id="";
String rent_list="";
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间
if ( stype.equals("add") ){        //添加操作
	
		sqlstr = "insert into fund_rent_plan (factoring,factoring_pringcipal,factoring_rantal,factoring_date) values ('" + factoring + "','" + factoring_pringcipal + "','" + factoring_rantal + "','"+systemDate+"')";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		%>
		
<%
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
	//String czid = getStr( request.getParameter("id") );
	//String sql="select contract_id,rent_list from fund_rent_factoring where contract_id=(select contract_id from fund_rent_plan where id='"+czid+"') and rent_list=(select rent_list from fund_rent_plan where id='"+czid+"'))";
	String sql="select contract_id,rent_list from fund_rent_factoring frf where exists(select * from fund_rent_plan frp where frp.contract_id=frf.contract_id and frp.rent_list=frf.rent_list and frp.id='"+czid+"')";
	rs = db.executeQuery(sql); 
	if(rs.next()){
	contract_id=getDBStr(rs.getString("contract_id"));
	rent_list=getDBStr(rs.getString("rent_list"));
	sqlstr="update fund_rent_factoring set factoring='"+factoring+"',factoring_pringcipal='"+factoring_pringcipal+"',factoring_rantal='"+factoring_rantal+"',factoring_date='"+factoring_date+"',modificator='"+dqczy+"',modify_date='"+systemDate+"' where contract_id='"+contract_id+"' and rent_list='"+rent_list+"'";
	}else{
	sqlstr="insert into fund_rent_factoring(contract_id,rent_list,factoring,factoring_pringcipal,factoring_rantal,factoring_date,creator,create_date,modificator,modify_date)  ";
	sqlstr+="select contract_id,rent_list,'"+factoring+"','"+factoring_pringcipal+"','"+factoring_rantal+"','"+factoring_date+"','"+dqczy+"','"+systemDate+"','"+dqczy+"','"+systemDate+"' from fund_rent_plan where id='"+czid+"'";
	}
	rs.close();	
		System.out.println("sqlstrsqlstr=="+sqlstr);
		%>
		
<%
		db.executeUpdate(sqlstr);
%>
		<script>

opener.window.location.href = "factoring.jsp";
		alert("修改成功!");
		this.close();
		
				//window.close();
			//opener.alert("修改成功!");
		
			//opener.location.reload();
			
		</script>
<%
	
}
if ( stype.equals("del") ){         //删除操作
	
	
	sqlstr = "delete from fund_rent_plan where id='" + czid + "'";
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

