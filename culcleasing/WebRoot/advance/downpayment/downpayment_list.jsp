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
if (right.CheckRight("advance-downpayment-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>首付款管理 - DownpaymentList</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onLoad="public_onload(0);">
<form action="downpayment_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				首付款管理 &gt; DownpaymentList</td>
			</tr>
</table>
<!--标题结束-->
<%
ResultSet rs;
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String wherestr = "";
if(!searchFld.equals("")) {
	wherestr = "  where "+searchFld+" like '%"+searchKey+"%'";
}
String sqlstr = "select views.contract_id,dbo.FK_GETVouchNo(views.contract_id) VouchNo,views.equip_sn,views.device_type,stock_place,views.cust_name,views.leas_mode,views.sale_name,isnull(views.peroid_payment,0) peroid_payment,isnull(dbo.fk_getfactmoney(views.contract_id),0) factmoney,dbo.fk_getfactinfo(views.contract_id) fact_info,isnull(views.peroid_payment,0)-isnull(dbo.fk_getfactmoney(views.contract_id),0) equals,views.insurance_flag,views.insurance,views.csa_cost,confirm_date,notarial_charge,remark from contract_view views left join downpayment_info as info on(views.contract_id=info.contract_id) " +wherestr ;
%>
<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="50%">
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    <td colspan="3">&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同号|机编号|客户|分公司","|views.contract_id|views.equip_sn|views.cust_name|views.sale_name"));</script></select>&nbsp;查询<input name="searchKey" value="<%=searchKey%>"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
    </tr>
    <tr class="maintab">
    <td><!-- <a href="#" accesskey="n" onClick="dataHander('add','downpayment_add.jsp',dataNav.itemselect);"><img  src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a>--><a href="#" accesskey="m" onClick="dataHander('mod','downpayment_update.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a><!--<a href="#" accesskey="d" onClick="dataHander('del','downpayment_del.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a>--></td>
</table>
<!--操作按钮结束-->
</td>

					 <td align="right" width="90%" valign="bottom">
					 	
					 	
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
		<th>合同编号</th>
        <th>客户名称</th>
        <th>VouchNo</th>
        <th>首付确认时间</th>
        <th>公证费</th>
		<th>机编号</th>
        <th>机型</th>        
        <th>融资模式</th>
        <th>库存</th>
        <th>分公司</th>
        <th>初期首付总额</th>
        <th>实收金额</th>
        <th>实收情况</th>
        <th>首付差额</th>
        <th>是否保险融资</th>
        <th>保险金额</th>
        <th>CSA</th>
        <th>备注</th>
      </tr>

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("contract_id") ) %>"></td>
        <td><a href="downpayment.jsp?czid=<%= getDBStr( rs.getString("contract_id") ) %>" target="_blank"><%=getDBStr( rs.getString("contract_id") ) %></a></td>
        <td><%= getDBStr( rs.getString("cust_name") ) %></td>
        <td><%= getDBStr( rs.getString("VouchNo") ) %></td>
        <td><%= getDBDateStr( rs.getString("confirm_date") ) %></td>
        <td><%= getMoneyStr( rs.getString("notarial_charge") ) %></td>
        <td><%= getDBStr( rs.getString("equip_sn") ) %></td>        
        <td><%= getDBStr( rs.getString("device_type") ) %></td>        
        <td><%= getDBStr( rs.getString("leas_mode") ) %></td>
        <td><%= getDBStr( rs.getString("stock_place") ) %></td>
        <td><%= getDBStr( rs.getString("sale_name") ) %></td>
        <td><%= getMoneyStr( rs.getString("peroid_payment") ) %></td>
        <td><%= getMoneyStr( rs.getString("factmoney") ) %></td>
        <td><%= getDBStr( rs.getString("fact_info") ) %></td>
        <td><%= getMoneyStr( rs.getString("equals") )%></td>
        <td><%= getDBStr( rs.getString("insurance_flag") )%></td>     
        <td><%= getMoneyStr( rs.getString("insurance") )%></td>   
        <td><%= getMoneyStr( rs.getString("csa_cost") )%></td>   
        <td><%=getDBStr( rs.getString("remark") )%></td>   
        <!-- <td><%// getDBDateStr( rs.getString("confirm_date") )%></td>  --> 
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
