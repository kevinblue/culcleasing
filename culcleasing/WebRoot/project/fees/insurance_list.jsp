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
if (right.CheckRight("insurance-fees-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���۹��� - ���շѼ���ά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body onLoad="public_onload(0);">
<form action="insurance_list.jsp" name="dataNav" onSubmit="return goPage()">
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> ���۹��� &gt; ���շѼ���ά��</td>
    </tr>
  </table>
  <!--�������-->
  <!--������Ͳ�������ʼ-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left" width="38%"><%
ResultSet rs;
String searchKey = getStr( request.getParameter("searchKey") );
String wherestr = "";
if(!searchKey.equals("")) {
	wherestr = "where dbo.FK_GETNAME(insurer) like '%"+searchKey+"%'";
}
String sqlstr = "select insurance_fees,dbo.FK_GETNAME(insurer) insurer,fees_way,note,insurance_type from insurance_fees " + wherestr; 
System.out.println("sqlstr=================="+sqlstr);
%>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left" width="40%">&nbsp;�����չ�˾&nbsp;
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>
">
              <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();"></td>
          </tr>
        </table></td>
        <td  width="100%"></td><td  width="100%"></td>
    </tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--������ť��ʼ-->
        <table border="0" cellspacing="0" cellpadding="0" >
          <tr class="maintab">
            <td><a href="#" accesskey="n" onClick="dataHander('add','insurance_add.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="����(Alt+N)" align="absmiddle"></a></td>
            <td><a href="#" accesskey="m" onClick="dataHander('mod','insurance_update.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" align="absmiddle" ></a></td>
            <td><a href="#" accesskey="d" onClick="dataHander('del','insurance_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" align="absmiddle" ></a></td>
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
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
        <th width="1%"></th>
        <th>ά�����</th>
        <th>���չ�˾</th>
        <th>���㷽ʽ</th>
		<th>����</th>
        <th>��ע</th>
      </tr>
      <%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("insurance_fees") ) %>"></td>
        <td align="left"><a href="insurance.jsp?czid=<%= getDBStr( rs.getString("insurance_fees") ) %>" target="_blank"><%= getDBStr(rs.getString("insurance_fees") ) %></a></td>
        <td><%= getDBStr( rs.getString("insurer") ) %></td>
        <td><% 	if("1".equals(getDBStr(rs.getString("fees_way")))){%>
          <%="��ƽ�����ռ��㷽��"%>
          <%	}else if("2".equals(getDBStr(rs.getString("fees_way")))){%>
          <%= "ƽ�����ռ��㷽��"%>
          <%	}else{%>
          <%= "ƽ�����ռ��㷽��(�����걣��)"%>
          <%	} %></td>
		  <td><%= getDBStr( rs.getString("insurance_type") ) %></td>
        <td><%= getDBStr( rs.getString("note") ) %></td>
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
