<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银核销 - 网银核销列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">
<form action="ebank_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				网银核销 &gt; 网银核销列表</td>
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
if (right.CheckRight("ebank-ebank-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------以上为权限控制--------

ResultSet rs;
String wherestr = " where 1=1";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

if ( !searchFld.equals("") && !searchKey.equals("") ) {
	wherestr = wherestr + " and " + searchFld + " like '%" + searchKey + "%'";
}
if ( searchFld.equals("fund_ebank_data.client_name") && searchKey.equals("") ) {
	wherestr = wherestr + " and isnull(fund_ebank_data.client_name,'')=''";
}

String sqlstr = "select fund_ebank_data.ebdata_id, fund_ebank_data.order_number, fund_ebank_data.arrive_date, fund_ebank_data.account_bank, fund_ebank_data.acc_number, fund_ebank_data.client_name, fund_ebank_data.client_accnumber, isnull(fund_ebank_data.fact_money,0) as fact_money, isnull(vi_ebank_remMoney.ebank_money,0) as ebank_money, fund_ebank_data.summary, fund_ebank_data.sn, fund_ebank_data.status, fund_ebank_data.business_flag from fund_ebank_data left join vi_ebank_remMoney on fund_ebank_data.ebdata_id=vi_ebank_remMoney.ebank_id" + wherestr +" order by fund_ebank_data.arrive_date desc"; 
System.out.println("sqlstr=================="+sqlstr);
%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td nowrap>&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|网银编号|到帐日期|上传日期|付款客户|到帐金额|状态|租赁相关标志","|fund_ebank_data.ebdata_id|convert(varchar(10),fund_ebank_data.arrive_date,121)|convert(varchar(10),fund_ebank_data.upload_date,121)|fund_ebank_data.client_name|fund_ebank_data.fact_money|fund_ebank_data.status|fund_ebank_data.business_flag"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
    	<%
    		if (right.CheckRight("ebank-ebank-mod",dqczy)>0){
    	 %>
		<td><a href="#" accesskey="m" onclick="dataHander('mod','ebank_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
		<%} %>
	</tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 100;   //一页显示的记录数
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
		<th>网银编号</th>
        <th>序号</th>
        <th>到帐时间</th>
        <th>到帐银行</th>
        <th>到帐帐号</th>
        <th>付款客户</th>
        <th>客户帐号</th>
        <th>到帐金额</th>
        <th>可核销金额</th>
        <th>摘要</th>
        <th>流水号</th>
        <th>状态</th>
        <th>租赁相关标志</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("ebdata_id") ) %>"></td>
        <td align="left"><a href="ebank.jsp?czid=<%= getDBStr( rs.getString("ebdata_id") ) %>" target="_blank"><%= getDBStr(rs.getString("ebdata_id") ) %></a></td> 	
		<td><%= getDBStr( rs.getString("order_number") ) %></td>
		<td><%= getDBDateStr( rs.getString("arrive_date") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("account_bank") ) %></td>
		<td><%= getDBStr( rs.getString("acc_number") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_name") ) %></td>
		<td><%= getDBStr( rs.getString("client_accnumber") ) %></td> 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("fact_money") ),"#,##0.00") %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("ebank_money") ),"#,##0.00") %></td>
		<td><%= getDBStr( rs.getString("summary") ) %></td> 
		<td><%= getDBStr( rs.getString("sn") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("status") ) %></td>
		<td><%= getDBStr( rs.getString("business_flag") ) %></td> 	
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
