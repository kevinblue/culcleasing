<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>地区信息列表 - 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String sqlstr;
ResultSet rs;
int i=0;
String wherestr=" where 1=1";
String searchKey="";
String czid=getStr(request.getParameter("czid"));
if ((czid==null) || (czid.equals("")))
{
  
}
else
{
wherestr=wherestr+" and jb_qyxx.gjid = '"+czid+"' "; 
}
if (request.getParameter("searchKey")!=null)
{
   searchKey=getStr(request.getParameter("searchKey"));
   wherestr=wherestr+" and jb_qyxx.qymc like '%"+searchKey+"%' "; 
}
sqlstr = "select jb_qyxx.id,jb_qyxx.qyid,jb_qyxx.gjid,jb_gjxx.gjmc,jb_qyxx.qymc,jb_qyxx.gxrq,jb_qyxx.czy,base_user.name from jb_qyxx  left join base_user on jb_qyxx.czy=base_user.id left join jb_gjxx on jb_qyxx.gjid=jb_gjxx.id"+wherestr+"order by jb_qyxx.id asc"; 
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
if (right.CheckRight("ywjcxx_dqxx_list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>

<body text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' onLoad="public_onload(0)">




<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle">
				基础信息管理&gt;地区信息</td>
			</tr>
</table> 
</div>
<!-- end cwTop -->






<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<form name="searchbar" action="qyxx_list.jsp">
		<td nowrap>地区信息：
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>"><input name="image" type="image" 

src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
          </td>
		</form>
		<%if(right.CheckRight("ywjcxx_dqxx_add",dqczy)>0){%>
		<td><a href="#" accesskey="n" onClick="dataHander('add','qyxx_add.jsp',dataNav.itemselect);"><img align="absmiddle"  

src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td><%}%>
<%if(right.CheckRight("ywjcxx_dqxx_mod",dqczy)>0){%>
		<td><a href="#"  accesskey="m" onClick="dataHander('mod','qyxx_mod.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" 

alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td><%}%>
<%if(right.CheckRight("ywjcxx_dqxx_del",dqczy)>0){%>
		<td><a href="#" accesskey="d" onClick="dataHander('del','qyxx_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" 

src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td><%}%>
    


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

<form action="sjxx_list.jsp" name="dataNav" onSubmit="return goPage()">
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

src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>




   <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	     <th width="1%"></th>
        <th>地区代码</th>
        <th>地区名称</th>
        <th>所属国家</th>
        <th>下属省/直辖市</th>
        <th>最后更新日期</th>
        <th>操作员</th>
      </tr>
  

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr onMouseOver="fn_changeTrColor()" onMouseOut="fn_changeTrColor()">
      <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
		<td><%=getDBStr(rs.getString("qyid"))%></td>
        <td><a href="qyxx.jsp?czid=<%=getDBStr(rs.getString("id"))%>" target="_blank"><%=getDBStr(rs.getString("qymc"))%></a></td>
        <td><a href="../gjxx/gjxx.jsp?czid=<%=getDBStr(rs.getString("gjid"))%>" target="_blank"><%=getDBStr(rs.getString("gjmc"))%></a></td>
        <td><a href="../sjxx/sjxx_list.jsp?czid=<%=getDBStr(rs.getString("qyid"))%>" target="_blank">查看</a></td>
        <td><%=getDBDateStr(rs.getString("gxrq"))%></td>
        <td><%=getDBStr(rs.getString("name"))%></td>
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
</form>
</div>
<!-- end cwDataNav -->



<!-- end cwCellContent -->





<!-- end cwCell -->






<!-- end cwMain -->
</body>
</html>
