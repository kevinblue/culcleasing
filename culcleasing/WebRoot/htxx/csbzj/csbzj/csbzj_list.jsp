<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����ͬ���̱�֤�����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<SCRIPT  Language="Javascript"  SRC="../public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="../publicEvent.js"></SCRIPT>

	
</head>

<%
String id = getStr( request.getParameter("id") );
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("��ͽ��") ) {
	searchFld_tmp = "vi_mproj_info_cs.min_payment";
}else if( searchFld.equals("��ͬ���") ) {
	searchFld_tmp = "vi_mproj_info_cs.contract_id";
}else if( searchFld.equals("�����豸���") ) {
	searchFld_tmp = "vi_mproj_info_cs.vendor_payment";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),create_date,21)<='"+create_end_date+"' ";
}
String sqlstr="select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_mproj_info_cs"+ wherestr;

System.out.println("&*"+sqlstr);
%>
<body onLoad="public_onload(0);" style="border:1px solid #8DB2E3;overflow:auto" >
<form action="csbzj_list.jsp" name="dataNav" onSubmit="return goPage()">
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">����ͬ���̱�֤����� &gt;</td>
    </tr>
  </table>
  <!--�������-->
  <!--������Ͳ�������ʼ-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left" colspan="2">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left">
				&nbsp;��&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|��ͽ��|��ͬ���|�����豸���"));</script></select>
				&nbsp;��ѯ&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
				�������<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
			</td>
          </tr>
        </table></td>
        
    </tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--������ť��ʼ-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr class="maintab">
				<td><a href="#" accesskey="n" onClick="dataHander('add','csbzj_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="����(Alt+N)" align="absmiddle"></a></td>
				<td><a href="#" accesskey="m" onClick="dataHander('mod','csbzj_mod.jsp?id=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" align="absmiddle" ></a></td>
				<td><a href="#" accesskey="d" onClick="dataHander('del','csbzj_del.jsp?id=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" align="absmiddle" ></a></td>
		    </tr>
        </table>
        <!--������ť����--></td>
      <td align="right" width="90%"><!--��ҳ���ƿ�ʼ-->
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
    System.out.println("sd"+sqlstr);


	rs.last();                                                  //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;            //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
	    System.out.println("%%"+sqlstr);
%>
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
              ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
          </tr>
        </table></td>
    </tr>
  </table>
  <!--��ҳ���ƽ���-->
  <!--����ʼ-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>���</th>
		
	    <th>�Ӻ�ͬ���</th>
	    <th>��֤�����</th>
	    <th>�����豸���</th>	
	  	<th>��ͱ�֤���</th>

		<th>��֤���ۼƽ��</th>
        <th>��֤�������</th>
		<th>��֤�����ʱ��</th>
		<th>��֤�����ԭ��</th>
		 <th>��֤�������</th>
		<th>��֤����ʱ��</th>
		<th>��֤����ԭ��</th>

		<th>������</th>
		<th>����ʱ��</th>
		<th>�޸���</th>
		<th>�޸�ʱ��</th>
		
      </tr>

<%	  

if ( intRowCount!=0 ) 
rs.previous();
if ( rs.next() )
{
	System.out.println("11111");
	while( i < intPageSize && !rs.isAfterLast() ) {
	System.out.println("11111");
%>

      <tr>
 
        <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") )%>"></td>
       <td align="center"><a href="csbzj.jsp?id=<%=getDBStr( rs.getString("id") )  %>" target="_blank"><%=getDBStr( rs.getString("id") )  %></a></td>
   
       <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
       
		<td><%=getDBStr(rs.getString("margin_per"))%></td>
		
		<td><%=formatNumberStr(rs.getString("vendor_payment"),"#,##0.00")%></td>
		<td><%=getDBStr(rs.getString("min_payment"))%></td>

		<td><%=getDBStr(rs.getString("margin_amount"))%></td>
		<td><%=getDBStr(rs.getString("deposit_amount"))%></td>
		<td><%=getDBStr(rs.getString("margin_time"))%></td>
		<td><%=getDBStr(rs.getString("margin_reason"))%></td>
		<td><%=getDBStr(rs.getString("deposit_export"))%></td>
		<td><%=getDBStr(rs.getString("export_time"))%></td>
        <td><%=getDBStr(rs.getString("export_reason"))%></td>

        <td align="center"><%= getDBStr( rs.getString("dengjiren") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("create_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("xiugairen") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("modify_date") ) %></td>
						
		
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
