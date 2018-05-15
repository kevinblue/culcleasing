<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<HTML>  
 <HEAD>  
  <TITLE> New Document </TITLE>  
     
    <script type="text/javascript">  
        function execute() {   
            window.returnValue = document.getElementsByName("factoring")[0].value; 
alert(document.getElementsByName("factoring")[0].value);
            window.close();   
        }   
    </script>  
 </HEAD>  
  <%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String factoring = getStr(request.getParameter("factoring") );
String factoring_pringcipal = getStr(request.getParameter("factoring_pringcipal") );
String factoring_rantal=getStr(request.getParameter("factoring_rantal"));
String sqlstr;
ResultSet rs;
//sqlstr="update fund_rent_plan set factoring='"+factoring+"',factoring_pringcipal='"+factoring_pringcipal+"',factoring_rantal='"+factoring_rantal+"' where id='
//"+czid+"';
		//db.executeUpdate(sqlstr);
		//System.out.println("sqlstrsqlstr=="+sqlstr);
%>
 <BODY>  
    <input type="text" name="factoring" value="<%=factoring%>">  
    <input type="button" value="È·¶¨" onclick="execute()">  
 </BODY>  
</HTML>  
