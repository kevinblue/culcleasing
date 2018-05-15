<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户类别大类列表 - 客户信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String sqlstr;
ResultSet rs;
int i=0;
String wherestr=" where 1=1";
String  searchKey=getStr(request.getParameter("searchKey"));
if (request.getParameter("searchKey")!=null)
{
  
   wherestr=wherestr+" and kh_lbdl.lbdlmc like '%"+searchKey+"%' "; 
}
sqlstr = "select kh_lbdl.*,base_user.name from kh_lbdl left join base_user on kh_lbdl.czy=base_user.id "+wherestr+" order by kh_lbdl.id asc"; 
rs=db.executeQuery(sqlstr); 
%>


<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_khlbdl_list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<body text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' onLoad="public_onload(0)">




<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle">
				客户信息管理&gt;客户类别大类列表</td>
			</tr>
</table> 
</div>
<!-- end cwTop -->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<form name="searchbar" action="khlbdl_list.jsp">
		<td nowrap>客户行业门类：
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
          </td>
		</form>
		<td><a href="#" accesskey="n" onClick="dataHander('add','khlbdl_add.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td>
		<td><a href="#"  accesskey="m" onClick="dataHander('mod','khlbdl_mod.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onClick="dataHander('del','khlbdl_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td>
    


</td>
					 <td align="right" width="100%">
					 	
					 	



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

	
%>

<form action="gjxx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKey" type="hidden" value="<%= searchKey %>">

<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" 

border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" 

style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" 

border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" 

style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" 

src="../../images/goto.gif" alt="执行" border="0"></td>
 </tr>
</table>

</td>
</tr>
</table>




   <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th >客户类别大类代码</th>
        <th >客户类别大类名称</th>
        <th>最后更新日期</th>
        <th>操作员</th>
		<th>类别小类</th>
      </tr>
  

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr onMouseOver="fn_changeTrColor()" onMouseOut="fn_changeTrColor()">
		<td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
        <td align="center"><%=getDBStr(rs.getString("id"))%></a></td>
        <td><a href="khlbdl.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank"><%=getDBStr(rs.getString("lbdlmc"))%></a></td>
        <td align="center"><%=getDBDateStr(rs.getString("gxrq"))%></td>
        <td align="center"><%=getDBStr(rs.getString("name"))%></td>
		<td align="center"><a href="../khlbxl/khlbxl_list.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank">查看</a></td>      </tr>
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
</form>
</div>
<!-- end cwDataNav -->



<!-- end cwCellContent -->





<!-- end cwCell -->






<!-- end cwMain -->
</body>
</html>
