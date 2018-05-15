<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>罚息额度设置 - 罚息额度设置</title>
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


		sqlstr = "select *,dbo.GETUSERNAME(creator) name from SYS_Penalty_Limit "; 
		LogWriter.logDebug(request, "输出sql:"+sqlstr);
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

<form action="penalty_limit_list" name="dataNav" onSubmit="return goPage()">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			其他基础信息&gt;罚息额度设置</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    <!-- 
		<td nowrap>行业名称：
              <input name="searchKey" accesskey="s" type="text" size="15" value="">
              <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="dataNav.submit();">
          </td>
 -->
		<%--if(right.CheckRight("ywjcxx_basetrade_add",dqczy)>0){--%>
		<td><a href="#" accesskey="n" onClick="dataHander('add','penalty_limit_add.jsp',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_new.gif" alt="新增(Alt+N)"></a></td><%--}--%>
		<%--if(right.CheckRight("basetrade_basetrade_mod",dqczy)>0){--%>
		<td><a href="#"  accesskey="m" onClick="dataHander('mod','penalty_limit_mod.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td><%--}--%>
		<%--if(right.CheckRight("ywjcxx_basetrade_del",dqczy)>0){--%>
        <td><a href="#" accesskey="d" onClick="dataHander('del','penalty_limit_save.jsp?savetype=del&czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" ></a></td><%--}--%>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th width="1%"></th>
     <th>罚息额度</th>
     <th>有效开始日期</th>
     <th>有效结束日期</th>
     <th>是否有效</th>
     <th>操作员</th>
   </tr>
   <tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
     <tr>
      <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
      <td align="center"><%=formatNumberStr((rs.getString("penalty_limit")),"#,##0.00")%></td>
	  <td align="center"><%=getDBDateStr(rs.getString("start_date"))%></td>
      <td align="center"><%=getDBDateStr(rs.getString("end_date"))%></td>
      <td align="center"><%=getDBStr(rs.getString("flag"))%></td>
      <td align="center"><%=getDBStr(rs.getString("name"))%></td>
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
