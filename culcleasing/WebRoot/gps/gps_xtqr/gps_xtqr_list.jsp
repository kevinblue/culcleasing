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
if (right.CheckRight("gps-xtqr-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ϳ�GPS�ͻ�Ѳ��- GPS����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>
<form action="gps_xtqr_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				GPS���� &gt; GPS��ϵͳǰȷ��</td>
			</tr>
</table>
<%
String searchKey = getStr( request.getParameter("searchKey") );
String wherestr = " where 1=1";
if(!searchKey.equals("")){
	wherestr+=" and sim_no like '%"+searchKey+"%'";
}
ResultSet rs;
String sqlstr = "select * from vi_gps_sure"+wherestr; 
System.out.println(sqlstr);

%>
	


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="50%">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
          <td align="left" colspan="2">&nbsp;��SIM����&nbsp;
        <input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();"></td>
	<!--<td><a href="#" accesskey="n" onClick="dataHander('add','gps_xtqr_add.jsp',dataNav.itemselect);"><img src="../../images/sbtn_new.gif" alt="����(Alt+N)" width="19" height="19" align="absmiddle"></a></td>
		<td width="40" align="right"><a href="#" accesskey="m" onClick="dataHander('mod','gps_xtqr_mod.jsp?id=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onClick="dataHander('del','gps_xtqr_del.jsp?id=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" width="19" height="19" align="absmiddle" ></a></td>-->
    </tr>
</table>
</td>
<td align="right" width="50%">
<%
int intPageSize = 18;   //һҳ��ʾ�ļ�¼��
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
    
    <td nowrap>ת�� <input name="page" type="text" size="2" value="1"> ҳ <img  style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
 </tr>
</table>

<!-- end cwCellTop -->
</td>
</tr>
</table>

<div style="vertical-align:top;height:580px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		<th>SIM����</th>
		<th>�ͻ���</th>
        <th>��ѯ����</th>
        <th>��������</th>
        <th>�����</th>
		<th>��λ״̬</th>
        <th>�ͺ�</th>
        <th>��������</th>
        <th>GPS�����ն����</th>
        <th>��������</th>
        <th>����ʱ��</th>
        <th>�����ֹʱ��</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("gpsinfo_id") ) %>"></td>
        <td><a href="gps_xtqr.jsp?id=<%= getDBStr( rs.getString("gpsinfo_id") ) %>" target="_blank"><%=getDBStr( rs.getString("sim_no") ) %></a></td>
        <td><%=getDBStr( rs.getString("cust_name") ) %></td>
        <td><%=getDBDateStr( rs.getString("install_date") ) %></td>
        <td><%=getDBDateStr( rs.getString("yes_date") ) %></td>
        <td><%=getDBStr( rs.getString("machine_no") ) %></td>
        <td><%=getDBStr( rs.getString("fixed_state") ) %></td>
        <td><%=getDBStr( rs.getString("machine_name") ) %></td>
        <td><%=getDBDateStr( rs.getString("expect_start_date") ) %></td>
        <td><%=getDBStr( rs.getString("gps_index_type") ) %></td>
        <td><%=getDBStr( rs.getString("term")) %></td>
        <td><%=getDBDateStr( rs.getString("service_begindate") ) %></td>
        <td><%=getDBDateStr( rs.getString("service_enddate") ) %></td>
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
<!-- end cwMain -->
</body>
</html>