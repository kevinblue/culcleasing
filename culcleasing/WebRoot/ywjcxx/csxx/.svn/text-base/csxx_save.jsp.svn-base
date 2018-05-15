<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String czy=(String) session.getAttribute("czyid");


String sqlstr;
int i;
String czid;
String id;
String csmc;
String sfid;
ResultSet rs;

//获取系统时间
String datestr=getSystemDate(1); 


    if (request.getParameter("savetype")!=null)
    {
        String stype=request.getParameter("savetype");
        if (stype.indexOf("add")>=0)     //新增操作
       {
            id=getStr(request.getParameter("id"));
            csmc=getStr(request.getParameter("csmc"));
	    sfid=getStr(request.getParameter("sfid"));
		
			sqlstr = "select * from jb_csxx where id='"+id+"'";
                        rs = db.executeQuery(sqlstr); 
			if ( rs.next() ) {
			%>
				<script>
				window.history.back();
				alert("所填国家代码与现有代码重复");
				</script>
			<%
			}
			else
			{
				sqlstr="insert into jb_csxx(id,csmc,sfid,gxrq,czy) values ('"+id+"','"+csmc+"','"+sfid+"',"+datestr+",'"+czy+"')";
				System.out.println("sqlstradd============"+sqlstr);
				i=db.executeUpdate(sqlstr); 
			}
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
            csmc=getStr(request.getParameter("csmc"));
			sfid=getStr(request.getParameter("sfid"));
			String kid = getStr( request.getParameter("kid") );
	if ( kid.equals(id) ) {
		sqlstr = "update jb_csxx set sfid='"+sfid+"' ,csmc='" + csmc  + "',gxrq=" + datestr + ",czy='" + czy + "' where id='" + id + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
		%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
		<%
	} else {
		sqlstr = "select * from jb_gjxx where id='" + id + "'";
		rs = db.executeQuery(sqlstr); 
		if ( rs.next() ) {
		%>
			<script>
			window.history.back();
			alert("所填国家代码与现有代码重复");
			</script>
		<%
		} else {
			sqlstr = "update jb_csxx set id='" + id  + "',csmc='" + csmc  + "',sfid='"+sfid+"',gxrq=" + datestr + ",czy='" + czy + "' where id='" + kid + "'";
			System.out.println("sqlstrsqlstr=="+sqlstr);
			db.executeUpdate(sqlstr);	
			%>
			<script>
				window.close();
				opener.alert("修改成功!");
				opener.location.reload();
			</script>
			<%
		}

       }
	   }
       if (stype.indexOf("del")>=0)         //删除操作
       {
            id=getStr(request.getParameter("id"));
            sqlstr="delete from jb_csxx where id='"+id+"'";
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
