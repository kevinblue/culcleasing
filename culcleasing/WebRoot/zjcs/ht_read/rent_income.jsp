<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���ƻ� - �����ƻ��޸�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String dqczy=(String) session.getAttribute("czyid");

%>


<body onload="public_onload(0);">
<form action="chjhxg_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				���ƻ� &gt; �����ƻ��޸�</td>
			</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%

String curr_date = getSystemDate(0);

String sqlstr;
ResultSet rs;
String wherestr = " where 1=1";

String contract_id=getStr( request.getParameter("contract_id") );
sqlstr="select fund_rent_income.*,ifelc_conf_dictionary.title as balance_mode_name from fund_rent_income left join ifelc_conf_dictionary on fund_rent_income.balance_mode=ifelc_conf_dictionary.name where fund_rent_income.contract_id='"+contract_id+"'";
//sqlstr="select fund_rent_income.* from fund_rent_income";

%>



<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		
		
    </tr>
</table>
<!--������ť����-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 200;   //һҳ��ʾ�ļ�¼��
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
		<th>��ͬ���</th>
        <th>�������</th>
        <th>�ƻ�����</th>
        <th>��������</th>
        <th>��������</th>
        <th>���㷽ʽ</th>
        <th>��������</th>
        <th>���ݺ�</th>
        <th>�������</th>
        <th>��������</th>
        <th>������Ϣ</th>
        <th>������Ϣ</th>
        <th>������</th>
        <th>�������</th>
        <th>��Ϣ����</th>
        <th>��Ϣ����</th>
        <th>������Դ</th>
        <th>������</th>
        <th>������λ����</th>
        <th>���������˻�</th>
        <th>���������ʺ�</th>
        <th>��ƴ�����</th>
        <th>��ע</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
		<td><%= getDBStr( rs.getString("contract_id") ) %></td> 
		<td><%= getDBStr( rs.getString("ebank_number") ) %></td> 
		<td><%= getDBStr( rs.getString("plan_list") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_list") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_type") ) %></td> 
		<td><%= getDBStr( rs.getString("balance_mode_name") ) %></td>
		<td><%= getDBDateStr( rs.getString("hire_date") ) %></td> 
		<td><%= getDBStr( rs.getString("invoice_no") ) %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("corpus") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("interest") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("penalty") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("rent_adjust") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("corpus_adjust") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("interest_adjust") ),"#,##0.00") %></td> 
		<td><%= formatNumberStr(getDBStr( rs.getString("penalty_adjust") ),"#,##0.00") %></td> 
		<td><%= getDBStr( rs.getString("hire_source") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_object") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_bank") ) %></td> 
		<td><%= getDBStr( rs.getString("hire_account") ) %></td>
		<td><%= getDBStr( rs.getString("hire_number") ) %></td> 
		<td><%= getDBDateStr( rs.getString("accounting_date") ) %></td> 
		<td><%= getDBStr( rs.getString("memo") ) %></td>
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
