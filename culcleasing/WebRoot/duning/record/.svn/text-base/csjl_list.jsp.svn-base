<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("duning-csjl-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>逾期情况 -租金催收</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
<%

String findName=getStr( request.getParameter("searchName") );
String nextDate=getStr(request.getParameter("nextDate"));
String cust_id = getStr( request.getParameter("cust_id") );
ResultSet rs;
String wherestr = " where 1=1";

if ( !cust_id.equals("") ){
	wherestr = wherestr + " and cust_id='" + cust_id + "'";
}
if(findName!="" && findName!=null){
	wherestr = wherestr + " and liaisoner like '%" + findName + "%' ";
}
if ( !nextDate.equals("") ){
	wherestr = wherestr + " and nextliaison_date='" + nextDate + "' ";
}
String sqlstr = "select dbo.GETCUSTNAME(cust_id) as custName,liaison_date,liaison_way,"+
				"liaison_info,pay_date,pay_money,nextliaison_date,dbo.GETUSERNAME(liaisoner) as liaisoner "+
				" from dunning_record "+wherestr+
				"order by nextliaison_date desc"; 

%>
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> 租金催收 &gt;催收记录</td>
  </tr>
</table>
<!--标题结束-->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
  <tr class="maintab">
<td align="left" >
      <form name="searchbar" action="csjl_list.jsp">
        &nbsp;&nbsp;催款人:
        <input name="searchName" accesskey="s" type="text" size="15" value="<%=findName %>">
        下次处理日
        <input name="nextDate" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=nextDate %>">
        <img  onClick="openCalendar(nextDate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
        </form></td>
  
  <td align="right" width="40%"><!--翻页控制开始-->
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
	rs = db.executeQuery(sqlstr); 

	rs.last();                                      //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>
      <form action="csjl_list.jsp" name="dataNav1">
        <table border="0" cellspacing="0" cellpadding="0">
          <tr class="maintab">
            <script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav1;
	</script>
            <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页
              <%if(intPage>1){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0">
              <% } %>
              第 <font color="red"><%=intPage%></font> 页
              <%if(intPage<intPageCount){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0">
              <% } %></td>
            <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
            <td nowrap>转到
              <input name="page" type="text" size="2" value="1">
              页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0"></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
<!--翻页控制结束-->
<!--
</form>
<form name="list">
-->
<!--报表开始-->
<div style="vertical-align:top;width:100%;height:470px;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
 
  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	  	 <th>客户名称</th>
		 <th>催款员</th>
		 <th>联系方式</th>
		 <th>&nbsp;&nbsp;联系日期&nbsp;&nbsp;</td>
		 <th>&nbsp;承诺还款日&nbsp;</th>
		 <th>承诺还款金额</th>
		 <th>&nbsp;下次处理日&nbsp;</th>
		 <th>联系情况</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
		
%>
	  
      <tr class="cwDLRow" >
	  	<td align="center"><%=getDBStr( rs.getString("custName") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("liaisoner") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("liaison_way") ) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("liaison_date") ) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("pay_date") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("pay_money") ) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("nextliaison_date") ) %></td>
		<td align="center" width="50%"><%=getDBStr( rs.getString("liaison_info") ) %></td>
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
</body>
</html>
