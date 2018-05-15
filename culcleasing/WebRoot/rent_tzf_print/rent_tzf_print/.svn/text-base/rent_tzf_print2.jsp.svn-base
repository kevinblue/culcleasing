<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<body>

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("rent-tzf-print2",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>
<%
//--------以上为权限控制-----------------------------
String sqlstr;
ResultSet rs;
ResultSet rs1;
String wherestr = " where 1=1 and aa.deduRent>0 and aa.contract_id not in(select contract_id from contract_notsend union select contract_id from contract_info where contract_status in('103') or charge_off_flag='是' union select contract_id from contract_equip where equip_status in('equip_status3','equip_status4','equip_status5'))";
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );


String s_date = getStr( request.getParameter("s_date") );	//开始日期
String e_date = getStr( request.getParameter("e_date") );	//结束日期
String bad_date = getStr( request.getParameter("bad_date") );	//逾期结算日期
//String industry_type = getStr( request.getParameter("industry_type") );	//行业
String print_flag= getStr( request.getParameter("print_flag") );//打印标志
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

String end_date="";//租赁合同结束日期：如果要发送的租赁通知书的日期＝保证金抵扣到的期项则取该期项的偿还计划日期
String c_punish="";//当期罚息

if ( !searchFld.equals("") && !searchKey.equals("") ) {
	if ( searchFld.equals("aa.industry_name") && searchKey.equals("非建筑") ) {
		wherestr = wherestr + " and isnull(aa.industry_name,'')<>'建筑业'";
	}else{
		wherestr = wherestr + " and " + searchFld + " like '%" + searchKey + "%'";
	}
}

sqlstr = "select aa.* from (select ifelc_conf_dictionary.title as industry_name,contract_payment_notice.print_status,contract_signatory.client_postcode, contract_signatory.client_address, vi_cust_all_info.cust_name, contract_signatory.client_linkman, contract_signatory.client_mobile_number, a.contract_id, a.plan_date, fund_rent_plan.rent, fund_rent_plan.rent_list, dbo.bb_getBadRent('1970-01-01','"+bad_date+"',a.contract_id) as badRent, dbo.bb_getPunishInterest('1970-01-01','"+bad_date+"',a.contract_id) as punishInterest, contract_condition.pena_rate,vi_cust_all_info2.cust_name as lessor_name, cust_account.bank_name, contract_signatory.lease_acc_number, contract_condition.nominalprice,dbo.bb_getDeduRent_tzf(contract_condition.contract_id,fund_rent_plan.rent_list) as deduRent,dbo.bb_getDeduList(contract_condition.contract_id) as deduList,isnull(dbo.bb_getPunishInterest_item('1970-01-01','"+bad_date+"',contract_condition.contract_id,fund_rent_plan.rent_list),0) as c_punish from ( select fund_rent_plan.contract_id, max(fund_rent_plan.plan_date) as plan_date from fund_rent_plan where plan_date>='"+s_date+"' and plan_date<='"+e_date+"' group by fund_rent_plan.contract_id )a left join contract_signatory on a.contract_id=contract_signatory.contract_id left join vi_cust_all_info on contract_signatory.client=vi_cust_all_info.cust_id inner join fund_rent_plan on a.contract_id=fund_rent_plan.contract_id and a.plan_date=fund_rent_plan.plan_date left join contract_condition on a.contract_id=contract_condition.contract_id left join vi_cust_all_info vi_cust_all_info2 on contract_signatory.lessor=vi_cust_all_info2.cust_id left join cust_account on contract_signatory.lease_acc_number=cust_account.acc_number and contract_signatory.lessor=cust_account.cust_id left join vi_contract_info on a.contract_id=vi_contract_info.contract_id left join ( 	select contract_payment_notice.* from contract_payment_notice where id in( 		select max(id) as id from contract_payment_notice group by contract_id,rent_list 	) )contract_payment_notice on fund_rent_plan.contract_id=contract_payment_notice.contract_id and fund_rent_plan.rent_list=contract_payment_notice.rent_list left join ifelc_conf_dictionary on vi_contract_info.industry_type=ifelc_conf_dictionary.name)aa"+wherestr; 

if(!print_flag.equals("")){
	sqlstr = sqlstr+" and isnull(aa.print_status,'否')='"+print_flag+"'";
}
System.out.println("sqlstr00=================================="+sqlstr);
String client_postcode="";
String client_address="";
String client_address1="";
String client_address2="";
String cust_name="";
String client_linkman="";
String phone="";
String contract_id="";
String curr_plan_date="";
String curr_rent="";
String curr_rent_list="";

String pena_rate="";
String lessor_name="";
String bank_name="";
String lease_acc_number="";

