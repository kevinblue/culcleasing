<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>系统意见 - 系统意见库管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  style="border:0px solid #8DB2E3;">
<form action="xtwt_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0"  height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				系统意见库管理 &gt; 系统意见</td>
			</tr>
</table>



<!-- end cwTop -->

<%
String dqczy=(String) session.getAttribute("czyid");
String cust_id = getStr( request.getParameter("cust_id") );
ResultSet rs;
String wherestr = " where 1=1";

if ( !cust_id.equals("") ){
	wherestr = wherestr + " and cust_id='" + cust_id + "'";
}

String sqlstr = "select *,xm=dbo.GETUSERNAME(refer_person) from system_suggestion " + wherestr; 
%>

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td><a href="#" accesskey="n" onclick="dataHander('add','xtwt_add.jsp?cust_id=<%=cust_id%>',dataNav.itemselect);"><img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle"></a></td>
		<td><a href="#" accesskey="m" onclick="dataHander('mod','xtwt_mod.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		
		<%if(right.CheckRight("khxx_frkh_del",dqczy)>0){%><td><a href="#" accesskey="d" onclick="dataHander('del','xtwt_del.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" ></a></td><%}%>
		<%if(right.CheckRight("khxx_frkh_del",dqczy)>0){%><td><a href="#" accesskey="n" onclick="dataHander('mod','xtwt_fix.jsp?czid=',dataNav.itemselect);"><img src="../../images/fdmo_09.gif" alt="管理员处理(Alt+G)" width="19" height="19" align="absmiddle" ></a></td><%}%> 
		<td><a href="#" accesskey="m" onclick="return isExport();"><img src="../../images/fdmo_70.gif" alt="导出(Alt+E)" width="19" height="19" align="absmiddle" ></a></td>
    </tr>
</table>
</td>
<td align="right" width="90%">
				<input type="hidden" name="savetype" value="dao">
<input type="hidden" name="where_str" id="where_str" value="<%=wherestr%>" />
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

<input type="hidden" name="cust_id" value="<%=cust_id%>">
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

<!-- end cwCellTop -->
</td>
</tr>
</table>




	

<!-- end cwCellTop -->

<div style="vertical-align:top;height:100%;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>




    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		<th>序号</th>
		<th>提交时间</th>
		<th>提交人</th>
		<th>记录内容</th>
		<th>功能</th>
		<th>模块</th>
		<th>优先程度</th>
		<th>备注</th>
		<th>处理状态</th>
		<th>处理人</th>
		<th>处理意见</th>
		<th>处理时间</th>
		
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" align="center">
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("id") ) %>"></td>
    	<td><%=getDBStr( rs.getString("id") ) %></td>
        <td><%= getDBDateStr( rs.getString("refer_date") ) %></td>
		<td><%= getDBStr( rs.getString("xm") )  %></td>
		<td align="center"><a href="xtwt.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank">查看</a></td>
		<td><%=getDBStr( rs.getString("action") ) %></td>
		<td><%=getDBStr( rs.getString("model") ) %></td>
		<td><%=getDBStr( rs.getString("degree") ) %></td>
		<td><%=getDBStr( rs.getString("remark") ) %></td>
		<td><%=getDBStr( rs.getString("state") ) %></td>
		<td><%=getDBStr( rs.getString("manage_person") ) %></td>
		<td><%=getDBStr( rs.getString("manage_opinion") ) %></td>
		<td><%=getDBDateStr( rs.getString("manage_date") ) %></td>
	
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

</body>
<script>

//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		// alert("jjjj"+<%=wherestr%>);
		dataNav.action="export_save.jsp";
		
		document.getElementById("where_str").value="<%=wherestr%>";
  		dataNav.submit();
		dataNav.action="xtwt_list.jsp";
	}
	return false;
}

</script>
</html>
