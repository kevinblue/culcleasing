<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
/*if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("inspecter-jxkcnb-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
*/
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����Ӧ����� - ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="public_onload(0)">
<form action="dyys_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				����&gt; ����Ӧ�����</td>
			</tr>
</table>
<%
String date=getSystemDate(0);
String dates[]=date.split("-");
int year=Integer.parseInt(dates[0]);
int month=Integer.parseInt(dates[1]);
String star=year+"-"+month+"-1";
String end=year+"-"+(month+1)+"-1";
if(month==12){end=(year+1)+"-1-1";}
ResultSet rs;
String sqlstr = "select distinct info.contract_id,dbo.getcustnamebycontractid(info.contract_id) as cust_name,(select top 1 finstart_date from contract_finstartdate where contract_id=info.contract_id order by finstart_date desc) as finstart_date,isnull(actual_start_date,start_date) as start_date,o_his.payment_date,dbo.getmodelbyid(equip.device_type) as device_type,equip.equip_sn,dbo.fk_getname(info.vndr_id) as vndr_id,cond.machine_price,cond.insurance,isnull(cond.csa_cost,0) as csa_cost ,cond.machine_price+isnull(cond.insurance,0)+isnull(cond.csa_cost,0)  as pay,cond.supervision_fee,cond.nominalprice,cond.caution_money,cond.first_payment,(isnull(cond.supervision_fee,0)+isnull(cond.nominalprice,0)+isnull(cond.caution_money,0)+isnull(cond.first_payment,0)) as firstpay,d_his.receive_date,(select isnull(sum(isnull(rent,0)),0) from fund_rent_income where contract_id=info.contract_id and hire_date>='"+star+"' and hire_date<'"+end+"') as hire_rent,(select isnull(sum(isnull(rent,0)),0) from fund_rent_plan where contract_id=info.contract_id  )-(select isnull(sum(isnull(rent,0)),0) from fund_rent_income where contract_id=info.contract_id ) as no_rent,(select isnull(sum(isnull(interest,0)),0) from fund_rent_plan where contract_id=info.contract_id  )-(select isnull(sum(isnull(interest,0)),0) from fund_rent_income where contract_id=info.contract_id ) as no_interest,(select fin_interest from vi_fin_fund_rent_plan where contract_id=info.contract_id and fin_plan_date>='"+star+"' and fin_plan_date<'"+end+"') as fin_interest,(select isnull(sum(isnull(rent,0)),0) from fund_rent_plan where contract_id=info.contract_id and datediff(mm,'"+star+"',plan_date)>=0 and datediff(mm,'"+star+"',plan_date)<=12 )-(select isnull(sum(isnull(rent,0)),0) from fund_rent_income where contract_id=info.contract_id and datediff(mm,'"+star+"',hire_date)>=0 and datediff(mm,'"+star+"',hire_date)<=12) as no_rent_12,(select isnull(sum(isnull(interest,0)),0) from fund_rent_plan where contract_id=info.contract_id  and datediff(mm,'"+star+"',plan_date)>=0 and datediff(mm,'"+star+"',plan_date)<=12 )-(select isnull(sum(isnull(interest,0)),0) from fund_rent_income where contract_id=info.contract_id and datediff(mm,'"+star+"',hire_date)>=0 and datediff(mm,'"+star+"',hire_date)<=12 ) as no_interest_12,(select isnull(sum(isnull(rent,0)),0) from fund_rent_plan where contract_id=info.contract_id and datediff(yy,'"+star+"',plan_date)>=0 and datediff(yy,'"+star+"',plan_date)<=5 )-(select isnull(sum(isnull(rent,0)),0) from fund_rent_income where contract_id=info.contract_id and datediff(yy,'"+star+"',hire_date)>=0 and datediff(yy,'"+star+"',hire_date)<=5) as no_rent_5,(select isnull(sum(isnull(interest,0)),0) from fund_rent_plan where contract_id=info.contract_id  and datediff(yy,'"+star+"',plan_date)>=0 and datediff(yy,'"+star+"',plan_date)<=5 )-(select isnull(sum(isnull(interest,0)),0) from fund_rent_income where contract_id=info.contract_id and datediff(yy,'"+star+"',hire_date)>=0 and datediff(yy,'"+star+"',hire_date)<=5 ) as no_interest_5,(select isnull(sum(isnull(rent,0)),0) from fund_rent_plan where contract_id=info.contract_id and datediff(yy,'"+star+"',plan_date)>5 )-(select isnull(sum(isnull(rent,0)),0) from fund_rent_income where contract_id=info.contract_id and datediff(yy,'"+star+"',hire_date)>5) as no_rent_out_5,(select isnull(sum(isnull(interest,0)),0) from fund_rent_plan where contract_id=info.contract_id  and datediff(yy,'"+star+"',plan_date)>5 )-(select isnull(sum(isnull(interest,0)),0) from fund_rent_income where contract_id=info.contract_id and datediff(yy,'"+star+"',hire_date)>5 ) as no_interest_out_5 from contract_info as info left join contract_condition as cond on (info.contract_id=cond.contract_id)left join contract_equip as equip on (info.contract_id=equip.contract_id)left join fund_down_payment_his as d_his on (info.contract_id=d_his.contract_id)left join fund_out_payment_his as o_his on (info.contract_id=o_his.contract_id)where info.contract_id in (select contract_id from fund_rent_plan group by contract_id)"; 
System.out.print(sqlstr);
%>

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
<td align="right">
<%
int intPageSize = 17;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��

	int intPage;       //����ʾҳ��
	String strPage = getStr( request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	 intPage = 1;
	}else{
	  intPage = java.lang.Integer.parseInt(strPage);
	  if(intPage<1) intPage = 1;
	} 
