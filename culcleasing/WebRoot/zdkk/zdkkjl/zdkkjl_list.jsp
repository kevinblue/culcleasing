<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("zdkk-zdkkjl-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����ۿ���Ϣ��Ϣ�б� - �����ۿ���Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String searchKeyName = getStr( request.getParameter("searchKeyName") );
String searchKeyDate = getStr( request.getParameter("searchKeyDate") );
String searchtype = getStr( request.getParameter("searchtype") );
ResultSet rs;
String where="";
if(!searchKeyDate.equals("")){
	where="  and createdate<='"+searchKeyDate+"' ";
}
if(!searchKeyName.equals("")){
	where="  and creator like '%"+searchKeyName+"%' ";
}
if(!searchtype.equals("3")&&!searchtype.equals("")){
	where="  and type ='"+searchtype+"' ";
}
String sqlstr = "select id,(case type when 1 then '����' else '����' end) as type,dbo.getusername(creator) as creator,createdate,addr,remark,is_verification from rent_list  where 1=1 "+where +" order by createdate desc";
System.out.println(sqlstr);
 %>
<body style="border:1px solid #8DB2E3;">
<form action="zdkkjl_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> �����ۿ���Ϣ  &gt; �����ۿ���Ϣ�б�</td>
  </tr>
</table>
<!--�������-->
<!--������Ͳ�������ʼ-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr><td colspan="2">
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left">
      &nbsp;��������&nbsp;
        <input name="searchKeyName" accesskey="s" type="text" size="15" value="<%= searchKeyName %>">
        ����������:
        <input name="searchKeyDate" accesskey="s" type="text" size="15" readonly value="<%= searchKeyDate %>">
        <img  onClick="openCalendar(searchKeyDate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><input type="radio" name="searchtype" <%if(searchtype.equals("3")||searchtype.equals(""))out.print("checked");%> value="3">�鿴ȫ��<input type="radio"  <%if(searchtype.equals("1"))out.print("checked");%>   name="searchtype" value="1">�鿴����<input type="radio"  <%if(searchtype.equals("0"))out.print("checked");%>  name="searchtype" value="0">�鿴����
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">

        </td>
    </tr>
  </table>
</td>
</tr>
      <tr class="maintab">
        <td align="left">(��ʾ:����ļ������ز鿴���ļ�)</td>
        <td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
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
rs = db.executeQuery(sqlstr); 

	rs.last();                                      //��ȡ��¼����
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
                ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0"></td>
            </tr>
          </table></td>
      </tr>
    </table>
    <!--��ҳ���ƽ���-->
    <!--
</form>
<form name="list">
-->
    <!--����ʼ-->
    <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
      <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
        <tr class="maintab_content_table_title">
          <th>�ɲ���ѡ��</th>
          <th>�ļ���</th>
          <th>��������</th>
          <th>������</th>
          <th>��������</th>
          <th width="50%">��ע</th>
        </tr>
        <%
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
        <tr>
        <td>
		<%
		String id=getDBStr(rs.getString("id"));
		String type=getDBStr(rs.getString("type"));
		String is_verification=getDBStr(rs.getString("is_verification"));
			if(type.equals("����")){
				if(is_verification.equals("0")){
				out.print("<a href=\"zdkkjl_save.jsp?id="+id+"\">����</a>");
				}else if(is_verification.equals("2")){
					out.print("���ļ�");	
				}else{
					out.print("�Ѻ�����");	
				}
			}else{
				out.print("���鿴");
			}
		%>
        </td>
		<td><a href="zdkkjl_out.jsp?id=<%=id%>"><%=getDBStr(rs.getString("addr"))%></a></td>
        <td><%=type%></td>
        <td><%=getDBStr(rs.getString("creator"))%></td>
        <td><%=getDBDateStr(rs.getString("createdate"))%></td>
        <td><%=getDBStr(rs.getString("remark"))%></td>
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
