<%@ page contentType="text/html; charset=gbk" language="java" %>

<!-- 下拉框的值 -->
<%
//贷款类型
String loan_name_str = "";

sqlstr="Select loan_name from dbo.financing_config_loantype";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	loan_name_str=loan_name_str+"|"+getDBStr(rs.getString("loan_name"));
}rs.close();

//授信单位
String unit_name_str = "";

sqlstr="Select unit_name from dbo.financing_config_unit";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	unit_name_str=unit_name_str+"|"+getDBStr(rs.getString("unit_name"));
}rs.close();


%>


