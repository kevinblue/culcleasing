<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%@ page import="com.*" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>

</head>

<BODY>
<%
String sqlstr;
int i;
String exchange_rate;
String interest_rate;
String amout;



String czy=(String) session.getAttribute("czyid");

String id=getStr(request.getParameter("id"));

//获取系统时间
String datestr=getSystemDate(1); 

    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {          
		  
            exchange_rate=getStr(request.getParameter("exchange_rate"));
            interest_rate=getStr(request.getParameter("interest_rate"));  
            amout=getStr(request.getParameter("amout"));
          
            sqlstr="insert into foreign_currency(exchange_rate,interest_rate,amout)";
            sqlstr+=" values ('"+exchange_rate+"','"+interest_rate+"','"+amout+"')";
			System.out.println("ttt"+sqlstr);
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
            id=getStr(request.getParameter("id"));
           
                  
          exchange_rate=getStr(request.getParameter("exchange_rate"));
            interest_rate=getStr(request.getParameter("interest_rate"));  
            amout=getStr(request.getParameter("amout"));
            
         
            
            sqlstr="update foreign_currency set exchange_rate='"+exchange_rate+"',interest_rate='"+interest_rate+"',amout='"+amout+"'";
			sqlstr+=" where id="+id;
			System.out.println(sqlstr);
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
            czy=getStr(request.getParameter("id"));
            sqlstr="delete from foreign_currency where id="+id;
            i=db.executeUpdate(sqlstr); 
			

%>
	<script>
                window.close();
                opener.alert("删除成功!");
		opener.location.reload();
	</script>
<%			
       }
}
db.close();
%>


</BODY>
</HTML>
