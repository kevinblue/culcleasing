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
<object codebase="http://leasing.tenwa.com/wsReport.cab#version=4,6,0,1" classid="clsid:08D91289-1761-4006-8294-FDE48B9F29BD" width="100%" height="100%" id="obj"></object>

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("rent-tzf-print",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("��û�в���Ȩ�ޣ�");
}

</script>
<%
//--------����ΪȨ�޿���-----------------------------
String sqlstr;
ResultSet rs;
ResultSet rs1;
String wherestr = " where 1=1 and aa.deduRent>0";
String curr_date = getSystemDate(0);
String czid = getStr( request.getParameter("czid") );
String stype = getStr( request.getParameter("savetype") );



String s_date = getStr( request.getParameter("s_date") );	//��ʼ����
String e_date = getStr( request.getParameter("e_date") );	//��������
String bad_date = getStr( request.getParameter("bad_date") );	//���ڽ�������
String print_flag= getStr( request.getParameter("print_flag") );//��ӡ��־
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

String end_date="";//���޺�ͬ�������ڣ����Ҫ���͵�����֪ͨ������ڣ���֤��ֿ۵���������ȡ������ĳ����ƻ�����
String c_punish="";//���ڷ�Ϣ

if ( !searchFld.equals("") && !searchKey.equals("") ) {
	if ( searchFld.equals("aa.industry_name") && searchKey.equals("�ǽ���") ) {
		wherestr = wherestr + " and isnull(aa.industry_name,'')<>'����ҵ'";
	}else{
		wherestr = wherestr + " and " + searchFld + " like '%" + searchKey + "%'";
	}
}
sqlstr = "select aa.* from (select contract_signatory.client_postcode, contract_signatory.client_address, vi_cust_all_info.cust_name, contract_signatory.client_linkman, contract_signatory.client_mobile_number, a.contract_id, a.plan_date, fund_rent_plan.rent, fund_rent_plan.rent_list, dbo.bb_getBadRent('1970-01-01','"+bad_date+"',a.contract_id) as badRent, dbo.bb_getPunishInterest('1970-01-01','"+bad_date+"',a.contract_id) as punishInterest, isnull(contract_condition.pena_rate,0) as pena_rate,vi_cust_all_info2.cust_name as lessor_name, cust_account.bank_name, contract_signatory.lease_acc_number, isnull(contract_condition.nominalprice,0) as nominalprice,dbo.bb_getDeduRent_tzf(fund_rent_plan.contract_id,fund_rent_plan.rent_list) as deduRent,dbo.bb_getDeduList(contract_condition.contract_id) as deduList,isnull(dbo.bb_getPunishInterest_item('1970-01-01','"+bad_date+"',contract_condition.contract_id,fund_rent_plan.rent_list),0) as c_punish,contract_payment_notice.print_status from ( select fund_rent_plan.contract_id, max(fund_rent_plan.plan_date) as plan_date from fund_rent_plan where plan_date>='"+s_date+"' and plan_date<='"+e_date+"' group by fund_rent_plan.contract_id )a left join contract_signatory on a.contract_id=contract_signatory.contract_id left join vi_cust_all_info on contract_signatory.client=vi_cust_all_info.cust_id inner join fund_rent_plan on a.contract_id=fund_rent_plan.contract_id and a.plan_date=fund_rent_plan.plan_date left join contract_condition on a.contract_id=contract_condition.contract_id left join vi_cust_all_info vi_cust_all_info2 on contract_signatory.lessor=vi_cust_all_info2.cust_id left join cust_account on contract_signatory.lease_acc_number=cust_account.acc_number left join vi_contract_info on a.contract_id=vi_contract_info.contract_id left join ( 	select contract_payment_notice.* from contract_payment_notice where id in( 		select max(id) as id from contract_payment_notice group by contract_id,rent_list 	) )contract_payment_notice on fund_rent_plan.contract_id=contract_payment_notice.contract_id and fund_rent_plan.rent_list=contract_payment_notice.rent_list left join ifelc_conf_dictionary on vi_contract_info.industry_type=ifelc_conf_dictionary.name)aa"+wherestr; 
if(!print_flag.equals("")){
	sqlstr = sqlstr+" and isnull(aa.print_status,'��')='"+print_flag+"'";
}
sqlstr+=" order by aa.contract_id";
System.out.println("sqlstr_print=================================="+sqlstr);
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
String deduList_money="";//�ɵֿ۱�֤�𣺽��׽ṹ�еĳ���ͻ��Ŀɵֿ۱�֤����ʣ�ౣ֤��֮�е�С��
String show_flag="";//�Ƿ���ʾ�������ĵ��к��ֲ���:1����ʾ������ʾ
String filepath="d:/������ϵͳ����֪ͨ������96.jpg";

