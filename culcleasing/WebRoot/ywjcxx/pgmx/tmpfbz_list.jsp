<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ŀ���ֱ�׼��Ϣ�б� - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >������Ϣ����</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">


<%
String sqlstr;
ResultSet rs;
String wherestr=" where 1=1";
String czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
  
}
else
{
   wherestr=wherestr+" and jb_pgmx_tmpfbz.tmid = '"+czid+"' "; 
}

%>


<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">������Ŀ���ֱ�׼��Ϣ�б�</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>

		<td><a href="#" accesskey="n" onclick="dataHander('add','tmpfbz_add.jsp?czid=<%=czid%>',list.itemselect);"><img src="../../images/sbtn_new.gif" alt="����(Alt+N)" width="19" height="19" align="absmiddle"></a></td>
		<td><a href="#"  accesskey="m" onclick="dataHander('mod','tmpfbz_mod.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onclick="dataHander('del','tmpfbz_del.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" width="19" height="19" align="absmiddle" ></a></td>
		<td><img src="../../images/sbtn_split.gif" width="2" height="14"></td>


      </tr>
</table>


</div>
<!-- end cwCellTop -->
<% 
int intPageSize;   //һҳ��ʾ�ļ�¼��
int intRowCount=0;   //��¼����
int intPageCount;  //��ҳ��
int intPage;       //����ʾҳ��
int i;
java.lang.String strPage;

     //����һҳ��ʾ�ļ�¼��
	 intPageSize = 15;
	 intPageCount=1;
	 //ȡ�ô���ʾҳ��
	 strPage = request.getParameter("page");
	 if(strPage==null || strPage=="")
	 {//������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	     intPage = 1;
	 }
	 else
	 {//���ַ���ת��������
	      intPage = java.lang.Integer.parseInt(strPage);
		  if(intPage<1) intPage = 1;
	 } 
%>



<div id="cwCellContent">

    <form name="list">

    <table class="cwDataList" width="100%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
      <tr class="cwDLHead">
	<th width="1%"></th>
	<th>����Ҫ��</th>
	<th>��������</th>
	<th>��ֵ</th>
        <th>���</th>
        <th>��ǰ�Ƿ���Ч</th>
      </tr>
	  
<%
sqlstr = "SELECT jb_pgmx_tmxx.pjys AS pjys, jb_pgmx_tmpfbz.*, jb_yhxx.xm AS djrxm, jb_yhxx_1.xm AS gxrxm FROM jb_pgmx_tmpfbz LEFT OUTER JOIN";
sqlstr+=" jb_yhxx jb_yhxx_1 ON jb_pgmx_tmpfbz.gxr = jb_yhxx_1.id LEFT OUTER JOIN jb_yhxx ON jb_pgmx_tmpfbz.djr = jb_yhxx.id LEFT OUTER JOIN";
sqlstr+=" jb_pgmx_tmxx ON jb_pgmx_tmpfbz.tmid = jb_pgmx_tmxx.id "+wherestr+" order by jb_pgmx_tmpfbz.xh asc"; 
rs=db.executeQuery(sqlstr); 

if (rs.next())
  {
     
	//��ȡ��¼����
	rs.last();
	intRowCount = rs.getRow();
	
	//������ҳ��
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;
	
	//��������ʾ��ҳ��
	if(intPage>intPageCount) intPage = intPageCount;
	
	if(intPageCount>0)
	//����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	   rs.absolute((intPage-1) * intPageSize + 1);
	
	//��ʾ����
	i=0;
	while(i<intPageSize && !rs.isAfterLast())
        {
%>
	  
      <tr class="cwDLRow" >
        <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
        <td align="center"><%=getDBStr(rs.getString("pjys"))%></td>
        <td><a href="tmpfbz.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank"><%=getDBStr(rs.getString("pfyj"))%></a></td>
        <td align="center"><%=getDBStr(rs.getString("fz"))%></td>
        <td align="center"><%=getDBStr(rs.getString("xh"))%></td>
        <td align="center"><%=formatBooleanStr(getDBStr(rs.getString("his")),0)%></td>
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
</form>

<div id="cwDataNav" >
<form action="tmpfbz_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="czid" type="hidden" value="<%=czid%>">
<table border="0" cellspacing="5" cellpadding="0">
  <tr>
    <td>
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
	<%if(intPage>1){%>	<img style="cursor:pointer; " onClick="goPage('first')" src="../../images/quick_back.gif" alt="��һҳ" width="19" height="19" border="0"> <img style="cursor:pointer; " onClick="goPage('prev')" src="../../images/back.gif" alt="��һҳ" width="19" height="19" border="0">
	<%}else{%><img style="filter:Gray;" src="../../images/quick_back.gif" alt="���ҳ" width="19" height="19" border="0"> <img style="filter:Gray;" src="../../images/back.gif" alt="���ҳ" width="19" height="19" border="0"><% } %>
	<%if(intPage<intPageCount){%> <img style="cursor:pointer; " onClick="goPage('next')" src="../../images/forward.gif" alt="��һҳ" width="19" height="19" border="0"> <img style="cursor:pointer; " onClick="goPage('last')" src="../../images/quick_forward.gif" alt="���ҳ" width="19" height="19" border="0">
	<%}else{%><img style="filter:Gray;" src="../../images/forward.gif" alt="���ҳ" width="19" height="19" border="0"> <img style="filter:Gray;" src="../../images/quick_forward.gif" alt="���ҳ" width="19" height="19" border="0"><% } %></td>
    <td>��<%=intRowCount%>�� ��<%=intPage%>ҳ/��<%=intPageCount%>ҳ </td>
    <td><img src="../../images/sbtn_split.gif"></td>
    <td>ת��<input name="page" type="text" size="2">ҳ<img style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" width="19" height="19" border="0" align="absmiddle"></td>
  </tr>
</table>
</form>
</div>
<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar">
<input class="btn" name="btnClose" value="�ر�" type="button" onClick="window.close()">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>