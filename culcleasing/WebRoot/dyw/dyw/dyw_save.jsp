<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<%@ page import="java.io.File" %>
<%@ page import="com.container.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<jsp:useBean id="execlBean" scope="page" class="com.UploadExecl" />
<%@ include file="../../func/common.jsp"%>
<%
String savetype =getStr( request.getParameter("savetype") );
String id=getStr( request.getParameter("id") );
String deal_info = "";
String deal_date = "";

String message  ="";
String sqlstr;
ResultSet rs=null;

	int fag=0;
	deal_info = getStr( request.getParameter("deal_info") );
	deal_date = getStr( request.getParameter("deal_date") );
if(savetype.equals("mod")){
		message="修改合同租抵押物件处理情况";
	   sqlstr="update contract_guarantee_equip set  deal_info='"+deal_info+"',deal_date='"+deal_date+"' where  id='"+id+"'";
		fag=db.executeUpdate(sqlstr);
		db.close();
    }
	if(fag==0){
		%>
        <script>
		alert("<%=message%>失败!");
		opener.location.reload();
		this.close();
		</script>
		<%		
	}else{
			%>
          <script>
		  alert("<%=message%>成功!");
		  opener.location.reload();
		  this.close();
		   </script>
		<%
	}	

%>