String notice_contact="";
String notice_content="";
String notice_explanation="";
String notice_note="";









//---------------------------
%>

<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 300;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��
	int intPage;       //����ʾҳ��
	String strPage = getStr( request.getParameter("intPage") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;            //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
	
%>




<%	
	rs.previous();
	if ( rs.next() ) {  
	while( i < intPageSize && !rs.isAfterLast() ) {
	if(getDBStr( rs.getString("print_status") ).equals("")||getDBStr( rs.getString("print_status") ).equals("��")){

//rs=db.executeQuery(sqlstr);
//while(rs.next()){


//------------------------------------------------






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
	
	//�������,�ֿ�����,���ڷ�Ϣ
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
	sqlstr="select (select isnull(sum(rent),0) from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+pre_rent_list+") -(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list="+pre_rent_list+") as pre_rent";
	//System.out.println("sqlstr22=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_rent=getDBStr( rs1.getString("pre_rent") );
	}rs1.close();
	
	sqlstr="select datediff(day,plan_date,'"+bad_date+"') as pre_days,isnull(dbo.bb_getPunishInterest_item('1970-01-01','"+bad_date+"','"+contract_id+"',"+pre_rent_list+"),0) as pre_punish from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+pre_rent_list;
	//System.out.println("sqlstr33=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_days=getDBStr( rs1.getString("pre_days") );
		pre_punish=getDBStr( rs1.getString("pre_punish") );
	}rs1.close();
	
	if(Double.parseDouble(pre_rent)>0){
		line_str1="��"+pre_rent_list+"����� ���Ϊ��"+formatNumberStr(pre_rent,"#,##0.00")+"Ԫ";
	}
	if(Double.parseDouble(pre_punish)>0){
		line_str1+="������"+pre_days+"��,�Ʒ�Ϣ���Ϊ��"+formatNumberStr(pre_punish,"#,##0.00");
	}
	
	//2
	sqlstr="select (select isnull(sum(rent),0) from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+pre_pre_rent_list+") -(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list="+pre_pre_rent_list+") as pre_rent";
	//System.out.println("sqlstr44=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_pre_rent=getDBStr( rs1.getString("pre_rent") );
	}rs1.close();
	
	
	sqlstr="select datediff(day,plan_date,'"+bad_date+"') as pre_days,isnull(dbo.bb_getPunishInterest_item('1970-01-01','"+bad_date+"','"+contract_id+"',"+pre_pre_rent_list+"),0) as pre_punish from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+pre_pre_rent_list;
	//System.out.println("sqlstr55=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_pre_days=getDBStr( rs1.getString("pre_days") );
		pre_pre_punish=getDBStr( rs1.getString("pre_punish") );
	}rs1.close();
	
	if(Double.parseDouble(pre_pre_rent)>0){
		line_str3="��"+pre_pre_rent_list+"����� ���Ϊ��"+formatNumberStr(pre_pre_rent,"#,##0.00")+"Ԫ";
	}
	if(Double.parseDouble(pre_pre_punish)>0){
		line_str3+="������"+pre_pre_days+"��,�Ʒ�Ϣ���Ϊ��"+formatNumberStr(pre_pre_punish,"#,##0.00");
	}
	
	//3
	sqlstr="select (select isnull(sum(rent),0) from fund_rent_plan where contract_id='"+contract_id+"' and rent_list<="+pre_pre_pre_rent_list+") -(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list<="+pre_pre_pre_rent_list+") as pre_rent";
	//System.out.println("sqlstr44=================================="+sqlstr);
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_pre_pre_rent=getDBStr( rs1.getString("pre_rent") );
	}rs1.close();
	
	sqlstr="select isnull(sum(dbo.bb_getPunishInterest_item('1970-01-01','"+bad_date+"','"+contract_id+"',rent_list)),0) as pre_punish from fund_rent_plan where contract_id='"+contract_id+"' and rent_list<="+pre_pre_pre_rent_list;
	rs1=db1.executeQuery(sqlstr);
	if(rs1.next()){
		pre_pre_pre_punish=getDBStr( rs1.getString("pre_punish") );
	}rs1.close();
	
	
	if(Double.parseDouble(pre_pre_pre_rent)>0){
		line_str5="��"+pre_pre_pre_rent_list+"�ڼ�֮ǰ��� ���Ϊ��"+formatNumberStr(pre_pre_pre_rent,"#,##0.00")+"Ԫ";
	}
	if(Double.parseDouble(pre_pre_pre_punish)>0){
		line_str5+="���ۼƷ�Ϣ���Ϊ��"+formatNumberStr(pre_pre_pre_punish,"#,##0.00");
	}
	
	total_money_bad=String.valueOf(Double.parseDouble(pre_rent)+Double.parseDouble(pre_punish)
	+Double.parseDouble(pre_pre_rent)+Double.parseDouble(pre_pre_punish)
	+Double.parseDouble(pre_pre_pre_rent)+Double.parseDouble(pre_pre_pre_punish));
	total_money=String.valueOf(Double.parseDouble(total_money_bad)+Double.parseDouble(curr_rent)
	+Double.parseDouble(c_punish)+Double.parseDouble(nominalprice));
	
	
