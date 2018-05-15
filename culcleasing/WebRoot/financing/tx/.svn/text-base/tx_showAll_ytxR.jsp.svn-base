<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息 - 所有已经调息列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script>  
<script Language="Javascript" src="../../js/jquery.js"></script>
</head>

<body onload="">
<%
	 //央行利率基准表中的主键,通过该主键在表fund_adjust_interest_contract中查询对应的adjust_id
	String txId = getStr(request.getParameter("txId"));  
	String adjust_method = getStr(request.getParameter("adjust_method")); 
	String adjust_flag = getStr(request.getParameter("adjust_flag")); 
	String adjustFlag = getStr(request.getParameter("adjustFlag")); 
	//String start_date = getStr(request.getParameter("start_date"));//调息开始日期
	//获取查询条件
	String drawings_id = getStr(request.getParameter("query_contract_id")); 
	
	String str = "";
	ResultSet rs = null;
	StringBuffer sql = new StringBuffer();
	sql.append(" select * from vi_tx_showAll_fina_ytx  vts")
	   .append(" where  exists ( ")
	   .append(" select drawings_id from financing_refund_plan_his fa ")
	   .append(" where fa.drawings_id=vts.drawings_id  ");
	   
	   if(!txId.equals("") && txId != null){
		  sql.append(" and adjust_id = "+txId+" ");//传入的ID是fund_standard_interest的ID
	    }   
	   sql.append(" ) ");
	   if(!drawings_id.equals("") && drawings_id != null){
		  sql.append(" and drawings_id like '%"+drawings_id+"%' ");//
	   }   
	   if(!"".equals(adjustFlag) && adjustFlag != null){
		  sql.append(" and adjust_flag = '是' ");//
	   }  
	  // sql.append("  and adjust_style<>'按次日' and settle_method='"+adjust_method+"'");
	   System.out.println("调息界面Sql==>> "+sql.toString());
	   String sqlstr = sql.toString();
%>
<form name="form2" id="form2" action="tx_showAll_ytx.jsp" method="post" onSubmit="return goPage()">
<!-- custId == adjust_id  -->
<input type="hidden" name="txId" id="txId" value="<%=txId%>">
<input type="hidden" name="adjust_method" id="adjust_method" value="<%=adjust_method%>">
<input type="hidden" name="all_checkbos_value" id="all_checkbos_value"/>
<input type="hidden" name="save_type" id="save_type"/>
<input type="hidden" name="adjust_flag" id="adjust_flag" value="<%=adjust_flag%>">

  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" colspan="2" id="cwCellTopTitTxt">
      	融资调息 &gt; 已调息记录列表
      </td>
    </tr>
    <tr class="maintab">
		<td align="left" >               
			&nbsp;提款编号&nbsp;
			<input type="text" name="query_contract_id" value="<%=drawings_id%>" />
			<a href="#" onclick="query();">
				<img src="../../images/tbtn_searh.gif" alt="查询" border="0" align="absmiddle" >
			</a>
       </td>
       
       <td nowrap="nowrap">
       </td>
	</tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplitNoCode.jsp"%>
	<!--翻页控制结束-->	
	</td>
	</tr>
</table>

  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>授信标号</th>
		<th>授信合同编号</th>
	    <th>提款标号</th>
		<th>授信单位</th>
		<th>贷款类型</th>
		<th>还款方式</th>
		<th>提款金额</th>
		<th>利率浮动类型</th>
		<th>调息状态</th>
		<th>调息前后</th>
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	String settle_method="";
%>
      <tr>
        <td align="center" nowrap><%=getDBStr(rs.getString("drawings_id"))%></td>
        <td align="center" nowrap><%=getDBStr(rs.getString("credit_id"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("credit_contract_id"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("crediter"))%></td>

		<td align="center" nowrap><%= getDBStr(rs.getString("drawings_type"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("refund_way"))%></td>

		<td align="center" nowrap><%= CurrencyUtil.convertFinance(rs.getString("drawings_money"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("drawings_rate_float_type"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("adjust_flag"))%></td>
	   <%
    	  if( "是".equals(getDBStr(rs.getString("adjust_flag"))) ){
       %>
		<td align="center" nowrap>
	        <a href="txdb.jsp?txid=<%=getDBStr(rs.getString("adjust_id"))%>&drawings_id=<%=getDBStr(rs.getString("drawings_id")) %>" target="_blank">
	      		<b style="color:#E46344;">前后对比</b>
	        </a>
	    </td>  

       <%} else{
       %>
		<td align="center" nowrap>暂未调息</td>
       <%} %>
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
</form>
</body>
</html>
