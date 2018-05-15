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
if (right.CheckRight("contract-zbqd-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ�����嵥 - ��ͬ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
ResultSet rs;
String searchKey = getStr( request.getParameter("searchKey") );
String wherestr = "";
if(!searchKey.equals("")) {
	wherestr = "and info.contract_id like '%"+searchKey+"%'";
}
String sqlstr = "select DISTINCT info.contract_id,dbo.getcustnamebycontractid(info.contract_id) as cust_name,DBO.GETMODELBYID(equip.DEVICE_TYPE) AS DEVICE_TYPE,equip.equip_sn,convert(varchar(10),start_date,120) as start_date,first_payment_ratio,lease_term,convert(varchar,(select top 1 rent from fund_rent_plan as plans where plans.contract_id=info.contract_id order by rent_list),1) as rent,dbo.fk_getname(info.proj_dept)as proj_dept ,base.province,convert(varchar(10),confirm_date,120)as confirm_date,convert(varchar(10),get_date,120) as get_date,dbo.getattach(info.contract_id) as attach_memo,convert(varchar(10),branch_expdate,120) as branchexpdate ,convert(varchar(10),csmd_receive_date,120)as csmdredate,convert(varchar(10),csmd_expdate,120)as csmdexpdate,convert(varchar(10),proj.offer_date,120) as offer_date,special_remark from contract_info as info left join contract_condition as con on (info.contract_id=con.contract_id) left join contract_equip as equip on (info.contract_id=equip.contract_id) left join downpayment_info as down on (info.contract_id=down.contract_id) left join insurance_info as ins on (info.contract_id=ins.contract_id) left join proj_info as proj on(info.proj_id=proj.proj_id) left join contract_time_info as timeinfo on(info.contract_id=timeinfo.contract_id) left join base_filiale_province as base on(info.proj_dept=base.filiale_id) where 1=1 " +wherestr; 
System.out.println("sqlstr=================="+sqlstr);
%>
<body onLoad="public_onload(0);">
<form action="zbqd_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				��ͬ���� &gt; ��ͬ�����嵥</td>
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
<a href="#" accesskey="n" onClick="dataHander('mod','zbqd_mod.jsp?czid=',dataNav.itemselect);"><img  src="../../images/sbtn_mod.gif" alt="�޸�(Alt+N)" align="absmiddle"></a></td>
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
		<th>�ͻ�����</th>
		<th>�豸�ͺ�</th>
        <th>�����</th>
        <th>������</th>
        <th>�׸�����</th>
        <th>��������</th>
        <th>ÿ�����</th>
        <th>�ֹ�˾</th>
        <th>ʡ��</th>
        <!--<th>�������ڵ�</th>-->
        <th>�׸�ȷ������</th>
        <th>�ձ�������</th>
        <th>�ļ���ע</th>
        <!--<th>��Ʊ������</th>-->
        <th>�ֹ�˾�ļ���</th>
        <th>CSMD�ռ���</th>
        <th>CSMD�ļ���</th>
        <th>����ͨ������</th>
        <th>�ر�ע</th>
      </tr>


<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("contract_id") ) %>"></td>
        <td><%= getDBStr(rs.getString("cust_name") ) %></td>
        <td><%= getDBStr( rs.getString("DEVICE_TYPE") ) %></td>
        <td><%= getDBStr( rs.getString("equip_sn") ) %></td>
        <td><%= getDBDateStr( rs.getString("start_date") ) %></td>
        <td><%= getDBStr( rs.getString("first_payment_ratio") ) %></td>
        <td><%= getDBStr( rs.getString("lease_term") ) %></td>        
        <td><%= getDBStr( rs.getString("rent") ) %></td>
        <td><%= getDBStr( rs.getString("proj_dept") ) %></td>
        <td><%= getDBStr( rs.getString("province") ) %></td>
        <!--<td></td>-->
        <td><%= getDBDateStr( rs.getString("confirm_date") ) %></td>
        <td><%= getDBDateStr( rs.getString("get_date") ) %></td>
        <td><%= getDBStr( rs.getString("attach_memo") ) %></td>
        <!--<td></td>-->
        <td><%= getDBDateStr( rs.getString("branchexpdate") ) %></td>
        <td><%= getDBDateStr( rs.getString("csmdredate") ) %></td>
        <td><%= getDBDateStr( rs.getString("csmdexpdate") ) %></td>
        <td><%= getDBDateStr( rs.getString("offer_date") ) %></td>
        <td><%= getDBStr( rs.getString("special_remark") ) %></td>
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
