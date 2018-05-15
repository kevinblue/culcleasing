<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>资金信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
/* cwCellTop */
.cwCellTop{
	width:100%;
	background-image: url(../../images/top_bakg.gif);
	background-repeat: repeat-x; 
	background-color:#EEEAEE;
}
#cwCell{
margin:5px;

border:none;
background-color:#F5F2F5;
height:auto;
}
#cwCellContent{ padding:0px}
#cwCellToolbar{
display:none;}
#cwCellTopTit{

width:250px}
.innerwin{border:#cccccc solid 1px;}
-->
</style></head>

<body>

<div id="cwMain" >


  <div id="cwTop">
    <table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwTopTitLeft"></td>
        <td id="cwTopTitTxt"  >每日现金余额表</td>
        <td id="cwTopTitRight"></td>
      </tr>
    </table>  
  </div>
  <!-- end cwTop -->
  
  
  
  <div id="cwCell">
    
    
    
    
    
    <div id="cwCellTop">
      

	    
<table style="display:none" id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
  <tr>
    <td></td>
        </tr>
  </table>
</div>
    <!-- end cwCellTop -->
    <%
String czzh=getStr(request.getParameter("czzh"));
String czzhmc=getStr(request.getParameter("czzhmc"));
    %>

  
    <div id="cwCellContent" >
      <table width="100%"   border="0" cellpadding="0" cellspacing="8" class="cwDataInput">
        <tr>
          <td colspan="2" scope="row"  class="innerwin"><div class="cwCellTop">	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">每日现金余额表-人民币</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table></div><iframe src="yermb_list.jsp?czzh=<%=czzh%>&czzhmc=<%=czzhmc%>" scrolling="auto" frameborder="0"  style="width:100%; height:300px"></iframe></td>
        </tr>
        <tr>
          <td colspan="2" scope="row"  class="innerwin"><div class="cwCellTop">	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">每日现金余额表-外币</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table></div><iframe src="yewb_list.jsp?czzh=<%=czzh%>&czzhmc=<%=czzhmc%>" scrolling="auto" frameborder="0"  style="width:100%; height:300px"></iframe></td>
        </tr>
      </table>
   
    <!-- end cwDataNav -->
    </div>
    <!-- end cwCellContent -->
  </div>
  <!-- end cwCell -->
  
  
  
  
  
  <div id="cwToolbar" >
  </div>
  <!-- end cwToolbar -->
</div>
<!-- end cwMain -->
</body>
</html>
