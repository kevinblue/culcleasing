<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ�б� - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String sqlstr;
ResultSet rs;
int i=0;
String wherestr=" where 1=1";
String searchKey="";
String czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
  
}
else
{
wherestr=wherestr+" and jb_qyxx.gjid = '"+czid+"' "; 
}
if (request.getParameter("searchKey")!=null)
{
   searchKey=getStr(request.getParameter("searchKey"));
   wherestr=wherestr+" and jb_qyxx.qymc like '%"+searchKey+"%' "; 
}
sqlstr = "select jb_qyxx.id,jb_qyxx.qyid,jb_qyxx.gjid,jb_gjxx.gjmc,jb_qyxx.qymc,jb_qyxx.gxrq,jb_qyxx.czy,base_user.name from jb_qyxx  left join base_user on jb_qyxx.czy=base_user.id left join jb_gjxx on jb_qyxx.gjid=jb_gjxx.id"+wherestr+"order by jb_qyxx.id asc"; 
rs=db.executeQuery(sqlstr);
%>


<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("ywjcxx_dqxx_list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>

<body text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' onLoad="public_onload(0)">




<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle">
				������Ϣ����&gt;������Ϣ</td>
			</tr>
</table> 
</div>
<!-- end cwTop -->






<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<form name="searchbar" action="qyxx_list.jsp">
		<td nowrap>������Ϣ��
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>"><input name="image" type="image" 

src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="searchbar.submit();">
          </td>
		</form>
		<%if(right.CheckRight("ywjcxx_dqxx_add",dqczy)>0){%>
		<td><a href="#" accesskey="n" onClick="dataHander('add','qyxx_add.jsp',dataNav.itemselect);"><img align="absmiddle"  

src="../../images/sbtn_new.gif" alt="����(Alt+N)" align="absmiddle"></a></td><%}%>
<%if(right.CheckRight("ywjcxx_dqxx_mod",dqczy)>0){%>
		<td><a href="#"  accesskey="m" onClick="dataHander('mod','qyxx_mod.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" 

alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" ></a></td><%}%>
<%if(right.CheckRight("ywjcxx_dqxx_del",dqczy)>0){%>
		<td><a href="#" accesskey="d" onClick="dataHander('del','qyxx_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" 

src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" align="absmiddle" ></a></td><%}%>
    


</td>
					 <td align="right" width="100%">
					 	
					 	



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

	
%>

<form action="sjxx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKey" type="hidden" value="<%= searchKey %>">

<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>�� <%=intRowCount%> �� / <%=intPageCount%> ҳ 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="��һҳ" 

border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="��һҳ"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="��һҳ"  border="0"><img align="absmiddle" 

style="filter:Gray;" src="../../images/ico_prev.gif" alt="��һҳ" border="0"><% } %>
	�� <font color="red"><%=intPage%></font> ҳ	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="��һҳ" 

border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="���ҳ" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" 

style="filter:Gray;" src="../../images/ico_last.gif" alt="���ҳ" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>ת�� <input name="page" type="text" size="2" value="1"> ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" 

src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>




   <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	     <th width="1%"></th>
        <th>��������</th>
        <th>��������</th>
        <th>��������</th>
        <th>����ʡ/ֱϽ��</th>
        <th>����������</th>
        <th>����Ա</th>
      </tr>
  

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr onMouseOver="fn_changeTrColor()" onMouseOut="fn_changeTrColor()">
      <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
		<td><%=getDBStr(rs.getString("qyid"))%></td>
        <td><a href="qyxx.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank"><%=getDBStr(rs.getString("qymc"))%></a></td>
        <td><a href="../gjxx/gjxx.jsp?czid=<%=getDBStr(rs.getString("gjid"))%>" target="_blank"><%=getDBStr(rs.getString("gjmc"))%></a></td>
        <td><a href="../sjxx/sjxx_list.jsp?czid=<%=getDBStr(rs.getString("qyid"))%>" target="_blank">�鿴</a></td>
        <td><%=getDBDateStr(rs.getString("gxrq"))%></td>
        <td><%=getDBStr(rs.getString("name"))%></td>
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
</form>
</div>
<!-- end cwDataNav -->



<!-- end cwCellContent -->





<!-- end cwCell -->






<!-- end cwMain -->
</body>
</html>