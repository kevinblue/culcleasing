<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>ɾ��������� - ������Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<%
String dqczy=(String) session.getAttribute("czyid");
int candel=0;
String czid;
czid=getStr(request.getParameter("czid"));
%>
<div id="cwMain" >
<form name="form1" method="post" action="zlwjzzs_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">������Ϣ����</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">





<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">ɾ���������������</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
<%
String sqlstr;
ResultSet rs;
%>
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td>
		</td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->

<div id="cwCellContent" >
<%
sqlstr = "SELECT jb_zlwjzzs.*,jb_yhxx.xm FROM jb_zlwjzzs LEFT OUTER JOIN jb_yhxx ON jb_zlwjzzs.czy = jb_yhxx.id where jb_zlwjzzs.id='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
	String czy=getDBStr(rs.getString("czy"));
	if ((dqczy==null) || (dqczy.equals("")))
	{
	  dqczy="����֤";
	}
	if ((czy==null) || (czy.equals("")))
	{
	  czy="�޼�¼";
	}
	
	if (dqczy.equals("AFEE-6A689J"))
    {
    	candel=1;
    }	
%>
<script>
if (<%=candel%>==0){
	window.close();
	opener.alert("��û��ɾ��Ȩ�ޣ�");
}

</script>




<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th class="cwDDLabel" width="20%">���</th>
    <td class="cwDDValue" width="80%"><%=getDBStr(rs.getString("id"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">����������</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zzsmc"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">����������</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("gxrq"))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">����Ա</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("xm"))%></td>
  </tr>
</table>

<%
}
else
{
   out.print("</center>������¼������!</center>");
}
rs.close(); 
db.close();
%>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar">
<input class="btn" name="submit" value="ɾ��" type="submit"  onClick="return(confirm('ȷ��ɾ����?'))">
<input class="btn" name="btnClose" value="�ر�" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>