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
if (right.CheckRight("gps-failure-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS合成巡检失败3次以上统计- GPS管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>
<form action="gps_failure_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				GPS管理 &gt; GPS合成巡检失败3次以上统计</td>
			</tr>
</table>
<%
String searchKey=getStr(request.getParameter("searchKey"));
ResultSet rs;
String where="";
if(!searchKey.equals("")){
	where=" and sim_no like '%"+searchKey+"%'";
}
String sqlstr = "select  contract_id,cust_name,info.sim_no,vi_sim.machine_no,dbo.getmodelbyid(vi_sim.machine_type) as machine_name,model,vi_sim.service_begindate,vi_sim.service_enddate,(select top 1 polling_date from hcexamine_details where sim_no=info.sim_no order by polling_date desc) as polling_date from examine_info as info left join vi_sim_no as vi_sim on(info.sim_no=vi_sim.sim_no) where info.sim_no in(select sim_no from hcexamine_details as details group by sim_no having (select count(*)as counts from (select top 3 * from hcexamine_details  where sim_no=details.sim_no  order by polling_date desc) as top3 where top3.fixed_state='无效')>=3 )"+where+"  order by polling_date desc"; 
System.out.println(sqlstr);
%>
	


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="20%">&nbsp;SIM卡号
<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>
"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<!--<td><a href="#" accesskey="m" onClick="dataHander('mod','dyw_mod.jsp?id=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>-->
    </tr>
</table>
</td>
<td align="right" width="90%">
<%
int intPageSize = 16;   //一页显示的记录数
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
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img  style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>

<!-- end cwCellTop -->
</td>
</tr>
</table>

<div style="vertical-align:top;height:480px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
        <th>合同编号</th>
        <th>客户名称</th>		
        <th>SIM卡号</th>
        <th>机编号</th>
        <th>车辆型号</th>
        <th>车辆类型</th>
        <th>入网时间</th>
        <th>服务截止时间</th>
        <th>巡检日期</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
        <td></td>
        <td><%=getDBStr( rs.getString("contract_id") ) %></td>
        <td><%=getDBStr( rs.getString("cust_name") ) %></td>
        <td><%=getDBStr( rs.getString("sim_no") ) %></td>
        <td><%=getDBStr( rs.getString("machine_no") ) %></td>
        <td><%=getDBStr( rs.getString("machine_name") ) %></td>
        <td><%=getDBStr( rs.getString("model") ) %></td>
        <td><%=getDBDateStr( rs.getString("service_begindate") ) %></td>
        <td><%=getDBDateStr( rs.getString("service_enddate") ) %></td>
        <td><%=getDBDateStr( rs.getString("polling_date") ) %></td>
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
<!-- end cwMain -->
</body>
</html>
