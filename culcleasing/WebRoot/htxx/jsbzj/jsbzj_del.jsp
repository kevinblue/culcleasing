<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʲ�����-���㱣֤�����</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
String czid;
String sqlstr;
ResultSet rs;
czid=getStr(request.getParameter("id"));
   // String id = getStr( request.getParameter("id") );
	//String cust_id = getStr( request.getParameter("custId") );
	sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_mproj_guarantee_info where id="+czid;
	 
	 rs = db.executeQuery(sqlstr);


String contract_id="";
String proj_id="";

String sign_date="";
String lineof_credit="";
String credit_fact="";
String credit_remain="";
String guarantee_plan="";
String plan_remain="";
String income_remian="";
String guarantee_income="";
String remark="";
String creator="";
String create_date="";
String modificator="";
String modify_date="";
	if(rs.next()){
		 proj_id=getStr(request.getParameter("proj_id"));
            contract_id=getStr(request.getParameter("contract_id"));
			sign_date=getStr(request.getParameter("sign_date"));
			lineof_credit=getStr(request.getParameter("lineof_credit"));
            credit_fact=getStr(request.getParameter("credit_fact"));
            credit_remain=getStr(request.getParameter("credit_remain"));
            guarantee_plan=getStr(request.getParameter("guarantee_plan"));
            plan_remain=getStr(request.getParameter("plan_remain"));
                  
            income_remian=getStr(request.getParameter("income_remian"));
            guarantee_income=getStr(request.getParameter("guarantee_income"));
            remark=getStr(request.getParameter("remark"));
            
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date")); 
	
%>
<body onLoad="public_onload(44);fun_winMax();">
<form name="form1" method="post" action="jsbzj_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
���㱣֤����� &gt; ���㱣֤��ɾ��
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="ɾ��"  type="submit" >
<img src="../../images/fdmo_01.gif" align="absmiddle" border="0">ɾ��</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">�ر�</button>

	    	</td>
	  </tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">ɾ��</td>
  
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
<center>

<!--
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">


<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
  <td >��Ŀ��ţ�</td>
    <td ><%=getDBStr(rs.getString("proj_id"))%></td>
    <td >��ͬ��ţ�</td>
    <td ><%=getDBStr(rs.getString("contract_id"))%></td>
  </tr>
  
  <tr>
    <td >���ڣ�</td>
    <td >
       <%=getDBStr(rs.getString("sign_date"))%></td>

  
    <td >�����ܶ�ȣ�</td>
    <td ><%=formatNumberStr(rs.getString("lineof_credit"),"#,##0.00")%>Ԫ</td>
  </tr>
    <tr>
    <td >���ŷ����</td>

     <td ><%=formatNumberStr(rs.getString("credit_fact"),"#,##0.00")%>Ԫ</td>
  
    <td >������</td>
       <td><%=formatNumberStr(rs.getString("credit_remain"),"#,##0.00")%>Ԫ</td>
  </tr>
    <tr>
     <td>Ӧ�ձ�֤��</td>
    <td><%=formatNumberStr(rs.getString("guarantee_plan"),"#,##0.00")%>Ԫ</td>
    <td>Ӧ�ձ�֤����</td>
 
     <td><%=formatNumberStr(rs.getString("plan_remain"),"#,##0.00")%>Ԫ</td>

  </tr>
 
    <tr>
     <td>ʵ�ձ�֤����</td>
     <td><%=formatNumberStr(rs.getString("income_remian"),"#,##0.00")%>Ԫ</td>
  
    <td>ʵ�ձ�֤�����</td>
     <td><%=formatNumberStr(rs.getString("guarantee_income"),"#,##0.00")%>Ԫ</td>


  </tr>

    <tr>
     <td>��ע��</td>
    <td> <%=getDBStr(rs.getString("remark"))%></td>
    <td></td>
    <td >
	</td>
  </tr>
	
</table>
</div>

</div>

</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--��ӽ���-->

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->

<%
}
	rs.close(); 
	db.close();
 %>






</form>

<!-- end cwMain -->
</body>
</html>