String total_money="";
String total_money_bad="";
String curr_badRent="";
String curr_punishInterest="";
String line_str1="";
String line_str2="";
String line_str3="";
String line_str4="";
String line_str5="";
String line_str6="";
String pre_rent_list="";
String pre_pre_rent_list="";
String pre_pre_pre_rent_list="";
String pre_rent="";
String pre_pre_rent="";
String pre_pre_pre_rent="";
String pre_days="";
String pre_pre_days="";
String pre_pre_pre_days="";
String pre_punish="";
String pre_pre_punish="";
String pre_pre_pre_punish="";

String nominalprice="";
String deduRent="";
String deduList="";
String deduList_money="";//可抵扣保证金：交易结构中的承租客户的可抵扣保证金与剩余保证金之中的小者
String show_flag="";//是否显示ｗｏｒｄ文档中红字部分:1不显示，０显示
String filepath="c:/新租赁系统付款通知书样稿96.jpg";

//短信
String sms_message="";


rs=db.executeQuery(sqlstr);
while(rs.next()){
	client_postcode=getDBStr( rs.getString("client_postcode") );
	client_address=getDBStr( rs.getString("client_address") );
	if(client_address.length()>30){
		client_address1=client_address.substring(0,30);
		client_address2=client_address.substring(30,client_address.length());
	}else{
		client_address1=client_address;
		client_address2="";
	}
	
	cust_name=getDBStr( rs.getString("cust_name") );
	client_linkman=getDBStr( rs.getString("client_linkman") );
	phone=getDBStr( rs.getString("client_mobile_number") );
	contract_id=getDBStr( rs.getString("contract_id") );
	curr_plan_date=getDBDateStr( rs.getString("plan_date") );
	curr_rent=getDBStr( rs.getString("rent") );
	curr_rent_list=getDBStr( rs.getString("rent_list") );
	
	//名义货价,抵扣期限,当期罚息
	nominalprice=getDBStr( rs.getString("nominalprice") );
	deduList=getDBStr( rs.getString("deduList") );
	curr_rent=getDBStr( rs.getString("deduRent") );
	c_punish=getDBStr( rs.getString("c_punish") );
	show_flag="1";
	end_date="";
	if(curr_rent_list.equals(deduList)){
		show_flag="0";
		end_date=curr_plan_date;
	}
	
	pena_rate=getDBStr( rs.getString("pena_rate") );
	lessor_name=getDBStr( rs.getString("lessor_name") );
	bank_name=getDBStr( rs.getString("bank_name") );
	lease_acc_number=getDBStr( rs.getString("lease_acc_number") );
	
	curr_badRent=getDBStr( rs.getString("badRent") );
	curr_punishInterest=getDBStr( rs.getString("punishInterest") );
	pre_rent_list=String.valueOf(Integer.parseInt(curr_rent_list)-1);
	pre_pre_rent_list=String.valueOf(Integer.parseInt(curr_rent_list)-2);
	pre_pre_pre_rent_list=String.valueOf(Integer.parseInt(curr_rent_list)-3);
	
	line_str1="";
	//line_str2="";
	line_str3="";
	//line_str4="";
	line_str5="";
	//line_str6="";
	
	pre_rent="0";
	pre_pre_rent="0";
	pre_pre_pre_rent="0";
	pre_days="0";
	pre_pre_days="0";
	pre_pre_pre_days="0";
	pre_punish="0";
	pre_pre_punish="0";
	pre_pre_pre_punish="0";
	//1
	sqlstr="select (select isnull(sum(rent),0) from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+pre_rent_list+") -(select  isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list="+pre_rent_list+") as  pre_rent";
	//System.out.println("sqlstr22=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_rent=getDBStr( rs1.getString("pre_rent") );
	}rs1.close();
	
	sqlstr="select datediff(day,plan_date,'"+bad_date+"') as pre_days,isnull(dbo.bb_getPunishInterest_item('1970-01- 01','"+bad_date+"','"+contract_id+"',"+pre_rent_list+"),0) as pre_punish from fund_rent_plan where contract_id='"+contract_id+"' and  rent_list="+pre_rent_list;
	//System.out.println("sqlstr33=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_days=getDBStr( rs1.getString("pre_days") );
		pre_punish=getDBStr( rs1.getString("pre_punish") );
	}rs1.close();
	
	if(Double.parseDouble(pre_rent)>0){
		line_str1="第"+pre_rent_list+"期租金 金额为￥"+formatNumberStr(pre_rent,"#,##0.00")+"元";
		if(Double.parseDouble(pre_punish)>0){
			line_str1+="，逾期"+pre_days+"天,计罚息金额为￥"+formatNumberStr(pre_punish,"#,##0.00");
		}
	}else{
		pre_punish="0";
	}
	
	
	//2
	sqlstr="select (select isnull(sum(rent),0) from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+pre_pre_rent_list+") - (select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and  plan_list="+pre_pre_rent_list+") as pre_rent";
	//System.out.println("sqlstr44=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_pre_rent=getDBStr( rs1.getString("pre_rent") );
	}rs1.close();
	
	
	sqlstr="select datediff(day,plan_date,'"+bad_date+"') as pre_days,isnull(dbo.bb_getPunishInterest_item('1970-01- 01','"+bad_date+"','"+contract_id+"',"+pre_pre_rent_list+"),0) as pre_punish from fund_rent_plan where contract_id='"+contract_id+"' and  rent_list="+pre_pre_rent_list;
	//System.out.println("sqlstr55=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_pre_days=getDBStr( rs1.getString("pre_days") );
		pre_pre_punish=getDBStr( rs1.getString("pre_punish") );
	}rs1.close();
	
	if(Double.parseDouble(pre_pre_rent)>0){
		line_str3="第"+pre_pre_rent_list+"期租金 金额为￥"+formatNumberStr(pre_pre_rent,"#,##0.00")+"元";
		if(Double.parseDouble(pre_pre_punish)>0){
			line_str3+="，逾期"+pre_pre_days+"天,计罚息金额为￥"+formatNumberStr(pre_pre_punish,"#,##0.00");
		}
	}else{
		pre_pre_punish="0";
	}
	
	
	//3
	sqlstr="select (select isnull(sum(rent),0) from fund_rent_plan where contract_id='"+contract_id+"' and  rent_list<="+pre_pre_pre_rent_list+") -(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where  contract_id='"+contract_id+"' and plan_list<="+pre_pre_pre_rent_list+") as pre_rent";
	//System.out.println("sqlstr44=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_pre_pre_rent=getDBStr( rs1.getString("pre_rent") );
	}rs1.close();
	
	sqlstr="select isnull(sum(dbo.bb_getPunishInterest_item('1970-01-01','"+bad_date+"','"+contract_id+"',rent_list)),0) as pre_punish from  fund_rent_plan where contract_id='"+contract_id+"' and rent_list<="+pre_pre_pre_rent_list;
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_pre_pre_punish=getDBStr( rs1.getString("pre_punish") );
	}rs1.close();
	
	
	if(Double.parseDouble(pre_pre_pre_rent)>0){
		line_str5="第"+pre_pre_pre_rent_list+"期及之前租金 金额为￥"+formatNumberStr(pre_pre_pre_rent,"#,##0.00")+"元";
		if(Double.parseDouble(pre_pre_pre_punish)>0){
			line_str5+="，累计罚息金额为￥"+formatNumberStr(pre_pre_pre_punish,"#,##0.00");
		}
	}else{
		pre_pre_pre_punish="0";
	}
	
	
	total_money_bad=String.valueOf(Double.parseDouble(pre_rent)+Double.parseDouble(pre_punish)
	+Double.parseDouble(pre_pre_rent)+Double.parseDouble(pre_pre_punish)
	+Double.parseDouble(pre_pre_pre_rent)+Double.parseDouble(pre_pre_pre_punish));
	if(show_flag.equals("0")){
		total_money=String.valueOf(Double.parseDouble(total_money_bad)+Double.parseDouble(curr_rent)
	+Double.parseDouble(c_punish)+Double.parseDouble(nominalprice));
	}else{
		total_money=String.valueOf(Double.parseDouble(total_money_bad)+Double.parseDouble(curr_rent)
	+Double.parseDouble(c_punish));
	}
	
	//sms_message="您好 依 "+contract_id+" 合同，请于 "+curr_plan_date.substring(5,7)+" 月 "+curr_plan_date.substring(8,10)+" 日前 向本司账户汇入当期租金￥ "+formatNumberStr(curr_rent,"#,##0.00")+" 元。并请立即向本司账户汇入前期逾期租金及罚息，共计￥ "+formatNumberStr(String.valueOf(Double.parseDouble(curr_badRent)+Double.parseDouble(curr_punishInterest)),"#,##0.00")+" 元。感谢配合 ! 如已支付请与本司联系。";
	sms_message="温馨提醒：按"+contract_id+"合同约定，请"+curr_plan_date.substring(5,7)+"月"+curr_plan_date.substring(8,10)+"日前将当期租金￥"+formatNumberStr(curr_rent,"#,##0.00")+"元足额汇给我司，以免产生罚息，谢谢-恒信租赁";
	if(!phone.equals("")){
		sqlstr="insert into sms_info (mobile_phone,sms_message,type,add_time,delete_flag,perform_flag) select '"+phone+"','"+sms_message+"','付款通知','"+curr_date+"','0','0'";
		System.out.println("sqlstrphone================================"+sqlstr);
		db1.executeUpdate(sqlstr);
	}
	
}rs.close();

db.close();
db1.close();
%>


</body>
</html>

<script>
			window.close();
			opener.alert("已生成短信内容!");
		</script>