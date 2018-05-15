<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户关联关系设定 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="public_onload(0);" style="border:1px solid #8DB2E3;overflow:auto">
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx-khglgx-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
					 
<%
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("客户名称") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("客户编号") ) {
	searchFld_tmp = "cust_id";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and vi_cust_use_info." + searchFld_tmp + " like '%" + searchKey + "%'";
}
String sqlstr = "select vi_cust_use_info.*,inter_cust_info.cust_name as inter_cust_name,inter_cust_info.short_name as inter_short_name from vi_cust_use_info left outer join inter_custid_join on vi_cust_use_info.cust_id=inter_custid_join.cust_id_b left outer join inter_cust_info on inter_custid_join.cust_id_f=inter_cust_info.cust_id" + wherestr +" order by vi_cust_use_info.cust_id desc"; 
System.out.println(sqlstr);
%>
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				客户信息管理 &gt; 客户关联关系设定</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<form name="searchbar" action="khglgx_list.jsp">
			<tr class="maintab">
				<td align="left" colspan="2">
					&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|客户编号|客户名称"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
				</td>
			</tr>
			<tr class="maintab">
				<td align="left" width="1%">





<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		
		<td nowrap>
		</td>
		
		<%if (right.CheckRight("khxx-khglgx-mod",dqczy)>0){ %><td><a href="#" accesskey="n" onclick="dataHander('mod','khglgx_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td><%} %>
		
    </tr>
</table>
</form>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 20;   //一页显示的记录数
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

	rs.last();                                      //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>

<form action="khglgx_list.jsp" name="dataNav1">
<input name="searchKey" type="hidden" value="<%= searchKey %>">
<input name="searchFld" type="hidden" value="<%= searchFld %>">
<table border="0" cellspacing="0" cellpadding="0">
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
</form>
</td>
</tr>
</table>

<!--翻页控制结束-->

<!--
</form>
<form name="list">
-->

<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
<form action="khglgx_list.jsp" name="dataNav">
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>客户编号</th>
		<th>客户名称</th>       
		<th>客户类型</th>
		<th>财务客户名称</th>
		<th>财务客户简称</th>
      </tr>
  

<%	  

if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("cust_id") ) %>"></td>
        <td><%= getDBStr( rs.getString("cust_id") ) %></td>
        <td><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td><%= getDBStr( rs.getString("info_flag") ) %></td>
		<td><%= getDBStr( rs.getString("inter_cust_name") ) %></td>
		<td><%= getDBStr( rs.getString("inter_short_name") ) %></td>
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
</div>


<!--报表结束-->

</body>
</html>
