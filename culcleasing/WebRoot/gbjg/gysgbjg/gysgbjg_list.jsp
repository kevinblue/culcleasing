<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ���Ϣ���� - ��Ӧ����ҵ�ɱ��ṹ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%String project_id= getStr(request.getParameter("project_id")); %>
<body onload="setDivHeight('mydiv',-55)" style="border:1px solid #8DB2E3;">

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				��Ӧ����ҵ�ɱ��ṹ &gt; �ͻ���Ϣ����</td>
			</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%

ResultSet rs;
String wherestr = " where 1=1";

String sqlstr = "select * from vi_mproj_vndr_capital_struct" + wherestr +" order by modify_date desc"; 

%>


<form name="searchbar" action="gysgbjg_list.jsp">
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		
		<td nowrap></td>
		
		<td><a href="#" accesskey="n" onclick="dataHander('add','gysgbjg_add.jsp?project_id=<%=project_id %>',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="����(Alt+N)" align="absmiddle"></a></td>
		<td><a href="#" accesskey="m" onclick="dataHander('mod','gysgbjg_mod.jsp?project_id=<%=project_id %>&czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onclick="dataHander('del','gysgbjg_del.jsp?project_id=<%=project_id %>&czid=',dataNav.itemselect);"><img align="absmiddle" src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" align="absmiddle" ></a></td>
    </tr>
</table>
</form>
<!--������ť����-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 35;   //һҳ��ʾ�ļ�¼��
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

	rs.last();                                      //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;            //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
	
%>

<form action="gysgbjg_list.jsp" name="dataNav1" onSubmit="return goPage()">
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
</form>
</td>
</tr>
</table>

<!--��ҳ���ƽ���-->

<!--
</form>
<form name="list">
-->

<!--����ʼ-->

<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
<form action="gysgbjg_list.jsp" name="dataNav">
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>��Ҫ�ɶ�����</th>
	    <th>��֯��������/���֤��</th>
        <th>��Ӧ��</th>
        <th>��Ӫҵ��</th>                
        <th>ע���ʱ�</th>
		<th>�ֹɱ���</th>
      </tr>
  

<%	  

if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("id") ) %>"></td>
        <td align="left"><a href="gysgbjg.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank"><%= getDBStr( 	  rs.getString("shareholder") ) %></a></td>
		<td><%= getDBStr( rs.getString("id_number") ) %></td> 	 
		<td><%= getDBStr( rs.getString("vndr_name") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("primary_business") ) %></td>
		<td><%= getDBStr( rs.getString("registered_capital") ) %></td>
		<td><%= getDBStr( rs.getString("equity_ratio") ) %></td>
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
    </form>
</div>


<!--�������-->

</body>
</html>
