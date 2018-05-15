<%@ page contentType="text/html; charset=gbk"%><%@ page import="java.math.BigDecimal,java.util.*,java.text.*,java.util.Date" %><%!  
public String smsReplace(String message){
	return message.replaceAll("722","7 22").replaceAll("7.22","7. 22")
	.replaceAll("64","6 4").replaceAll("6.4","6. 4")
	.replaceAll("425","4 25").replaceAll("4.25","4. 25")
	.replaceAll("130","1 30").replaceAll("133","1 33");
}
public String insertSms(String mobile_phone,String sms_message,String type,String add_time){
	String sqlstr = "";
	sqlstr="insert into sms_info (mobile_phone,sms_message,perform_time,perform_flag,actual_time,type,add_time,delete_flag) values (";
	sqlstr+="'"+mobile_phone+"'";
	sqlstr+=",'"+sms_message+"'";
	sqlstr+=",null";
	sqlstr+=",0";
	sqlstr+=",null";
	sqlstr+=",'"+type+"'";
	if(add_time!=null&&!add_time.equals("")){
		sqlstr+=",'"+add_time+"'";
	}else{
		sqlstr+=",getdate()";
	}
	sqlstr+=",'0'";
	sqlstr+=")";
	return sqlstr;
}
%>