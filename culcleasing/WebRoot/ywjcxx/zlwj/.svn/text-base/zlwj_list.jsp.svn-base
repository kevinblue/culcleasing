<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租赁物件列表 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">基础信息管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">





<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">租赁物件列表</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<%
if (1==0)
{
%>
		<td><a href="#" accesskey="n" onclick="dataHander('add','zlwj_add.jsp',list.itemselect);"><img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle"></a></td>
               <td><a href="#" accesskey="d"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle"  onclick="dataHander('del','zlwj_del.jsp?czid=',list.itemselect);"></a></td>
<%
}

if (1==0)
{
%>
		<td><a href="#"  accesskey="m"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle"  onclick="dataHander('mod','zlwj_mod.jsp?czid=',list.itemselect);"></a></td>
<%
}
%>
</tr>
<%
String sqlstr;
ResultSet rs;
String wherestr=" where 1=1";
String searchKey="";
String searchKey1="";
String searchKey2="";
String searchKey3="";
String searchKey4="";
String searchKey5="";

if ((request.getParameter("searchKey")!=null) && (!request.getParameter("searchKey").equals("")))
{
   searchKey=getStr(request.getParameter("searchKey"));
   wherestr=wherestr+" and jb_zlwjxx.wjmc like '%"+searchKey+"%' "; 
}
if ((request.getParameter("searchKey1")!=null) && (!request.getParameter("searchKey1").equals("")))
{
   searchKey1=getStr(request.getParameter("searchKey1"));
   searchKey2=getStr(request.getParameter("searchKey2"));
   wherestr=wherestr+" and jb_zlwjxx.wjlb = '"+searchKey2+"' "; 
}
if ((request.getParameter("searchKey3")!=null) && (!request.getParameter("searchKey3").equals("")))
{
   searchKey3=getStr(request.getParameter("searchKey3"));
   wherestr=wherestr+" and jb_zlwjxx.scssscsx like '%"+searchKey3+"%' "; 
}
if ((request.getParameter("searchKey4")!=null) && (!request.getParameter("searchKey4").equals("")))
{
   searchKey4=getStr(request.getParameter("searchKey4"));
   searchKey5=getStr(request.getParameter("searchKey5"));
   wherestr=wherestr+" and jb_zlwjxx.wjlx = '"+searchKey5+"' "; 
}

%>
        <form name="searchbar" action="zlwj_list.jsp" metthod="post">
<tr>
          <td nowrap>物件名称&nbsp;&nbsp;：<input name="searchKey" accesskey="s" type="text" size="30" value="<%=searchKey%>">
          </td>
          <td nowrap>总类&nbsp;&nbsp;&nbsp;&nbsp;：
<input type="text" name="searchKey1" readonly size="30" value="<%=searchKey1%>"><input type="hidden" name="searchKey2" value="<%=searchKey2%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle" style="cursor:pointer" onclick="SimpleDataWindow('','','jb_zlwjlb','lxmc','id','','','id','searchbar.searchKey1','searchbar.searchKey2');">

          </td>
<td colspan="3">&nbsp;</td>
</tr>
<tr>
          <td nowrap>生产厂商系：<input name="searchKey3" type="text" size="30" value="<%=searchKey3%>">
          </td>
          <td nowrap>产品名称：
<input type="text" name="searchKey4" readonly size="30" value="<%=searchKey4%>"><input type="hidden" name="searchKey5" value="<%=searchKey5%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle" style="cursor:pointer" onclick="SimpleDataWindow('','','jb_zlwjlx','lxmc','id','','','id','searchbar.searchKey4','searchbar.searchKey5');">
<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
          </td>

<td colspan="3">&nbsp;</td>
        </form>

      </tr>
</table>


</div>
<!-- end cwCellTop -->


<% 
sqlstr = "SELECT V_yhxx.xm, jb_zlwjlb.lxmc as lbmc,jb_zlwjlx.lxmc, jb_zlwjzzs.zzsmc, jb_zlwjxx.* FROM jb_zlwjxx LEFT OUTER JOIN jb_zlwjzzs ON jb_zlwjxx.zzs = jb_zlwjzzs.id LEFT OUTER JOIN jb_zlwjlx ON jb_zlwjxx.wjlx = jb_zlwjlx.id LEFT OUTER JOIN jb_zlwjlb ON jb_zlwjxx.wjlb = jb_zlwjlb.id LEFT OUTER JOIN V_yhxx ON jb_zlwjxx.czy = V_yhxx.id"+wherestr+" order by jb_zlwjxx.wjmc,jb_zlwjxx.id asc"; 
rs=db.executeQuery(sqlstr); 
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


    <table class="cwDataList" width="100%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
      <tr class="cwDLHead">
	    <th width="1%"></th>
            <th>编号</th>
	    <th>租赁物件名称</th>
        <th>总类</th>
        <th>产品名称</th>
        <th>制造商</th>
		<th>信息状态</th>
      </tr>
	  
<%
//SELECT dbo.jb_yhxx.*, dbo.jb_gsbm.bmmc AS bmmc FROM dbo.jb_gsbm RIGHT OUTER JOIN dbo.jb_yhxx ON dbo.jb_gsbm.id = dbo.jb_yhxx.bm

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
        <td align="center"><%=getDBStr(rs.getString("id"))%></td>
        <td><a href="zlwj.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank"><%=getDBStr(rs.getString("wjmc"))%></a></td>
        <td align="center"><%=getDBStr(rs.getString("lbmc"))%></td>
        <td align="center"><%=getDBStr(rs.getString("lxmc"))%></td>
        <td align="center"><%=getDBStr(rs.getString("zzsmc"))%></td>
		<td align="center"><%=getDBStr(rs.getString("zt"))%></td>
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
<form action="zlwj_list.jsp" name="dataNav"  metthod="post" onSubmit="return goPage()">
<input name="searchKey" type="hidden" value="<%=searchKey%>">
<input name="searchKey1" type="hidden" value="<%=searchKey1%>">
<input name="searchKey2" type="hidden" value="<%=searchKey2%>">
<input name="searchKey3" type="hidden" value="<%=searchKey3%>">
<input name="searchKey4" type="hidden" value="<%=searchKey4%>">
<input name="searchKey5" type="hidden" value="<%=searchKey5%>">
<table border="0" cellspacing="5" cellpadding="0">
  <tr>
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
  </tr> -->
</table>
</form>
</div>
<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<div id="cwToolbar">
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
