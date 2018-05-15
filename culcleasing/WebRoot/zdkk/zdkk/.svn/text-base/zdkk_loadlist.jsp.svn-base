<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("zdkk-zdkk-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>主动扣款信息信息列表 - 主动扣款信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
//String context = request.getContextPath();

String searchKeyName = getStr( request.getParameter("searchKeyName") );
String searchKeyDate = getStr( request.getParameter("searchKeyDate") );
ResultSet rs;
if(searchKeyDate.equals("")){
	searchKeyDate=getSystemDate(0);
}
session.setAttribute("zdkk_name",searchKeyName);
session.setAttribute("zdkk_date",searchKeyDate);
String sqlstr = "select * from table_zdkk('"+searchKeyDate+"','"+searchKeyName+"')"; 
System.out.println(sqlstr);
 %>
<body style="border:1px solid #8DB2E3;">
<form action="zdkk_loadlist.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> 主动扣款信息  &gt; 主动扣款信息列表</td>
  </tr>
</table>
<!--标题结束-->
<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr><td colspan="2">
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left">
      &nbsp;按客户名&nbsp;
        <input name="searchKeyName" accesskey="s" type="text" size="15" value="<%= searchKeyName %>">
        按截至日期:
        <input name="searchKeyDate" accesskey="s" type="text" size="15" readonly value="<%= searchKeyDate %>">
        <img  onClick="openCalendar(searchKeyDate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
       
        </td>
    </tr>
  </table>
</td>
</tr>
      <tr class="maintab">
        <td align="left" width="36%"><!--操作按钮开始-->
          <table border="0" cellspacing="0" cellpadding="0" >
            <tr class="maintab">
              <td ><a href="zdkk_out.jsp"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="上传主动扣款信息" >导出主动扣款信息</a></td>
              <td ><a href="#" accesskey="n" onClick="dataHander('add_modal','zdkk_upload.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="上传主动扣款信息" >上传主动扣款信息</a></td>
            </tr>
          </table>
          <!--操作按钮结束--></td>
        <td align="right" width="60%"><!--翻页控制开始-->
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
          <table border="0" cellspacing="0" cellpadding="0">
            <tr class="maintab">
              <script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
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
          </table></td>
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
          <th>客户名称</th>
          <th>卡号</th>
          <th>应收租金</th>
          <th>租金金额</th>
          <th>罚息金额</th>
        </tr>
        <%
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
        <tr>
          <td ><%= getDBStr( rs.getString("cust_name")) %></td>
          <td ><%= getDBStr( rs.getString("client_acc_number")) %></td>
          <%
		  double all_rent=rs.getDouble("all_rent");
		  double rent=rs.getDouble("rent");
		  double fx=rs.getDouble("fx");
		  all_rent=all_rent<0?0.0:all_rent;
		  rent=rent<0?0.0:rent;
		  fx=fx<0?0.0:fx;
		  %>
          <td ><%= formatNumberStr(all_rent+"","#,##0.00") %></td>
          <td ><%=formatNumberStr(rent+"","#,##0.00") %></td>
          <td ><%=formatNumberStr(fx+"","#,##0.00") %></td>
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
