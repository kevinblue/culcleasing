<%@ page contentType="text/xml; charset=utf-8" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="com.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%
	String cardId=request.getParameter("cardId");
	String sql="";
	ResultSet rs=null;
	sql="select *,provinceName=dbo.GetProvince(province) from cust_ewlp_info where card_no='" + cardId + "'";
	rs = db.executeQuery(sql);
	out.print("<context>");
	if(rs.next()){
		out.print("<custId>"+rs.getString("cust_id")+"</custId>");
		out.print("<custName>"+rs.getString("cust_name")+"</custName>");
		out.print("<sex>"+rs.getString("sex")+"</sex>");
		out.print("<maritalStatus>"+rs.getString("marital_status")+"</maritalStatus>");
		out.print("<brithDate>"+rs.getString("brith_date")+"</brithDate>");
		out.print("<mobileNumber>"+rs.getString("mobile_number")+"</mobileNumber>");
		out.print("<homePhone>"+rs.getString("home_phone")+"</homePhone>");
		out.print("<otherPhone>"+rs.getString("other_phone")+"</otherPhone>");
		out.print("<homeAddress>"+rs.getString("home_address")+"</homeAddress>");
		out.print("<province>"+rs.getString("province")+"</province>");
		out.print("<provinceName>"+rs.getString("provinceName")+"</provinceName>");
		out.print("<city>"+rs.getString("city")+"</city>");
		out.print("<mailAddress>"+rs.getString("mail_address")+"</mailAddress>");
		out.print("<postCode>"+rs.getString("post_code")+"</postCode>");
		out.print("<truster>"+rs.getString("truster")+"</truster>");
		out.print("<trusterTel>"+rs.getString("truster_tel")+"</trusterTel>");
		out.print("<trusterPhone>"+rs.getString("truster_phone")+"</trusterPhone>");
		out.print("<trusterCardNo>"+rs.getString("truster_card_no")+"</trusterCardNo>");
		out.print("<branch>"+rs.getString("branch")+"</branch>");
		out.print("<memo>"+rs.getString("memo")+"</memo>");
		out.print("<match>"+rs.getString("match")+"</match>");
		out.print("<matchCardNo>"+rs.getString("match_card_no")+"</matchCardNo>");
		out.print("<matchTel>"+rs.getString("match_tel")+"</matchTel>");
		out.print("<matchPhone>"+rs.getString("match_phone")+"</matchPhone>");
		out.print("<assets>"+rs.getDouble("assets")+"</assets>");
		
	}else{
		out.print("<error>没有这个身份证号码，请录入信息</error>");
	}
	out.print("</context>");
	rs.close(); 
	db.close();
%>