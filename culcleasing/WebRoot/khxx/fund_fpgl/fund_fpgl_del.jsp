<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>票据管理-票据管理</title>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

<script src="../../js/comm.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
String dqczy=(String) session.getAttribute("czyid");

if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("fpgl_del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<%
String czid;
String sqlstr;
ResultSet rs;
czid=getStr(request.getParameter("id"));
   // String id = getStr( request.getParameter("id") );
	//String cust_id = getStr( request.getParameter("custId") );
	 sqlstr = "select * from dbo.proj_invoice  where id="+czid; 
	 rs = db.executeQuery(sqlstr);
	
String invoice_number="";
	String invoice_total="";
	String invoice_date="";
	if(rs.next()){
		invoice_number=getDBStr(rs.getString("invoice_number"));
	invoice_total=getDBStr(rs.getString("invoice_total"));
	invoice_date=getDBStr(rs.getString("invoice_date"));
	
	
%>
<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="fund_fpgl_save_del.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
票据管理 &gt; 票据删除
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/btn_delete.gif" align="absmiddle" border="0">删除</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->

</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">删除</td>
  
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

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">




<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	 
 
<tr>
    <td >票据号：</td>
    <td > <%=getDBStr(rs.getString("invoice_number"))%></td>
  </tr>
<tr>
  <td >票据总额：</td>
    <td ><%=formatNumberStr(rs.getString("invoice_total"),"#,##0.00")%>元</td>
  </tr>
  
  
    <tr>
  <td >开票日期：</td>
     <td > <%=getDBStr(rs.getString("invoice_date"))%></td>
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
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->

<%
}
	rs.close(); 
	db.close();
 %>






</form>

<!-- end cwMain -->
</body>
</html>
