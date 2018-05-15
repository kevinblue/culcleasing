<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String sqlstr;
int i;
String czid;
String type_id;
String order_number;
String indicator_def;
String weighting;
String standard_value;
String standard_value_disp;
String ratio_relation;
String limitation;
String his_flag;
ResultSet rs;

String czy=(String) session.getAttribute("czyid");

//获取系统时间
String datestr=getSystemDate(1); 

    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {

            type_id=getStr(request.getParameter("type_id"));
            order_number=getStr(request.getParameter("order_number"));
            indicator_def=getStr(request.getParameter("indicator_def"));
            weighting=getStr(request.getParameter("weighting"));
            standard_value=getStr(request.getParameter("standard_value"));
            standard_value_disp=getStr(request.getParameter("standard_value_disp"));
            ratio_relation=getStr(request.getParameter("ratio_relation"));
            limitation=getStr(request.getParameter("limitation"));
            his_flag=getStr(request.getParameter("his_flag"));

            if (order_number.equals("")) order_number="0";
            if (weighting.equals("")) weighting="Null";
            if (standard_value.equals("")) standard_value="Null";               
 
            sqlstr="insert into perf_assessment_model(type_id,order_number,indicator_def,weighting,standard_value,standard_value_disp, ratio_relation, ";
            sqlstr+=" limitation, his_flag, creator, create_date, modificator, modify_date)";
            sqlstr+=" values ("+type_id+","+order_number+",'"+indicator_def+"',"+weighting+","+standard_value+",'"+standard_value_disp+"','";
            sqlstr+=ratio_relation+"','"+limitation+"','"+his_flag+"','"+czy+"',"+datestr+",'"+czy+"',"+datestr+")";
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
            czid=getStr(request.getParameter("id"));
            type_id=getStr(request.getParameter("type_id"));
            order_number=getStr(request.getParameter("order_number"));
            indicator_def=getStr(request.getParameter("indicator_def"));
            weighting=getStr(request.getParameter("weighting"));
            standard_value=getStr(request.getParameter("standard_value"));
            standard_value_disp=getStr(request.getParameter("standard_value_disp"));
            ratio_relation=getStr(request.getParameter("ratio_relation"));
            limitation=getStr(request.getParameter("limitation"));
            his_flag=getStr(request.getParameter("his_flag"));

            if (order_number.equals("")) order_number="0";
            if (weighting.equals("")) weighting="Null";
            if (standard_value.equals("")) standard_value="Null"; 
	
            sqlstr="update perf_assessment_model set type_id="+type_id+",order_number="+order_number+",indicator_def='"+indicator_def+"',weighting=";
            sqlstr+=weighting+",standard_value="+standard_value+",standard_value_disp='"+standard_value_disp+"',ratio_relation='"+ratio_relation;
            sqlstr+="',limitation='"+limitation+"',his_flag='"+his_flag+"',modificator='"+czy+"',modify_date="+datestr+" where id="+czid;
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
            sqlstr="delete from perf_assessment_model where id="+czid;
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
