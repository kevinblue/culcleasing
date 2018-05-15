<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
 <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>财务凭证下载 - 财务凭证下载</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String context = request.getContextPath();
 %>
<body style="border:1px solid #8DB2E3;">
<form action="pzxz_download.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				财务凭证下载 &gt; 财务凭证下载</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="50%">
					 
<%
ResultSet rs = null;
String down_date = getStr(request.getParameter("down_date"));
String export_flag = getStr(request.getParameter("export_flag"));
String delete_flag = getStr(request.getParameter("delete_flag"));
String sql = "";
String strwhere = " where 1=1";
if(down_date!=null&&!down_date.equals("")){
	strwhere+=" and convert(varchar(10),inter_evidence_download.down_date,21)='"+down_date+"'";
}
if(export_flag!=null&&!export_flag.equals("")){
	strwhere+=" and inter_evidence_download.export_flag='"+export_flag+"'";
}
if(delete_flag!=null&&!delete_flag.equals("")){
	strwhere+=" and inter_evidence_download.delete_flag='"+delete_flag+"'";
}
sql = "select inter_evidence_download.id,convert(varchar(19),inter_evidence_download.down_date,20) as down_date,inter_evidence_download.down_url,jb_yhxx.xm,inter_evidence_download.export_flag,inter_evidence_download.delete_flag from inter_evidence_download left outer join jb_yhxx on inter_evidence_download.creator = jb_yhxx.id "+strwhere+"  order by create_date desc";
System.out.println(sql);
%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		
		<td nowrap>
			<input name="down_date" type="text" size="15" readonly maxlength="10" value="<%=down_date %>" dataType="Date"> <img  onClick="openCalendar(down_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			<select name="export_flag"><script>w(mSetOpt("<%= export_flag %>","|已导出|未导出"));</script></select>
			<select name="delete_flag"><script>w(mSetOpt("<%= delete_flag %>","|有效|废止"));</script></select>
			<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="window.submit()">
		</td>
		
    </tr>
</table>

<!--操作按钮结束-->
</td>
<td align="right" width="10%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 10;   //一页显示的记录数
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


rs = db.executeQuery(sql); 

	rs.last();                                      //获取记录总数
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

<!--
</form>
<form name="list">
-->

<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="20%">生成日期</th>
	    <th width="40%">文件</th>
	    <th width="20%">操作员</th>
	     <th width="10%">导出状态</th>
	      <th width="10%">有效状态</th>
      </tr>
  

<%	  

if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>

		<td><%= getDBStr( rs.getString("down_date") ) %></td>	
		<td><a target="_black" href="<%= basePath+getDBStr( rs.getString("down_url") ) %>"><%=getDBStr( rs.getString("down_url") ) %></a></td> 
      	<td><%= getDBStr( rs.getString("xm") ) %></td>
      	
      	<td align="center"><a href="pzxz_save.jsp?czid=<%= getDBStr( rs.getString("id") ) %>&gnbh=<%= getDBStr( rs.getString("export_flag") ) %>&savetype=export" target="_blank"><span title="设置凭证下载为<%=getDBStr( rs.getString("export_flag") ).equals("已导出")?"未导出":"已导出" %>状态"><%= getDBStr( rs.getString("export_flag") ) %></span></a>  </td>
      	<td align="center"><a href="pzxz_save.jsp?czid=<%= getDBStr( rs.getString("id") ) %>&gnbh=<%= getDBStr( rs.getString("delete_flag") ) %>&savetype=delete" target="_blank"><span title="设置凭证下载为<%=getDBStr( rs.getString("delete_flag") ).equals("有效")?"废止":"有效" %>状态"><%= getDBStr( rs.getString("delete_flag") ) %></span></a></td>
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

