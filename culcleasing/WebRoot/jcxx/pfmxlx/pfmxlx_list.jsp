<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
System.out.println("jcxx-pfmxlx-list:"+right.CheckRight("jcxx-pfmxlx-list",dqczy));
if (right.CheckRight("jcxx-pfmxlx-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>评分模型类型 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="setDivHeight('mydiv',-55);">

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				基础信息管理 &gt; 评分模型类型</td>
			</tr>
</table>
<%



ResultSet rs;
String wherestr = " where 1=1";


String sqlstr = "select * from vi_base_evaluation_type" + wherestr; 


%>
	


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<%if (right.CheckRight("jcxx-pfmxlx-op",dqczy)>0){ %><td><a href="#" accesskey="n" onclick="dataHander('add','pfmxlx_add.jsp?',list.itemselect);"><img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle"></a></td><%} %>
		<%if (right.CheckRight("jcxx-pfmxlx-op",dqczy)>0){ %><td><a href="#" accesskey="m" onclick="dataHander('mod','pfmxlx_mod.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td><%} %>
		<%if (right.CheckRight("jcxx-pfmxlx-op",dqczy)>0){ %><td><a href="#" accesskey="d" onclick="dataHander('del','pfmxlx_del.jsp?czid=',list.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" ></a></td><%} %>
    </tr>
</table>
</td>
<td  align="right" width="90%">
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
rs=db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //记算总页数
	if(intPage>intPageCount) intPage = intPageCount;            //调整待显示的页码
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //将记录指针定位到待显示页的第一条记录上
	int i = 0; %>
<form action="khzygr_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>
</form>
<!-- end cwCellTop -->
</td>
</tr>
</table>
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>

    <form name="list">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		<th>评分类型</th>
		<th>评分模型/调整项</th>
		<th>登记人</th>
		<th>登记时间</th>
		<th>更新人</th>
		<th>更新日期</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("id") ) %>"></td>
		<td align="left"><a href="pfmxlx.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank"><%= getDBStr( rs.getString("evaluation_type") ) %></a></td>
		<td align="center"><%if (right.CheckRight("jcxx-pfmxlx-op",dqczy)>0){ %><a href="../pfmx/pfmx_list.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_ablank">评分项</a> &nbsp;&nbsp;/&nbsp;&nbsp;<a href="../tzxx/tzxx_list.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_ablank">调整项</a><%} %></td>
		<td><%=getDBStr( rs.getString("creator") ) %></td>
		<td><%=getDBDateStr( rs.getString("create_date") ) %></td>
		<td><%=getDBStr( rs.getString("modificator") ) %></td>
		<td><%=getDBDateStr( rs.getString("modify_date") ) %></td>
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

<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->



<!-- end cwMain -->
</body>
</html>
