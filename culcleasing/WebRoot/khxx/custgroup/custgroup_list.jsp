<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 集团列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx-custgroup-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				客户信息 &gt; 集团列表</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<%


ResultSet rs;
ResultSet rs2;

String sqlstr2="";
String cust_name="";

String wherestr = " where 1=1";


String searchKey = getStr( request.getParameter("searchKey") );

if ( !searchKey.equals("") ) {

	wherestr = wherestr + " and group_name like '%" + searchKey + "%' ";
}


String sqlstr = "SELECT * FROM cust_group " + wherestr; 
sqlstr +="order by group_name";
//System.out.println("sqlstr=================="+sqlstr);
%>



<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<form name="searchbar" action="custgroup_list.jsp">
			<tr class="maintab">
				<td align="left" width="1%">
					 




<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
			<form name="searchbar" action="custgroup_list.jsp">
    <tr class="maintab">
		<td nowrap>集团名称<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">		
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
		<td><a href="#" accesskey="n" onclick="dataHander('add','custgroup_add.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td>
		<td><a href="#" accesskey="m" onclick="dataHander('mod','custgroup_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onclick="dataHander('del','custgroup_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td>
    </tr>
</form>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 50;   //一页显示的记录数
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


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>


<table border="0" cellspacing="0" cellpadding="0">
<form action="custgroup_list.jsp" name="dataNav1" onSubmit="return goPage()">
<input name="searchKey" accesskey="s" type="hidden" size="15" value="<%= searchKey %>">	
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav1;
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

</td>
</tr>
</form>
</table>

<!--翻页控制结束-->






<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
<form action="custgroup_list.jsp" name="dataNav" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th width="30%">集团名称</th>
		<th>集团成员</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("group_id") ) %>"></td>
        <td align="left">
<a href="custgroup.jsp?czid=<%=getDBStr( rs.getString("group_id"))%>" target="_blank"><%= getDBStr( rs.getString("group_name") ) %></a>
	</td>
<%
	cust_name="";
	sqlstr2="SELECT vi_cust_all_info.cust_name FROM cust_group_company LEFT OUTER JOIN vi_cust_all_info ON cust_group_company.cust_id = vi_cust_all_info.cust_id where cust_group_company.group_id='"+getDBStr( rs.getString("group_id") )+"' order by vi_cust_all_info.cust_name";
	rs2 = db2.executeQuery(sqlstr2); 
	while ( rs2.next() )
	{
		cust_name+=getDBStr( rs2.getString("cust_name") )+"<br>";
	}
	rs2.close(); 
 %>
	<td><%=cust_name%></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
db2.close();
%>
    </table>
</div>

<!--报表结束-->
</form>
</body>
</html>
