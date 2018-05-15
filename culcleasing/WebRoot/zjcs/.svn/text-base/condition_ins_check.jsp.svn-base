<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp" %>
<%
String model = getStr(request.getParameter("model"));
String insurer = getStr(request.getParameter("insurer"));
ResultSet rs;
String sqlstr="";
String r_turn="";
sqlstr="select dbo.fk_getname(equip_type) as model_name from dbo.equip_model where model_id='"+model+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	String model_name=getDBStr(rs.getString("model_name"));
	if(model_name.equals("山工装载机")||model_name.equals("山工压路机")){
		sqlstr="select id from ifelc_conf_dictionary where parentid='insurance' and name='"+insurer+"'";
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			String title=getDBStr(rs.getString("id"));
			if(!title.equals("2265")){
				r_turn="0";
			}else{
				r_turn="1";
			}
		}
	}else{
		r_turn="1";
	}
}else{
	r_turn="1";
}
db.close();
%>
<%=r_turn %>