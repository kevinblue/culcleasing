<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body>
<form action="zjjh_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> �ʽ���֧���� &gt; �ʽ���֧�嵥</td>
  </tr>
</table>
<%
String searchFld = getStr( request.getParameter("searchFld") );
String searchFld_tmp = "";
if( searchFld.equals("�޵��ݺ�") ) {
	searchFld_tmp = "where invoice_no=null";
}else if( searchFld.equals("�е��ݺ�") ) {
	searchFld_tmp = "where invoice_no<>''";
}else if( searchFld.equals("ȫ����ʾ") ) {
	searchFld_tmp = "";
}else{
	searchFld_tmp = "where invoice_no=null";
}
ResultSet rs;
String sqlstr = "select inm.id,dbo.getcustnamebycontractid(inm.contract_id) as cust_name,inm.contract_id,dbo.getmodelbyid(info.device_type) as device_type,inm.ebank_number,inm.plan_list,inm.hire_list,inm.hire_type,inm.balance_mode,inm.hire_date,inm.invoice_no,inm.rent,inm.corpus,inm.interest,inm.penalty,inm.rent_adjust,inm.corpus_adjust,inm.interest_adjust,inm.penalty_adjust,inm.hire_source,inm.hire_object,inm.hire_bank,inm.hire_account,inm.hire_number,inm.accounting_date,inm.instead_flag,inm.memo from fund_rent_income as inm left join contract_equip as info  on (info.contract_id=inm.contract_id) "+searchFld_tmp+" order by id desc";
System.out.println(sqlstr);
%>
<form name="searchbar" action="zjjh_list.jsp">
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left" width="30%"><table border="0" cellspacing="0" cellpadding="0" >
          <tr class="maintab">
          <td>��ʾ����:<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","�޵��ݺ�|�е��ݺ�|ȫ����ʾ"));</script></select><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();"></td>
            <td><a href="#" accesskey="u" onClick="dataHander('add_modal','zjjh_upload.jsp',dataNav.itemselect);"><img src="../../images/sbtn_2Excel.gif" alt="����(Alt+U)" width="19" height="19" align="absmiddle"></a></td>
            <td><a href="zjjh_out.jsp"><img src="../../images/sbtn_down.gif" alt="����(Alt+U)" width="19" height="19" align="absmiddle"></a></td>
          </tr>
        </table></td>
      <td align="right" width="50%"><%
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
              <%if(intPage>1){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="��һҳ"    border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="��һҳ"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="��һҳ" border="0">
              <% } %>
              �� <font color="red"><%=intPage%></font> ҳ
              <%if(intPage<intPageCount){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="���ҳ" border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="���ҳ" border="0">
              <% } %></td>
            <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
            <td nowrap>ת��
              <input name="page" type="text" size="2" value="1">
              ҳ <img  style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
          </tr>
        </table>
        <!-- end cwCellTop --></td>
    </tr>
  </table>
<div style="vertical-align:top;height:500px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
    <tr class="maintab_content_table_title">
<th width="1%">id</th>
<th>�û���</th>
<th>��ͬ���</th>
<th>�豸�ͺ�</th>
<th>�������</th>
<th>�ƻ�����</th>
<th>��������</th>
<th>��������</th>
<th>���㷽ʽ</th>
<th>��������</th>
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
<th>���������ʻ�</th>
<th>���������ʺ�</th>
<th>��ƴ�����</th>
<th>�Ƿ����</th>
<th>��ע</th>
<th>���ݺ�</th>
    </tr>
    <%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
    <tr class="cwDLRow" >
      <td><%=getDBStr( rs.getString("id") ) %></td>
      <td><%= getDBStr( rs.getString("cust_name") ) %></td>
      <td><%=getDBStr( rs.getString("contract_id") ) %></td>
      <td><%=getDBStr( rs.getString("device_type") ) %></td>
      <td><%=getDBStr( rs.getString("ebank_number") ) %></td>
      <td><%=getDBStr( rs.getString("plan_list") ) %></td>
      <td><%=getDBStr( rs.getString("hire_list") ) %></td>
      <td><%=getDBStr( rs.getString("hire_type") ) %></td>
      <td><%=getDBDateStr( rs.getString("balance_mode") ) %></td>
      <td><%=getDBDateStr( rs.getString("hire_date") ) %></td>
      <td><%=getDBStr( rs.getString("rent") ) %></td>
      <td><%=getDBStr( rs.getString("corpus") ) %></td>
      <td><%=getDBStr( rs.getString("interest") ) %></td>
      <td><%=getDBStr( rs.getString("penalty") ) %></td>
      <td><%=getDBStr( rs.getString("rent_adjust") ) %></td>
      <td><%=getDBStr( rs.getString("corpus_adjust") ) %></td>
      <td><%=getDBStr( rs.getString("interest_adjust") ) %></td>
      <td><%=getDBDateStr( rs.getString("penalty_adjust") ) %></td>
      <td><%=getDBStr( rs.getString("hire_source") ) %></td>
      <td><%=getDBStr( rs.getString("hire_object") ) %></td>
      <td><%=getDBStr( rs.getString("hire_bank") ) %></td>
<td><%=getDBStr( rs.getString("hire_account") ) %></td>
<td><%=getDBStr( rs.getString("hire_number") ) %></td>
<td><%=getDBDateStr( rs.getString("accounting_date") ) %></td>
<td><%=getDBStr( rs.getString("instead_flag") ) %></td>
<td><%=getDBStr( rs.getString("memo") ) %></td>
      <td><%= getDBStr( rs.getString("invoice_no") ) %></td>
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
  <!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
 </form>
</form>
<!-- end cwMain -->
</body>
</html>