%>
<script language="VBScript">
'obj.SetBackGround ("<%=filepath%>") '����Ʊ�ݱ���
obj.Init
obj.PageSize = 3	'A4
obj.SetTextColor RGB(0, 0, 0)
obj.SetOutline 0, 0, 2, 0, RGB(0, 0, 0)

obj.LeftMargin=107
obj.TopMargin=16

obj.SetFont "����", 1
obj.SetFontSize 15
obj.SetFontStyle 0,1,0

obj.DrawObject " ", "", 1, "", 5, "1,2,3,4", "", "false,1"

<% if(client_address.length()<=30){%>
obj.DrawObject " ", "", 0, "578,36", 1, "1,2,3,4", "", "true,1"
obj.DrawObject " ", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "<%=client_postcode%>", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "<%=client_address%>", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"

<%}else{%>
obj.DrawObject " ", "", 0, "578,36", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "<%=client_postcode%>", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "<%=client_address1%>", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "<%=client_address2%>", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"
<%}%>



obj.DrawObject "<%=cust_name%> ", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "<%=client_linkman%>", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"
obj.DrawObject " ", "", 0, "578,2", 1, "1,2,3", "", "true,1"

obj.SetFontSize 28
obj.SetFontStyle 0,1,1
obj.DrawObject "�� �� ͨ ֪ ��", "", 0, "578,16", 5, "1,2,3,4", "", "true,1"


obj.SetFontSize 15
obj.SetFontStyle 0,1,0
obj.DrawObject " ", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "<%=cust_name%>��", "", 0, "578,16", 1, "1,2,3,4", "", "true,1"

obj.LineInterval=1
obj.SetFontSize 13
obj.SetFontStyle 0,0,0
obj.DrawObject " ", "", 0, "578,15", 1, "1,2,3,4", "", "true,1"
obj.DrawObject " ", "", 0, "28,1", 1, "1,2,3,4", "", "false,1"
obj.DrawObject "���ݹ���˫��ǩ���ı��Ϊ <%=contract_id%> �����޺�ͬ�涨��", "", 0, "578,1", 1, "1,2,3,4", "", "true,1"

obj.DrawObject "��1����Ӧ��", "", 0, "", 1, "1,2,3,4", "0,-2", "false,1"
obj.SetFontStyle 0,1,0
obj.DrawObject "<%=curr_plan_date.substring(0,4)%>��<%=curr_plan_date.substring(5,7).replaceAll("0","")%>��<%=curr_plan_date.substring(8,10).replaceAll("0","")%>��", "", 0, "", 1, "1,2,3,4", "0,-2", "flase,1"

