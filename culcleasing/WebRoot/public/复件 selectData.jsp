<%@ page contentType="text/html; charset=gbk" language="java" %>

<!-- 下拉框的值 -->
<%
//客户的注册类型
String regtype_name_str = "";

sqlstr="select name from base_cust_regtype";
sqlstr+=" where name is not null order by code";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	regtype_name_str=regtype_name_str+"|"+getDBStr(rs.getString("name"));
}rs.close();

//资金计划 - 款项内容 显示str
String feetype_name_str = "";

sqlstr="select feetype_name from base_feetype";
sqlstr+=" where feetype_name is not null order by feetype_number";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	feetype_name_str=feetype_name_str+"|"+getDBStr(rs.getString("feetype_name"));
}rs.close();

//资金计划 - 款项内容值 取值str
String feetype_name_val = "";

sqlstr="select feetype_number from base_feetype";
sqlstr+=" where feetype_name is not null order by feetype_number";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	feetype_name_val=feetype_name_val+"|"+getDBStr(rs.getString("feetype_number"));
}rs.close();

//资金计划 - 款项内容收款 显示str
String feetype_name_str_SK = "";

sqlstr="select feetype_name from base_feetype";
sqlstr+=" where feetype_name is not null and paytype='收款' order by feetype_number";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	feetype_name_str_SK=feetype_name_str_SK+"|"+getDBStr(rs.getString("feetype_name"));
}rs.close();

//资金计划 - 款项内容值收款 取值str
String feetype_name_val_SK = "";

sqlstr="select feetype_number from base_feetype";
sqlstr+=" where feetype_name is not null and paytype='收款' order by feetype_number";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	feetype_name_val_SK=feetype_name_val_SK+"|"+getDBStr(rs.getString("feetype_number"));
}rs.close();

//资金计划 - 款项内容付款 显示str
String feetype_name_str_FK = "";

sqlstr="select feetype_name from base_feetype";
sqlstr+=" where feetype_name is not null and paytype='付款' order by feetype_number";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	feetype_name_str_FK=feetype_name_str_FK+"|"+getDBStr(rs.getString("feetype_name"));
}rs.close();

//资金计划 - 款项内容值付款 取值str
String feetype_name_val_FK = "";

sqlstr="select feetype_number from base_feetype";
sqlstr+=" where feetype_name is not null and paytype='付款' order by feetype_number";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	feetype_name_val_FK=feetype_name_val_FK+"|"+getDBStr(rs.getString("feetype_number"));
}rs.close();

//资金计划 - 结算方式 显示str
String paytype_name_str = "";

sqlstr="select pay_type_name from base_paytype";
sqlstr+=" where pay_type_name is not null order by id";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	paytype_name_str=paytype_name_str+"|"+getDBStr(rs.getString("pay_type_name"));
}rs.close();

//资金计划 - 结算方式 取值str
String paytype_name_val = "";

sqlstr="select pay_type_code from base_paytype";
sqlstr+=" where pay_type_name is not null order by id";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	paytype_name_val=paytype_name_val+"|"+getDBStr(rs.getString("pay_type_code"));
}rs.close();

//客户类型 - 承租人、供应商、第三方

String cust_type_str = "";

sqlstr = "select lbdlmc from kh_lbdl";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	cust_type_str=cust_type_str+"|"+getDBStr(rs.getString("lbdlmc"));
}rs.close();

%>


