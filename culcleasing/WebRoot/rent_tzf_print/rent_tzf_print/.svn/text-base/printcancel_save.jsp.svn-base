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
if (right.CheckRight("printcancel-save",dqczy)>0) canedit=1;
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
sqlstr = "select aa.* from (select ifelc_conf_dictionary.title as industry_name,contract_payment_notice.id,a.contract_id,dbo.bb_getDeduRent_tzf(fund_rent_plan.contract_id,fund_rent_plan.rent_list) as deduRent,contract_payment_notice.print_status from ( select fund_rent_plan.contract_id, max(fund_rent_plan.plan_date) as plan_date from fund_rent_plan where plan_date>='"+s_date+"' and plan_date<='"+e_date+"' group by fund_rent_plan.contract_id )a left join contract_signatory on a.contract_id=contract_signatory.contract_id left join vi_cust_all_info on contract_signatory.client=vi_cust_all_info.cust_id inner join fund_rent_plan on a.contract_id=fund_rent_plan.contract_id and a.plan_date=fund_rent_plan.plan_date left join contract_condition on a.contract_id=contract_condition.contract_id left join vi_cust_all_info vi_cust_all_info2 on contract_signatory.lessor=vi_cust_all_info2.cust_id left join cust_account on contract_signatory.lease_acc_number=cust_account.acc_number and contract_signatory.lessor=cust_account.cust_id left join vi_contract_info on a.contract_id=vi_contract_info.contract_id left join ( 	select contract_payment_notice.* from contract_payment_notice where id in( 		select max(id) as id from contract_payment_notice group by contract_id,rent_list 	) )contract_payment_notice on fund_rent_plan.contract_id=contract_payment_notice.contract_id and fund_rent_plan.rent_list=contract_payment_notice.rent_list left join ifelc_conf_dictionary on vi_contract_info.industry_type=ifelc_conf_dictionary.name)aa"+wherestr; 
if(!print_flag.equals("")){
	sqlstr = sqlstr+" and isnull(aa.print_status,'否')='"+print_flag+"'";
}
sqlstr+=" order by aa.contract_id";
System.out.println("sqlstr_Pcancel=================================="+sqlstr);

//---------------------------
%>

<!--翻页控制开始-->


<% 
	int intPageSize = 300;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("intPage") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 


	rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>




<%	
rs.previous();
if ( rs.next() ) {  
	while( i < intPageSize && !rs.isAfterLast() ) {
			sqlstr="update contract_payment_notice set print_status='否' where id='"+getDBStr( rs.getString("id") )+"'";
			db1.executeUpdate(sqlstr);
		rs.next();
		i++;
	}
}

//-------------------------------------------
rs.close();
db1.close();
db.close();
%>

<script>
			window.close();
			opener.alert("修改打印状态成功!");
			opener.location.reload();
		</script>
</body>
</html>

