<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("sms-smstest-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------以上为权限控制--------

String czid = getStr( request.getParameter("czid") );
String del_flag = getStr( request.getParameter("del_flag") );
String sqlstr = "";
sqlstr="update sms_info set delete_flag='"+del_flag+"' where id="+czid;
db.executeUpdate(sqlstr);
db.close();
%>
<script>
	window.close();
	opener.alert("短信记录作废成功!");
	opener.location.reload();
</script>