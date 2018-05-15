<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险公司- 基础信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
wherestr=" where 1=1";
String searchKey="";
String czid=getStr(request.getParameter("czid"));
if ((czid!=null) && (!czid.equals("")))
{  
	wherestr=wherestr+" and insurer_info.insurer_code = '"+czid+"' "; 
}
if (request.getParameter("searchKey")!=null)
{
   searchKey=getStr(request.getParameter("searchKey"));
   wherestr=wherestr+" and insurer_info.insurer_name like '%"+searchKey+"%' "; 
}
%>

<%--
//权限判断
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;

if (right.CheckRight("ywjcxx_basetrade_list",dqczy)>0){
	canedit=1;
}
if (canedit==0) {
	response.sendRedirect("../../noright.jsp");
}
--%>

<body onLoad="public_onload(0)">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<form action="insurer_list.jsp" name="dataNav" onSubmit="return goPage()">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			基础信息管理&gt;保险公司</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td nowrap>保险公司名称：
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%=searchKey %>">
              <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="dataNav.submit();">
          </td>

		<%--if(right.CheckRight("ywjcxx_basetrade_add",dqczy)>0){--%>
		<td><a href="#" accesskey="n" onClick="dataHander('add','insurer_add.jsp',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_new.gif" alt="新增(Alt+N)"></a></td><%--}--%>
		<%--if(right.CheckRight("basetrade_basetrade_mod",dqczy)>0){--%>
		<td><a href="#"  accesskey="m" onClick="dataHander('mod','insurer_mod.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td><%--}--%>
		<%--if(right.CheckRight("ywjcxx_basetrade_del",dqczy)>0){--%>
        <td><a href="#" accesskey="d" onClick="dataHander('del','insurer_del.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" ></a></td><%--}--%>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		<% 

		sqlstr = "select insurer_info.*,base_user.name from dbo.insurer_info left join base_user on insurer_info.creator=base_user.id"+wherestr+"order by insurer_info.insurer_code asc"; 
		System.out.print("yyyyyyyyyyyy========"+sqlstr);
		LogWriter.logDebug(request, "输出sql:"+sqlstr);
		%>
		
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th width="1%"></th>
     <th>保险公司编码</th>
     <th>保险公司全称</th>
     <th>保险公司简称</th>
    
     <th>最后更新日期</th>
     <th>操作员</th>
   </tr>
   <tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
     <tr>
      <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("insurer_code"))%>"></td>
	  <td align="center"><%=getDBStr(rs.getString("insurer_code"))%></td>
	  <td align="center"><%=getDBStr(rs.getString("insurer_name"))%></td>
	  <td align="center"><%=getDBStr(rs.getString("simple_name"))%></td>
      <td align="center"><%=getDBDateStr(rs.getString("modify_date"))%></td>
     
      <td align="center"><%=getDBDateStr(rs.getString("creator"))%></td>
      
    </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>

</form>
</body>
</html>
