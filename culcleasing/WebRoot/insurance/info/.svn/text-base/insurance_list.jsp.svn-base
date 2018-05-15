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
if (right.CheckRight("insurance-info-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 保险清单</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onLoad="public_onload(0);">
<form action="insurance_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				保险管理 &gt; 保险清单</td>
			</tr>
</table>
<!--标题结束-->
<%
ResultSet rs;
String wherestr = "";
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
if(!searchFld.equals("")) {
	wherestr = " where  "+searchFld+" like '%"+searchKey+"%'";
}
String sqlstr = "select distinct  views.contract_id,views.equip_sn,views.engine_code,info.insurance_date,views.insurance_enddate,views.cust_name,views.insurer,info.insurance_no,views.leas_mode operation_way,views.equip_amt,views.income_number,views.insurance,views.lsh_insurance,views.cust_insurance,views.insurance_flag,info.give_insurance,views.insurance_type,info.insurance_account,info.get_date,info.pay_date,info.pay_no,views.sale_name,info.is_special,info.check_info,info.claims_note,claims.claims_money,claims.repair_delaymoney,claims.financing_delaymoney,claims.claims_name,info.finallyclaims_money,info.surrender_note,info.surrender_object,info.surrender_money,info.note from contract_view views left join insurance_info info  on views.contract_id = info.contract_id left join insurance_claims claims on info.contract_id = claims.contract_id "+wherestr +""; 
System.out.println("@@@@@@@@@@@@@@@"+sqlstr);
%>
<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="38%">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td align="left" width="28%">
					 &nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|机编号|客户名称|保险公司","|views.contract_id|info.equip_sn|views.cust_name|views.insurer"));</script></select>&nbsp;查询
<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>
"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
</td>
    </tr>
</table>
</td><td></td><td></td></tr><tr class="maintab">
<td align="left">
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<!--<td><a href="#" accesskey="n" onClick="dataHander('add','insurance_add.jsp',dataNav.itemselect);"><img  src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td>-->
		<td><a href="#" accesskey="m" onClick="dataHander('mod','insurance_update.jsp?czid=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
		<!--<td><a href="#" accesskey="d" onClick="dataHander('del','insurance_del.jsp?czid=',dataNav.itemselect);"><img  src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td>-->
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


	rs.last();
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
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
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
		<th>发动机号</th>
        <th>合同编号</th>
        <th>投保日期&nbsp;&nbsp;&nbsp;&nbsp;</th>
        <th>保险终止日期</th>
        <th>客户名&nbsp;&nbsp;&nbsp;&nbsp;</th>
		<th>保险公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        <th>保险单号</th>
        <th>操作方式</th>
        <th>机价</th>
		<th>期数</th>
        <th>保险费总额</th>
        <th>利星行支付保险(LSH)</th>
        <th>融资公司赠送保险(HS/CCI)</th>
		<th>客户现金支付保险(客户)</th>
        <th>保险费是否融资</th>
        <th>险种&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        <th>保险账户</th>
		<th>收保单日期&nbsp;&nbsp;&nbsp;&nbsp;</th>
        <th>付保费日期&nbsp;&nbsp;&nbsp;&nbsp;</th>
        <th>付款单编号</th>
        <th>分公司</th>
		<th>是否有特殊情况</th>
        <th>批单信息</th>
        <th>索赔理赔日志</th>
        <th>赔款金额</th>
		<th>维修欠费</th>
        <th>欠融资或分期月付款</th>
        <th>最终赔付对象</th>
        <th>最终赔付金额</th>
        <th>退保日志</th>
        <th>退保对象</th>
        <th>退保金额</th>
        <th>备注</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("contract_id") ) %>"></td>
        
        <td align="left"><a href="insurance.jsp?czid=<%= getDBStr( rs.getString("contract_id") ) %>" target="_blank"><%= getDBStr(rs.getString("equip_sn") ) %></a></td>
        <td><%= getDBStr( rs.getString("engine_code") ) %></td>
         <td><%= getDBStr( rs.getString("contract_id") ) %></td>
        <td><%= getDBDateStr( rs.getString("insurance_date") ) %></td>
        <td><%= getDBDateStr( rs.getString("insurance_enddate") ) %></td>
        <td><%= getDBStr( rs.getString("cust_name") ) %></td>
        <td><%= getDBStr( rs.getString("insurer") ) %></td>
        <td><%= getDBStr( rs.getString("insurance_no") ) %></td>
        <td><%= getDBStr( rs.getString("operation_way") ) %></td>
        <td><%= formatNumberStr(rs.getString("equip_amt"),"#,##0.00") %></td>
        <td><%= getDBStr( rs.getString("income_number") ) %></td>
        <td><%= formatNumberStr( rs.getString("insurance"),"#,##0.00" )%></td>
        <td><%= formatNumberStr( rs.getString("lsh_insurance") ,"#,##0.00")%></td>
        <td><%= formatNumberStr(rs.getString("give_insurance"),"#,##0.00" )%></td>
        <td><%= formatNumberStr(rs.getString("cust_insurance"),"#,##0.00" )%></td>
        <td><%= getDBStr( rs.getString("insurance_flag") ) %></td>
        <td><%= getDBStr( rs.getString("insurance_type") ) %></td>
        <td><%= getDBStr( rs.getString("insurance_account") ) %></td>
        <td><%= getDBDateStr( rs.getString("get_date") ) %></td>
        <td><%= getDBDateStr( rs.getString("pay_date") ) %></td>
        <td><%= getDBStr( rs.getString("pay_no") ) %></td>
        <td><%= getDBStr( rs.getString("sale_name") ) %></td>
        <td><%= getDBStr( rs.getString("is_special") ) %></td>
        <td><%= getDBStr( rs.getString("check_info") ) %></td>
        <td><%= getDBStr( rs.getString("claims_note") ) %></td>
        <td><%= formatNumberStr(rs.getString("claims_money"),"#,##0.00" ) %></td>
        <td><%= formatNumberStr(rs.getString("repair_delaymoney"),"#,##0.00" )%></td>
        <td><%= formatNumberStr(rs.getString("financing_delaymoney"),"#,##0.00" ) %></td>
        <td><%= getDBStr( rs.getString("claims_name") ) %></td>
        <td><%= formatNumberStr(rs.getString("finallyclaims_money"),"#,##0.00" )%></td>
        <td><%= getDBStr( rs.getString("surrender_note") ) %></td>
        <td><%= getDBStr( rs.getString("surrender_object") ) %></td>
        <td><%= formatNumberStr(rs.getString("surrender_money"),"#,##0.00" )%></td>
        <td><%= getDBStr( rs.getString("note") ) %></td>
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
