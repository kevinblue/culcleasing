<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ������ - �����ƻ��б�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">
<form action="chjhxg_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				��ͬ������ &gt; �����ƻ��б�</td>
			</tr>
</table>
<!--�������-->
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
<%
	String sqlstr;
	ResultSet rs;
	String curr_date = getSystemDate(0);
	String wherestr = " where 1=1";
	String doc_id = getStr( request.getParameter("doc_id") );
	String contract_id = getStr( request.getParameter("contract_id") );
	String proj_id = getStr( request.getParameter("proj_id") );
	
	
	
	String query_rent_sql = "";
	//��ѯ��ʽ��
	
	
	//��ѯ��ͬ�����ƻ���ʽ�������SQL
	//StringBuffer query_infoSql = new StringBuffer();
	//query_infoSql.append(" select f.contract_id,f.rent_list,f.plan_date,f.corpus  ")
	//			 .append(",c.equip_amt,c.year_rate  ")
	//			 .append("from  fund_rent_plan as f   ")
	//			 .append("left join  contract_condition  as c  ")
	//			 .append("on  f.contract_id = c.contract_id  ")
	//             .append(" where contract_id = '"+contract_id+"' ")
	//             .append("  ");
	             
	query_rent_sql = " select * from  contract_condition ";             
	System.out.println("query_rent_sql=================="+query_rent_sql);
%>



<!--������ť��ʼ
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	
		<td align="center"><a href="#" accesskey="n" onclick="dataHander('add','chjhxg_add.jsp?doc_id=<%=doc_id %>&contract_id=<%=contract_id %>',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="����(Alt+N)" align="absmiddle"></a></td>
		<td align="center"><a href="#" accesskey="m" onclick="dataHander('mod','chjhxg_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" align="absmiddle" ></a></td>
		<td align="center"><a href="#" accesskey="d" onclick="dataHander('del','chjhxg_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" align="absmiddle" ></a></td>
    </tr>
</table>
-->
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


	rs = db.executeQuery(query_rent_sql); 


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
		<!-- <th width="1%"></th> -->
		<th>��ͬ���</th>
        <th>�豸��</th>
        <th>������</th>
        <th>����</th>
        <th>��������</th>
        <th>���ޱ���</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	String start_date = getDBDateStr(rs.getString("start_date"));
	String income_day = getDBStr(rs.getString("income_day"));
	String now_start_date = start_date.substring(0,8)+income_day;
%>

      <tr>
      <!-- 
        <td align="center">
        	<input class="rd" type="radio" 
        		name="itemselect" value="<%=getDBStr(rs.getString("contract_id")) %>"/>
        </td>
      -->
        <td align="center">
        	<a href="zjcs_contract_list.jsp?contract_id=<%=getDBStr(rs.getString("contract_id"))%>" 
        		target="_blank"><%=getDBStr(rs.getString("contract_id"))%></a>
        </td>
		<td align="center"><%= formatNumberStr(getDBStr(rs.getString("equip_amt")),"#,##0.0000")%></td> 
		<td align="center"><%= formatNumberStr(getDBStr(rs.getString("year_rate")),"#,##0.0000") %></td> 
		<td align="center"><%= getDBStr(rs.getString("lease_term"))%></td> 
		<td align="center">
			<%=now_start_date%>
		</td> 
		<td align="center"><%= formatNumberStr(getDBStr( rs.getString("lease_money")),"#,##0.00") %></td> 
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
