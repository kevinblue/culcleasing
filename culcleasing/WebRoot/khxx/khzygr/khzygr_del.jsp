<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title> �ͻ���Ϣ����-��Ҫ������Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body>

<%
	String czid = getStr( request.getParameter("czid") );
	String  sqlstr = "select cp.*,dengjiren=dbo.GETUSERNAME(cp.creator),xiugairen=dbo.GETUSERNAME(cp.modificator),vci.project_name from cust_person cp left join vi_contract_info vci on vci.proj_id=cp.res_project  where cp.id='" + czid+"'"; 
	String age;
	String service_life;
	ResultSet rs = db.executeQuery(sqlstr);
	if( rs.next() ){
		age=getDBStr(rs.getString("age"));if(age.equals("0")) {age="";}
		service_life=getDBStr(rs.getString("service_life"));if(service_life.equals("0")){ service_life="";}
		
		String cust_id=getDBStr(rs.getString("cust_id"));
	    sqlstr="select cust_name from vi_cust_all_info where cust_id='"+cust_id+"'";
	    ResultSet rs1 = db1.executeQuery(sqlstr);
	    String cust_name="";
	    if( rs1.next() ){
		  cust_name=getDBStr(rs1.getString("cust_name"));
	    }
	    rs1.close();
		db1.close();
%>

<form name="form1" method="post" action="khzygr_save.jsp">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
�ͻ���Ϣ���� &gt; ɾ���ͻ���Ҫ������Ϣ
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="ɾ��"  type="submit" >
<img src="../../images/btn_delete.gif" align="absmiddle" border="0">ɾ��</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
<img src="../../images/btn_close.gif" align="absmiddle" border="0">�ر�</button>
    </td></tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">ɾ ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
   <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwCellTop -->


<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
   
  
    <td width="20%">������</td>
    <td><%=getDBStr(rs.getString("name"))%></td>
    <td width="20%">�Ƿ���ն��ţ�</td>
    <%if(getDBStr( rs.getString("msg_recieved") )==null || getDBStr( rs.getString("msg_recieved") )=="") {%>
		<td align="center">��</td>
		<%} else {%>
		<td align="center">��</td>
		<%} %>
  </tr>
  <tr>
	<td >�Ա�</td>
	<td><%=getDBStr(rs.getString("sex"))%></td>
  
    <td >�Ը�</td>
    <td><%=getDBStr(rs.getString("person_character"))%></td>
  </tr>
  <tr>
    <td >���䣺</td>
    <td><%=age%></td>
  
    <td >��ְ���ޣ�</td>
    <td><%=service_life%></td>
  </tr>
  
  <tr>
	<td >�Ƿ�����ϵ�ˣ�</td>
	<td><%=getDBStr(rs.getString("main_person_flag"))%></td>
  
    <td >�������£�</td>
    <td><%=getDBDateStr(rs.getString("birth_date"))%></td>
  </tr>
  <tr>
    <td >���᣺</td>
    <td><%=getDBStr(rs.getString("native_place"))%></td>
  
    <td >�绰��</td>
    <td><%=getDBStr(rs.getString("phone"))%></td>
  </tr>
  <tr>
  	<td >�ֻ���</td>
    <td ><%=getDBStr(rs.getString("mobile_number"))%></td>
    <td >���棺</td>
    <td><%=getDBStr(rs.getString("fax"))%></td>
   </tr>
  <tr>
    <td >��ҵѧУ��</td>
    <td><%=getDBStr(rs.getString("graduate_school"))%></td>
 
    <td >רҵ��</td>
    <td><%=getDBStr(rs.getString("major"))%></td>
  </tr>
  <tr>
  	<td >ѧ����</td>
    <td ><%=getDBStr(rs.getString("education"))%></td>
    <td >E-mail</td>
    <td><%=getDBStr(rs.getString("e_mail"))%></td>
  </tr>
  <tr>
    <td >����</td>
    <td><%=getDBStr(rs.getString("hobbies"))%></td>
  
    <td >ְλ/��ϵ</td>
    <td><%=getDBStr(rs.getString("jobposition"))%></td>
  </tr>
  <tr>
    <td >ѧ������</td>
    <td><%=getDBStr(rs.getString("subject_field"))%></td>
  
    <td >ѧ��ְ��</td>
    <td><%=getDBStr(rs.getString("academic_duty"))%></td>
  </tr>
  <tr>
    <td >���ְ��</td>
    <td><%=getDBStr(rs.getString("social_duty"))%></td>
  <td >������</td>
	<td><%=getDBStr(rs.getString("managial_style"))%></td>
    
  </tr>
  <tr>
  <td >��ż��</td>
    <td><%=getDBStr(rs.getString("spouse"))%></td>
    <td >��Ů��</td>
    <td><%=getDBStr(rs.getString("children"))%></td>
  </tr>
 
  
  <tr>
    <td >��ע��</td>
    <td><textarea class="text"><%=getDBStr(rs.getString("memo"))%></textarea></td>
	<td >��Ŀ���ƣ�</td>
    <td><%=getDBStr(rs.getString("project_name"))%></td>
	</tr>
</table>
<%
}else{
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
<!-- end cwToolbar -->
</td></tr></table>
</form>

<!-- end cwMain -->
</body>
</html>
