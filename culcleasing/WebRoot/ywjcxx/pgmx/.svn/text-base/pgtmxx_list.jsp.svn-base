<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>评估条目信息列表 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >基础信息管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">



<%
String sqlstr;
ResultSet rs;

String wherestr=" where (1=1)";

String czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
}
else
{
	wherestr=wherestr+" and (jb_pgmx_tmxx.pglxxlid = '"+czid+"') "; 
}
String searchKey=getStr(request.getParameter("searchKey"));
if ((searchKey==null) || (searchKey.equals("")))
{
}
else
{
	wherestr=wherestr+" and (jb_pgmx_tmxx.pjys like '%"+searchKey+"%') ";   
}


%>

<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">评估条目信息列表</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
		<td><a href="#" accesskey="n" onclick="dataHander('add','pgtmxx_add.jsp?czid=<%=czid%>',list.itemselect);"><img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle"></a></td>
		<td><a href="#"  accesskey="m" onclick="dataHander('mod','pgtmxx_mod.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onclick="dataHander('del','pgtmxx_del.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" ></a></td>
		<td><img src="../../images/sbtn_split.gif" width="2" height="14"></td>

        <form name="searchbar" action="pgtmxx_list.jsp">
           <input type="hidden" name="czid" value="<%=czid%>">
          <td nowrap>评估条目名称：<input name="searchKey" accesskey="s" type="text" size="15" value="<%=searchKey%>"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
          </td>
        </form>

      </tr>
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

    <table class="cwDataList" width="100%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
	<tr class="cwDLHead">
	<th width="1%"></th>
	<th>评价要素</th>
	<th>计算口径</th>
	<th>评分说明</th>
        <th>单项权重</th>
        <th>序号</th>
        <th>当前是否有效</th>
        <th>评分指导区间</th>

<%
sqlstr = "SELECT jb_pgmx_tmxx.*, jb_pgmx_pglxxl.pglxxlmc AS pglxxlmc,jb_yhxx.xm AS djrxm, jb_yhxx_1.xm AS gxrxm ";
sqlstr+=" FROM jb_yhxx jb_yhxx_1 RIGHT OUTER JOIN jb_pgmx_tmxx ON jb_yhxx_1.id = jb_pgmx_tmxx.gxr LEFT OUTER JOIN jb_yhxx ON jb_pgmx_tmxx.djr = jb_yhxx.id ";
sqlstr+=" LEFT OUTER JOIN jb_pgmx_pglxxl ON jb_pgmx_tmxx.pglxxlid = jb_pgmx_pglxxl.id "+wherestr+" order by jb_pgmx_tmxx.xh asc"; 
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
        <td><a href="pgtmxx.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank"><%=getDBStr(rs.getString("pjys"))%></a></td>
        <td align="center"><%=getDBStr(rs.getString("jskj"))%></td>
        <td align="left"><%=getDBStr(rs.getString("pfsm"))%></td>
        <td align="center"><%=getDBStr(rs.getString("qz"))%></td>
        <td align="center"><%=getDBStr(rs.getString("xh"))%></td>
        <td align="center"><%=formatBooleanStr(getDBStr(rs.getString("his")),0)%></td>
        <td><a href="tmpfbz_list.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank">查看</a></td>
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
<form action="pgtmxx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKey" type="hidden" value="<%=searchKey%>">
<input name="czid" type="hidden" value="<%=czid%>">
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
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
