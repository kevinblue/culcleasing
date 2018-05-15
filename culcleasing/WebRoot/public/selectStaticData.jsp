<%@ page contentType="text/html; charset=gbk" language="java" %>

<!-- 下拉框的值 -->
<%
//sqlstr -- 主要存放查询sql语句
String sqlstr="";
//rs 查询结果
ResultSet rs = null;
//租赁物名称
String prod_id_str="";

sqlstr="select distinct title from ifelc_conf_dictionary";
sqlstr+=" where parentid='ProductType' and title is not null ";
sqlstr+=" and title<>'' ";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	prod_id_str=prod_id_str+"|"+ rs.getString("title");
}rs.close();
//制造商
String zzs_str = "";

sqlstr="select distinct zzsmc from jb_zlwjzzs where zzsmc is not null ";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	zzs_str=zzs_str+"|"+ rs.getString("zzsmc");
}rs.close();

//开户银行  
String bank_str="";

sqlstr="select distinct title from ifelc_conf_dictionary";
sqlstr+=" where parentid='BankType' and title is not null ";
sqlstr+=" and title<>'' ";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	bank_str=bank_str+"|"+ rs.getString("title");
}rs.close();

//租金核销银行
String hire_bank_str="";
sqlstr="select distinct title from ifelc_conf_dictionary";
sqlstr+=" where parentid='HireBank' and title is not null ";
sqlstr+=" and title<>'' ";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	hire_bank_str=hire_bank_str+"|"+ rs.getString("title");
}rs.close();


//项目状态
String proj_state_str = "";

sqlstr="select status_name from dbo.base_projstatus ";
sqlstr+=" where status_name is not null";
sqlstr+=" and status_name<>'' order by cast(status_code as float) ";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	proj_state_str=proj_state_str+"|"+rs.getString("status_name");
}rs.close();

//步骤名称
String step_name_str = "";
step_name_str = "|DB租金测算|DB上传资料|DB经理审核|信审但当送审";
step_name_str+= "|信审科长审核|信审部长审核|营业副总审核|立项批准|反馈信审但当";
step_name_str+= "|卡号验证|企划但当签约|企划科长审批|企划部长审批|合同档案上传|首期付款验证";
step_name_str+= "|起租申请|起租科长审批|起租部长审批|起租批准";

%>
