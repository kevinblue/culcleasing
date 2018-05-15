<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>发票退回-修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//进入新增之后，查询申请单
String glide_id= getStr( request.getParameter("fpId") );
String apply_p = "";
String apply_date = "";
sqlstr="select ci.*,apply_p=dbo.getUserName(ci.creator) from invoice_draw_info_t ci where glide_id='"+glide_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	apply_p=getDBStr( rs.getString("apply_p") );
	apply_date=getDBDateStr( rs.getString("plan_date") );
}
rs.close();
db.close();
%>

<body style="overflow:auto;"> 
  <div style="vertical-align:top;width:100%;overflow:auto;">
  
  <table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
	<td class="tree_title_txt"  height=26 valign="middle"> 
	<br><br>申请发票退回 
	</td>
</tr>
</table>
	 <table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
	 <tr>
	 <td><a href="#" onClick="closePage();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/fdmo_37.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
		<td scope="row">申请人:&nbsp;&nbsp;<b style="color:#E46344;"><%=apply_p %></b></td>
	    <td>&nbsp;</td>
	    <td scope="row">申请号:&nbsp;&nbsp;<b style="color:#E46344;"><%=glide_id %></b></td>
	    <td>&nbsp;</td>
	
	    <td scope="row">申请日期:&nbsp;&nbsp;<b style="color:#E46344;"><%=apply_date %></b></td>
	    <td>&nbsp;</td>
	  </tr>
	</table>

   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		资金发票&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="invoice_zj.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		罚息发票&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="invoice_fx.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
   <div id="tabletit" class="tabtitexp">&nbsp; 
   		租金发票&nbsp;
   		<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
   		style="cursor:hand" title="显示/隐藏内容">				 
   	</div> 
   	<div>
	<iframe frameborder="0" name="con" width="100%" height="430" 
		src="invoice_rent.jsp?glide_id=<%=glide_id%>">
	</iframe>
   </div>
   
</div>
</body>
<script type="text/javascript">
	function closePage(){
		window.close();
		opener.location.reload();
	}
</script>
</html>
