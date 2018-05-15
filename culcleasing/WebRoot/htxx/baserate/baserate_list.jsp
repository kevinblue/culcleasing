<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>利率信息 - 央行基准利率</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">
<form action="baserate_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				利率信息 &gt; 央行基准利率</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("htxx-baserate-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------以上为权限控制--------

ResultSet rs;
String wherestr = " where 1=1";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String searchFld_tmp = "";

String sqlstr = "select fund_standard_interest.id,fund_standard_interest.start_date,fund_standard_interest.rate_half,fund_standard_interest.rate_one,fund_standard_interest.rate_three,fund_standard_interest.rate_five,fund_standard_interest.rate_abovefive,fund_standard_interest.base_rate_half,fund_standard_interest.base_rate_one,fund_standard_interest.base_rate_three,fund_standard_interest.base_rate_five,fund_standard_interest.base_rate_abovefive from fund_standard_interest" + wherestr; 
System.out.println("sqlstr=================="+sqlstr);
%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<%
    		if (right.CheckRight("htxx-baserate-add",dqczy)>0){
    	 %>
		<td><a href="#" accesskey="n" onclick="dataHander('add','baserate_add.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td>
		<%} 
			if (right.CheckRight("htxx-baserate-mod",dqczy)>0){
		%>
		<td><a href="#" accesskey="m" onclick="dataHander('mod','baserate_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
		<%
		}
			if (right.CheckRight("htxx-baserate-del",dqczy)>0){
		 %>
		<td><a href="#" accesskey="d" onclick="dataHander('del','baserate_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td>
    	<%} %>
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
		<th>利率开始执行日期</th>
        <th>利息调整幅度_六月</th>
        <th>利息调整幅度_1年</th>
        <th>利息调整幅度_3年</th>
        <th>利息调整幅度_5年</th>
        <th>利息调整幅度_5年以上</th>
        <th>利息央行基准_六月</th>
        <th>利息央行基准_1年</th>
        <th>利息央行基准_3年</th>
        <th>利息央行基准_5年</th>
        <th>利息央行基准_5年以上</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("id") ) %>"></td>
        <td><a href="baserate.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank"><%= getDBDateStr(rs.getString("start_date") ) %></a></td>
		<td><%= formatNumberStr(getDBStr( rs.getString("rate_half") ),"#,##0.0000") %>%</td> 	 	
		<td><%= formatNumberStr(getDBStr( rs.getString("rate_one") ),"#,##0.0000") %>%</td>
		<td><%= formatNumberStr(getDBStr( rs.getString("rate_three") ),"#,##0.0000") %>%</td>
		<td><%= formatNumberStr(getDBStr( rs.getString("rate_five") ),"#,##0.0000") %>%</td>
		<td><%= formatNumberStr(getDBStr( rs.getString("rate_abovefive") ),"#,##0.0000") %>%</td> 	 	
		<td><%= formatNumberStr(getDBStr( rs.getString("base_rate_half") ),"#,##0.0000") %>%</td>
		<td><%= formatNumberStr(getDBStr( rs.getString("base_rate_one") ),"#,##0.0000") %>%</td>
		<td><%= formatNumberStr(getDBStr( rs.getString("base_rate_three") ),"#,##0.0000") %>%</td>
		<td><%= formatNumberStr(getDBStr( rs.getString("base_rate_five") ),"#,##0.0000") %>%</td> 	 	
		<td><%= formatNumberStr(getDBStr( rs.getString("base_rate_abovefive") ),"#,##0.0000") %>%</td>
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