obj.SetFontStyle 0,0,0
obj.DrawObject "��Ӧ�����գ���ǰ���ҹ�˾�˻����뵱�ڿ��", "", 0, "", 1, "1,2,3,4", "0,-2", "true,1"
obj.DrawObject "��<%=curr_rent_list%>����� ���Ϊ ��<%=formatNumberStr(curr_rent,"#,##0.00")%>Ԫ", "", 0, "", 1, "1,2,3,4", "28,-4", "true,1"

obj.DrawObject "��2������������˾֧���������ڿ��", "", 0, "", 1, "1,2,3,4", "0,14", "true,1"

<%if(!line_str1.equals("")){%>
obj.DrawObject "<%=line_str1%>", "", 0, "", 1, "1,2,3,4", "28,12", "true,1"
<%}else{%>
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "28,12", "true,1"
<%}%>
<%if(!line_str3.equals("")){%>
obj.DrawObject "<%=line_str3%>", "", 0, "", 1, "1,2,3,4", "28,10", "true,1"
<%}else{%>
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "28,10", "true,1"
<%}%>
<%if(!line_str5.equals("")){%>
obj.DrawObject "<%=line_str5%>", "", 0, "", 1, "1,2,3,4", "28,9", "true,1"
<%}else{%>
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "28,9", "true,1"
<%}%>

obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "", "true,1"

<%if(show_flag.equals("0")){%>
obj.DrawObject "��3����֧��", "", 0, "80,10", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,1,1
obj.DrawObject "���������ۣ�<%=formatNumberStr(nominalprice,"#,##0.00")%>Ԫ", "", 0, "160,10", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,0,0
obj.DrawObject "������Լ��֧������ǰ��", "", 0, "160,10", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,1,1
obj.DrawObject "��֤���վ�", "", 0, "80,10", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,0,0
obj.DrawObject "�Ļ����ҹ�˾��", "", 0, "120,10", 1, "1,2,3,4", "0,0", "true,1"
obj.DrawObject "�Ա�����豸����Ȩת��������", "", 0, "600,10", 1, "1,2,3,4", "28,0", "true,1"
<%}else{%>
obj.DrawObject " ", "", 0, "80,10", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,1,1
obj.DrawObject "", "", 0, "160,10", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,0,0
obj.DrawObject " ", "", 0, "160,10", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,1,1
obj.DrawObject "", "", 0, "80,10", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,0,0
obj.DrawObject " ", "", 0, "120,10", 1, "1,2,3,4", "0,0", "true,1"
obj.DrawObject " ", "", 0, "600,10", 1, "1,2,3,4", "28,0", "true,1"
<%}%>

obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "", "true,1"

<%if(show_flag.equals("0")){%>
obj.SetFontStyle 0,1,0
obj.DrawObject "��ͬ�����ϼƣ� ", "", 0, "", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,1,1
obj.DrawObject "��<%=formatNumberStr(total_money,"#,##0.00")%>Ԫ  ", "", 0, "", 1, "1,2,3,4", "0,0", "true,1"
obj.SetFontStyle 0,0,0
<%}else{%>
obj.SetFontStyle 0,1,0
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "0,0", "false,1"
obj.SetFontStyle 0,1,1
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "0,0", "true,1"
obj.SetFontStyle 0,0,0
<%}%>

obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "", "true,1"


obj.DrawObject "", "", 0, "562,124", 1, "", "", "true,1"
obj.SetOutline 0, 0, 1, 2, RGB(0, 0, 0)
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"
obj.DrawObject "", "", 0, "", 1, "1,2,3,4", "", "true,1"

obj.DrawObject "", "", 0, "600,1", 1, "1,2,3", "0,100", "true,1"

obj.DrawObject "˵����", "", 0, "", 1, "1,2,3,4", "0,-202", "true,1"
obj.DrawObject "1��	�����޺�ͬ�������涨�����������������밴��<%=formatNumberStr(String.valueOf(Double.parseDouble(pena_rate)/100),"#,##0.00")%>%֧���Ӹ���Ϣ��", "", 0, "", 1, "1,2,3,4", "0,-204", "true,1"
obj.DrawObject "2��	������֪ͨ����������������������ʼ������ӡ�ռǡ�", "", 0, "", 1, "1,2,3,4", "0,-206", "true,1"

