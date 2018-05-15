<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����ָ����ϸ - ������Ϣ����</title>
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
String czid;
String sqlstr;
ResultSet rs;
czid=getStr(request.getParameter("czid"));

if ((czid==null) || (czid.equals("")))
{
   czid="0";
}

%>



<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">����ָ����ϸ</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td><a href="gczb_mod.jsp?czid=<%=czid%>"  accesskey="m" title="�޸�(Alt+M)"><img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" > �޸�</a></td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%
sqlstr = "SELECT perf_assessment_type.assess_type AS assess_type,perf_assessment_model.* FROM perf_assessment_model LEFT OUTER JOIN perf_assessment_type ";
sqlstr+=" ON perf_assessment_model.type_id = perf_assessment_type.id where perf_assessment_model.id="+czid; 
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{ 
%>


<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <th width="20%" class="cwDDLabel">�������</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("assess_type"))%></td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">���</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("order_number"))%></td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">����ָ��</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("indicator_def"))%></td>
  </tr>
    <tr>
    <th width="20%" class="cwDDLabel">Ȩ��</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("weighting"))%></td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">��׼ֵ</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("standard_value"))%></td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">��׼ֵ��ʾֵ</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("standard_value_disp"))%></td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">��ϵ����</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("ratio_relation"))%></td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">�����޶�����</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("limitation"))%></td>
  </tr>
  <tr>
    <th width="20%" class="cwDDLabel">��ǰ�Ƿ���Ч</th>
    <td class="cwDDValue"><%=formatBooleanStr(getDBStr(rs.getString("his_flag")),0)%>
    </td>
  </tr>
</table>

<%
}
else
{
   out.print("<center>������¼������!</center>");
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
<input class="btn" name="btnClose" value="�ر�" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
