<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>公司内部账户列表 - 公司内部账户</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/expwin.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--


-->
</style>
<script src="../../js/comm.js"></script>
</head>
<%String tit=getStr(request.getParameter("tit"));
String czid=getStr(request.getParameter("czid"));
%>
<body>

<div id="cwMain" >


<div id="cwTop">
<!-- <table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">公司内部账户</td>
      <td id="cwTopTitRight"></td>
    </tr>
 --></table>  
</div>
<!-- end cwTop -->



<div id="cwCell">





<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">公司内部账户列表</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>

<%
String sqlstr;
ResultSet rs;
String wherestr=" where 1=1";

%>

</table>


</div>
<!-- end cwCellTop -->
<% 
int intPageSize;   //一页显示的记录数
int intRowCount=0;   //记录总数
int intPageCount;  //总页数
int intPage;       //待显示页码
int i;
java.lang.String strPage;

     //设置一页显示的记录数
	 intPageSize = 15;
	 intPageCount=1;
	 //取得待显示页码
	 strPage = request.getParameter("page");
	 if(strPage==null || strPage=="")
	 {//表明在QueryString中没有page这一个参数，此时显示第一页数据
	     intPage = 1;
	 }
	 else
	 {//将字符串转换成整型
	      intPage = java.lang.Integer.parseInt(strPage);
		  if(intPage<1) intPage = 1;
	 } 
%>
<div id="cwCellContent">

    <form name="list">
<!--<span class="cwLBTit">所属银行:<%= tit %></span>-->
    <table class="cwDataList" width="100%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
<tr class="cwDLHead">
	<th width="1%"></th>
	    <th>帐户名称</th>
            <th>开户帐号</th>
            <th>币种</th>
            <th>帐户性质</th>
	    <th>每日余额</th>
	    <th>总体授信额度</th>
   	    <th>可用额度</th>
</tr>
	  
<%
sqlstr = "SELECT * FROM jb_nbzhxx where yhid='"+czid+"'"; 
rs=db.executeQuery(sqlstr); 

if (rs.next())
  {
     
	//获取记录总数
	rs.last();
	intRowCount = rs.getRow();
	
	//记算总页数
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;
	
	//调整待显示的页码
	if(intPage>intPageCount) intPage = intPageCount;
	
	if(intPageCount>0)
	//将记录指针定位到待显示页的第一条记录上
	   rs.absolute((intPage-1) * intPageSize + 1);
	
	//显示数据
	i=0;
	while(i<intPageSize && !rs.isAfterLast())
        {
%>
	  
      <tr class="cwDLRow" >
        <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
        <td align="center"><%=getDBStr(rs.getString("zhmc"))%></td>
        <td><a href="gszh.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank"><%=getDBStr(rs.getString("khzh"))%></a></td>
        <td align="center"><%=getDBStr(rs.getString("zhbz"))%></td>
		<td align="center"><%=getDBStr(rs.getString("zhxz"))%></td>
	<td align="center"><a href="../yexx/ye_report.jsp?czzh=<%=getDBStr(rs.getString("khzh"))%>&czzhmc=<%=getDBStr(rs.getString("zhmc"))%>" target="_blank">每日余额</td>
	<%
        if (getDBDecStr(rs.getBigDecimal("sxed",2)).compareTo(new BigDecimal(0.00))==0)
        {
        %>
     <td align="left" nowrap></td>
        <%
        }
        else
        { 
        %>
     <td align="left" nowrap><a href="../edxx/edxx_list.jsp?czid=<%=getDBStr(rs.getString("khzh"))%>" target="_blank"><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("sxed",2))%></a></td>
        <%
        }
        %>  

	<%
        if (getDBDecStr(rs.getBigDecimal("kyed",2)).compareTo(new BigDecimal(0.00))==0)
        {
        %>
     <td align="left" nowrap></td>
        <%
        }
        else
        { 
        %>
     <td align="left" nowrap><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("kyed",2))%></td>
        <%
        }
        %>  
      </tr>
	  
	  

<%
       rs.next();
       i++;
	}
  }
rs.close(); 
db.close();
%>

    </table>
</form>

<div id="cwDataNav" >
<form name="dataNav" action="gszh_list.jsp">
<input name="czid" type="hidden" value="<%=czid%>">
<table border="0" cellspacing="5" cellpadding="0">
  <tr>               
		<td><a href="#" accesskey="n" onclick="dataHander('add','gszh_add.jsp',list.itemselect);"><img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle"></a></td>
		<td><a href="#" accesskey="d" onclick="dataHander('del','gszh_del.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" ></a></td>
		<td><a href="#"  accesskey="m" onclick="dataHander('mod','gszh_mod.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		<td><img src="../../images/sbtn_split.gif" width="2" height="14"></td>
    <td>
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
	<%if(intPage>1){%>	<img style="cursor:pointer; " onClick="goPage('first')" src="../../images/quick_back.gif" alt="第一页" width="19" height="19" border="0"> <img style="cursor:pointer; " onClick="goPage('prev')" src="../../images/back.gif" alt="上一页" width="19" height="19" border="0">
	<%}else{%><img style="filter:Gray;" src="../../images/quick_back.gif" alt="最后页" width="19" height="19" border="0"> <img style="filter:Gray;" src="../../images/back.gif" alt="最后页" width="19" height="19" border="0"><% } %>
	<%if(intPage<intPageCount){%> <img style="cursor:pointer; " onClick="goPage('next')" src="../../images/forward.gif" alt="下一页" width="19" height="19" border="0"> <img style="cursor:pointer; " onClick="goPage('last')" src="../../images/quick_forward.gif" alt="最后页" width="19" height="19" border="0">
	<%}else{%><img style="filter:Gray;" src="../../images/forward.gif" alt="最后页" width="19" height="19" border="0"> <img style="filter:Gray;" src="../../images/quick_forward.gif" alt="最后页" width="19" height="19" border="0"><% } %></td>
    <td>共<%=intRowCount%>条 第<%=intPage%>页/共<%=intPageCount%>页 </td>
    <td><img src="../../images/sbtn_split.gif"></td>
    <td>转到<input name="page" type="text" size="2">页<img style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" width="19" height="19" border="0" align="absmiddle"></td>
<!--     <td><img src="../../images/sbtn_split.gif"></td>
    <td>每页<input type="text" size="2">条<a href="#"><img src="../../images/ok.gif" alt="确定" width="19" height="19" border="0" align="absmiddle"></a></td>
 -->  </tr>
</table>
</form>
</div>
<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar">
<!-- <input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
 --></div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
