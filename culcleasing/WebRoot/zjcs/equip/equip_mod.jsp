<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������� - ��ƾ�������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
</head>

<%
	String czid = getStr( request.getParameter("czid") );
	String  sqlstr = "select * from contract_equip_temp where id='" + czid+"'"; 

	ResultSet rs = db.executeQuery(sqlstr);
	if( rs.next() ){
	
%>

<body  onload="public_onload();fun_winMax();" >
<form name="form1" method="post" action="equip_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ƾ������� &gt; ��ƾ����޸�
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td >
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">�� ��</td>
  
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
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=czid%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td nowrap>�ʲ�����/�ͺ�</td>
    <td nowrap><input class="text" name="eqip_name" type="text" maxlength="3" size="3" maxB="40" Require="ture"  value="<%=getDBStr(rs.getString("eqip_name"))%>"></td>
  
    <td nowrap>����(̨)</td>
    <td nowrap><input class="text" name="equip_num" type="text" size="3"  maxlength="3" dataType="Integer" maxB="40" Require="ture"  value="<%=getDBStr(rs.getString("equip_num"))%>"></td>
  </tr>
  

  <tr>
    <td nowrap>�豸����(Ԫ)</td>
    <td nowrap><input class="text" name="equip_price" type="text"  maxlength="50" maxB="50"  dataType="Money" Require="ture"  value="<%=formatNumberStr(getDBStr(rs.getString("equip_price")),"#,##0.00")%>"></td>
  
    <td nowrap>�豸�ܶ�(Ԫ)</td>
    <td nowrap><input class="text" name="total_price" type="text"  maxlength="40" maxB="40"  dataType="Money" Require="ture"  value="<%=formatNumberStr(getDBStr(rs.getString("total_price")),"#,##0.00")%>" ></td>
  </tr>
  <tr>
  <td nowrap>��Ӧ��</td>
    <td nowrap><input class="text" name="distributor" type="text"  maxlength="40" maxB="40" value="<%=getDBStr(rs.getString("distributor"))%>"></td>
    <td nowrap>����(��)</td>
    <td nowrap><input class="text" name="equip_team" type="text"  maxlength="40" maxB="40" dataType="Integer"  Require="ture"  value="<%=getDBStr(rs.getString("equip_team"))%>"></td>
  </tr>
  <tr>
    <td nowrap>ÿ�����(Ԫ)</td>
    <td nowrap><input class="text" name="equip_rent" type="text"  maxlength="100" maxB="100" Require="ture"  dataType="Money"  value="<%=formatNumberStr(getDBStr(rs.getString("equip_rent")),"#,##0.00")%>"></td>
  
    <td nowrap>��Ʒ���</td>
    <td nowrap><input class="text" name="equip_type" type="text"  maxlength="100" maxB="100" value="<%=getDBStr(rs.getString("equip_type"))%>"></td>
 </tr>
 <tr>
 <td nowrap>����</td>
    <td nowrap><input class="text" name="equip_dispose" type="text"  maxlength="100" maxB="100" value="<%=getDBStr(rs.getString("equip_dispose"))%>"></td>
    <td nowrap></td>
    <td nowrap></td>
  </tr>
  
  
  <tr>
    <td nowrap>��ע</td>
    <td><textarea class="text" name="memo" maxB="500" rows="6"><%=getDBStr(rs.getString("memo"))%></textarea></td>
  

    <td ></td>
  </tr>
</table>
	<%
	}
rs.close();
db.close();
%>

<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>

<!-- end cwToolbar -->
    </form>

<!-- end cwMain -->
</body>
</html>
