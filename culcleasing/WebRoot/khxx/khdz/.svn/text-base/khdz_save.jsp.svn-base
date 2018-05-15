<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>
<BODY>
<%
String sqlstr;
ResultSet rs;
String czy_name="";
String czy=(String) session.getAttribute("czyid");
System.out.println(czy+"122222222222222");
sqlstr="select name from base_user where id='"+czy+"' ";
//sqlstr=" select xm from jb_yhxx where id='"+czy+"' ";
rs=db.executeQuery(sqlstr); 
if(rs.next()) 
{
	//czy_name=getDBStr(rs.getString("xm"));
          czy_name=getDBStr(rs.getString("name"));
}
int i;
String czid;
String cust_id;
String cust_name;
String short_name;
String cust_num;
String modify_date;
String modificator;

//获取系统时间
String datestr=getSystemDate(1);
//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            cust_id=getStr(request.getParameter("cust_id"));
            cust_name=getStr(request.getParameter("cust_name"));
            short_name=getStr(request.getParameter("short_name"));
			cust_num=getStr(request.getParameter("cust_num"));
            sqlstr="insert into inter_cust_info(cust_id,cust_name,short_name,cust_num,modify_date,modificator) values ('"+cust_id+"','"+cust_name+"','"+short_name+"','"+cust_num+"',"+datestr+",'"+czy_name+"')";
            System.out.println("======="+sqlstr);
            i=db.executeUpdate(sqlstr); 
			%>
				<script>
                window.close();
                opener.alert("添加成功!");
				opener.location.reload();
				</script>
            <%           
       }
       if (stype.indexOf("mod")>=0)      //修改操作
       {
       			czid=getStr(request.getParameter("kid"));
            cust_id=getStr(request.getParameter("cust_id"));
            cust_name=getStr(request.getParameter("cust_name"));
            short_name=getStr(request.getParameter("short_name"));
			cust_num=getStr(request.getParameter("cust_num"));
            sqlstr="update inter_cust_info set cust_id='"+cust_id+"',cust_name='"+cust_name+"',short_name='"+short_name+"',cust_num='"+cust_num+"',modify_date="+datestr+",modificator='"+czy_name+"' where id='"+czid+"'";
            i=db.executeUpdate(sqlstr);
			%>
				<script>
                window.close();
                opener.alert("修改成功!");
				opener.location.reload();
				</script>
			<%
       }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            czid=getStr(request.getParameter("id"));
            sqlstr="delete from inter_cust_info where id='"+czid+"'";
            i=db.executeUpdate(sqlstr);
			%>
				<script>
                window.close();
                opener.alert("删除成功!");
				opener.location.reload();
				</script>
			<%
       }   
%>
<%
}
db.close();
%>
</BODY>
</HTML>