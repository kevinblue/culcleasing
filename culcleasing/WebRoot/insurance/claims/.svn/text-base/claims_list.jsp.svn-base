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
if (right.CheckRight("insurance-claims-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 保险赔款确认</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onLoad="public_onload(0);">
<form action="claims_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				保险管理 &gt; 保险赔款确认</td>
			</tr>
</table>
<!--标题结束-->
 <%
ResultSet rs;

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String wherestr = "";
if(!searchFld.equals("")) {
	wherestr = "where "+searchFld+" like '%"+searchKey+"%'";
}
String sqlstr = " select distinct claims_id,views.insurer,dbo.fk_getname(views.sale_id) sale_id ,claims.claims_date,claims.claims_name,claims.equip_sn,claims.claims_money,claims.repair_delaydate,claims.repair_delaymoney,claims.financing_delaydate,claims.financing_delaymoney,views.leas_mode operation_way from insurance_claims claims left join  contract_view views on views.contract_id = claims.contract_id "+wherestr; 
System.out.println("sqlstr=================="+sqlstr);
%>
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
            <td align="left" width="40%">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td align="left" width="25%">
					 &nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|机编号|保险公司|分公司","|claims.equip_sn|views.insurer|views.sale_name"));</script></select>&nbsp;查询
<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>
"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
</td>
    </tr>
</table>
</td><td></td><td></td></tr><tr class="maintab">
<td align="left" width="30%">
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
        <td><a href="#" accesskey="n" onClick="dataHander('add','claims_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td>
		<td><a href="#" accesskey="m" onClick="dataHander('mod','claims_update.jsp?czid=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onClick="dataHander('del','claims_del.jsp?czid=',dataNav.itemselect);"><img  src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td>
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
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img  style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
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
        <th>机编号</th>
		<th>保险公司</th>
        <th>分公司</th>
		<th>日期</th>
        <th>姓名</th>
        <th>赔款金额</th>
        <th>确认维修欠款时间</th>
        <th>确认维修欠款金额</th>
        <th>融资或分期欠款时间</th>
        <th>融资或分期欠款金额</th>
        <th>操作方式</th>
      </tr>
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("claims_id") ) %>"></td>
        
        <td align="left"><a href=claims.jsp?czid=<%= getDBStr( rs.getString("claims_id") ) %> target="_blank"><%= getDBStr(rs.getString("equip_sn")) %></a></td>
        <td><%= getDBStr( rs.getString("insurer") ) %></td>
        <td><%= getDBStr( rs.getString("sale_id") ) %></td>
        <td><%= getDBDateStr( rs.getString("claims_date") ) %></td>
        <td><%= getDBStr( rs.getString("claims_name") ) %></td>
        <td><%= getMoneyStr( rs.getString("claims_money") ) %></td>
        <td><%= getDBDateStr( rs.getString("repair_delaydate") ) %></td>
        <td><%= getMoneyStr( rs.getString("repair_delaymoney") ) %></td>
        <td><%= getDBDateStr( rs.getString("financing_delaydate") ) %></td>
        <td><%= getMoneyStr( rs.getString("financing_delaymoney") ) %></td>
        <td><%= getDBStr( rs.getString("operation_way") ) %></td>
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
