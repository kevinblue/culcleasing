<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp" %>
<%
String czid = getStr(request.getParameter("czid"));
String lease_term = getStr(request.getParameter("lease_term"));
String equip_amt = getStr(request.getParameter("equip_amt"));
String model = getStr(request.getParameter("model"));
String flag = getStr(request.getParameter("flag"));

ResultSet rs;
String sqlstr="";
String method="";
String r_turn="";

sqlstr="select dbo.fk_getname(equip_type) as model_name from dbo.equip_model where model_id='"+model+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	String model_name=getDBStr(rs.getString("model_name"));
	if(model_name.equals("山工装载机")||model_name.equals("山工压路机")){
		if(flag.equals("1")){
			r_turn=Double.parseDouble(equip_amt)*0.007*(Double.parseDouble(lease_term)/12)+"";
		}else if(flag.equals("2")){
			r_turn=Double.parseDouble(equip_amt)*0.01*(Double.parseDouble(lease_term)/12)+"";
			r_turn=formatNumberDoubleZero(r_turn);
		}
		System.out.println("model_name=============="+model_name+"====="+r_turn);
	}else{
		if(flag.equals("1")){
			sqlstr="select * from insurance_fees where insurer='"+czid+"'";
			rs=db.executeQuery(sqlstr);
			if(rs.next()){
				method=getDBStr(rs.getString("fees_way"));
			}rs.close();
			r_turn=getInsurance(method,lease_term,equip_amt);
			System.out.println("method=============="+method+"====="+r_turn);
		}else  if(flag.equals("2")){
			r_turn=Double.parseDouble(equip_amt)*0.01+"";
			r_turn=formatNumberDoubleZero(r_turn);
		}
	}
}
db.close();
r_turn=formatNumberDoubleTwo(r_turn);
%>
<%=r_turn %>