<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - ��ͬ��ѯ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<%
String sqlstr;
ResultSet rs;
String wherestr = " where 1=1";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

String industry_name = getStr( request.getParameter("industry_name") );
String equip_name = getStr( request.getParameter("equip_name") );
String contract_id = getStr( request.getParameter("contract_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String status_name = getStr( request.getParameter("status_name") );
String start_date = getStr( request.getParameter("start_date") );
String end_date = getStr( request.getParameter("end_date") );

if(!industry_name.equals("")){
	wherestr+=" and ifelc_conf_dictionary.title like '%"+industry_name+"%'";
}
if(!equip_name.equals("")){
	wherestr+=" and ifelc_conf_dictionary2.title like '%"+equip_name+"%'";
}
if(!contract_id.equals("")){
	wherestr+=" and vi_contract_info.contract_id like '%"+contract_id+"%'";
}
if(!cust_name.equals("")){
	wherestr+=" and vi_contract_info.cust_name like '%"+cust_name+"%'";
}
if(!proj_manage_name.equals("")){
	wherestr+=" and vi_contract_info.proj_manage_name like '%"+proj_manage_name+"%'";
}
if(!status_name.equals("")){
	wherestr+=" and vi_contract_info.status_name like '%"+status_name+"%'";
}
if(!start_date.equals("")){
	wherestr+=" and vi_contract_info.actual_start_date >= '"+start_date+"'";
}
if(!end_date.equals("")){
	wherestr+=" and vi_contract_info.actual_start_date <= '"+end_date+"'";
}
sqlstr = "select vi_contract_info.contract_id,vi_contract_info.cust_name,ifelc_conf_dictionary.title as industry_name, ifelc_conf_dictionary2.title as equip_name, vi_contract_info.actual_start_date,vi_contract_info.status_name,vi_contract_info.proj_manage_name, vi_contract_info.equip_amt ,vi_contract_info.docurl from vi_contract_info left join ifelc_conf_dictionary on vi_contract_info.industry_type=ifelc_conf_dictionary.name left join ifelc_conf_dictionary ifelc_conf_dictionary2 on vi_contract_info.equip_type=ifelc_conf_dictionary2.name" + wherestr; 
System.out.println("sqlstr============================================="+sqlstr);
%>
<body onload="public_onload(0)">

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle">
				��ͬ��Ϣ &gt; ��ͬ��ѯ</td>
			</tr>
</table>
<!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;�߼�����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<form name="searchbar" action="htxxcx_list.jsp">
<tr><td>�ڲ���ҵ<select name="industry_name"></select>
<script language="javascript">dict_list("industry_name","industry_type","<%=industry_name%>","title");</script></td>
<td>�豸����<select name="equip_name"></select>
<script language="javascript">dict_list("equip_name","equipment_type","<%=equip_name%>","title");</script></td>
<td>��ͬ���<input name="contract_id" type="text" value="<%=contract_id %>"></td>
<td>����ͻ�<input name="cust_name" type="text" value="<%=cust_name %>"></td>
</tr>
<tr>
<td>��Ŀ������<input name="proj_manage_name" type="text" value="<%=proj_manage_name %>"></td>
<td>��ͬ״̬<input name="status_name" type="text" size="20" value="<%=status_name %>" readonly><input type="hidden" name="status"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','��ͬ״̬','base_contractstatus','status_name','status_code','status_name','status_name','asc','searchbar.status_name','searchbar.status');"></td>
<td>��ʼ����<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>��������<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();"></td>
</tr>

</form></table>
</fieldset>
</div>
<!--���۵���ѯ����-->



<!--������Ͳ�������ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">

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

<form action="htxxcx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKey" type="hidden" value="<%= searchKey %>">
<input name="searchFld" type="hidden" value="<%= searchFld %>">

<input name="industry_name" type="hidden" value="<%= industry_name %>">
<input name="equip_name" type="hidden" value="<%= equip_name %>">
<input name="contract_id" type="hidden" value="<%= contract_id %>">
<input name="cust_name" type="hidden" value="<%= cust_name %>">
<input name="proj_manage_name" type="hidden" value="<%= proj_manage_name %>">
<input name="status_name" type="hidden" value="<%= status_name %>">
<input name="start_date" type="hidden" value="<%= start_date %>">
<input name="end_date" type="hidden" value="<%= end_date %>">
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

   <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>��ͬ��</th>
        <th>����ͻ�</th>
        <th>�ڲ���ҵ</th>
        <th>�豸����</th>
        <th>����</th>
        <th>��ͬ״̬</th>
        <th>�豸���</th>
      </tr>
  

<%	
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr onmouseover="fn_changeTrColor()" onmouseout="fn_changeTrColor()">
		<td><a href="<%= getDBStr( rs.getString("docurl") ) %>" target="_blank"><%= getDBStr( rs.getString("contract_id") ) %></a></td>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td><%= getDBStr( rs.getString("industry_name") ) %></td>
		<td><%= getDBStr( rs.getString("equip_name") ) %></td>
		<td><%= getDBDateStr( rs.getString("actual_start_date") ) %></td>
		<td><%= getDBStr( rs.getString("status_name") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs.getString("equip_amt") ),"#,##0.00") %></td>
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

<!--�������-->

</body>
</html>
