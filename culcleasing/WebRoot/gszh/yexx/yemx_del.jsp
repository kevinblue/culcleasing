<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ɾ���ʻ��ʽ���֧ - �ʽ���Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String czid=getStr(request.getParameter("czid"));
%>
<body>

<div id="cwMain" >
<form name="form1" method="post" action="yemx_save.jsp">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >�ʽ���Ϣ����</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">


<%
String sqlstr;
ResultSet rs;
String czy=(String) session.getAttribute("czyid");//ȡ�ò���ԱID
if ((czy==null) || (czy.equals(""))) czy="0";
//czy="AFEE-6A6CWE";//�ʽ�������Żݻ�
sqlstr="select bmbh from jb_gsbm where bmmc=(select bmmc from v_yhxx where id='"+czy+"')";
String bmid="";//����id
rs=db.executeQuery(sqlstr);
if (rs.next()) bmid=rs.getString("bmbh");
if ((bmid==null) || (bmid.equals(""))) bmid="0";
if (!bmid.equals("12"))//�����ʽ�
{
%>
				<script>
              if(opener==null){
               	opener=true;
              	opener.alert("��û��Ȩ��!");
              }else{
              	alert("��û��Ȩ��");
              }
              window.close();
				</script>
<%}%>


<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">ɾ���ʻ��ʽ���֧</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
        <td></td>
      </tr>
</table>
	
</div>
<!-- end cwCellTop -->



<div id="cwCellContent">
<%
sqlstr = "SELECT * from v_zh_xjyemx where id='"+czid+"'";
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
%>

<table  class="cwDataDetail" width="100%" border="0" cellspacing="1" cellpadding="1">
 
<tr>
    <th class="cwDDLabel" scope="row">�ʻ�</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zh"))%></td>
  </tr>
<tr>
    <th class="cwDDLabel" scope="row">�ʻ�����</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("zhmc"))%></td>
  </tr>
    <tr>
    <th class="cwDDLabel" scope="row">��֧��ʽ</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("szfs"))%></td>
    </tr>
  <tr>
    <th class="cwDDLabel" scope="row">��¼¼������</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("jlrq"))%></td>
  </tr>

   <tr>
    <th class="cwDDLabel" scope="row">���(�����)</th>
    <td class="cwDDValue"><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("jebb",2))%></td>
  </tr>
  <tr>
    <th class="cwDDLabel" scope="row">���(���)</th>
    <td class="cwDDValue"><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("jewb",2))%></td>
  </tr>

  <tr>
    <th class="cwDDLabel" scope="row">�ո�����</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("memo"))%></td>
  </tr>
<tr>
    <th class="cwDDLabel" scope="row">��ע</th>
    <td class="cwDDValue"><%=getDBStr(rs.getString("memo2"))%></td>
  </tr>


  <tr>
    <th class="cwDDLabel" scope="row">¼��ʱ��</th>
    <td class="cwDDValue"><%=getDBDateStr(rs.getString("lrsj"))%></td>
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
<input class="btn" name="submit" value="ɾ��" type="submit"  onClick="return(confirm('ȷ��ɾ����?'))">
<input class="btn" name="btnClose" value="�ر�" type="button" onclick="window.close();">
</div>
<!-- end cwToolbar -->
</form>
</div>
<!-- end cwMain -->
</body>
</html>