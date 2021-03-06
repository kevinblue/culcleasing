<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>基本信息 - 催款员负责合同列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				基本信息 &gt; 催款员负责合同列表</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<%
ResultSet rs;
String wherestr = " where 1=1 ";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

String searchFld_tmp = "";
if( searchFld.equals("省") ) {
	searchFld_tmp = "vi_cust_all_info.sfmc";
}else if( searchFld.equals("市") ) {
	searchFld_tmp = "vi_cust_all_info.csmc";
}else if( searchFld.equals("催款员") ) {
	searchFld_tmp = "base_user.name";
}else if( searchFld.equals("合同编号") ) {
	searchFld_tmp = "vi_contract_info.contract_id";
}else if( searchFld.equals("承租人") ) {
	searchFld_tmp = "vi_cust_all_info.cust_name";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%' ";
}




String sqlstr = "SELECT vi_contract_info.contract_id,vi_cust_all_info.cust_name,vi_cust_all_info.sfmc,vi_cust_all_info.csmc,base_user.name,.vi_contract_info.status_name FROM base_user RIGHT OUTER JOIN contract_dun ON base_user.id = contract_dun.dun RIGHT OUTER JOIN vi_cust_all_info RIGHT OUTER JOIN vi_contract_info ON vi_cust_all_info.cust_id = vi_contract_info.cust_id ON contract_dun.contract_id = vi_contract_info.contract_id" + wherestr; 

sqlstr +=" order by vi_cust_all_info.sfmc,vi_cust_all_info.csmc,base_user.name";

//System.out.println("sqlstr=================="+sqlstr);
%>


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<form name="searchbar" action="contractdun_list.jsp">
			<tr class="maintab">
				<td align="left" width="1%">
					 



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td nowrap>&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|省|市|催款员|合同编号|承租人"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">		
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"><a href="#" accesskey="m" onclick="dataHander('mod','contractdun_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
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

<form action="contractdun_list.jsp" name="dataNav1" onSubmit="return goPage()">
<input name="searchFld" accesskey="s" type="hidden" size="15" value="<%= searchFld %>">	
<input name="searchKey" accesskey="s" type="hidden" size="15" value="<%= searchKey %>">	
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

</td>
</tr>
</form>
</table>

<!--翻页控制结束-->






<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
<form action="contractdun_list.jsp" name="dataNav" >
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th>合同号</th>
		<th nowrap>承租人</th>
		<th>城市</th>
		<th>省份</th>
		<th>合同状态</th>
		<th>催款员</th>
      </tr>
  

<%	  

rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("contract_id") ) %>"></td>
        <td><%= getDBStr( rs.getString("contract_id") ) %></a></td>
        <td><%= getDBStr( rs.getString("cust_name") ) %></a></td>
        <td><%= getDBStr( rs.getString("csmc") ) %></a></td>
        <td><%= getDBStr( rs.getString("sfmc") ) %></td>
        <td><%= getDBStr( rs.getString("status_name") ) %></a></td>
        <td><%= getDBStr( rs.getString("name") ) %></td>
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
</div>

<!--报表结束-->
</form>
</body>
</html>
