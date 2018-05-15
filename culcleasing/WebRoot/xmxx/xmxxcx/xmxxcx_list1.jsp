<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ��Ϣ - ��Ŀ��ѯ</title>
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

String proj_id = getStr( request.getParameter("proj_id") );
String proj_name = getStr( request.getParameter("proj_name") );
String cust_name = getStr( request.getParameter("cust_name") );

if(!proj_id.equals("")){
	wherestr+=" and proj_info.proj_id like '%"+proj_id+"%'";
}
if(!proj_name.equals("")){
	wherestr+=" and proj_info.project_name like '%"+proj_name+"%'";
}
if(!cust_name.equals("")){
	wherestr+=" and vi_cust_all_info.cust_name like '%"+cust_name+"%'";
}
sqlstr = "select proj_info.proj_id,proj_info.project_name as proj_name,proj_info.docurl,vi_cust_all_info.cust_name from proj_info left join vi_cust_all_info on proj_info.cust_id=vi_cust_all_info.cust_id" + wherestr; 
System.out.println("sqlstr============================================="+sqlstr);
%>
<body onload="public_onload(0)">

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle">
				��Ŀ��Ϣ &gt; ��Ŀ��ѯ</td>
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
<form name="searchbar" action="xmxxcx_list.jsp">
<tr>
<td>��Ŀ���<input name="proj_id" type="text" value="<%=proj_id %>"></td>
<td>��Ŀ����<input name="proj_name" type="text" value="<%=proj_name %>"></td>
<td>����ͻ�<input name="cust_name" type="text" value="<%=cust_name %>">
<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();"></td>
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

<form action="xmxxcx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKey" type="hidden" value="<%= searchKey %>">
<input name="searchFld" type="hidden" value="<%= searchFld %>">

<input name="proj_id" type="hidden" value="<%= proj_id %>">
<input name="proj_name" type="hidden" value="<%= proj_name %>">
<input name="cust_name" type="hidden" value="<%= cust_name %>">
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
		<th>��Ŀ���</th>
        <th>��Ŀ����</th>
        <th>����ͻ�</th>
        <th>��Ŀ��Ϣ</th>
      </tr>
  

<%	
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr onmouseover="fn_changeTrColor()" onmouseout="fn_changeTrColor()">
		
		<td><%= getDBStr( rs.getString("proj_id") ) %></td>
		<td><%= getDBStr( rs.getString("proj_name") ) %></td>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td><a href="<%= getDBStr( rs.getString("docurl") ) %>" target="_blank">�鿴</a></td>
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
