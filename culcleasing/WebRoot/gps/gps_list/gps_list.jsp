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
if (right.CheckRight("gps-list-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS清单- GPS管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body>
<form action="gps_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> GPS管理 &gt; GPS清单</td>
  </tr>
</table>
<%
String searchKey = getStr( request.getParameter("searchKey") );
String service_begindate = getStr( request.getParameter("service_begindate") );
ResultSet rs;
String wherestr = " where 1=1";
if(!searchKey.equals("")){
	wherestr+=" and sim_no like '%"+searchKey+"%'";
}
if(!service_begindate.equals("")){
	wherestr+=" and service_begindate <= '"+service_begindate+"'";
}
String sqlstr = "select * from vi_examine_info_main" + wherestr +" order by install_date desc"; 
System.out.println(sqlstr);
%>
<form name="searchbar" action="gps_list.jsp">
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
  
    <tr class="maintab">
      <td align="left" colspan="2">&nbsp;按SIM卡号&nbsp;
        <input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
        入网时间:<input name="service_begindate" type="text" size="12" value="<%=service_begindate%>" readonly><img  onClick="openCalendar(service_begindate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
    </tr>
    
   </table>

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left" width="1%"><table border="0" cellspacing="0" cellpadding="0" >
          <tr class="maintab">
            <td><a href="#" accesskey="u" onClick="dataHander('add_modal','gps_upload.jsp',dataNav.itemselect);"><img src="../../images/sbtn_2Excel.gif" alt="上传(Alt+U)" width="19" height="19" align="absmiddle"></a></td>
            <!--<td><a href="#" accesskey="n" onClick="dataHander('add','gps_add.jsp',dataNav.itemselect);"><img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle"></a></td>-->
            <td><a href="#" accesskey="m" onClick="dataHander('mod','gps_mod.jsp?id=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
            <td><a href="#" accesskey="d" onClick="dataHander('del','gps_del.jsp?id=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" ></a></td>
          </tr>
        </table></td>
      <td align="right" width="90%"><%
int intPageSize = 18;   //一页显示的记录数
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
              页 <img  style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
          </tr>
        </table>
        <!-- end cwCellTop --></td>
    </tr>
  </table>
<div style="vertical-align:top;height:580px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
    <tr class="maintab_content_table_title">
      <th width="1%"></th>
      <th>GPS信息(ID)</th>
      <th>合同编号</th>
      <th>设备型号</th>
      <th>机身编号</th>
      <th>SIM卡号</th>
      <th>GPS车载终端型号(版本号)</th>
      <th>安装日期</th>
      <th>入网时间</th>
    </tr>
    <%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
    <tr class="cwDLRow" >
      <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("gpsinfo_id") ) %>"></td>
      <td align="left"><a href="gps.jsp?id=<%= getDBStr( rs.getString("gpsinfo_id") ) %>" target="_blank"><%= getDBStr( rs.getString("gpsinfo_id") ) %></a></td>
      <td><%=getDBStr( rs.getString("contract_id") ) %></td>
      <td><%=getDBStr( rs.getString("machine_type") ) %></td>
      <td><%=getDBStr( rs.getString("machine_no") ) %></td>
      <td><%=getDBStr( rs.getString("sim_no") ) %></td>
      <td><%=getDBStr( rs.getString("gps_terminal_type") ) %></td>
      <td><%=getDBDateStr( rs.getString("install_date") ) %></td>
      <td><%=getDBDateStr( rs.getString("service_begindate") ) %></td>
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
  <!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
 </form>
</form>
<!-- end cwMain -->
</body>
</html>
