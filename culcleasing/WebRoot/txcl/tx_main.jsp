<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>


<html xmlns="http//www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>��Ϣ���� - ��Ϣ����</title>
<link href="../../css/main.css" rel="stylesheet" type="text/css">
</head>

<body onload="public_onload(0);">
<%
//ȡ��Ϣid
String czid=getStr(request.getParameter("czid"));
//��ѯ��Ϣ��ʼʱ��
String start_date="";
String adjust_flag="";
ResultSet rs;
String sqlstr = "select * from base_adjust_interest where id='"+czid+"'";
rs=db.executeQuery(sqlstr);
if (rs.next())
{
    start_date=getDBDateStr(rs.getString("start_date"));   
    adjust_flag = getDBStr(rs.getString("adjust_flag"));
}
rs.close();
%>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
 <td height="2%">
   <div class="tTable" ><b>��Ϣ����<b></div>
 </td>
</tr>

 <tr>
  <td valign="top" height="1%">
	  <div>
		  <span class="tTable" style="float:right; margin-top:1px; margin-right:5px" >
		  <a href="#" onClick="ifmXghtList.delxm();">
		  <img src="../../images/sbtn_del2.gif" width="19" height="19" title="��Ϣ����">��Ϣ����</a>
		  </span>
		  <span class="tTable" style="float:right; margin-top:1px; margin-right:5px" >
		  <a href="#" onClick="ifmXghtList.processxm();">
		  <img src="../../images/sbtn_chkit.gif" width="19" height="19" title="ִ�е�Ϣ">��Ϣ����</a>
		  </span>
		  <div class="tTable" >��Ϣ��ʼ����Ϊ��<%=start_date%></div>
	      <div name="expContent">
		  <iframe name="ifmXghtList" class="w100p" frameborder="0" height="300" src="tx_choice.jsp?czid=<%=czid%>" scrolling="auto">
		  </iframe>
		  </div>
	  </div>
  </td>
 </tr>
 <tr>
  <td>
	  <div>
		<span class="tTable" style="float:right; margin-top:1px; margin-right:5px" >
		<a href="#" accesskey="a" onClick="ifmFxghtList.addxm();">
		<img src="../../images/sbtn_new2.gif" alt="����" width="19" height="19" align="absmiddle" >����</a>
		</span>
		<div class="tTable" >ѡ����Ŀ</div>
	    <div name="expContent">
			<iframe name="ifmFxghtList" class="w100p" frameborder="0" height="700" src="tx_wait_choice.jsp?czid=<%=czid%>" scrolling="auto">
			</iframe>
		</div>
	  </div>
  </td>
 </tr>

<%
db.close();
%>
</table>

</body>
</html>
