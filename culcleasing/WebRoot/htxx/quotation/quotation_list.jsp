<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����Э�鱨�� - ����ά��</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 
	
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
<%
String dqczy=(String) session.getAttribute("czyid");
System.out.println("dqczy="+dqczy);
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

ResultSet rs;
String wherestr = " where mqi.contract_id is not null ";

String searchFld_tmp = "";
if( searchFld.equals("����Ŀ���") ) {
	searchFld_tmp = "mqi.proj_id";
}else if( searchFld.equals("����ͬ��") ) {
	searchFld_tmp ="mqi.contract_id";
}else if( searchFld.equals("�ͻ�����") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("���ʽ") ) {
	searchFld_tmp ="pay_type";
}else if( searchFld.equals("��������") ) {
	searchFld_tmp ="plan_year";
}else if( searchFld.equals("��ĩ�豸�˻�") ) {
	searchFld_tmp ="equip_return ";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}

//String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_info_main" + wherestr +" order by create_date desc"; 
String sqlstr = "select mqi.*,vca.cust_name,xm=dbo.GETUSERNAME(mqi.modificator)  from mproj_quotation_info mqi left join mproj_info mi on mqi.contract_id=mi.contract_id left join vi_cust_all_info vca on mi.cust_id=vca.cust_id  " + wherestr+" order by cust_name "; 
System.out.println("###"+sqlstr);
%>
<!--<body onLoad="public_onload(0);"-->

  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      ��Э�鱨�� &gt; ��Э�鱨����Ϣ</td>
    </tr>
  </table>
  <!--�������-->
  <!--������Ͳ�������ʼ-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
	 <form name="dataNav1" action="quotation_list.jsp">		
	<tr class="maintab">
				<td align="left" colspan="4">               
					&nbsp;��&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|����Ŀ���|����ͬ��|�ͻ�����|���ʽ|��������|��ĩ�豸�˻�"));</script></select>&nbsp;��ѯ&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
				<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="3%" rowspan="2"><!--������ť��ʼ-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr>
			<%--
				<%if(right.CheckRight("khxx_frkh_mod",dqczy)>0){%><td><a href="#" accesskey="m" onClick="dataHander('mod','quotation_mod.jsp?custId=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" align="absmiddle" ></a>&nbsp;</td><%}%>
             --%>
	  </tr>
</table>
        <!--������ť����--></td>
      <td align="right" width="90%" colspan="2"><!--��ҳ���ƿ�ʼ-->
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

System.out.println("%%%%===================================%%"+sqlstr);
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
		var nf = document.dataNav1;
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
              ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
          </tr>
          </form>
        </table></td>
    </tr>
  </table>
  <!--��ҳ���ƽ���-->
  <!--����ʼ-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
    <form action="frkh_list.jsp" name="dataNav">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <!-- <th width="1%"></th> -->
	    <th>����Ŀ���</th>
	    <th>����ͬ���</th>
	    <th>�ͻ�����</th>
	    <th>��������</th>
	    <th>���ⷽʽ</th>
	     <th>����������</th>
	    <th>����IRR</th>
		<th>��ƾ����</th>
		<th>�豸�˻�</th>
		<!-- <th>�޸���</th>
		<th>�޸�ʱ��</th> -->
		
		
      </tr>

<%	  

if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
	//String custId=getDBStr(rs.getString("cust_id"));
   //System.out.println("99"+custId);
%>

      <tr>
	 
        <%-- <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") )%>"></td>  --%>
        <td align="center"><%=getDBStr( rs.getString("proj_id") )  %></td>
        <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
         <td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("type") ) %></td>
			<td align="center"><%= getDBStr( rs.getString("pay_type") ) %></td>

		<td align="center"><%=formatNumberStr( rs.getString("plan_bj"),"#,##0.00") %></td>
		<td align="center"><%=formatNumberStr( rs.getString("plan_bjirr"),"#,##0.00") %></td>
		<td align="center"><%=getDBStr( rs.getString("plan_year")) %></td>
		<td align="center"><%=getDBStr( rs.getString("equip_return")) %></td>
		<%--  <td align="center"><%= getDBStr( rs.getString("xm") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("modify_date") ) %></td> --%>
			
      </tr>
<%
		rs.next();
		i++;
	}
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
