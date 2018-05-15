<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>逾期情况明细 - 租金催收</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%!
public String getMoney(double money){
	if(money<0){
		return "0";
	}else{
		return formatNumberDouble(money);
	}
}
%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
 response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("duning-zjcs-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<div style="vertical-align:top;height:240px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
     <th >合同编号</th>
      <th >客户名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
	  <th >机编号</th>
	  <th >联系方式</th>
      <th >催款员&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <th >起租日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <th >下一次处理日</th>      
	  <th >最近一次付款金额/时间&nbsp;&nbsp;</th>
      <th >租金总余额/未还款期数</th>
      <th colspan="3">逾期</th>
      <th >逾期1～30</th>
      <th >逾期31～60</th>
      <th >逾期61～90</th>
      <th >逾期91～120</th>
      <th >逾期>=121</th>
	  <th >台数</th>
	  <th >分公司</th>
	  <th >付款方式</th>
	  <th >总期数</th>
	  <th >月还款</th>    
      <th >计划下次还款日</th>
	  <th >&nbsp;承诺还款日&nbsp;</th>
      <th >设备型号</th>
      <th >&nbsp;销售员&nbsp;</th>
	  <th >担保人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>      
	  <th >客户地址&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
      </tr>
      <tr class="maintab_content_table_title">
	  <th ></th>
      <th ></th>
      <th ></th>
      <th ></th>
      <th ></th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
      <th>期数</th>
      <th>总金额</th>
      <th>总违约金</th>
      <th>租金</th>
      <th>租金</th>
      <th>租金</th>
      <th>租金</th>
      <th>租金</th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
	  <th ></th>
      <th ></th>
	  <th ></th>
      <th ></th>
      <th ></th>
      <th ></th>
	  <th></th>
      </tr>
<%
boolean a=true;
String date = getStr( request.getParameter("enddate") );
String cust_id = getStr( request.getParameter("cust_id") );
ResultSet rs;
String sqlstr ="select * from (select info.cust_id,out.contract_id,cust_name,dbo.getmodelbyid(device_type) as device_type,addr,mobile_number,dbo.getusername(proj_manage) as proj_manage,dbo.getassuror(out.contract_id) as assuror,(select top 1 nextliaison_date from dunning_record as re where re.cust_id=info.cust_id order by dunningrecord_id desc) as nextliaison_date,dbo.bb_getBadNub('2000-1-1','"+date+"',out.contract_id)as out_counts,(out_rent_0+out_rent_3+out_rent_6+out_rent_9+out_rent_12) as out_rent,dbo.bb_getPunishInterest(out.contract_id,'"+date+"') as out_penalty ,(select sum(isnull(rent,0)+isnull(rent_adjust,0)) from fund_rent_plan where contract_id=out.contract_id)-(select  sum(isnull(rent,0)+isnull(rent_adjust,0)) from fund_rent_income where contract_id=out.contract_id) as rent_balance,(dit.income_number-(select max(plan_list) from fund_rent_income where contract_id=out.contract_id)) as list,out_rent_0,out_rent_3,out_rent_6,out_rent_9,out_rent_12 ,equip_num,dbo.fk_getname(info.proj_dept) as sale_name,pay_type= CASE  dit.income_number_year when '1' then '月付' when '3' then '季付' when '6' then '半年付' when '12' then '年付' end,dit.income_number,(select top 1 isnull(rent,0)+isnull(rent_adjust,0) from fund_rent_plan where contract_id=out.contract_id and datediff(dd,plan_date,'"+date+"')<=0 order by id) as rent,(select sum(isnull(rent,0)+isnull(rent_adjust,0)+isnull(penalty,0)) from fund_rent_income where contract_id=out.contract_id and hire_date=(select max(hire_date) from fund_rent_income where contract_id=out.contract_id)) as hire_rent,(select max(hire_date) from fund_rent_income where contract_id=out.contract_id) as hire_date,(select top 1 pay_date  from dunning_record as re where re.cust_id=info.cust_id order by dunningrecord_id desc) as p_plan_date ,equip_sn,isnull(dit.actual_start_date,dit.start_date) as start_date,(select top 1 plan_date from fund_rent_plan where contract_id=out.contract_id and datediff(dd,plan_date,'"+date+"')<=0 order by plan_date) as plan_date,dbo.getusername(dun.dun) as dun from(select info.contract_id,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=30 and datediff(dd,plan_date,'"+date+"')>0)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=30 and datediff(dd,plan_date,'"+date+"')>0)) as out_rent_0 ,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=60 and datediff(dd,plan_date,'"+date+"')>30)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=60 and datediff(dd,plan_date,'"+date+"')>30))as out_rent_3 ,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=90 and datediff(dd,plan_date,'"+date+"')>60)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=90 and datediff(dd,plan_date,'"+date+"')>60))as out_rent_6 ,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=120 and datediff(dd,plan_date,'"+date+"')>90)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')<=120 and datediff(dd,plan_date,'"+date+"')>90))as out_rent_9,(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')>120)-(select (isnull(sum(rent),0)+isnull(sum(rent_adjust),0)) from fund_rent_income where contract_id=info.contract_id and plan_list in (select rent_list from fund_rent_plan where contract_id=info.contract_id and datediff(dd,plan_date,'"+date+"')>120))as out_rent_12 from contract_info as info ) as out left join contract_info as info on (out.contract_id=info.contract_id)left join contract_equip as eq on(out.contract_id=eq.contract_id)left join vi_cust_all_info as cust on(info.cust_id=cust.cust_id)left join contract_condition as dit on(out.contract_id=dit.contract_id)left join contract_dun as dun on (out.contract_id=dun.contract_id)) as duning where duning.out_rent>0 and cust_id='"+cust_id+"'"; 
System.out.println(sqlstr+"==========================================================");
rs = db.executeQuery(sqlstr);
while(rs.next()){
%>
<script>
/*function reloadifame(contract_id){
	parent.UserBody2.location.href ='../directives/directives_list.jsp?contract_id='+contract_id;
	parent.UserBody1.location.href ='../record/record_list.jsp?contract_id='+contract_id;
}*/
</script>
      <tr class="cwDLRow">
        <td><%= getDBStr( rs.getString("contract_id") ) %></td>
        <td><%= getDBStr(rs.getString("cust_name") ) %></td>
		<td><%= getDBStr( rs.getString("equip_sn") ) %></td>
        
        <td><%= getDBStr( rs.getString("mobile_number") ) %></td>
        <td><%= getDBStr( rs.getString("dun") ) %></td>
        <td><%= getDBDateStr( rs.getString("start_date") ) %></td>
        <td><%= getDBDateStr( rs.getString("nextliaison_date") ) %></td>        
        <td><%= formatNumberStr( rs.getString("hire_rent") ,"#,##0.00" ) %><span style="color:#F00"> / </span><%= getDBDateStr( rs.getString("hire_date") ) %></td>  
        <td><%= formatNumberStr( rs.getString("rent_balance")  ,"#,##0.00") %><span style="color:#F00"> / </span><%= getDBStr( rs.getString("list") ) %></td>
         <td >&nbsp;&nbsp;<%= formatNumberDoubleTwo(rs.getString("out_counts")) %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent")  ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_penalty")  ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_0") ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_3")  ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_6") ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_9"),"#,##0.00")%>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("out_rent_12") ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= getDBStr( rs.getString("equip_num") ) %>&nbsp;&nbsp;</td>
        <td ><%= getDBStr( rs.getString("sale_name") ) %></td>
        <td ><%= getDBStr( rs.getString("pay_type") ) %></td>      
        <td >&nbsp;&nbsp;<%= getDBStr( rs.getString("income_number") ) %>&nbsp;&nbsp;</td>
        <td >&nbsp;&nbsp;<%= formatNumberStr( rs.getString("rent") ,"#,##0.00") %>&nbsp;&nbsp;</td>
        <td ><%= getDBDateStr( rs.getString("plan_date") ) %></td>     
        <td ><%= getDBDateStr( rs.getString("p_plan_date") ) %></td>  
        <td ><%= getDBStr( rs.getString("device_type") ) %></td> 
        <td ><%= getDBStr( rs.getString("proj_manage") ) %></td>
        <%
		String temp=getDBStr(rs.getString("assuror"));
		if(temp.length()>1){
		temp=temp.substring(0,temp.length()-33);
		}
		%>
        <td ><%= temp %></td>        
        <td ><%= getDBStr( rs.getString("addr") ) %></td>
      </tr>
      <%
	}
rs.close(); 
db.close();
%>
    </table>
</div>
</body>
</html>
