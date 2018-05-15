<%@ page contentType="text/xml; charset=utf-8" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%
	String cardId=request.getParameter("cardId");
	String sql="";
	ResultSet rs=null;
	sql="select id from cust_info where org_code='" + cardId + "'";
	rs = db.executeQuery(sql);
	out.print("<context>");
	if(rs.next()){
		out.print("<custId>"+rs.getString("cust_id")+"</custId>");
		out.print("<custName>"+rs.getString("cust_name")+"</custName>");
		out.print("<org_code>"+rs.getString("org_code")+"</orgCode>");
		out.print("<licenseNo>"+rs.getString("license_no")+"</licenseNo>");
		out.print("<comTel>"+rs.getString("com_tel")+"</comTel>");
		out.print("<legal>"+rs.getString("legal")+"</legal>");
		out.print("<legalCardNo>"+rs.getString("legal_card_no")+"</legalCardNo>");
		out.print("<legalTel>"+rs.getString("legal_tel")+"</legalTel>");
		out.print("<legalPhone>"+rs.getString("legal_phone")+"</legalPhone>");
		out.print("<province>"+rs.getString("province")+"</province>");
		out.print("<provinceName>"+rs.getString("provinceName")+"</provinceName>");
		out.print("<city>"+rs.getString("city")+"</city>");
		out.print("<contact>"+rs.getString("contact")+"</contact>");
		out.print("<contactCardNo>"+rs.getString("contact_card_no")+"</contactCardNo>");
		out.print("<contactTel>"+rs.getString("contact_tel")+"</contactTel>");
		out.print("<contactPhone>"+rs.getString("contact_phone")+"</contactPhone>");
		out.print("<branch>"+rs.getString("branch")+"</branch>");
		out.print("<memo>"+rs.getString("memo")+"</memo>");
		out.print("<regMoney>"+rs.getDouble("reg_money")+"</regMoney>");
		out.print("<assets>"+rs.getDouble("assets")+"</assets>");
	}else{
		out.print("<error>没有这个组织机构代码，请录入信息</error>");
	}
	out.print("</context>");
	rs.close(); 
	db.close();
%>