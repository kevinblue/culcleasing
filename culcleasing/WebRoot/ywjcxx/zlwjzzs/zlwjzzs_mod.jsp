<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�޸�������� - �������������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>

<body>

<div id="cwMain" >
<form name="form1" method="post" action="zlwjzzs_save.jsp"  onSubmit="return Validator.Validate(this,3);">

<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">�������������</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">

<%
String dqczy=(String) session.getAttribute("czyid");
int canmod=0;
%>



<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">�޸��������������</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td>&nbsp;</td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent" >
<%
String sqlstr;
String czid;
ResultSet rs;

sqlstr="select bmbh from v_yhxx where id='"+dqczy+"'";
String bmbh="";
rs=db.executeQuery(sqlstr); 
if (rs.next())
{
	bmbh=rs.getString("bmbh");
        if ((bmbh==null) || (bmbh.equals("")))
        {
           bmbh="0";
        }
}
else
{
     bmbh="0";      
}

czid=getStr(request.getParameter("czid"));
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
	
	if ((dqczy.equals("AFEE-6A689J")) || (bmbh.equals("13")) || (bmbh.equals("02")))
    {
    	canmod=1;
    }	
%>
<script>
if (<%=canmod%>==0){
	window.close();
	opener.alert("��û���޸�Ȩ�ޣ�");
}
</script>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=getDBStr(rs.getString("id"))%>">
  <table class="cwDataInput"  border="0" cellspacing="5" cellpadding="2">
    <tr>
      <th width="121" scope="row">����������</th>
      <td width="384"><input name="zzsmc" type="text" size="50" maxB="100" maxlength="100" label="����������" value="<%=getDBStr(rs.getString("zzsmc"))%>"  Require="true"> 
      <span class="biTian">*</span>
      </td>
    </tr>
    <tr>
      <th scope="row">����������</th>
      <td><%=getDBStr(rs.getString("gxrq"))%></td>
    </tr>
    <tr>
      <th scope="row"> ����Ա</th>
      <td><%=getDBStr(rs.getString("xm"))%></td>
    </tr>
  </table>


<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar" >
<%
if (canmod==1)
{
%>
<input class="btn" name="submit" value="����" type="submit">
<%
}
%><input class="btn" name="btnClose" value="ȡ��" type="button" onClick="cfClose()"><input class="btn" name="btnOk" value="����" type="reset">
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
   out.print("</center>������¼������!</center>");
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>


