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
if (right.CheckRight("contract-zbwj-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>正本文件清单- 正本文件</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>
<form action="zbwj_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				正本文件 &gt; 正本文件清单</td>
			</tr>
</table>
<%
//String hcpolling_id=getStr( request.getParameter("hcpolling_id") );
ResultSet rs;
String sqlstr = "select  dbo.getcustname(info.cust_id) as cust_name,info.contract_id,(convert(varchar(2),(convert(decimal(2,0),first_payment_ratio)))+''+convert(varchar(2),(convert(decimal(2,0),income_number)))) as leas_mode,equip.equip_num,dbo.getmodelbyid(equip.device_type)as model_name,equip.equip_sn,expect_start_date,send_date from contract_info as info left join contract_equip as equip on (info.contract_id=equip.contract_id) left join contract_time_info as time on(info.contract_id=time.contract_id) left join contract_condition on(info.contract_id=contract_condition.contract_id) order by expect_start_date desc"; 
%>
	


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
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
		<th>客户名</th>
		<th>合同号</th>
		<th>融资模式</th>
		<th>台数</th>
        <th>设备型号</th>
        <th>机器编号</th>
		<th>起租日期</th>
        <th>a类档案归案</th>
        <th>b类档案归案</th>
		<th>c类档案归案</th>
        <th>电子档</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
	  
      <tr class="cwDLRow" >
        <td></td>
        <td><%=getDBStr( rs.getString("cust_name") ) %></td>
		<td ><%= getDBStr( rs.getString("contract_id") ) %></td> 
		<td><%=getDBStr( rs.getString("leas_mode") ) %></td>
		<td><%=getDBStr( rs.getString("equip_num") ) %></td>
        <td><%=getDBStr( rs.getString("model_name") ) %></td>
        <td><%=getDBStr( rs.getString("equip_sn") ) %></td>
        <td><%=getDBDateStr( rs.getString("expect_start_date") ) %></td>
        <td><%=getDBDateStr( rs.getString("send_date") ) %></td>
        <td><%=getDBDateStr( rs.getString("send_date") ) %></td>
        <td><%=getDBDateStr( rs.getString("send_date") ) %></td>
        <td><%=getDBDateStr( rs.getString("send_date") ) %></td>
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
