<%@ page contentType="text/html; charset=gbk" language="java" %>

<!-- �������ֵ -->
<%
//��������
String loan_name_str = "";

sqlstr="Select loan_name from dbo.financing_config_loantype";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	loan_name_str=loan_name_str+"|"+getDBStr(rs.getString("loan_name"));
}rs.close();

//���ŵ�λ
String unit_name_str = "";

sqlstr="Select unit_name from dbo.financing_config_unit";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	unit_name_str=unit_name_str+"|"+getDBStr(rs.getString("unit_name"));
}rs.close();


%>


