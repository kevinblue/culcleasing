<%@ page contentType="text/html; charset=gbk" language="java"  %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息管理 - 调息列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<%

String dqczy=(String) session.getAttribute("czyid");
%>
<%--
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("tx_cz",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
//out.print("canedit="+canedit);
--%>

<body onload="public_onload(0);">
<form action="tx_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		调息管理 &gt; 调息列表</td>
	</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="1%">
<%
//String dqczy=(String) session.getAttribute("czyid");
ResultSet rs;
String wherestr = " where 1=1";

String sqlstr = "select base_adjust_interest.* from base_adjust_interest" + wherestr+" order by create_date desc"; 
//System.out.println("sqlstr=================="+sqlstr);
%>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
        <td align="right">
		  <BUTTON class="btn_2" type="button" onclick="dataHander('add','tx_add.jsp',dataNav.itemselect);">
		  <img src="../../images/sbtn_new.gif" align="absmiddle" border="0">&nbsp;新增</button>
		</td>
		<td align="right">
		  <BUTTON class="btn_2" type="button" onclick="dataHander('mod','tx_mod.jsp?czid=',dataNav.itemselect);">
		  <img src="../../images/sbtn_mod.gif" align="absmiddle" border="0">&nbsp;修改</button>
		</td>
		
		<td align="right">
		  <BUTTON class="btn_2" type="button" onclick="dataHander('del','tx_del.jsp?czid=',dataNav.itemselect);">
		  <img src="../../images/sbtn_del.gif" align="absmiddle" border="0">&nbsp;删除</button>
		</td>
    </tr>
</table>
<!--操作按钮结束-->
</td>

<td align="right" width="90%">
<!--翻页控制开始-->
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
</td>
</tr>
</table>
<!--翻页控制结束-->

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th>央行基础利率</th>
		<th>央行调整后利率</th>
		<th>期限</th>
		<th>央行利率调整日期</th>
		<th>系统租金变更执行日期</th>
		<th>租赁公司基础利率</th>
		<th>利率差下限</th>
		<th>调息结束</th>
		<th>调息</th>
      </tr>
<tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
		String adjust_flag=getDBStr( rs.getString("adjust_flag") );
%>
      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("id") ) %>"></td>
        <td align="center"><a href="tx.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank"><%= getDBStr( rs.getString("base_rate") ) %>%</a></td>
        <td align="center"><%= getDBStr( rs.getString("yh_adjust_rate") ) %>%</td>
        <td align="center"><%= getDBStr( rs.getString("nx") ) %></td>
        <td align="center"><%= getDBDateStr( rs.getString("base_date") ) %></td>
        <td align="center"><%= getDBDateStr( rs.getString("start_date") ) %></td>
        <td align="center"><%= getDBStr( rs.getString("base_adjust_rate") ) %>%</td>
        <td align="center"><%= getDBStr( rs.getString("rate_limit") ) %>%</td>
        <td align="center"><%= getDBStr( rs.getString("adjust_flag") ) %></td>
        <%if(adjust_flag.equals("否")){ %>
        <td align="center">
        <a href="tx_gz_main.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank">规则调息</a>
        |
        <a href="tx_bgz_main.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank">不规则调息</a>
        </td>
        <%}else{ %>
        <td align="center"><a href="tx_read.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank">调息记录</a></td>
        <%} %>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody></table>
</div>
<!--报表结束-->
</form>
</body>
</html>
