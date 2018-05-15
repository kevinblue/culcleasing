<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金管理-发票管理</title>
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
ResultSet rs1;
czid=getStr(request.getParameter("id"));
   // String id = getStr( request.getParameter("id") );
	//String cust_id = getStr( request.getParameter("custId") );
	 sqlstr = " select * from factoring_contract_info  where id="+czid; 
	 rs1 = db.executeQuery(sqlstr);
	
String factoring_backname="";
String factoring_account="";
String factoring_date="";
String factoring_rent="";
String factoring_corpus="";
String factoring_interest="";
String factoring_repay="";
String factoring_rate="";
	if(rs1.next()){
	factoring_backname=getDBStr(rs1.getString("factoring_backname"));
	factoring_account=getDBStr(rs1.getString("factoring_account"));
	factoring_date=getDBDateStr(rs1.getString("factoring_date"));
	factoring_rent=getDBStr(rs1.getString("factoring_rent"));
	factoring_corpus = getDBStr(rs1.getString("factoring_corpus"));
	factoring_interest = getDBStr(rs1.getString("factoring_interest"));
	factoring_repay = getDBStr(rs1.getString("factoring_repay"));
	factoring_rate = getDBStr(rs1.getString("factoring_rate"));
	
	
%>
<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="factoring_save_del.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保理管理 &gt; 保理删除
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
	
   <td class="row"> 保理银行&nbsp;&nbsp;<%=getDBStr(rs1.getString("factoring_backname"))%>&nbsp;&nbsp;</td>
   <td class="row"> 保理帐户&nbsp;&nbsp;<%= factoring_account%>&nbsp;&nbsp;</td>
  <td class="row">  保理时间&nbsp;&nbsp;<%= getDBDateStr(rs1.getString("factoring_date")) %>&nbsp;&nbsp;</td>
  <td class="row">  保理金额&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_rent"),"#,##0.00")%></td>
	</tr>
	<tr>
	
	
	<td class="row">保理本金&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_corpus"),"#,##0.00")%>&nbsp;&nbsp;</td>
	<td class="row">保理利息&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_interest"),"#,##0.00")%>&nbsp;&nbsp;</td>
	<td class="row">偿还金额&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_repay"),"#,##0.00")%>&nbsp;&nbsp;</td>
	<td class="row">保理利率&nbsp;&nbsp;<%=formatNumberStr(rs1.getString("factoring_rate"),"#,##0.00")%></td>

	
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
	rs1.close(); 
	db.close();
 %>






</form>

<!-- end cwMain -->
</body>
</html>
