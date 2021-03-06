<%@ page contentType="text/html; charset=gb2312" language="java"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>满意度模型管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td id="cwTopTitLeft"></td>
        <td id="cwTopTitTxt"  >满意度模型管理</td>
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
         <td id="cwCellTopTitTxt">满意度模型管理</td>
         <td id="cwCellTopTitRight"></td>
    </tr>
</table>
<%


String sqlstr = "select * from v_perf_satissurvey_model order by dept_id"; 
ResultSet rs;
%>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >    
    <tr>
		<td><a href="#" accesskey="n" onclick="dataHander('add','mydmx_add.jsp?',list.itemselect);"><img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle"></a></td>
		<td><a href="#" accesskey="m" onclick="dataHander('mod','mydmx_mod.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onclick="dataHander('del','mydmx_del.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" ></a></td>
    </tr>
</table>


</div>
<!-- end cwCellTop -->
<% 
	int intPageSize = 15;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数

	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	 intPage = 1;
	}else{
	  intPage = java.lang.Integer.parseInt(strPage);
	  if(intPage<1) intPage = 1;
	} 
%>
<div id="cwCellContent">

    <form name="list">

    <table class="cwDataList" width="100%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
      <tr class="cwDLHead">
	    <th width="1%"></th>
		<th>部门</th>
		<th>项目</th>
		<th>考核频度</th>
		<th>评分人</th>
		<th>更新人</th>
		<th>更新日期</th>
      </tr>
	  
<%

rs=db.executeQuery(sqlstr); 

if (rs.next()){
	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //记算总页数
	if(intPage>intPageCount) intPage = intPageCount;            //调整待显示的页码
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("id") ) %>"></td>
		<td><a href="mydmx.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank"><%= getDBStr( rs.getString("bmmc") ) %></a></td>
		<td><%= getDBStr( rs.getString("item") ) %></td>
		<td><%= getDBStr( rs.getString("frequency") ) %></td>
		<td><%= getDBStr( rs.getString("examiner") ) %></td>
		<td><%= getDBStr( rs.getString("gxrxm") ) %></td>
		<td><%= getDBDateStr( rs.getString("modify_date") ) %></td>
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
<form action="mydmx_list.jsp" name="dataNav" onSubmit="return goPage()">
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
 </tr>
</table>
</form>
</div>
<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->

</div>
<!-- end cwCell -->


<div id="cwToolbar">
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()"  style="display:none">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
