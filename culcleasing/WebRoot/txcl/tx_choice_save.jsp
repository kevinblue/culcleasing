<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );
String curr_date = getSystemDate(0);
String xmidstr = getStr( request.getParameter("xmidstr") );

String sqlstr = "";
ResultSet rs = null;
//-----------------判断重复--------------
String proj_arr[];
String proj_id;
proj_arr=xmidstr.split(",");
for(int i=0;i<proj_arr.length;i++){
	proj_id=proj_arr[i];
	if(stype.equals("process")){
		String status="";
		sqlstr = "select id from fund_rent_plan where plan_status=0 and plan_date<getdate() and proj_id='"+proj_id+"'";
		rs = db.executeQuery(sqlstr);
		status=rs.next()?"逾期":"正常";
		
		//插入proj_change_tx
		sqlstr="insert into proj_change_tx(proj_id,left_rent,left_interest,left_corpus,un_receive_amount,";
		sqlstr+=" fund_status,adjust_date,adjust_id) ";
		sqlstr+=" select proj_id,left_rent,left_interest, ";
		sqlstr+=" left_corpus,un_received_amount,'"+status+"','"+curr_date+"','"+czid+"' from dbo.v_leftrent_info";
		sqlstr+=" where proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);
		//调息处理
		sqlstr="exec tx '"+czid+"','"+proj_id+"'";
		db.executeUpdate(sqlstr);
		//更新
		sqlstr = "update proj_change_tx set adjust_interest=";
		sqlstr += "(select adjust_amt from adjust_interest_proj where proj_id='"+proj_id+"' and adjust_id='"+czid+"')";
		sqlstr += "	where proj_id='"+proj_id+"' and adjust_id='"+czid+"'";
		db.executeUpdate(sqlstr);	
	}else if(stype.equals("del")){
		//调息前历史记录覆盖调息后偿还计划表
		sqlstr="delete from fund_rent_plan where proj_id='"+proj_id+"'";
System.out.println("11111"+sqlstr);
		db.executeUpdate(sqlstr);
		sqlstr="insert into fund_rent_plan(proj_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,rent_adjust) ";
		sqlstr+="select proj_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,rent_adjust from fund_rent_adjust_interest_his where adjust_id='"+czid+"' and proj_id='"+proj_id+"' and modify_reason='调息' and adjust_flag='前'";
//System.out.println("22222"+sqlstr);		
db.executeUpdate(sqlstr);

		//sqlstr="update adjust_interest_proj set adjust_flag='否',adjsut_amt=0,before_rate=0,after_rate=0 where adjust_id='"+czid+"' and proj_id='"+proj_id+"'";
		sqlstr="delete from adjust_interest_proj where adjust_id='"+czid+"' and proj_id='"+proj_id+"'";
//System.out.println("344444"+sqlstr);		
db.executeUpdate(sqlstr);
		sqlstr="delete from proj_change_tx where proj_id='"+proj_id+"' and adjust_id='"+czid+"'";
		db.executeUpdate(sqlstr);	

		//调整交易结构中租金总额
//select base_adjust_rate from dbo.base_adjust_interest where id=25  select top 1 year_rate from fund_rent_plan where where proj_id='"+proj_id+"' order by year_rate desc
		sqlstr="update proj_condition set year_rate=(select base_adjust_rate from dbo.base_adjust_interest where id='"+czid+"'),";
		sqlstr+="total_amt=((select isnull(sum(rent),0) from fund_rent_plan where proj_id='"+proj_id+"')+head_amt) where proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);
		//调整交易结构临时表中租金总额
		sqlstr="update proj_condition set year_rate=(select base_adjust_rate from dbo.base_adjust_interest where id='"+czid+"'),";
		sqlstr+=" total_amt=((select isnull(sum(rent),0) from fund_rent_plan where proj_id='"+proj_id+"')+head_amt) where proj_id='"+proj_id+"'";
		db.executeUpdate(sqlstr);

		//撤销处理
		sqlstr="delete from fund_rent_adjust_interest_his where adjust_id='"+czid+"' and proj_id='"+proj_id+"'";
//System.out.println("3333"+sqlstr);
		db.executeUpdate(sqlstr);

	}
}
db.close();
%>
<script>
	window.close();
	opener.alert("成功!");
	opener.parent.location.reload();
</script>
		