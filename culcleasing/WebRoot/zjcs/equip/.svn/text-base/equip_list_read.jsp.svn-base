<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合审审批 - 租凭物件</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body  onload="public_onload(0)">

<form action="equip_list_read.jsp" name="dataNav" onSubmit="return goPage()">

<%


String contract_id = getStr( request.getParameter("contract_id") );
ResultSet rs;
String wherestr = " where 1=1";
String sqlstr="";
if ( !contract_id.equals("") ){
	wherestr = wherestr + " and contract_id='" + contract_id + "'";

}
	 sqlstr = "select * from contract_equip_temp  " + wherestr; 



%>
	


<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">

</td>
<td align="right" width="90%">
<%
int intPageSize = 50;   //一页显示的记录数
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

	rs.beforeFirst();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //记算总页数
	if(intPage>intPageCount) intPage = intPageCount;            //调整待显示的页码
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);   
         //将记录指针定位到待显示页的第一条记录上
	int i = 0; %>

<input type="hidden" name="contract_id" value="<%=contract_id%>">
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
<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		 <th>资产名称/型号</th>
		 <th>数量(台)</th>
		 <th>设备单价(元)</th>
		 <th>设备总额(元)</th>
		 <th>供应商</th>
		 <th>租期(月)</th>
		 <th>每期租金(元)</th>
		 <th>产品类别</th>
		 <th>配置</th>
		 <th>备注</th>
      </tr>
<%
	
if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
int startIndex = (intPage-1)*intPageSize+i+1;

%>
	  
      <tr class="cwDLRow" >
        <td>&nbsp;<%=startIndex%></td>
		<td align="center" style="width: 10%"> <%= getDBStr( rs.getString("eqip_name") ) %></a></td>
		<td align="center"><%=getDBStr( rs.getString("equip_num") ) %></td>
			<td align="center"><%=formatNumberStr(getDBStr( rs.getString("equip_price") ),"#,##0.00") %></td>
		<td align="center"><%= formatNumberStr(getDBStr( rs.getString("total_price") ),"#,##0.00") %></td>	<td align="center" style="width: 16%"><%= getDBStr( rs.getString("distributor") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("equip_team") ) %></td>
		<td align="center"><%= formatNumberStr(getDBStr( rs.getString("equip_rent") ),"#,##0.00") %></td>
		<td align="center" style="width: 15%"><%= getDBStr( rs.getString("equip_type") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("equip_dispose") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("memo") ) %></td>
	
		
		
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
