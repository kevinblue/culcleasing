<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");//������
String czid = getStr( request.getParameter("czid") );//id
String systemDate = getSystemDate(0);

//�õ�Ҫ��ӵ����ݿ��ַ���
String sqldata = getStr( request.getParameter("sqldata") );
String sid = getStr( request.getParameter("sid") );
String sql_date = getStr( request.getParameter("sql_date") );
	
String sqlstr="";
ResultSet rs;
int flag=0;
String message="";

System.out.println(sqldata+"|||");
String stype =  getStr( request.getParameter("savetype") );
//��ӵ���ʵ�Ľ��׽ṹ��
if ( stype.equals("add") ){ 

	if (sqldata.indexOf("_")>-1) {
		sqlstr = "";
		String [] s=sqldata.split("_");
		String [] sid_arr = sid.split(",");
		for (int i=0;i<s.length;i++){
			sqlstr +="insert into fund_fund_charge (ssfk,fact_date, account_bank, acc_number,";
			sqlstr +="proj_id,funds_mode,funds_type,funds_name,plan_date,plan_money,";
			sqlstr +=" item_method,settle_mode,fact_money,creator,create_date,plan_id,payer,payee,status) ";
			
			sqlstr +=" select "+s[i]+"',";
			sqlstr +="  fund_fund_charge_plan.proj_id,funds_mode,funds_type,funds_name,plan_date,plan_money,";
			sqlstr +=" vi_item_method.title,settle_mode,plan_money"+",'"+dqczy+"','"+systemDate+"'"+",fund_fund_charge_plan.id,payer,payee,1 ";
			sqlstr +=" from fund_fund_charge_plan left join proj_info proj on proj.proj_id=fund_fund_charge_plan.proj_id ";
			sqlstr +=" left join vi_item_method on vi_item_method.pl_id=fund_fund_charge_plan.id ";
			sqlstr +=" where funds_mode='�տ�' and funds_type<>'��������' and fund_fund_charge_plan.proj_id in ( ";
			sqlstr +=" 	select proj_id from apply_info_detail where apply_id in("+sid_arr[i]+"))";
		}
		System.out.println("leasing_save.jsp==001=="+sqlstr);
	
	} else {
		sqlstr="insert into fund_fund_charge (ssfk,fact_date, account_bank, acc_number,";
		sqlstr +="proj_id,funds_mode,funds_type,funds_name,plan_date,plan_money,";
		sqlstr +=" item_method,settle_mode,fact_money,creator,create_date,plan_id,payer,payee,status) ";
		
		sqlstr +=" select "+sqldata+"',";
		sqlstr +="  fund_fund_charge_plan.proj_id,funds_mode,funds_type,funds_name,plan_date,plan_money,";
		sqlstr +=" vi_item_method.title,settle_mode,plan_money "+",'"+dqczy+"','"+systemDate+"'"+",fund_fund_charge_plan.id,payer,payee,1 ";
		sqlstr +=" from fund_fund_charge_plan  left join proj_info proj on proj.proj_id=fund_fund_charge_plan.proj_id  ";
		sqlstr +=" left join vi_item_method on vi_item_method.pl_id=fund_fund_charge_plan.id  ";
		sqlstr +=" where funds_mode='�տ�' and funds_type<>'��������' and fund_fund_charge_plan.proj_id in ( ";
		sqlstr +=" 	select proj_id from apply_info_detail where apply_id in("+sid+"))";
		System.out.println("leasing_save.jsp==002=="+sqlstr);
	}

//���½��׽ṹ�������븶���
String sid_sql=sql_date;

sid_sql+=" update dbo.fund_fund_charge_plan set status=1 where proj_id in ( ";
sid_sql+=" 	select proj_id from apply_info_detail where apply_id in("+sid+")) ";
sid_sql+=" and funds_mode='�տ�' and funds_type<>'��������' ";

//ִ�����--����״̬
flag = db.executeUpdate(sid_sql);
System.out.println("flag============================="+flag);

//ִ�����--����ʵ��
flag = db.executeUpdate(sqlstr);
System.out.println("flag============================="+flag);

System.out.println("sid_sql��"+sid_sql);
//�޸����ƻ����һ�����״̬
sqlstr="update fund_rent_plan set plan_status='1',penalty=0 where proj_id in(select proj_id from apply_info_detail where apply_id in("+ sid +")) and rent_list=1 ";
db.executeUpdate(sqlstr);
//���ʵ�ձ��޸�����
sqlstr="insert into fund_rent_income(proj_id,plan_list,hire_date,rent,rent_type,item_method) ";
sqlstr+=" select proj_id,'1',fact_date,fact_money,'���','������' from fund_fund_charge where ";
sqlstr+=" proj_id in(select proj_id from apply_info_detail where apply_id in("+ sid +")) and funds_mode='�տ�' and funds_type='��1�����'";

db.executeUpdate(sqlstr);

message="��������˾����";
}else if ( stype.equals("bh") ){  //����ʱ
//�õ�����ŵļ���
String sql_bh_ids = getStr( request.getParameter("sql_bh_ids") );

sqlstr=" update apply_info set status='�Ѳ���',is_sub='δ�ύ' where id in ("+sql_bh_ids+") ";
flag=db.executeUpdate(sqlstr);
System.out.println("sid_sql������=="+sqlstr);
message="���ش���˾����";
}

if(flag!=0){
%>
<script>
		window.close();
		opener.alert("<%=message%>�ɹ�!");
	  // window.location.href = "leasing_list.jsp";
		opener.location.reload();	
</script>
<%
}else{
%>
<script>
		window.close();
		opener.alert("<%=message%>ʧ��!");
		opener.location.reload();
</script>
<%}db.close();%>