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
if (right.CheckRight("duning-record-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ - �߿�Ա�������򻮷�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				������Ϣ &gt; �߿�Ա�������򻮷�</td>
			</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->

<%
ResultSet rs;
String wherestr = " where 1=1 ";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

String searchFld_tmp = "";
if( searchFld.equals("ʡ") ) {
	searchFld_tmp = "jb_ssxx.sfmc";
}else if( searchFld.equals("��") ) {
	searchFld_tmp = "jb_csxx.csmc";
}else if( searchFld.equals("�߿�Ա") ) {
	searchFld_tmp = "base_user.name";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%' ";
}


String sqlstr = "SELECT jb_csxx.id as csid,jb_csxx.csmc,jb_ssxx.sfmc,base_user.name FROM base_user RIGHT OUTER JOIN dunning_area ON base_user.id = dunning_area.dun RIGHT OUTER JOIN jb_csxx LEFT OUTER JOIN jb_ssxx ON jb_csxx.sfid = jb_ssxx.id ON dunning_area.city_id = jb_csxx.id" + wherestr; 
sqlstr +=" order by jb_ssxx.sfmc,jb_csxx.csmc,base_user.name";
//System.out.println("sqlstr=================="+sqlstr);
%>


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<form name="searchbar" action="dunarea_list.jsp">
			<tr class="maintab">
				<td align="left" width="1%">
					 



<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td nowrap>&nbsp;��&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|ʡ|��|�߿�Ա"));</script></select>&nbsp;��ѯ&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">		
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();"><a href="#" accesskey="m" onclick="dataHander('mod','dunarea_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" align="absmiddle" ></a></td>
    </tr>
</form>
</table>

<!--������ť����-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 50;   //һҳ��ʾ�ļ�¼��
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

<form action="dunarea_list.jsp" name="dataNav1" onSubmit="return goPage()">
<input name="searchFld" accesskey="s" type="hidden" size="15" value="<%= searchFld %>">	
<input name="searchKey" accesskey="s" type="hidden" size="15" value="<%= searchKey %>">	
<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav1;
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
</form>
</table>

<!--��ҳ���ƽ���-->






<!--������ʼ-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
<form action="dunarea_list.jsp" name="dataNav" >
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th width="20%">����</th>
		<th width="20%">ʡ��</th>
		<th>�߿�Ա</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("csid") ) %>"></td>
        <td><%= getDBStr( rs.getString("csmc") ) %></a></td>
        <td><%= getDBStr( rs.getString("sfmc") ) %></td>
        <td><%= getDBStr( rs.getString("name") ) %></td>
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

<!--��������-->
</form>
</body>
</html>