<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="common.jsp"%>
<%
String windowtype=request.getParameter("wt");
String selfldname=request.getParameter("sf");
String tblname=request.getParameter("tn");
String listfld=request.getParameter("lf");
String listvalue=request.getParameter("lv");
String filterfld=request.getParameter("ff");
String filtervalue=request.getParameter("fv");
String dataobj=request.getParameter("do");
String valueobj=request.getParameter("vo");

if (windowtype.indexOf("simple")>=0)
{
%>

<form name=selform action="seldatawindow.jsp">
  <%=selfldname%>:<input type="text" name="serchkey"><input type="submit" value="查询">
</form>
<%
}
else
{
%>
<select name="datalist" size="15">
<%
String sqlstr;
ResultSet rs;
sqlstr = "select "+listfld+","+listvalue+" from "+tblname+" where "+filterfld+"='"+filtervalue+"'"; 
rs=db.executeQuery(sqlstr); 
while (rs.next())
{
%>
<option value="<%=rs.getString(listvalue)%>"><%=rs.getString(listfld)%></option>
<%
}
%>
</select>
<%
}
%>


//simple/spec 分开  string/int 分开
<%if(null != db){db.close();}%>