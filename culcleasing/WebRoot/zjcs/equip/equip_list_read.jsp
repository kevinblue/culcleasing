<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������� - ��ƾ���</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body  onload="public_onload(0)">

<form action="equip_list_read.jsp" name="dataNav" onSubmit="return goPage()">

<%


String contract_id = getStr( request.getParameter("contract_id") );
ResultSet rs;
String wherestr = " where 1=1";
String sqlstr="";
if ( !contract_id.equals("") ){
	wherestr = wherestr + " and contract_id='" + contract_id + "'";

}
	 sqlstr = "select * from contract_equip_temp  " + wherestr; 



%>
	


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">

</td>
<td align="right" width="90%">
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
   rs=db.executeQuery(sqlstr); 
   

	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();

	rs.beforeFirst();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //������ҳ��
	if(intPage>intPageCount) intPage = intPageCount;            //��������ʾ��ҳ��
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);   
         //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0; %>

<input type="hidden" name="contract_id" value="<%=contract_id%>">
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

<!-- end cwCellTop -->
</td>
</tr>
</table>
<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		 <th>�ʲ�����/�ͺ�</th>
		 <th>����(̨)</th>
		 <th>�豸����(Ԫ)</th>
		 <th>�豸�ܶ�(Ԫ)</th>
		 <th>��Ӧ��</th>
		 <th>����(��)</th>
		 <th>ÿ�����(Ԫ)</th>
		 <th>��Ʒ���</th>
		 <th>����</th>
		 <th>��ע</th>
      </tr>
<%
	
if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
int startIndex = (intPage-1)*intPageSize+i+1;

%>
	  
      <tr class="cwDLRow" >
        <td>&nbsp;<%=startIndex%></td>
		<td align="center" style="width: 10%"> <%= getDBStr( rs.getString("eqip_name") ) %></a></td>
		<td align="center"><%=getDBStr( rs.getString("equip_num") ) %></td>
			<td align="center"><%=formatNumberStr(getDBStr( rs.getString("equip_price") ),"#,##0.00") %></td>
		<td align="center"><%= formatNumberStr(getDBStr( rs.getString("total_price") ),"#,##0.00") %></td>	<td align="center" style="width: 16%"><%= getDBStr( rs.getString("distributor") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("equip_team") ) %></td>
		<td align="center"><%= formatNumberStr(getDBStr( rs.getString("equip_rent") ),"#,##0.00") %></td>
		<td align="center" style="width: 15%"><%= getDBStr( rs.getString("equip_type") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("equip_dispose") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("memo") ) %></td>
	
		
		
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
