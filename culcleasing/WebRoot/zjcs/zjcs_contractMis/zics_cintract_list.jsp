<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同租金测算 - 偿还计划列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">
<form action="chjhxg_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				合同租金测算 &gt; 偿还计划列表</td>
			</tr>
</table>
<!--标题结束-->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
<%
	String sqlstr;
	ResultSet rs;
	String curr_date = getSystemDate(0);
	String wherestr = " where 1=1";
	String doc_id = getStr( request.getParameter("doc_id") );
	String contract_id = getStr( request.getParameter("contract_id") );
	String proj_id = getStr( request.getParameter("proj_id") );
	
	
	
	String query_rent_sql = "";
	//查询正式表
	
	
	//查询合同偿还计划正式表的数据SQL
	//StringBuffer query_infoSql = new StringBuffer();
	//query_infoSql.append(" select f.contract_id,f.rent_list,f.plan_date,f.corpus  ")
	//			 .append(",c.equip_amt,c.year_rate  ")
	//			 .append("from  fund_rent_plan as f   ")
	//			 .append("left join  contract_condition  as c  ")
	//			 .append("on  f.contract_id = c.contract_id  ")
	//             .append(" where contract_id = '"+contract_id+"' ")
	//             .append("  ");
	             
	query_rent_sql = " select * from  contract_condition ";             
	System.out.println("query_rent_sql=================="+query_rent_sql);
%>



<!--操作按钮开始
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	
		<td align="center"><a href="#" accesskey="n" onclick="dataHander('add','chjhxg_add.jsp?doc_id=<%=doc_id %>&contract_id=<%=contract_id %>',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td>
		<td align="center"><a href="#" accesskey="m" onclick="dataHander('mod','chjhxg_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
		<td align="center"><a href="#" accesskey="d" onclick="dataHander('del','chjhxg_del.jsp?czid=',dataNav.itemselect);"><img align="absmiddle" src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td>
    </tr>
</table>
-->
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 200;   //一页显示的记录数
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


	rs = db.executeQuery(query_rent_sql); 


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
		<!-- <th width="1%"></th> -->
		<th>合同编号</th>
        <th>设备款</th>
        <th>年利率</th>
        <th>期项</th>
        <th>起租日期</th>
        <th>租赁本金</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	String start_date = getDBDateStr(rs.getString("start_date"));
	String income_day = getDBStr(rs.getString("income_day"));
	String now_start_date = start_date.substring(0,8)+income_day;
%>

      <tr>
      <!-- 
        <td align="center">
        	<input class="rd" type="radio" 
        		name="itemselect" value="<%=getDBStr(rs.getString("contract_id")) %>"/>
        </td>
      -->
        <td align="center">
        	<a href="zjcs_contract_list.jsp?contract_id=<%=getDBStr(rs.getString("contract_id"))%>" 
        		target="_blank"><%=getDBStr(rs.getString("contract_id"))%></a>
        </td>
		<td align="center"><%= formatNumberStr(getDBStr(rs.getString("equip_amt")),"#,##0.0000")%></td> 
		<td align="center"><%= formatNumberStr(getDBStr(rs.getString("year_rate")),"#,##0.0000") %></td> 
		<td align="center"><%= getDBStr(rs.getString("lease_term"))%></td> 
		<td align="center">
			<%=now_start_date%>
		</td> 
		<td align="center"><%= formatNumberStr(getDBStr( rs.getString("lease_money")),"#,##0.00") %></td> 
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
