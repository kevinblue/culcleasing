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
if (right.CheckRight("gps-failure-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS�ϳ�Ѳ��ʧ��3������ͳ��- GPS����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>
<form action="gps_failure_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				GPS���� &gt; GPS�ϳ�Ѳ��ʧ��3������ͳ��</td>
			</tr>
</table>
<%
String searchKey=getStr(request.getParameter("searchKey"));
ResultSet rs;
String where="";
if(!searchKey.equals("")){
	where=" and sim_no like '%"+searchKey+"%'";
}
String sqlstr = "select  contract_id,cust_name,info.sim_no,vi_sim.machine_no,dbo.getmodelbyid(vi_sim.machine_type) as machine_name,model,vi_sim.service_begindate,vi_sim.service_enddate,(select top 1 polling_date from hcexamine_details where sim_no=info.sim_no order by polling_date desc) as polling_date from examine_info as info left join vi_sim_no as vi_sim on(info.sim_no=vi_sim.sim_no) where info.sim_no in(select sim_no from hcexamine_details as details group by sim_no having (select count(*)as counts from (select top 3 * from hcexamine_details  where sim_no=details.sim_no  order by polling_date desc) as top3 where top3.fixed_state='��Ч')>=3 )"+where+"  order by polling_date desc"; 
System.out.println(sqlstr);
%>
	


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="20%">&nbsp;SIM����
<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>
"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<!--<td><a href="#" accesskey="m" onClick="dataHander('mod','dyw_mod.jsp?id=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>-->
    </tr>
</table>
</td>
<td align="right" width="90%">
<%
int intPageSize = 16;   //һҳ��ʾ�ļ�¼��
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

<div style="vertical-align:top;height:480px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
        <th>��ͬ���</th>
        <th>�ͻ�����</th>		
        <th>SIM����</th>
        <th>�����</th>
        <th>�����ͺ�</th>
        <th>��������</th>
        <th>����ʱ��</th>
        <th>�����ֹʱ��</th>
        <th>Ѳ������</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
        <td></td>
        <td><%=getDBStr( rs.getString("contract_id") ) %></td>
        <td><%=getDBStr( rs.getString("cust_name") ) %></td>
        <td><%=getDBStr( rs.getString("sim_no") ) %></td>
        <td><%=getDBStr( rs.getString("machine_no") ) %></td>
        <td><%=getDBStr( rs.getString("machine_name") ) %></td>
        <td><%=getDBStr( rs.getString("model") ) %></td>
        <td><%=getDBDateStr( rs.getString("service_begindate") ) %></td>
        <td><%=getDBDateStr( rs.getString("service_enddate") ) %></td>
        <td><%=getDBDateStr( rs.getString("polling_date") ) %></td>
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