rs=db.executeQuery(sqlstr); 


	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //������ҳ��
	if(intPage>intPageCount) intPage = intPageCount;            //��������ʾ��ҳ��
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0; %>
    
<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>�� <%=intRowCount%> �� / <%=intPageCount%> ҳ 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="��һҳ"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="��һҳ"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="��һҳ" border="0"><% } %>
	�� <font color="red"><%=intPage%></font> ҳ	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="���ҳ" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="���ҳ" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>ת�� <input name="page" type="text" size="2" value="1"> ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>
<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
      <th></th>
		 <th>��ͬ���</th>
         <th>�ͻ�����</th>
		 <th>��������ڼ�</th>
         <th>&nbsp;&nbsp;������&nbsp;&nbsp;&nbsp;</th>
		 <th>����ʱ��&nbsp;&nbsp;</th>
		 <th>�豸�ͺ�</th>         
		 <th>�������</th>
         <th>��Ӧ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
         <th>�����۸�</th>
         <th>���շ�</th>
         <th>CSA</th>
         <th>Ӧ���˿�</th>
         <th>�����</th>
         <th>��Ѻ��</th>
         <th>��֤��</th>
         <th>DownPayment</th>
         <th>�׸���</th>
         <th>�յ�����</th>
         <th>�����յ����</th>
         <th>Ӧ��δ�����</th>
         <th>δʵ����Ϣ���</th>
         <th>����ȷ����Ϣ</th>
         <th>��12����δ���ڱ���</th>
         <th>��12����δ������Ϣ</th>
         <th>ʣ��5���ڵ��ڱ���</th>
         <th>ʣ��5���ڵ�����Ϣ</th>
         <th>����5�굽�ڱ���</th>
         <th>����5�굽����Ϣ</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
		
%>  
     <tr class="cwDLRow" >
        <td><input class="rd" type="radio" name="itemselect" value=""></td>
		<td align="center"><%=getDBStr( rs.getString("contract_id") ) %></td>
        <td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>
        <%
		String temp=getDBDateStr(rs.getString("finstart_date"));
		if(!temp.equals("")){
		String datess[]=temp.split("-");
		temp=datess[0]+"-"+datess[1];
		}
		%>
        <td align="center"><%=temp %></td>		
        <td align="center"><%=getDBDateStr( rs.getString("start_date") ) %></td>
        <td align="center"><%=getDBDateStr( rs.getString("payment_date") ) %></td>
        <td align="center"><%=getDBStr( rs.getString("device_type") ) %></td>
        <td align="center"><%=getDBStr( rs.getString("equip_sn") ) %></td>
        <td align="center"><%=getDBStr( rs.getString("vndr_id") ) %></td>
		<td align="center"><%=formatNumberStr( rs.getString("machine_price"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("insurance"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("csa_cost"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("pay"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("supervision_fee"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("nominalprice"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("caution_money"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("first_payment"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("firstpay"),"#,##0.00" ) %></td>
        <td align="center"><%=getDBDateStr( rs.getString("receive_date") ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("hire_rent"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("no_rent"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("no_interest"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("fin_interest"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("no_rent_12"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("no_interest_12"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("no_rent_5"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("no_interest_5"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("no_rent_out_5"),"#,##0.00" ) %></td>
        <td align="center"><%=formatNumberStr( rs.getString("no_interest_out_5"),"#,##0.00" ) %></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>

    </table>

</div>
</form>
</body>
</html>
