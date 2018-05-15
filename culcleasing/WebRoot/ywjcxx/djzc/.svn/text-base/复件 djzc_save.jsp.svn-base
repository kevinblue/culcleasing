<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>
<BODY>
<%
String sqlstr;
String returnStr="";
String returnStr1="";
String num="";

ResultSet rs;
String czy_name="";
String code="";
String czy=(String) session.getAttribute("czyid");
sqlstr=" select xm from jb_yhxx where id='"+czy+"'";
rs=db.executeQuery(sqlstr); 
if(rs.next()) 
{
	czy_name=getDBStr(rs.getString("xm"));
}

int i;
String czid;

String name;



//获取系统时间
String datestr=getSystemDate(1);
//try {
    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
			
            code=getStr(request.getParameter("code"));
            name=getStr(request.getParameter("name"));
            sqlstr="select count(*) as num from base_cust_regtype where code='"+code+"'";
            rs=db.executeQuery(sqlstr);
            if(rs.next())
           {
                 num = getDBStr(rs.getString("num"));
           }
                 if (num=="1"){
				returnStr1 ="登记注册类型编码已存在,无法添加";
			}else{
				sqlstr="insert into base_cust_regtype(code,name) values ('"+code+"','"+name+"')";
                                 i=db.executeUpdate(sqlstr); 
				returnStr1 ="添加成功!";
				
				}

            
			%>
				<script>
                window.close();
                opener.alert("<%=returnStr1%>");
				opener.location.reload();
				</script>
            <%           
       }
       if (stype.indexOf("mod")>=0)      //修改操作
       {
       		        czid=getStr(request.getParameter("id"));        
                        code=getStr(request.getParameter("code"));
			name=getStr(request.getParameter("name"));
                        sqlstr ="select count(*) as num from base_cust_regtype where  code='"+code+"'";
			rs=db.executeQuery(sqlstr); 
			if (rs.next())
			{
				num = getDBStr(rs.getString("num"));
			}
			if (num=="1" && code==czid || num=="0" ){
				sqlstr="update base_cust_regtype set code='"+code+"',name='"+name+"' where code='"+czid+"'";
				i=db.executeUpdate(sqlstr);
				returnStr ="修改成功!";
			}else{
				returnStr ="登记注册类型编码已存在,无法修改";
				}
			%>
				<script>
                window.close();
				
                opener.alert("<%=returnStr%>");
				opener.location.reload();
				</script>
			<%
       }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            czid=getStr(request.getParameter("id"));
            sqlstr="delete from base_cust_regtype where code='"+czid+"'";
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