<%if(show_flag.equals("0")){%>
obj.DrawObject "3��	�����޺�ͬԼ����", "", 0, "", 1, "1,2,3,4", "0,-208", "false,1"
obj.SetFontStyle 0,1,0
obj.DrawObject "<%=end_date%>������", "", 0, "", 1, "1,2,3,4", "0,-208", "true,1"
obj.SetFontStyle 0,0,0
<%}else{%>
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "0,-208", "false,1"
obj.SetFontStyle 0,1,0
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "0,-208", "true,1"
obj.SetFontStyle 0,0,0
<%}%>

obj.DrawObject "��ܰ��ʾ���Ӽ��������ǻ������Ϊ���ṩÿ��Ӧ�����ֻ��������ѷ����������ʣ�����", "", 0, "", 1, "1,2,3,4", "0,-210", "true,1"
obj.DrawObject "��˾�ͷ���ϵ����ϵ�绰��800-820-6213", "", 0, "", 1, "1,2,3,4", "0,-212", "true,1"

obj.SetFontStyle 0,1,0
obj.DrawObject "���Ž����������޹�˾", "", 0, "", 1, "1,2,3,4", "438,-192", "true,1"
obj.DrawObject "<%=bad_date.substring(0,4)%>��<%=bad_date.substring(5,7).replaceAll("0","")%>��<%=bad_date.substring(8,10).replaceAll("0","")%>��", "", 0, "", 1, "1,2,3,4", "468,-194", "true,1"

obj.SetFontStyle 0,0,0
obj.DrawObject "������", "", 0, "", 1, "1,2,3,4", "0,-176", "true,1"
obj.DrawObject "�㣺<%=lessor_name%> <%=bank_name%>��<%=lease_acc_number%>", "", 0, "", 1, "1,2,3,4", "0,-178", "true,1"

obj.DrawObject "������� ��<%=formatNumberStr(curr_rent,"#,##0.00")%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,819", "false,2"
obj.DrawObject "���ڷ�Ϣ��<%=formatNumberStr(c_punish,"#,##0.00")%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,838", "false,2"
obj.DrawObject "���ڿ��� ��<%=formatNumberStr(total_money_bad,"#,##0.00")%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,857", "false,2"

obj.SetFontStyle 0,0,1
<%if(show_flag.equals("0")){%>
obj.DrawObject "������ ��<%=formatNumberStr(nominalprice,"#,##0.00")%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,878", "false,2"
<%}else{%>
obj.DrawObject " ", "", 0, "", 1, "1,2,3,4", "26,878", "false,2"
<%}%>

obj.SetFontStyle 0,1,0
obj.DrawObject "�ϼƣ�<%=formatNumberStr(total_money,"#,##0.00")%>Ԫ", "", 0, "", 1, "1,2,3,4", "26,898", "false,2"
obj.SetFontStyle 0,0,0
obj.DrawObject "���� RMB  ��            Ԫ", "", 0, "", 1, "1,2,3,4", "0,919", "false,2"
obj.DrawObject "��ע�� ֧����ͬ <%=contract_id%> ���ȡ�", "", 0, "", 1, "1,2,3,4", "0,939", "false,2"
obj.SetFontStyle 0,1,0
obj.DrawObject "����Ϣ��Ҫ����������룬лл����", "", 0, "", 1, "1,2,3,4", "260,939", "false,2"

obj.SetFontSize 8
obj.DrawObject "Unitrust Finance & leasing Corporation", "", 0, "", 1, "1,2,3,4", "450,989", "false,2"

