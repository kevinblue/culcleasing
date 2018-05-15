<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("contract-htlb-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���󱨱� -��ͬ���� </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
ResultSet rs;
String searchKey = getStr( request.getParameter("searchKey") );
String wherestr = "";
if(!searchKey.equals("")) {
	wherestr = "and contract_info.contract_id like '%"+searchKey+"%'";
}
String sqlstr = "select contract_info.id,contract_info.proj_id,proj_approve_id,custName=dbo.GETCUSTNAME(contract_info.cust_id),custCode=dbo.getCustCode(contract_info.cust_id),industry_type=dbo.FK_GETNAME(contract_info.industry_type),gyName=dbo.FK_GETNAME(contract_info.vndr_id),assurorName=dbo.GETCUSTNAME(assuror),assurorCode=dbo.getCustCode(assuror),projName=dbo.FK_GETNAME(contract_info.proj_dept),province,dbo.getmodelbyid(contract_equip.device_type)as model_name,contract_equip.equip_sn,contract_equip.equip_num,first_payment,lease_term,lease_amt,lease_money,irr,contract_condition.create_date,approve_conclusion,approve_date,rent=(select top 1 isnull(rent,0)+isnull(rent_adjust,0) from fund_rent_plan where contract_id=contract_info.contract_id and datediff(dd,plan_date,getdate())<=0 order by id), out_time,isnull(actual_start_date,start_date) as actual_start_date,contract_info.contract_id,hkzfzt=(case when total_payment is null then 'n' else 'y' end),total_payment,fund_out_payment_his.payment_date,approve_remark,dbo.getapprovedstatus(contract_info.contract_id) as status from contract_info left join proj_info on(contract_info.proj_id=proj_info.proj_id) left join contract_guarantee_method on(contract_info.contract_id=contract_guarantee_method.contract_id) left join base_filiale_province on(contract_info.proj_dept=base_filiale_province.filiale_id) left join contract_equip on (contract_info.contract_id=contract_equip.contract_id) left join contract_condition on (contract_info.contract_id=contract_condition.contract_id) left join fund_out_payment_his on (contract_info.contract_id=fund_out_payment_his.contract_id) where 1=1 " +wherestr; 
%>
<body onLoad="public_onload(0);">
<form action="htlb_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				��ͬ���� &gt; ���󱨱�</td>
			</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="35%">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td align="left" width="30%">
					 &nbsp;����ͬ��Ų�ѯ
<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>
"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
<a href="#" accesskey="n" onClick="dataHander('mod','htlb_update.jsp?czid=',dataNav.itemselect);"><img  src="../../images/sbtn_mod.gif" alt="�޸�(Alt+N)" align="absmiddle"></a></td>
    </tr>
</table>
<td align="left" width="1%">

<!--������ť��ʼ-->
<!--������ť����-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 15;   //һҳ��ʾ�ļ�¼��
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


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;            //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
	
%>


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

<!--��ҳ���ƽ���-->






<!--����ʼ-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th>��Ŀ���</th>
        <th>��ͬ���</th>
		<th>�����</th>
        <th>&nbsp;�ͻ�����&nbsp;</th>
        <th>�ͻ����֤/<br/>��֯��������</th>
        <th>�ڲ���ҵ</th>
        <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��Ӧ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        <th>������</th>
        <th>���������֤<br/>��֯��������</th>
        <th>�ֹ�˾</th>
        <th>ʡ��</th>
        <th>�豸�ͺ�</th>
		<th>�����</th>
		<th>����</th>
		<th>�׸�</th>
		<th>����</th>
		<th>�����ܶ�</th>
		<th>�����ʶ�</th>
		<th>ʵ������</th>
		<th>��������&nbsp;&nbsp;&nbsp;&nbsp;</th>
		<th>����״̬</th>
		<th>��������&nbsp;&nbsp;&nbsp;&nbsp;</th>
		<th>�»���</th>
		<th>�����ļ�״̬</th>
		<th>&nbsp;&nbsp;&nbsp;&nbsp;������&nbsp;&nbsp;&nbsp;&nbsp;</th>
		<th>&nbsp;&nbsp;&nbsp;&nbsp;������&nbsp;&nbsp;&nbsp;&nbsp;</th>
		<!--<th>��Ч��</th>-->	
		<th>����֧��״̬</th>
		<th>�ϳɸ������и���</th>
		<th>��������</th>
		<th width="30%">��Ŀ��ע</th>
      </tr>


<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td align="center"><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("contract_id") ) %>"></td>
        <td align="center"><%= getDBStr(rs.getString("proj_id") ) %></td>
        <td align="center"><%= getDBStr(rs.getString("contract_id") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("proj_approve_id") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("custName") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("custCode") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("industry_type") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("gyName") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("assurorName") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("assurorCode") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("projName") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("province") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("model_name") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("equip_sn") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("equip_num") ) %></td>
		<td align="center"><%= formatNumberDoubleTwo(rs.getString("first_payment") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("lease_term") ) %></td>
		<td align="center"><%= formatNumberDoubleTwo(rs.getString("lease_amt") ) %></td>
		<td align="center"><%= formatNumberDoubleTwo(rs.getString("lease_money") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("irr") ) %></td>
		<td align="center"><%= getDBDateStr(rs.getString("create_date") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("approve_conclusion") ) %></td>
		<td align="center"><%= getDBDateStr(rs.getString("approve_date") ) %></td>
		<td align="center"><%= formatNumberDoubleTwo(rs.getString("rent") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("status") ) %></td>
		<td align="center"><%= getDBDateStr(rs.getString("out_time") ) %></td>
		<td align="center"><%= getDBDateStr(rs.getString("actual_start_date") ) %></td>
		<!-- <td align="center">.</td> -->	
		<td align="center"><%= getDBStr(rs.getString("hkzfzt") ) %></td>
		<td align="center"><%= formatNumberDoubleTwo(rs.getString("total_payment") ) %></td>
		<td align="center"><%= getDBDateStr(rs.getString("payment_date") ) %></td>
		<td align="center"><%= getDBStr(rs.getString("approve_remark") ) %></td>
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

<!--�������-->
</form>
</body>
</html>