obj.DrawObject "", "", 2, "", 5, "1,2,3,4", "", "false,1"
obj.DrawObject "", "", 0, "", 5, "1,2,3,4", "", "true,3"
</script>
<%
//�����֪ͨ�����ݱ��浽���ݿ�
	notice_contact="";
	notice_content="";
	notice_explanation="";
	notice_note="";
	if(client_address.length()<=30){
		notice_contact+=client_postcode+"<br>";
		notice_contact+=client_address+"<br>";
	}else{
		notice_contact+=client_postcode+"<br>";
		notice_contact+=client_address1+"<br>";
		notice_contact+=client_address2+"<br>";
	}
	notice_contact+=cust_name+"<br>";
	notice_contact+=client_linkman+"<br>";
	//����
	notice_content+="����֪ͨ��<br>";
	notice_content+=cust_name+"<br>";
	notice_content+="���ݹ���˫��ǩ���ı��Ϊ "+contract_id+" �����޺�ͬ�涨��"+"<br>";
	notice_content+="��1����Ӧ��"+curr_plan_date.substring(0,4)+"��"+curr_plan_date.substring(5,7).replaceAll("0","")+"��"+curr_plan_date.substring(8,10).replaceAll("0","")+"�գ�Ӧ�����գ���ǰ���ҹ�˾�˻����뵱�ڿ��"+"<br>";
	notice_content+="��"+curr_rent_list+"����� ���Ϊ ��"+formatNumberStr(curr_rent,"#,##0.00")+"Ԫ"+"<br>";
	notice_content+="��2������������˾֧���������ڿ��"+"<br>";
	if(!line_str1.equals("")){
		notice_content+=line_str1+"<br>";
	}
	if(!line_str2.equals("")){
		notice_content+=line_str2+"<br>";
	}
	if(!line_str3.equals("")){
		notice_content+=line_str3+"<br>";
	}
	if(show_flag.equals("0")){
		notice_content+="��3����֧�����������ۣ�"+formatNumberStr(nominalprice,"#,##0.00")+"Ԫ������Լ��֧������ǰ����֤���վݼĻ����ҹ�˾��"+"<br>";
		notice_content+="�Ա�����豸����Ȩת��������"+"<br>";
		notice_content+="��ͬ�����ϼƣ�  ��"+formatNumberStr(total_money,"#,##0.00")+"Ԫ  "+"<br>";
	}
	//˵��
	notice_explanation+="˵��"+"<br>";
	notice_explanation+="1��	�����޺�ͬ�������涨�����������������밴��"+formatNumberStr(String.valueOf(Double.parseDouble(pena_rate)/100),"#,##0.00")+"%֧���Ӹ���Ϣ��"+"<br>";
	notice_explanation+="2��	������֪ͨ����������������������ʼ������ӡ�ռǡ�"+"<br>";
	if(show_flag.equals("0")){
		notice_explanation+="3��	�����޺�ͬԼ����2009-8-17������"+"<br>";
	}
	notice_explanation+="��ܰ��ʾ���Ӽ��������ǻ������Ϊ���ṩÿ��Ӧ�����ֻ��������ѷ����������ʣ�����"+"<br>";
	notice_explanation+="��˾�ͷ���ϵ����ϵ�绰��800-820-6213"+"<br>";
	//������
	notice_note+="������"+"<br>";
	notice_note+=lessor_name+" "+bank_name+": "+lease_acc_number+"<br>";
	notice_note+="������� ��"+formatNumberStr(curr_rent,"#,##0.00")+"Ԫ"+"<br>";
	notice_note+="���ڷ�Ϣ��"+formatNumberStr(c_punish,"#,##0.00")+"Ԫ"+"<br>";
	notice_note+="���ڿ��� ��"+formatNumberStr(total_money_bad,"#,##0.00")+"Ԫ"+"<br>";
	if(show_flag.equals("0")){
		notice_note+="������ ��"+formatNumberStr(nominalprice,"#,##0.00")+"Ԫ"+"<br>";
	}
	notice_note+="�ϼƣ�"+formatNumberStr(total_money,"#,##0.00")+"Ԫ"+"<br>";
	notice_note+="���� RMB  ��          Ԫ"+"<br>";
	notice_note+="��ע�� ֧����ͬ "+contract_id+" ���ȡ�����Ϣ��Ҫ����������룬лл����"+"<br>";
	
	sqlstr="insert into contract_payment_notice(contract_id,rent_list,notice_contact,notice_content,notice_explanation,notice_note,late_settlement,print_status,print_date,print_staff) select '"+contract_id+"',"+curr_rent_list+",'"+notice_contact+"','"+notice_content+"','"+notice_explanation+"','"+notice_note+"','"+bad_date+"','��','"+curr_date+"','"+dqczy+"'";
	System.out.println("sqlstrnotice=================================="+sqlstr);
	db1.executeUpdate(sqlstr);
	
}

//-------------------------------------------
//}



		rs.next();
		i++;
	}
}

//-------------------------------------------
rs.close();
%>
<script language="VBScript">
obj.PrintPreview
</script>
<%
db.close();
db1.close();
%>


</body>
</html>

